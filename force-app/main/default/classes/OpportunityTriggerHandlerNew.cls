public class OpportunityTriggerHandlerNew {
    public static void handleInsertUpdateDml(list<opportunity> listOpportunity){
        if(listOpportunity.size() > 0){
            for(Opportunity opp : listOpportunity){
               //System.debug('The opportunity record is'+opp);
                if(opp.stageName == 'Closed Won' && opp.amount == null){
                    opp.amount = 0;
                }
            }
        }
    }
    public static void handleInsertUpdateDmlAfterContext(list<opportunity> listOpportunity){
        if(listOpportunity.size() > 0){
            list<Quote__c> listQuote = new list<Quote__c>();
            for(opportunity opp : listOpportunity){
                if(opp.StageName == 'Qualification'){
                    Quote__c quot = new Quote__c();
                    quot.Name = opp.Name;
                    quot.Opportunity__c = opp.Id;
                    listQuote.add(quot);
                }
            }
            if(listQuote.size() > 0){
                insert listQuote;
            }
        }
    }
}