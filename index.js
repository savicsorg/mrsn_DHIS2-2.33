const express = require('express');
const app = express();
const fetch = require('node-fetch');
var myConfig = require('./config/config');
var port = myConfig.api.server.port;
var postApiUrl= myConfig.api.dhis2.url + '/api/dataValueSets';
var username = myConfig.api.dhis2.user.name;
var password = myConfig.api.dhis2.user.pwd;
const form2 = require ('./form2.json');
const data = require ('./raw.json');
var auth = "Basic " + new Buffer(username + ":" + password).toString("base64");
var mapFile = require('./mapFile');

var orgUnit = mapFile.getOrgUnit(data.OrgUnit);
var dataSet = mapFile.getDataSet(data.formulaire);
var completeDate = data.dateEnvoie;
var period = data.periode;
var attributeOptionCombo = "HllvX50cXC0";

var rawJsonTab = data.donnees;
var dataValues = form2.dataValues;
var obj = [];

for(i=0; i < rawJsonTab.length; i ++) {
  obj.push(rawJsonTab[i].champs)
  dataValues[i].value = obj[i];
 };

var JSONPayLoad = {
  dataSet,
  period,
  completeDate,
  orgUnit,
  attributeOptionCombo,
  dataValues
};

var options = {
  method: 'POST',
  body: JSON.stringify(JSONPayLoad),
  headers: {
    'Content-Type': 'application/json',
    'Authorization': auth,
    'Accept': 'application/json',
  }
};

fetch(postApiUrl, options)
  .then(res => res.json())
  .then(json => console.log(json))
  .catch(err => console.log("description error: "+err));

// fetch('./raw.json')
//   .then(res => res.json())
//   .then(json => {
//       console.log("First user in the array:");
//       console.log(json[0]);
//       // console.log("Name of the first user in the array:");
//       // console.log(json[0].name);
// });
  // simple route
app.get("/", (req, res) => {
    res.json({ message: "Welcome." });
  });


// start the server on port 9000
const server = app.listen(port, () => {
  console.log(`Express running → PORT ${server.address().port}`);
  console.log(period);
})