public class ApexInvocable {
	@InvocableMethod(label='Delete Opp')
    public static void deleteRelatedOpportunity(list<string> Ids){
        list<opportunity> listOpp = [SELECT Id FROM Opportunity WHERE accountId != null  AND accountId  IN : Ids AND stageName = 'Closed Won' ];
        delete  listOpp;
    }
}