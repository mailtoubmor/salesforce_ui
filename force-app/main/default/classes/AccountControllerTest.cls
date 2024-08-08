@isTest
public class AccountControllerTest {
    @isTest
    public static void testMethod1(){
        Account acc = new Account();
        acc.Name = 'Prashanth Enterprises';
        acc.Rating = 'Hot';
        insert acc;
        
        AccountController.fetchAccount();
    }
}