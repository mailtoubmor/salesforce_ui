public class QueableApexController implements Queueable{
    public void execute(QueueableContext context) {
        Account acc =[SELECT Id FROM Account WHERE Name='Default Account' limit 1];   
        list<contact> conList = new list<Contact>();
        for(Integer i = 0 ; i < 100 ; i++){
            contact con = new contact();
            con.accountId = acc.Id;
            con.lastName = 'Sample Data';
            conList.add(con);
        }
         
        if(conList.size() > 0){
            insert conList;
        }
    }
}