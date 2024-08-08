@RestResource(urlMapping='/OppManagement')
global with sharing class OpportunityManagement{
    @httpGet
    global static list<opportunity> getListOfOpportunity(){
        String oppSearchTerm = RestContext.request.params.get('oppName');
        System.debug('the search term received is'+oppSearchTerm);
        list<opportunity> lstOpportunity =new list<opportunity>();
        if(String.isNotBlank(oppSearchTerm)){
            if (Schema.sObjectType.Opportunity.isAccessible()){
                String oppSearch = '%'+oppSearchTerm+'%';
                lstOpportunity = [SELECT Id,Name FROM Opportunity WHERE Name like :oppSearch];
            }
        }  
        else{
            lstOpportunity = [SELECT Id,Name FROM Opportunity];
        } 
        return lstOpportunity;  
    }
    
    @httpPost
    global static string insertOpportunity(OpportunityInformation oppRec){
        Opportunity oppRecToInsert = oppRec.opp;
        Contact con = oppRec.con;
        string returnStatement ;
        try{
            if (Schema.sObjectType.Opportunity.isAccessible()){
                insert oppRecToInsert;
                insert con;
                returnStatement =  'records inserted succesfully, Opp record id is:'+oppRecToInsert.Id+'Contct record is'+con.id;
                
            }
        }
        catch(exception ex){
            System.debug('Record couldnt get inserted : error message '+ex.getMessage());
            returnStatement = 'record inserted succesfully, record id is:'+oppRecToInsert.Id;
        }
        return returnStatement;
    }
    
    @httpDelete
    global static void deleteTodaysCreatedOppRecord(){
        delete [SELECT Id FROM Opportunity WHERE createdDate = Today];
    }
     
    
    global Class OpportunityInformation{
        global Opportunity opp{get;set;}
        global Contact con{get;set;}
    }
}