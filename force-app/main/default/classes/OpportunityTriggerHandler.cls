public with sharing class OpportunityTriggerHandler {
   public static void handleAfterInsert(List<Opportunity>lstOpp){
        set<Id> setAccountId = new set<Id>();
        if(lstOpp != null && lstOpp.size() > 0){
            for(Opportunity opp : lstOpp){
                if(opp.accountId != null){
                    setAccountId.add(opp.accountId);
                }
            }
            calculateTotalRevenue(setAccountId);
        }
   }

   
   public static void handleAfterUpdate(list<Opportunity> oppList ,Map<Id,Opportunity> oldMap){
        set<Id> setAccountId = new set<Id>();
        if(oppList != null && oppList.size() > 0){
            for(Opportunity opp : oppList){
                setAccountId.add(opp.accountId);
                if(opp.Amount != null && opp.Amount != oldMap.get(opp.Id).Amount){
                    setAccountId.add(oldMap.get(opp.Id).accountId);
                }
            }
            calculateTotalRevenue(setAccountId);
        }
   }

   public static void handleAfterDelete(list<Opportunity> oppList ){
        set<Id> setAccountId = new set<Id>();
        if(oppList != null && oppList.size() > 0){
            for(Opportunity opp : oppList){
                setAccountId.add(opp.accountId);
            }
            calculateTotalRevenue(setAccountId);
        }
    }


   public static void calculateTotalRevenue(set<id>setAccountId){
        Map<Id,Integer> mapAccountIdTotalAmt = new Map<Id,Integer>();
        if(setAccountId.size() > 0){
            list<Opportunity> oppList = [SELECT Id,AccountId,Amount FROM Opportunity WHERE AccountId IN : setAccountId];
            if(oppList.size() > 0){
                Integer total =0 ;
                for(Opportunity opp : oppList){
                    if(mapAccountIdTotalAmt.containskey(opp.accountId)){
                        total = mapAccountIdTotalAmt.get(opp.accountId);
                    }
                    if(opp.Amount != null){
                        total = total + (Integer.valueOf(opp.Amount));
                    }
                    mapAccountIdTotalAmt.put(opp.accountId, total );
                }
            }

            List<Account> accList = new List<Account>();
            for(Id accId : mapAccountIdTotalAmt.keySet()){
                   Account acc = new Account();
                   acc.Id = accId ;
                   acc.Total_Opportuity__c = mapAccountIdTotalAmt.get(accId) ;
                   accList.add(acc);
            }

            if(accList.size() > 0){
                update accList;
            }
        } 
   }
}