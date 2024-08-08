global class BatchToCreateBulkAccount implements Database.batchable<SObject> {
    //Batch apex runs in system 
    global Database.queryLocator  start(Database.BatchableContext bc){
        return database.getQueryLocator([SELECT Id FROM contact WHERE AccountId = null]); 
    }
    global void execute(Database.BatchableContext bc ,list<contact> lstContact){
        System.debug('IN EXECUTE METHOD--');
        if(lstContact.size() > 0){
            account acc = [SELECT Id FROM account WHERE name  = 'Default Account' limit 1];
            for(contact con : lstContact){
                con.accountId = acc.id ;
            }
            update lstContact;
        }
    }
    
    global void finish(Database.BatchableContext bc){
        //If we want to do any one time activity like sending mail of report 
    }
}