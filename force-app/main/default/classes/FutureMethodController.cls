public class FutureMethodController {
    public static void createContactForDefaultAccount(){
        System.debug('In FutureMethodController.createContactForDefaultAccount');
        Account acc = [SELECT Id FROM Account WHERE Name = 'Default Account' limit 1];
        FutureMethodController.insertContactForAccount(acc.Id);
    }
    @future
    public static void insertContactForAccount(string accId){
        list<contact> conList = new list<Contact>();
        for(Integer i = 0 ; i < 100 ; i++){
            contact con = new contact();
            con.accountId = accId;
            con.lastName = 'Sample Data';
            conList.add(con);
        }
         
        if(conList.size() > 0){
            insert conList;
        }
    }
}