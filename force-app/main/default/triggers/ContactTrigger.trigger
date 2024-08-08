trigger ContactTrigger on contact(
  after insert,
  after update,
  after delete,
  after undelete
) {
  list<contact> listContact = new List<contact>();
  set<id> accountId = new Set<id>();
  if (Trigger.isDelete) {
    System.debug('IN DELETE ===>');
    listContact = Trigger.old;
  } else {
    listContact = Trigger.New;
  }

  if (listContact.size() > 0) {
    for (contact con : listContact) {
      if (con.accountId != null) {
        accountId.add(con.accountId);
      }

      if(Trigger.isUpdate){
            contact contOldRec = Trigger.oldMap.get(con.Id); 
            if(contOldRec != null && con.accountId != contOldRec.accountId){
                accountId.add(contOldRec.accountId);
            }

            if(accountId.contains(con.accountId)){
                accountId.remove(con.accountId);
            }
      }

      if(accountId.size() > 0){
            list<account> listAccount = new list<account>();
            for(Id accId : accountId){
                Account acc = new Account();
                acc.id = accId;
                acc.Total_contacts__c = 0;
                listAccount.add(acc);
            }
            update listAccount;
      }
    }

    if (accountId.size() > 0) {
      ContactTriggerHandler.handleContactTriggerOperations(accountId);
    }
  }
}