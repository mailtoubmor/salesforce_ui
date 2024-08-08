public class MyController { 
    Account account;
    public PageReference save() {     
        update account;
        return null;
    }

    public String getName() {
        return 'MyController';
    }
    
    public String setName() {
        System.debug('Set Name');
        return 'MyController';
    }

    public Account getAccount() {
          if(account == null) 
            account = [select id, name, site from Account 
                       where id = :ApexPages.currentPage().getParameters().get('id')];
        return account; 
    } 
}