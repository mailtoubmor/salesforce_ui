public with sharing class FetAccountDetails {
    @AuraEnabled(cacheable=true)
   public static list<account> fetchAllAccounts(){
        list<account> lstAccount = new list<account>();
        lstAccount = [SELECT Id,Name FROM Account limit 5];
        return lstAccount;
   }
}