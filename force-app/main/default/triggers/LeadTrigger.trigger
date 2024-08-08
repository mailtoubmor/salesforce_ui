trigger LeadTrigger on Lead (before insert,before delete, before update , after update,after insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        System.debug('In LeadTrigger.beforeInsert operation- the data in context is'+trigger.new);
        LeadTriggerHandler leadHandle = new LeadTriggerHandler();
        leadHandle.handlBeforeInsert(Trigger.New);
        System.debug('Exit from before trigger');
    }
     if(Trigger.isBefore && Trigger.isUpdate){
        System.debug('In LeadTrigger.beforeUpdate operation- the data in context is'+trigger.new);
        LeadTriggerHandler leadHandle = new LeadTriggerHandler();
        leadHandle.handleBeforeUpdate(Trigger.New);
        System.debug('Exit from before trigger');
    }

    if(Trigger.isAfter && Trigger.isInsert){
        System.debug('In LeadTrigger.afterInsert operation - the data in context is'+trigger.new);
        string leadData = JSON.serialize(Trigger.New);
        System.debug('Data being sent is'+leadData);

        LeadTriggerHandler leadHandle = new LeadTriggerHandler();
        leadHandle.handleAfterInsert(leadData);
        System.debug('Exit from before trigger');
    }
}