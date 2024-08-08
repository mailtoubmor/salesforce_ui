@isTest(seeAllData = false)
public with sharing class FetchOpportunityDetailsControllerTest {
    @TestSetup
    static void createTestData() {
        Account acc = new Account();
        acc.Name = 'Test AccountA';
        insert acc ;
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.FirstName = 'Harman';
        con.LastName = 'Soles';
        con.Email = 'harmanName@test.com' + Math.floor(Math.random() * 1000);
        insert con;
        
        Contact conTwo = new Contact();
        conTwo.AccountId = acc.Id;
        conTwo.FirstName = 'Surya';
        conTwo.LastName = 'Singh';
        conTwo.Email = 'harmanName@test.com' + Math.floor(Math.random() * 1000);
        insert conTwo;
        
      	Opportunity opp = new Opportunity();
        opp.name = 'Opportunity 0';
        opp.amount = 1000;
        opp.ContactId = con.Id;
        opp.closeDate = Date.today();
        opp.AccountId = acc.Id ;
        opp.stageName = 'Prospecting';
        insert opp;
        
        FetchOpportunityDetailsController.fetchOpportunityDetails('Prospecting');
    }
    @isTest
    static void testOpportunitySearch() {
        list<Account> listAccount = [SELECT Id ,Name FROM Account];
        System.debug('listAccount>>>>>>'+listAccount);
        FetchOpportunityDetailsController.fetchOpportunityDetails(listAccount[0].Name);
    }
    
    @isTest
    static void testOpportunityConRoleSearch() {
    }
}