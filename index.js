const express = require('express');
const app = express();
const fetch = require('node-fetch');
var myConfig = require('./config/config');
var port = myConfig.api.server.port;
var postApiUrl= myConfig.api.dhis2.url + '/api/dataValueSets';
var username = myConfig.api.dhis2.user.name;
var password = myConfig.api.dhis2.user.pwd;
const form2 = require ('./form2.json');
var auth = "Basic " + new Buffer(username + ":" + password).toString("base64");

fetch(postApiUrl, {
    method: 'POST',
    body: JSON.stringify(form2),
    headers: { 
        'Content-Type': 'application/json',
        'Authorization': auth,
		'Accept': 'application/json',
 }
}).then(res => res.json())
  .then(json => console.log(json))
  .catch(err => console.log(err))

  // simple route
app.get("/", (req, res) => {
    res.json({ message: "Welcome." });
  });


// start the server on port 9000
const server = app.listen(port, () => {
  console.log(`Express running → PORT ${server.address().port}`);
})
