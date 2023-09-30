/***
*Developer by : Umesh Mor
*Description : Lead Trigger handler
***/
public class LeadTriggerHandler {
    /***
    *Description : Lead Trigger handler - handles before insert
    ***/
    public string missingFields = '';
    public void handlBeforeInsert(list<lead>leadList){ 
    	system.debug('In LeadTriggerHandler.handlBeforeInsert|Method entry,Data received is'+leadList);
        if(leadList != null){
            for(Lead leadRec : leadList){
                boolean isRecValid = validateLeadData(leadRec);
                if(isRecValid == false){
                  leadRec.addError('Record Not valid please check you data!!'+':'+'Missing Datafor fields'+missingFields);  
                }
            }   
        }
    }
     /***
    *Description : Lead Trigger handler - handles before insert
    ***/
    public void  handleBeforeUpdate(list<lead>leadList){
        system.debug('In LeadTriggerHandler.handlBeforeInsert|Method entry,Data received is'+leadList);
        if(leadList != null){
            for(Lead leadRec : leadList){
                boolean isRecValid = validateLeadData(leadRec);
                if(isRecValid == false){
                  leadRec.addError('Record Not valid please check you data!!');  
                }
            }   
        }
    }
     /***
    *Description : Lead Trigger handler - handles before insert
    ***/
    public void  handleAfterInsert(String leadListTrigger){
        system.debug('In LeadTriggerHandler.handleAfterInsert|Method entry,Data received is'+leadListTrigger);
        list<lead> leadList = (list<lead>)JSON.deserialize(leadListTrigger,list<lead>.class);
        list<account> listAccount = new List<Account>();
        if(leadList != null && leadList.size()>0){
            for(lead ld : leadList){
                Account acc = new Account();
                acc.Name = ld.company;
                acc.AnnualRevenue = ld.AnnualRevenue;
                listAccount.add(acc);
            }
            insert listAccount;
        }
    }
     /***
    *Description : Lead Trigger handler - handles before insert
    ***/
    public boolean validateLeadData(Lead leadRec){
        boolean isLeadValid = true;
        if(leadRec.AnnualRevenue == null){
            missingFields = 'Annual Revenue';
            isLeadValid = false;
        }  
        return isLeadValid;
    }
}