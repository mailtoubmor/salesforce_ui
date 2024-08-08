public class CreateContact {
	@AuraEnabled
    public static void createContact(Contact cont){
        System.debug('In Method apex ');
        if(cont != null){
             System.debug('In If apex ');
            try{
               insert cont; 
                 System.debug('In If apex record  '+cont.Id);
            }
            catch(exception ex){
                 System.debug('In exception '+ex.getMessage());
            }
        }
    }
}