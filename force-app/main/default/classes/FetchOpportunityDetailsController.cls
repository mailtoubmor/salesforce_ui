/** 
    * *****************************************************************
    * Author : Umesh Mor
    * Caller : OpportunityAndRelatedDetails-lwc component
    * @description : Search opportunity and related data- wc component
    * *****************************************************************
*/
public with sharing class FetchOpportunityDetailsController {
    /** 
    * **********************************************************
    * @description : Fetches the opportunities and related data
    * @param  : searchTerm
    * @return : list of OpportunityRelatedDataWrapper
    * ***********************************************************
    */
	@AuraEnabled
    public static list<OpportunityRelatedDataWrapper> fetchOpportunityDetails(String searchTerm){
        list<OpportunityRelatedDataWrapper> listFinalWrapper = new list<OpportunityRelatedDataWrapper>();
        System.debug(logginglevel.INFO, 'Inside getCaseList() method from DCECaseUIController class'); 
        map<id,list<OpportunityRelatedDataWrapper>> mapAccIdLstWrap = new map<id,list<OpportunityRelatedDataWrapper>>();
        set<Id> accountIdSet = new set<Id>();
        try{
            if(String.isNotBlank(searchTerm)){
                list<opportunity> opportunityList = [SELECT id,stageName,UserRecordAccess.HasReadAccess,closeDate,account.name,name,description FROM opportunity WHERE (account.name like :searchTerm OR stagename like :searchTerm) WITH  SYSTEM_MODE];
                if(opportunityList.size() > 0){
                    for(opportunity opp : opportunityList){
                        if(opp.accountId != null){
                            if(mapAccIdLstWrap.containsKey(opp.accountId)){
                                list<OpportunityRelatedDataWrapper> listOppRelDataWrap = mapAccIdLstWrap.get(opp.accountId);
                                listOppRelDataWrap.add(prepareOpportunityRelatedDataWrapper(opp));
                                mapAccIdLstWrap.put(opp.accountId,listOppRelDataWrap);
                            }
                            else{
                                list<OpportunityRelatedDataWrapper> listOppRelDataWrap = new list<OpportunityRelatedDataWrapper>();
                                listOppRelDataWrap.add(prepareOpportunityRelatedDataWrapper(opp));
                                mapAccIdLstWrap.put(opp.accountId,listOppRelDataWrap);
                            }
                        } 
                    }
                }
                else{
                    for(OpportunityContactRole oppConRole : [SELECT Id,Opportunity.Name,Opportunity.UserRecordAccess.HasReadAccess,opportunity.description,Opportunity.stagename,Opportunity.CloseDate,Opportunity.AccountId FROM OpportunityContactRole WHERE contact.Name like :searchTerm]){
                        if(mapAccIdLstWrap.containsKey(oppConRole.opportunity.accountId)){
                            list<OpportunityRelatedDataWrapper> listOppRelDataWrap = mapAccIdLstWrap.get(oppConRole.Opportunity.AccountId);
                            listOppRelDataWrap.add(prepareOpportunityRelatedDataWrapperTwo(oppConRole));
                            mapAccIdLstWrap.put(oppConRole.Opportunity.AccountId,listOppRelDataWrap);
                        }
                        else{
                            list<OpportunityRelatedDataWrapper> listOppRelDataWrap = new list<OpportunityRelatedDataWrapper>();
                            listOppRelDataWrap.add(prepareOpportunityRelatedDataWrapperTwo(oppConRole));
                            mapAccIdLstWrap.put(oppConRole.opportunity.accountId,listOppRelDataWrap);
                        }
                    } 
                    associateOppWithAccRescentCont(mapAccIdLstWrap,listFinalWrapper); 
                }
            }    
        }
        catch(exception ex){
            System.debug(logginglevel.ERROR, 'Error occured while processing search request,Error message'+ex.getMessage()+'@Line no:'+ex.getLineNumber());    
        }
        return listFinalWrapper;
    }
    
    /** 
    * ******************************************************************************
    * @description : This method prepares the opportunity data with account details
    * @param  : opportunity record 
    * @return : OpportunityRelatedDataWrapper
    * ******************************************************************************
    */
    public static OpportunityRelatedDataWrapper prepareOpportunityRelatedDataWrapper(Opportunity opp){
        OpportunityRelatedDataWrapper wrap = new OpportunityRelatedDataWrapper();
        wrap.opportunityName = 	opp.Name;
        wrap.opportunityDescription= opp.description;
        wrap.closeDate = opp.closeDate;
        wrap.associatedAccount = opp.Account.Name;	
        wrap.hasRecordAccess = opp.UserRecordAccess.HasReadAccess;
        return wrap;
    }

     /** 
    * ******************************************************************************
    * @description : This method prepares the opportunity data with account details
    * @param  : opportunityContactRole 
    * @return : OpportunityRelatedDataWrapper
    * ******************************************************************************
    */
    public static OpportunityRelatedDataWrapper prepareOpportunityRelatedDataWrapperTwo(OpportunityContactRole oppConRole){
        OpportunityRelatedDataWrapper wrap = new OpportunityRelatedDataWrapper();
        wrap.opportunityName = 	oppConRole.opportunity.Name;
        wrap.opportunityDescription= oppConRole.opportunity.description;
        wrap.closeDate = oppConRole.opportunity.closeDate;
        wrap.associatedAccount = oppConRole.opportunity.Account.Name;	
        wrap.hasRecordAccess = oppConRole.opportunity.UserRecordAccess.HasReadAccess;
        return wrap;
    }

    /** 
    * ******************************************************************************
    * @description : This method associats opportunity with its accounts recent contact 
    * @param  : mapAccIdLstWrap,listFinalWrapper
    * @return : 
    * ******************************************************************************
    */
    public static void associateOppWithAccRescentCont( map<id,list<OpportunityRelatedDataWrapper>> mapAccIdLstWrap,list<OpportunityRelatedDataWrapper> listFinalWrapper){
        map<id,contact> mapAccountIdsToContact = new map<id,contact>();
        for(contact con :  [SELECT Id,Name,Email,Phone,accountId FROM contact WHERE accountId IN : mapAccIdLstWrap.keySet() ORDER by createddate DESC ]){ 
            if(!mapAccountIdsToContact.containsKey(con.accountId)){
                mapAccountIdsToContact.put(con.accountId,con) ; 
            }
        } 
        for(id accid : mapAccIdLstWrap.keySet()){
            for(OpportunityRelatedDataWrapper wrap : mapAccIdLstWrap.get(accid)){
                if(mapAccountIdsToContact.containsKey(accid)){
                    wrap.associatedResentContact = mapAccountIdsToContact.get(accid).Name;
                    wrap.associatedResContactEmail = mapAccountIdsToContact.get(accid).Email;
                    wrap.associatedResContactPhone  =  mapAccountIdsToContact.get(accid).Phone;
                    listFinalWrapper.add(wrap);
                }    
            }
        }
    }
}