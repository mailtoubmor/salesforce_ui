public with sharing class ContactListForLwcUI {
    @AuraEnabled(cacheable=true)
    public static list<contact> FetchContactList(){
        list<contact> listContact = new list<Contact>();
        try {
            listContact = [SELECT Id,FirstName,LastName,Email,Phone FROM contact];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return listContact;
    }
}