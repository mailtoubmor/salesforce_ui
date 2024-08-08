public with sharing class FetchContactController {
   @AuraEnabled(cacheable = true)
   public static list<contact> getContactRecords(){
    List<Contact> conList = new list<Contact>();
    try {
        conList = [SELECT FirstName,LastName,Email,Phone FROM Contact limit 10];
    } 
    catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
    }
    return conList;
   }
}