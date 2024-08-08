//Wrapper class
//list account with contact info
//Wrapper class can be a innner class or it can be saperate class
public class WrapperClassContoller {
    public static list<wrapperClass> getAccountInfo(){
        list<wrapperClass> accWrappList = new list<wrapperClass>();
        list<Account> listAcc= [SELECT Id,Name FROM Account limit 10];
        if(listAcc.size() > 0){
            for(Account acc : listAcc){
                wrapperClass accWrap = new wrapperClass();
                accWrap.acc = acc;
                accWrap.Isactive = true ;
                accWrappList.add(accWrap);
            }
        }
        return accWrappList;
    }
}