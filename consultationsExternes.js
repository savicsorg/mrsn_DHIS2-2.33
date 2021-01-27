// POST DHIS2 information 
var request = require('request');
var myConfig = require('./config/config');


var postApiUrl= myConfig.api.dhis2.url + '/api/dataValueSets';
var username = myConfig.api.dhis2.user.name;
var password = myConfig.api.dhis2.user.pwd;
var auth = "Basic " + new Buffer(username + ":" + password).toString("base64");
var orgUnit = "sKIaHUZzcOx"; //HD Gaya  ** replace by "hLGXSxm940X"for HD Gothèye **
var date = "2020-12-14";
var period = "202012";
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

var jsonPayloadToConsultationExterne = {
  "dataSet": "G5MHmZM6SfM", // Consultation Externe
  "completeDate": date,
  "period": period,
  "orgUnit": orgUnit,
  "dataValues": [
	{   "dataElement": "uwne8XcNsWR", 
		"categoryOptionCombo": "PkyhEETzeVq", 
		"value": "10", 
		"comment": ""
	},
	{	"dataElement": "uwne8XcNsWR", 
		"categoryOptionCombo": "yDODsYEbH1n", 
		"value": "20", 
		"comment": "" 
	},
	{ 	"dataElement": "uwne8XcNsWR", 
		"categoryOptionCombo": "B1e6KGksbyE",
		"value": "30", 
		"comment": "" 
	},
	{ 	"dataElement": "uwne8XcNsWR", 
		"categoryOptionCombo": "cJZk4vnmox8", 
		"value": "40", 
		"comment": "" 
	},
	{ 	"dataElement": "jJtCxRd0dOJ", 
		"categoryOptionCombo": "PkyhEETzeVq", 
		"value": "50", 
		"comment": "" 
	},
	{ 	"dataElement": "jJtCxRd0dOJ", 
		"categoryOptionCombo": "yDODsYEbH1n", 
		"value": "60", 
		"comment": "" 
	},
	{ 	"dataElement": "jJtCxRd0dOJ", 
		"categoryOptionCombo": "B1e6KGksbyE", 
		"value": "70", 
		"comment": "" 
	},
	{ 	"dataElement": "jJtCxRd0dOJ", 
		"categoryOptionCombo": "cJZk4vnmox8", 
		"value": "80", 
		"comment": "" 
	},
	{ 	"dataElement": "pfcaAuPitFB", 
		"categoryOptionCombo": "PkyhEETzeVq", 
		"value": "90", 
		"comment": "" 
	},
	{ 	"dataElement": "pfcaAuPitFB", 
		"categoryOptionCombo": "yDODsYEbH1n", 
		"value": "100", 
		"comment": "" 
	},
	{ 	"dataElement": "pfcaAuPitFB", 
		"categoryOptionCombo": "B1e6KGksbyE", 
		"value": "110", 
		"comment": "" 
	},
	{ 	"dataElement": "pfcaAuPitFB", 
		"categoryOptionCombo": "cJZk4vnmox8", 
		"value": "120", 
		"comment": "" 
	},
	{ 	"dataElement": "bHoCQhb4cGr", 
		"categoryOptionCombo": "PkyhEETzeVq", 
		"value": "130", 
		"comment": "" 
	},
	{ 	"dataElement": "bHoCQhb4cGr", 
		"categoryOptionCombo": "yDODsYEbH1n", 
		"value": "140", 
		"comment": "" 
	},
	{ 	"dataElement": "bHoCQhb4cGr", 
		"categoryOptionCombo": "B1e6KGksbyE", 
		"value": "150", 
		"comment": "" 
	},
	{ 	"dataElement": "bHoCQhb4cGr", 
		"categoryOptionCombo": "cJZk4vnmox8", 
		"value": "160", 
		"comment": "" 
	}
  ]
};

request(options, function (error, response) {
    if (error) throw new Error(error);
    console.log(response.body);
  });