public with sharing class OpportunityWrapperDemo {
    @AuraEnabled
    public string opportunityName {get;set;}
    @AuraEnabled
    public string opportunityDescription {get;set;}
    @AuraEnabled
    public date  CloseDate {get;set;}
    @AuraEnabled
    public string  associatedAccount {get;set;}
    @AuraEnabled
    public string  associatedResentContact {get;set;}
    @AuraEnabled
    public string  associatedResContactEmail {get;set;}
    @AuraEnabled
    public string  associatedResContactPhone {get;set;}
}