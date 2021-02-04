var request = require('request');
var myConfig = require('./config/config');


var postApiUrl= myConfig.api.dhis2.url + '/api/dataValueSets';
var username = myConfig.api.dhis2.user.name;
var password = myConfig.api.dhis2.user.pwd;
var auth = "Basic " + new Buffer.from(username + ":" + password).toString("base64");
var orgUnit = "sKIaHUZzcOx"; //HD Gaya  ** replace by "hLGXSxm940X"for HD Gothèye **
var date = "2021-02-03";
var period = "202012";

var jsonPayloadToConsultationExterne = {
  "dataSet": "yOM8cDdyX8m", // Consultation Externe
  "completeDate": date,
  "period": period,
  "orgUnit": orgUnit,
  "attributeOptionCombo": "HllvX50cXC0",
  "dataValues": [
	{   "dataElement": "bL8hgP9t6H9", 
		"categoryOptionCombo": "jpMgblQN1BO", 
		"value": "10", 
		"comment": ""
	},
	{	"dataElement": "bL8hgP9t6H9", 
		"categoryOptionCombo": "PgqJQFyKD8E", 
		"value": "20", 
		"comment": "" 
	},
	{ 	"dataElement": "bL8hgP9t6H9", 
		"categoryOptionCombo": "AWg0ckSlZ9c",
		"value": "30", 
		"comment": "" 
	},
	{ 	"dataElement": "bL8hgP9t6H9", 
		"categoryOptionCombo": "P0wfW4JYXfK", 
		"value": "40", 
		"comment": "" 
	},
	{ 	"dataElement": "CXa7XQjsYBj", 
		"categoryOptionCombo": "jpMgblQN1BO", 
		"value": "50", 
		"comment": "" 
	},
	{ 	"dataElement": "CXa7XQjsYBj", 
		"categoryOptionCombo": "PgqJQFyKD8E", 
		"value": "60", 
		"comment": "" 
	},
	{ 	"dataElement": "CXa7XQjsYBj", 
		"categoryOptionCombo": "AWg0ckSlZ9c", 
		"value": "70", 
		"comment": "" 
	},
	{ 	"dataElement": "CXa7XQjsYBj", 
		"categoryOptionCombo": "P0wfW4JYXfK", 
		"value": "80", 
		"comment": "" 
	},
	{ 	"dataElement": "KgrleYbF15t", 
		"categoryOptionCombo": "jpMgblQN1BO", 
		"value": "90", 
		"comment": "" 
	},
	{ 	"dataElement": "KgrleYbF15t", 
		"categoryOptionCombo": "PgqJQFyKD8E", 
		"value": "100", 
		"comment": "" 
	},
	{ 	"dataElement": "KgrleYbF15t", 
		"categoryOptionCombo": "AWg0ckSlZ9c", 
		"value": "110", 
		"comment": "" 
	},
	{ 	"dataElement": "KgrleYbF15t", 
		"categoryOptionCombo": "P0wfW4JYXfK", 
		"value": "120", 
		"comment": "" 
	},
	{ 	"dataElement": "F8ZUtq2GS1b", 
		"categoryOptionCombo": "jpMgblQN1BO", 
		"value": "130", 
		"comment": "" 
	},
	{ 	"dataElement": "F8ZUtq2GS1b", 
		"categoryOptionCombo": "PgqJQFyKD8E", 
		"value": "140", 
		"comment": "" 
	},
	{ 	"dataElement": "F8ZUtq2GS1b", 
		"categoryOptionCombo": "AWg0ckSlZ9c", 
		"value": "150", 
		"comment": "" 
	},
	{ 	"dataElement": "F8ZUtq2GS1b", 
		"categoryOptionCombo": "P0wfW4JYXfK", 
		"value": "160", 
		"comment": "" 
	}
  ]
};
var options = {
	method: 'POST',
	url: postApiUrl,
	body: JSON.stringify(jsonPayloadToConsultationExterne),	
	headers: { 	
		'Authorization': auth,
		'Accept': 'application/json',
		'Content-Type': 'application/json' 
	},
	from: {
	  mimeType: 'application/json'
	}
}; 

request(options, function (error, response) {
    if (error) throw new Error(error);
    console.log(response.body);
  });