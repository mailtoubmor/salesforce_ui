public with sharing class CaseController {
    @AuraEnabled(cacheable=true)
    public static List<Case> getCases(String accountId) {
        System.debug('The account>>>');
        list<case> listCase = new list<Case>();
         listCase =[SELECT AccountId, Id, Subject, Status, Priority, CaseNumber
                FROM Case
                WHERE AccountId = :accountId LIMIT 10];
        return listCase;
    }
}