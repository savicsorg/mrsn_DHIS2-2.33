#!/usr/bin/env node
'use strict'

const formidable = require('formidable');
const express = require('express');
const medUtils = require('openhim-mediator-utils');
const winston = require('winston');
const _ = require('underscore');
var https = require('https');
var http = require('http');
const fetch = require('node-fetch');
const bodyParser = require('body-parser');
const form = require ('../models/formsModels');
var mapFile = require('./utils');


var myConfig = require('../config/config.json');
var port = myConfig.server.port;
var postApiUrl= myConfig.dhis2.url + '/api/dataValueSets';
var username = myConfig.dhis2.user.name;
var password = myConfig.dhis2.user.pwd;
var auth = "Basic " + new Buffer(username + ":" + password).toString("base64");


// Logging setup
winston.remove(winston.transports.Console);
winston.add(winston.transports.Console, { level: 'info', timestamp: true, colorize: true });

// Config
var config = {}; // this will vary depending on whats set in openhim-core
const apiConf = process.env.NODE_ENV === 'test' ? require('../config/test') : require('../config/config');
const mediatorConfig = require('../config/mediatorConfig.json');

var port = process.env.NODE_ENV === 'test' ? 7001 : mediatorConfig.endpoints[0].port;

/**
 * setupApp - configures the http server for this mediator
 *
 * @return {express.App}  the configured http server
 */
function setupApp() {
  
  // start the rest of your app here
  const app = express();

  // Parse incoming requests data
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded({ extended: false }));
  app.use(bodyParser.raw({type: '*/*', limit: '100mb'}));

  var orgUnit;
  var dataSet;
  var completeDate;
  var period;
  var dataValues;
  var attributeOptionCombo = "HllvX50cXC0";
  
  // Post reports route
    app.all('/reports', (req, res) => {
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
      for(var i=0; i < report.donnees.length; i ++) {
      dataValues[i].value = report.donnees[i].champs;
      };
  
      res.send({
        success: 'true',
        message: 'Form '+report.formulaire+' added successfully',
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
    
  return app;

}

/**
 * start - starts the mediator
 *
 * @param  {Function} callback a node style callback that is called once the
 * server is started
 */
function start (callback) {
  // if (apiConf.api.trustSelfSigned) { process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0' }

  if (apiConf.register) {
    medUtils.registerMediator(apiConf.api, mediatorConfig, (err) => {
      if (err) {
        console.log('Failed to register this mediator, check your config')
        console.log(err.stack)
        process.exit(1)
      }
      apiConf.api.urn = mediatorConfig.urn
      medUtils.fetchConfig(apiConf.api, (err, newConfig) => {
        console.log('Received initial config:')
        console.log(JSON.stringify(newConfig))
        config = newConfig
        if (err) {
          console.log('Failed to fetch initial config')
          console.log(err.stack)
          process.exit(1)
        } else {
          console.log('Successfully registered mediator!')
          let app = setupApp()
          const server = app.listen(port, () => {
            let configEmitter = medUtils.activateHeartbeat(apiConf.api)
            configEmitter.on('config', (newConfig) => {
              console.log('Received updated config:')
              console.log(JSON.stringify(newConfig))
              // set new config for mediator
              config = newConfig
            })
            callback(server)
          })
          server.setTimeout(600000)
          console.log('Server timeout is: ' + server.timeout)
        }
      })
    })
  } else {
    // default to config from mediator registration
    config = mediatorConfig.config
    let app = setupApp()
    const server = app.listen(port, () => callback(server))
    server.setTimeout(600000)
    console.log('Server timeout is: ' + server.timeout)
  }
}
exports.start = start

if (!module.parent) {
  // if this script is run directly, start the server
  start(() => console.log(`Listening on ${port}...`))
}