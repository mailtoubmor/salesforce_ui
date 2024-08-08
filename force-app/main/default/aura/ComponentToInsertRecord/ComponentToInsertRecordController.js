// casesForAccountController.js
({
    init : function(cmp, evt) {
        console.log('Init >>>>');
        var action = cmp.get("c.getCases");
        action.setParams({
            "accountId": cmp.get("v.recordId")
        });
        action.setCallback(this, function(response){
             console.log('response >>>>');
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.cases", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})