public class CaseCreationController {
    public static void createCasesForClosedWonOpportunty(){
    	 list<opportunity> listOpprotunity = [SELECT Id ,AccountId FROM Opportunity WHERE AccountId != null AND StageName = 'ClosedWon']; 
         
    }
}