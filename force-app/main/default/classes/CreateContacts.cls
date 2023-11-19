public with sharing class CreateContacts {
   @AuraEnabled
   public static string createContact(Contact con){
        String result ;
        try{
            insert con ;
            if(con.id != null)
            {
                result = 'Contact created successfully : Id is: '+con.id; 
            }
            else{
                result = 'Eror';
            }
        }
        catch(exception e){
            result = e.getMessage() ;
        }
        return result ;
   }
}