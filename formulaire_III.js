var request = require('request');
var myConfig = require('./config/config');

var postApiUrl= myConfig.api.dhis2.url + '/api/dataValueSets';
var username = myConfig.api.dhis2.user.name;
var password = myConfig.api.dhis2.user.pwd;
var auth = "Basic " + new Buffer(username + ":" + password).toString("base64");
var orgUnit = "sKIaHUZzcOx"; //HD Gaya  ** replace by "hLGXSxm940X"for HD Gothèye **
var date = "2021-02-05";
var period = "202011";
var jsonPayloadToServiceUrgences = {
    "dataSet": "nd8Njom3T68", // Service des Urgences
    "completeDate": date,
    "period": period,
	"orgUnit": orgUnit,
	"attributeOptionCombo": "HllvX50cXC0",
    "dataValues": [
    {   "dataElement": "cp5TSXIxrID", 
		"categoryOptionCombo": "jpMgblQN1BO", 
		"value": "1", 
		"comment": " "
	},
    {   "dataElement": "cp5TSXIxrID", 
		"categoryOptionCombo": "PgqJQFyKD8E", 
		"value": "2", 
		"comment": " "
	},
    {   "dataElement": "cp5TSXIxrID", 
		"categoryOptionCombo": "AWg0ckSlZ9c", 
		"value": "3", 
		"comment": " "
	},
    {   "dataElement": "cp5TSXIxrID", 
		"categoryOptionCombo": "P0wfW4JYXfK", 
		"value": "4", 
		"comment": " "
	},
    {   "dataElement": "iMPGYCcLEbS", 
		"categoryOptionCombo": "jpMgblQN1BO", 
		"value": "5", 
		"comment": " "
	},
    {   "dataElement": "iMPGYCcLEbS", 
		"categoryOptionCombo": "PgqJQFyKD8E", 
		"value": "6", 
		"comment": " "
	},
    {   "dataElement": "iMPGYCcLEbS", 
		"categoryOptionCombo": "AWg0ckSlZ9c", 
		"value": "7", 
		"comment": " "
	},
    {   "dataElement": "iMPGYCcLEbS", 
		"categoryOptionCombo": "P0wfW4JYXfK", 
		"value": "8", 
		"comment": " "
	},
	{   "dataElement": "RvlRVvQm85x", 
		"categoryOptionCombo": "jpMgblQN1BO", 
		"value": "9", 
		"comment": " "
	},
	{   "dataElement": "RvlRVvQm85x", 
		"categoryOptionCombo": "PgqJQFyKD8E", 
		"value": "10", 
		"comment": " "
	},
	{   "dataElement": "RvlRVvQm85x", 
		"categoryOptionCombo": "AWg0ckSlZ9c", 
		"value": "11", 
		"comment": " "
	},
	{   "dataElement": "RvlRVvQm85x", 
		"categoryOptionCombo": "P0wfW4JYXfK", 
		"value": "12", 
		"comment": " "
	},
    {   "dataElement": "VTYlq79wfw7", 
		"categoryOptionCombo": "jpMgblQN1BO", 
		"value": "13", 
		"comment": " "
	},
    {   "dataElement": "VTYlq79wfw7", 
		"categoryOptionCombo": "PgqJQFyKD8E", 
		"value": "14", 
		"comment": " "
	},
    {   "dataElement": "VTYlq79wfw7", 
		"categoryOptionCombo": "AWg0ckSlZ9c", 
		"value": "15", 
		"comment": " "
	},
    {   "dataElement": "VTYlq79wfw7", 
		"categoryOptionCombo": "P0wfW4JYXfK", 
		"value": "16", 
		"comment": " "
	},
    {   "dataElement": "PeipyyyU7d9", 
		"categoryOptionCombo": "jpMgblQN1BO", 
		"value": "17", 
		"comment": " "
	},
    {   "dataElement": "PeipyyyU7d9", 
		"categoryOptionCombo": "PgqJQFyKD8E", 
		"value": "18", 
		"comment": " "
	},
    {   "dataElement": "PeipyyyU7d9", 
		"categoryOptionCombo": "AWg0ckSlZ9c", 
		"value": "19", 
		"comment": " "
	},
    {   "dataElement": "PeipyyyU7d9", 
		"categoryOptionCombo": "P0wfW4JYXfK", 
		"value": "20", 
		"comment": " "
	},
	{   "dataElement": "oP8H40N8Q59", 
		"categoryOptionCombo": "jpMgblQN1BO", 
		"value": "21", 
		"comment": " "
	},
	{   "dataElement": "oP8H40N8Q59", 
		"categoryOptionCombo": "PgqJQFyKD8E", 
		"value": "22", 
		"comment": " "
	},
	{   "dataElement": "oP8H40N8Q59", 
		"categoryOptionCombo": "AWg0ckSlZ9c", 
		"value": "23", 
		"comment": " "
	},
	{   "dataElement": "oP8H40N8Q59", 
		"categoryOptionCombo": "P0wfW4JYXfK", 
		"value": "24", 
		"comment": " "
	},

    ]
};
var options = {
	method: 'POST',
	url: postApiUrl,
	body: JSON.stringify(jsonPayloadToServiceUrgences),	
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