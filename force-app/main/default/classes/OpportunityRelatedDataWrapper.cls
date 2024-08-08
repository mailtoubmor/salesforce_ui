/**
 * Author : .
 * Release :
 * @description : 
 */
public with sharing class OpportunityRelatedDataWrapper {
    /*** @description : opportunityName**/
    @AuraEnabled
    public string opportunityName {get;set;}

    /*** @description : opportunityDescription**/
    @AuraEnabled
    public string opportunityDescription {get;set;}

    /*** @description : closeDate**/
    @AuraEnabled
    public date  closeDate {get;set;}

     /*** @description : associatedAccount**/
    @AuraEnabled
    public string  associatedAccount {get;set;}

     /*** @description : associatedResentContact**/
    @AuraEnabled
    public string  associatedResentContact {get;set;}
    
     /*** @description : associatedResContactEmail**/
    @AuraEnabled
    public string  associatedResContactEmail {get;set;}

     /*** @description : associatedResContactPhone**/
    @AuraEnabled
    public string  associatedResContactPhone {get;set;}

     /*** @description : hasRecordAccess**/
     @AuraEnabled
     public boolean  hasRecordAccess {get;set;}
}