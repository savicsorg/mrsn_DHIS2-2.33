exports.getDataSet = function(idDataSet){
    
    switch(idDataSet){
        case 'Consultation Externe':
            return 'yOM8cDdyX8m';
        case 'Service des Urgences':
            return 'nd8Njom3T68';
        case 'Planification Familiale':
            return 'zG4BbP1UUdn';
        default:
            return idDataSet;
    }
};

exports.getOrgUnit = function (idOrgUnit) {
    switch(idOrgUnit){
        case 'HD Gaya':
            return 'sKIaHUZzcOx';
        case 'HD Gothèye':
            return 'hLGXSxm940X';
        default:
            return idOrgUnit;
    }

    
}