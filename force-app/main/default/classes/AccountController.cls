public class AccountController {
    public static void fetchAccount(){
        list<account> listAccounts = [SELECT Id ,Name ,rating ,AnnualRevenue FROM Account WHERE rating = 'hot' AND AnnualRevenue = null];
        System.debug('Data fetched is'+listAccounts.size());
        for(Account acc : listAccounts){
             acc.AnnualRevenue = 0;
        }
        update listAccounts;
    }
}