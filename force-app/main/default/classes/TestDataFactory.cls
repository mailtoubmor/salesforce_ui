public with sharing class TestDataFactory {
    /** 
    * ******************************************************
    * This method is test data for create Account
    * ******************************************************
    */
    
    public static list<Account>  createAccount(integer noOfRecords){
        list<Account> listAccount = new list<Account>();
        for(Integer i =0 ; i<10 ;i++){
            Account acc = new Account();
            acc.Name = 'Test Account *'+i;
            listAccount.add(acc);
        }
        insert listAccount;
        System.debug('listAccount'+listAccount);
        return listAccount;
    }

    /**
     * *******************************************************
     * This method is test data for create contact object
     * *******************************************************
     */
    public static list<contact> createContact(list<Account>listAccount){
        list<contact> conList = new list<contact>();
        Integer i = 0 ;
        for(account acc : listAccount){
            i += 1;
            Contact con = new Contact();
            con.AccountId = acc.Id;
            con.FirstName = 'FirstName';
            con.LastName = 'LastName'+i;
            con.Email = 'FirstName@test.com' + Math.floor(Math.random() * 1000);
            conList.add(con);
        }
        insert conList;
        return conList;
    }

    /**
    * ***********************************************************
    * This method is test data for create Opportunity object
    * ***********************************************************
    */
    
    public static List<Opportunity>createOpportunity(list<Account> listAccount) {
        System.debug('REceived AccountList'+listAccount);
		List<Opportunity> oppsList = new List<Opportunity>();
		for(Integer i = 1; i <listAccount.size(); i++) {
			Opportunity opp = new Opportunity();
			opp.name = 'Opportunity 0 ' + i;
			opp.accountId = listAccount[0].Id;
            System.debug('OPP'+opp.accountId);
			opp.amount = 1000;
			opp.closeDate = Date.today();
			opp.stageName = 'Prospecting';
			oppsList.add(opp);
		}
        insert oppsList;
		return oppsList;
	}
    
     /**
    * ***********************************************************
    * This method is test data for create Opportunity object
    * ***********************************************************
    */
    
    public static void createOpportunityContactRole(List<Opportunity> oppsList,list<Contact> contList ) {
		List<OpportunityContactRole> oppConRoleList = new List<OpportunityContactRole>();
		for(Integer i = 1; i <oppsList.size(); i++) {
			OpportunityContactRole oppConRole = new OpportunityContactRole();
			oppConRole.OpportunityId = oppsList[0].Id;
            oppConRole.ContactId = contList[0].Id;
			oppConRoleList.add(oppConRole);
		}
        insert oppConRoleList;
	}
}