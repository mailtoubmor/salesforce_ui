trigger AccountTrigger on Account (before insert,after insert , before update , after update , after delete , after undelete) {
    //Context variable
    	//1. Trigger.isBefore , Trigger.isInsert
    	//2.Trigger.New
    	//There shounot be dml while in before update -----
    if(Trigger.isBefore && Trigger.isInsert){
        for(Account acc : Trigger.New){
            if(acc.rating == 'hot' && acc.AnnualRevenue == null){
               	acc.AnnualRevenue = 4.9;
                //acc.addError('For Hot accounts , annual revenue should atleast be defaulted with 0');
            }
        }
    }
    
     if(Trigger.isAfter && Trigger.isInsert){
        list<contact> listContact = new list<contact>();
        for(Account acc : Trigger.New){
                contact con = new contact();
                con.lastName = acc.Name;
                con.AccountId = acc.Id;//
                listContact.add(con);
        }
        if(listContact.size() > 0 ){
            insert listContact; 
        }
    }
}