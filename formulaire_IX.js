var request = require('request');
var myConfig = require('./config/config');
var postApiUrl= myConfig.api.dhis2.url + '/api/dataValueSets';
var username = myConfig.api.dhis2.user.name;
var password = myConfig.api.dhis2.user.pwd;
var auth = "Basic " + new Buffer(username + ":" + password).toString("base64");
var orgUnit = "sKIaHUZzcOx"; //HD Gaya  ** replace by "hLGXSxm940X"for HD Gothèye **
var date = "2020-02-03";
var period = "202012";
var jsonPayloadToConsultationExterne = {
  "dataSet": "zG4BbP1UUdn", // Planification Familiale
  "completeDate": date,
  "period": period,
  "orgUnit": orgUnit,
  "attributeOptionCombo": "HllvX50cXC0",
  "dataValues":
  [
	{   "dataElement": "luxs1nMVeWU", 
		"categoryOptionCombo": "EdeF5g84qOH", 
		"value": "10", 
		"comment": ""
	},
	{	"dataElement": "luxs1nMVeWU", 
		"categoryOptionCombo": "ypTYRKCIKeR", 
		"value": "20", 
		"comment": "" 
    },
    {   "dataElement": "luxs1nMVeWU", 
        "categoryOptionCombo": "bBN7EAvEMiz", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "luxs1nMVeWU", 
        "categoryOptionCombo": "GG3DG52QqyW", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "luxs1nMVeWU", 
        "categoryOptionCombo": "AyfUsxA8LtJ", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "luxs1nMVeWU", 
        "categoryOptionCombo": "DUdSSAGnu4m", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "OPQPMR7Nxxx", 
        "categoryOptionCombo": "EdeF5g84qOH", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "OPQPMR7Nxxx", 
        "categoryOptionCombo": "ypTYRKCIKeR", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "OPQPMR7Nxxx", 
        "categoryOptionCombo": "bBN7EAvEMiz", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "OPQPMR7Nxxx", 
        "categoryOptionCombo": "GG3DG52QqyW", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "OPQPMR7Nxxx", 
        "categoryOptionCombo": "AyfUsxA8LtJ", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "OPQPMR7Nxxx", 
        "categoryOptionCombo": "DUdSSAGnu4m", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "IJy9O4qecuW", 
        "categoryOptionCombo": "EdeF5g84qOH", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "IJy9O4qecuW", 
        "categoryOptionCombo": "ypTYRKCIKeR", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "IJy9O4qecuW", 
        "categoryOptionCombo": "bBN7EAvEMiz", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "IJy9O4qecuW", 
        "categoryOptionCombo": "GG3DG52QqyW", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "IJy9O4qecuW", 
        "categoryOptionCombo": "AyfUsxA8LtJ", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "IJy9O4qecuW", 
        "categoryOptionCombo": "DUdSSAGnu4m", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "Kkm3X8mwFZW", 
        "categoryOptionCombo": "EdeF5g84qOH", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "Kkm3X8mwFZW", 
        "categoryOptionCombo": "ypTYRKCIKeR", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "Kkm3X8mwFZW", 
        "categoryOptionCombo": "bBN7EAvEMiz", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "Kkm3X8mwFZW", 
        "categoryOptionCombo": "GG3DG52QqyW", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "Kkm3X8mwFZW", 
        "categoryOptionCombo": "AyfUsxA8LtJ", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "Kkm3X8mwFZW", 
        "categoryOptionCombo": "DUdSSAGnu4m", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "OZmOQt4k4XY", 
        "categoryOptionCombo": "EdeF5g84qOH", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "OZmOQt4k4XY", 
        "categoryOptionCombo": "ypTYRKCIKeR", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "OZmOQt4k4XY", 
        "categoryOptionCombo": "bBN7EAvEMiz", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "OZmOQt4k4XY", 
        "categoryOptionCombo": "GG3DG52QqyW", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "OZmOQt4k4XY", 
        "categoryOptionCombo": "AyfUsxA8LtJ", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "OZmOQt4k4XY", 
        "categoryOptionCombo": "DUdSSAGnu4m", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "hknyQyA04pn", 
        "categoryOptionCombo": "EdeF5g84qOH", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "hknyQyA04pn", 
        "categoryOptionCombo": "ypTYRKCIKeR", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "hknyQyA04pn", 
        "categoryOptionCombo": "bBN7EAvEMiz", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "hknyQyA04pn", 
        "categoryOptionCombo": "GG3DG52QqyW", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "hknyQyA04pn", 
        "categoryOptionCombo": "AyfUsxA8LtJ", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "hknyQyA04pn", 
        "categoryOptionCombo": "DUdSSAGnu4m", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "YWWN7a8TOOR", 
        "categoryOptionCombo": "EdeF5g84qOH", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "YWWN7a8TOOR", 
        "categoryOptionCombo": "ypTYRKCIKeR", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "YWWN7a8TOOR", 
        "categoryOptionCombo": "bBN7EAvEMiz", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "YWWN7a8TOOR", 
        "categoryOptionCombo": "GG3DG52QqyW", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "YWWN7a8TOOR", 
        "categoryOptionCombo": "AyfUsxA8LtJ", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "YWWN7a8TOOR", 
        "categoryOptionCombo": "DUdSSAGnu4m", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "BJ00nE7jV0k", 
        "categoryOptionCombo": "EdeF5g84qOH", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "BJ00nE7jV0k", 
        "categoryOptionCombo": "ypTYRKCIKeR", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "BJ00nE7jV0k", 
        "categoryOptionCombo": "bBN7EAvEMiz", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "BJ00nE7jV0k", 
        "categoryOptionCombo": "GG3DG52QqyW", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "BJ00nE7jV0k", 
        "categoryOptionCombo": "AyfUsxA8LtJ", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "BJ00nE7jV0k", 
        "categoryOptionCombo": "DUdSSAGnu4m", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "ZgkoYOly0Ng", 
        "categoryOptionCombo": "EdeF5g84qOH", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "ZgkoYOly0Ng", 
        "categoryOptionCombo": "ypTYRKCIKeR", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "ZgkoYOly0Ng", 
        "categoryOptionCombo": "bBN7EAvEMiz", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "ZgkoYOly0Ng", 
        "categoryOptionCombo": "GG3DG52QqyW", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "ZgkoYOly0Ng", 
        "categoryOptionCombo": "AyfUsxA8LtJ", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "ZgkoYOly0Ng", 
        "categoryOptionCombo": "DUdSSAGnu4m", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "qx3Hyj1FSQk", 
        "categoryOptionCombo": "EdeF5g84qOH", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "qx3Hyj1FSQk", 
        "categoryOptionCombo": "ypTYRKCIKeR", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "qx3Hyj1FSQk", 
        "categoryOptionCombo": "bBN7EAvEMiz", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "qx3Hyj1FSQk", 
        "categoryOptionCombo": "GG3DG52QqyW", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "qx3Hyj1FSQk", 
        "categoryOptionCombo": "AyfUsxA8LtJ", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "qx3Hyj1FSQk", 
        "categoryOptionCombo": "DUdSSAGnu4m", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "rlBTTUB2SZD", 
        "categoryOptionCombo": "EdeF5g84qOH", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "rlBTTUB2SZD", 
        "categoryOptionCombo": "ypTYRKCIKeR", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "rlBTTUB2SZD", 
        "categoryOptionCombo": "bBN7EAvEMiz", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "rlBTTUB2SZD", 
        "categoryOptionCombo": "GG3DG52QqyW", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "rlBTTUB2SZD", 
        "categoryOptionCombo": "AyfUsxA8LtJ", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "rlBTTUB2SZD", 
        "categoryOptionCombo": "DUdSSAGnu4m", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "NyFQWnoiyeH", 
        "categoryOptionCombo": "EdeF5g84qOH", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "NyFQWnoiyeH", 
        "categoryOptionCombo": "ypTYRKCIKeR", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "NyFQWnoiyeH", 
        "categoryOptionCombo": "bBN7EAvEMiz", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "NyFQWnoiyeH", 
        "categoryOptionCombo": "GG3DG52QqyW", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "NyFQWnoiyeH", 
        "categoryOptionCombo": "AyfUsxA8LtJ", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "NyFQWnoiyeH", 
        "categoryOptionCombo": "DUdSSAGnu4m", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "WEnx5hF5YmV", 
        "categoryOptionCombo": "EdeF5g84qOH", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "WEnx5hF5YmV", 
        "categoryOptionCombo": "ypTYRKCIKeR", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "WEnx5hF5YmV", 
        "categoryOptionCombo": "bBN7EAvEMiz", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "WEnx5hF5YmV", 
        "categoryOptionCombo": "GG3DG52QqyW", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "WEnx5hF5YmV", 
        "categoryOptionCombo": "AyfUsxA8LtJ", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "WEnx5hF5YmV", 
        "categoryOptionCombo": "DUdSSAGnu4m", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "D79CdxJRZ4y", 
        "categoryOptionCombo": "EdeF5g84qOH", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "D79CdxJRZ4y", 
        "categoryOptionCombo": "ypTYRKCIKeR", 
        "value": "20", 
        "comment": "" 
    },
    {   "dataElement": "D79CdxJRZ4y", 
        "categoryOptionCombo": "bBN7EAvEMiz", 
        "value": "10", 
        "comment": ""
    },
    {	"dataElement": "D79CdxJRZ4y", 
        "categoryOptionCombo": "GG3DG52QqyW", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "D79CdxJRZ4y", 
        "categoryOptionCombo": "AyfUsxA8LtJ", 
        "value": "20", 
        "comment": "" 
    },
    {	"dataElement": "D79CdxJRZ4y", 
        "categoryOptionCombo": "DUdSSAGnu4m", 
        "value": "20", 
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