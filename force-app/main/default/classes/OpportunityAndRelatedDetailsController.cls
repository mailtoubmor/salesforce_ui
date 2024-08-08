/**
 * Author : Umesh Mor
 * Caller : OpportunityAndRelatedDetails - lwc component
 * @description : Search opportunity and related data - lwc componet
 */
public with sharing class OpportunityAndRelatedDetailsController {

    /**
	* @description : This method fetches the opportunities and related details for the search term it receives
	* @param  : searchTerm
    * @return : list of OpportunityRelatedDataWrapper
	**/

	@AuraEnabled
    public static list<OpportunityRelatedDataWrapper> fetchOpportunityDetails(String searchTerm){
        System.debug(logginglevel.INFO, 'Inside getCaseList() method from DCECaseUIController class'); 
        map<id,list<OpportunityRelatedDataWrapper>> mapAccIdLstWrap = new map<id,list<OpportunityRelatedDataWrapper>>();
        set<Id> accountIdSet = new set<Id>();
        map<id,contact> mapAccountIdsToContact = new map<id,contact>();
        list<OpportunityRelatedDataWrapper> listFinalWrapper = new list<OpportunityRelatedDataWrapper>();
        if(String.isNotBlank(searchTerm)){
            list<opportunity> opportunityList = [SELECT id,stageName,UserRecordAccess.HasReadAccess,closeDate,account.name,name,description FROM opportunity WHERE (account.name like : searchTerm OR stagename like : searchTerm) WITH  SYSTEM_MODE];
            for(opportunity opp : opportunityList){
                if(opp.accountId != null){
                    if(mapAccIdLstWrap.containsKey(opp.accountId)){
                        list<OpportunityRelatedDataWrapper> listOppRelDataWrap = mapAccIdLstWrap.get(opp.accountId);
                        OpportunityRelatedDataWrapper wrap = new OpportunityRelatedDataWrapper();
                        wrap.opportunityName = 	opp.Name;
                        wrap.opportunityDescription= opp.description;
                        wrap.closeDate = opp.closeDate;
                        wrap.associatedAccount = opp.Account.Name;	
                        wrap.hasRecordAccess = opp.UserRecordAccess.HasReadAccess;
                        listOppRelDataWrap.add(wrap);
                        mapAccIdLstWrap.put(opp.accountId,listOppRelDataWrap);
                    }
                    else{
                        list<OpportunityRelatedDataWrapper> listOppRelDataWrap = new list<OpportunityRelatedDataWrapper>();
                        OpportunityRelatedDataWrapper wrap = new OpportunityRelatedDataWrapper();
                        wrap.opportunityName = 	opp.name;
                        wrap.opportunityDescription= opp.description;
                        wrap.closeDate = opp.closeDate;
                        wrap.associatedAccount = opp.Account.name;	
                        wrap.hasRecordAccess = opp.UserRecordAccess.HasReadAccess;
                        listOppRelDataWrap.add(wrap);
                        mapAccIdLstWrap.put(opp.accountId,listOppRelDataWrap);
                    }
                } 
            }
            for(contact con :  [SELECT Id,Name,Email,Phone,accountId FROM contact WHERE accountId IN : mapAccIdLstWrap.keySet() ORDER by createddate DESC ]){ 
                if(!mapAccountIdsToContact.containsKey(con.accountId)){
                    mapAccountIdsToContact.put(con.accountId,con) ; 
                }
            } 
            for(id mapKey : mapAccIdLstWrap.keySet()){
                for(OpportunityRelatedDataWrapper wrap : mapAccIdLstWrap.get(mapKey)){
                    if(mapAccountIdsToContact.containsKey(mapKey)){
                        wrap.associatedResentContact = mapAccountIdsToContact.get(mapKey).Name;
                        wrap.associatedResContactEmail = mapAccountIdsToContact.get(mapKey).Email;
                        wrap.associatedResContactPhone  =  mapAccountIdsToContact.get(mapKey).Phone;
                        listFinalWrapper.add(wrap);
                    }    
                }
            }
        }
        return listFinalWrapper;
    }
}