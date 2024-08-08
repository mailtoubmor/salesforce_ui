/**
 * Author : Team Gravity
 * Release :
 * @description : This api when called validates and creates casecomment records in cep for received payload.
 * Caller :
 */
public with sharing class OpportunitySearchController {
    /**
     * Author : Team Gravity
     * Release :
     * @description : This api when called validates and creates casecomment records in cep for received payload.
     * Caller :
    */
    @AuraEnabled
    public static list<OpportunityWrapperDemo> fetchOpportunityDetails(String searchTerm){
        System.debug('IN APEX CALL'+searchTerm);
        list<OpportunityWrapperDemo> oppWarpList = new list<OpportunityWrapperDemo>();
        list<opportunity> listOpp = [SELECT Id,Name,Account.Name,StageName,Description,CloseDate FROM Opportunity];
        for(Opportunity opp : listOpp){
            OpportunityWrapperDemo oppWrap  = new OpportunityWrapperDemo();
            oppWrap.oppName= opp.Name;
            oppWrap.oppCloseDate = opp.CloseDate;
            oppWrap.acc = opp.account.Name;
            oppWrap.oppAccCon = opp.account.Name;
            oppWrap.oppAccRescentContactEmail = 'email@gmail.com';
            oppWrap.oppAccRescentContactPhone = '09909090';
            oppWarpList.add(oppWrap);
        }
        System.debug('WRAPPED DATA'+oppWarpList);
        return oppWarpList;
    }
}