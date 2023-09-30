public with sharing class SearchAccountBasedOnName {
    String accountName = '';
    @AuraEnabled(cacheable=true)
    public static list<Account> searchAccountByName(String name){
        system.debug('In SearchAccountBasedOnName.searchAccountName');
        String searchString = '%'+name+'%';
        list<Account> accountList;
        if(String.IsNotBlank(name)){
            accountList = [SELECT Id,Name,AnnualRevenue,AccountNumber,Rating,Industry FROM Account WHERE Name like :searchString];
        }
        return accountList;
    }
}