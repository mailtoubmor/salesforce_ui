public with sharing class ContactTriggerHandler {
   public static void handleContactTriggerOperations(set<id> accountIdSet){
        list<account> listAccount = new List<Account>();
        if(accountIdSet.size() > 0){
            list<aggregateResult> listAgrResult =  [SELECT AccountId , count(id) FROM contact WHERE accountId IN :accountIdSet group by AccountId];
            if(listAgrResult.size() > 0 ){
                for(integer i = 0 ; i < listAgrResult.size(); i++){
                    aggregateResult agr = listAgrResult.get(i);
                    Account acc = new Account();
                    acc.Id  = (id)agr.get('AccountId');
                    acc.Total_contacts__c = (decimal) agr.get('expr0');
                    listAccount.add(acc);
                }
            }
            if(listAccount.size() > 0){
                update listAccount;
            }
        }
   }
}