const express = require('express');
const app = express();
const fetch = require('node-fetch');
const bodyParser = require('body-parser');
const form = require ('./models/formsModels');
var mapFile = require('./utils/mapFile');


// Parse incoming requests data
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

var myConfig = require('./config/config');
var port = myConfig.api.server.port;
var postApiUrl= myConfig.api.dhis2.url + '/api/dataValueSets';
var username = myConfig.api.dhis2.user.name;
var password = myConfig.api.dhis2.user.pwd;
var auth = "Basic " + new Buffer(username + ":" + password).toString("base64");

var orgUnit;
var dataSet;
var completeDate;
var period;
var dataValues;
var attributeOptionCombo = "HllvX50cXC0";

app.get("/", (req, res) => {
    res.send({ message: "Welcome!" });
  });

// Post reports route
  app.post('/reports', (req, res) => {
    var report = req.body;
    orgUnit = mapFile.getOrgUnit(report.OrgUnit);
    dataSet = mapFile.getDataSet(report.formulaire);
    completeDate = report.dateEnvoie;
    period = report.periode;
    if (report.formulaire == "Consultation Externe") {
      dataValues = form.form2.dataValues;
    } else if (report.formulaire == "Service des Urgences") {
      dataValues = form.form3.dataValues;
    } else if (report.formulaire == "Planification Familiale"){
      dataValues = form.form9.dataValues;
    }
    for(i=0; i < report.donnees.length; i ++) {
    dataValues[i].value = report.donnees[i].champs;
    };

    res.send({
      success: 'true',
      message: 'Form '+report.formulaire+' added successfully',
      //report
    });

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
    
});


// start the server on port 9000
const server = app.listen(port, () => {
  console.log(`Express running → PORT ${server.address().port}`);
})