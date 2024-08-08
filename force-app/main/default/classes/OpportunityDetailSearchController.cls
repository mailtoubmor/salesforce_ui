public class OpportunityDetailSearchController {
    @AuraEnabled
    public static list<Opportunity> fetchOpportunityDetails(String searchTerm){
        System.debug('IN OpportunityDetailSearchController|fetchOpportunityDetails');
        Schema.DescribeFieldResult fieldResult = Opportunity.StageName.getDescribe();
        set<string> setStageNames = new set<string>();
        boolean isStageNameBasedSearch = false ;
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry s:ple){
           setStageNames.add(String.valueOf(s));
        } 
        if(setStageNames.contains(searchTerm)){
            System.debug('Its stageName Based search');
            isStageNameBasedSearch = true ;
        }
        
        //If stageName based search 
        if(isStageNameBasedSearch){
            Map<Id,List<opportunity>> mapIdListOpportunity = new Map<Id,List<opportunity>>();
            List<Opportunity> listOpportunity = new list<Opportunity>();
        	listOpportunity = [SELECT Id,Name,StageName,AccountId,contactId FROM Opportunity WHERE AccountId != null AND Name like :searchTerm];
            if(listOpportunity.size()>0){
                for(Opportunity opp : listOpportunity){
                    if(opp.AccountId != null){
                        if(!mapIdListOpportunity.containsKey(opp.AccountId)) {
                            list<opportunity> oppListNew =new list<opportunity>();
                            oppListNew.add(opp);
                            mapIdListOpportunity.put(opp.AccountId,oppListNew);
                        }
                        else{
                            list<opportunity> oppListNew = mapIdListOpportunity.get(opp.AccountId);
                            oppListNew.add(opp);
                            mapIdListOpportunity.put(opp.accountId,oppListNew);
                        }
                    }    
                }
                //to check If accounts has related contacts
                Map<Id,list<contact>> mapAccountIdContact = new Map<Id,list<contact>>();
                list<contact> listContact = [SELECT Id,FirstName,Email,LastName,Phone FROM Contact WHERE AccountId IN: mapIdListOpportunity.keySet() order by createddate DESC];
                if(listContact.size() > 0){
                    for(contact con :listContact){  
                        if(mapAccountIdContact.containsKey(con.accountId)){
                            List<contact> lstContact = mapAccountIdContact.get(con.AccountId);
                            lstContact.add(con);
                            mapAccountIdContact.put(con.accountId,lstContact);
                        }else{
                            list<Contact> conListNew =new list<Contact>();
                            conListNew.add(con);
                            mapAccountIdContact.put(con.AccountId,conListNew);
                        }
                    }
                }
                //Constructing Data to return 
                for(Id accId : mapIdListOpportunity.keySet()){
                    if(mapAccountIdContact.containsKey(accId) && mapAccountIdContact.get(accId) != null && mapAccountIdContact.get(accId).size() > 0){
                        for(Opportunity opp : mapIdListOpportunity.get(accId)){
                            
                        }
                    }
                }
            }
        }
        return null; 
    }
}