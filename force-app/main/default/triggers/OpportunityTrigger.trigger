//Trigger : Piece of code that gets executed when certain event or dml operation takes place
//Why trigger 
//They are used for complex validation 
//To validate and update the data 
//To update/create related records
//Lightning flows - wF / PB 
//Types :
//Before Trigger - Validation and updates of records which initiates trigger 
//After Trigger - Updatating/create/deleting the related object records ..
//Best practises :
    //1.Trigger should be logic less
    //2.Trigger Bulkified - No dml inside the for loop 

trigger OpportunityTrigger on Opportunity (before insert,after insert,before update , after update , before delete, after delete ,after undelete) {
    If((Trigger.isInsert || Trigger.isUpdate) && Trigger.isBefore){
        OpportunityTriggerHandlerNew.handleInsertUpdateDml(Trigger.New);
    }	
     If((Trigger.isInsert || Trigger.isUpdate) && Trigger.isAfter){
        OpportunityTriggerHandlerNew.handleInsertUpdateDmlAfterContext(Trigger.New);
    }	
}