/**
 * Author : 
 * Release :
 * @description : This class is invoked by SearchSObjectData lwc component.
 * Caller :
 */
public with sharing class SearchSObjectDataController {
    /**
	* @description - This method update existing sync state record or prepare new record as per stage value
	* @param pageNumber -  
	* @param pageSize - 
	* @param searchTerm -  
	* @return - OpportunityDataWrapper
	**/
    @AuraEnabled
    public static OpportunityDataWrapper fetchOpportunityData(Decimal pageNumber,Decimal pageSize,string searchTerm){
        System.debug('In Search SObject Controller>>>>'+searchTerm);
        List<OpportunityWrapperDemo> searchResult = new List<OpportunityWrapperDemo>();
        Integer pSize;
        if(pageSize!=null && pageSize!=0.0){
            pSize = (Integer)pageSize;    
        }else{
            pSize=10;  
        } 
        Integer pNumber = (Integer)pageNumber;
        Integer offset = (pNumber - 1) * pSize;
        list<Opportunity> oppList = new list<Opportunity>();
        String query = 'Select id,Description,CloseDate, Account.Name  from Opportunity LIMIT :pSize OFFSET :offset';
        String countQuery = 'select count() from Opportunity';
        oppList = Database.query(query);
        OpportunityDataWrapper result = new OpportunityDataWrapper();
        if(oppList.size() > 0){
            for(Opportunity opp : oppList){
                OpportunityWrapperDemo oppWrap = new OpportunityWrapperDemo();
                oppWrap.opportunityName = opp.Name;
                oppWrap.opportunityDescription = opp.Description;
                oppWrap.CloseDate = opp.CloseDate;
                oppWrap.associatedAccount = opp.Account.Name;
                oppWrap.associatedResentContact = 'Umesh Mor';
                oppWrap.associatedResContactEmail = 'umesh@gmail.com';
                oppWrap.associatedResContactPhone = '909090';
                searchResult.add(oppWrap);
            }
        }
        result.data = searchResult;
        result.totalRecords = Database.countQuery(countQuery);
        result.recordStart = offset + 1;
        Integer recordEnd = pSize * pNumber;
        result.recordEnd = result.totalRecords >= recordEnd ? recordEnd : result.totalRecords; 
        return result;
    }

    /**
     * Author : 
     * Release :
     * @description : 
     * Caller :
    */
    public class OpportunityDataWrapper {
         /*** @description : total records**/
        @AuraEnabled
        public Integer totalRecords {get;set;}
         /*** @description : record start**/
        @AuraEnabled
        public Integer recordStart {get;set;}
         /*** @description : record end*/
        @AuraEnabled
        public Integer recordEnd {get;set;}
         /*** @description : data to display*/
        @AuraEnabled
        public List<OpportunityWrapperDemo> data {get;set;}
    } 
}