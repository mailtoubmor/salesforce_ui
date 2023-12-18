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

    @AuraEnabled
    public static list<Account> searchAccountByNameLatest(String name){
        system.debug('In SearchAccountBasedOnName.searchAccountName');
        String searchString = '%'+name+'%';
        list<Account> accountList;
        if(String.IsNotBlank(name)){
            accountList = [SELECT Id,Name,AnnualRevenue,AccountNumber,Rating,Industry FROM Account WHERE Name like : searchString];
        }
        else{
            accountList =[SELECT Id,Name,AnnualRevenue,AccountNumber,Rating,Industry FROM Account limit 10];
        }
        return accountList;
    }
}