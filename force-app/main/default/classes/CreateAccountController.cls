public class CreateAccountController {
    public static list<account> createAccount(integer noOfRec){
         list<account> accList = new list<Account>();
        if(noOfRec != 0){
           
            for(integer i = 0 ; i< noOfRec ; i++){
                Account acc = new Account();
                acc.name = 'DEMO ACCOUNT'+i;
                accList.add(acc);
            }
            //no dml inside for loop 
            insert accList;
        }
        return accList;
    }
}