({
	handleClick : function(component, event, helper) {
		console.log('Getting executed'+component.get('v.contact.FirstName'));
        console.log('Hello');
        console.log('Getting executed LastName'+component.get('v.contact.LastName'));
        component.set("v.contact.AccountId",component.get("v.recordId"));
        var action = component.get('c.createContact');
        action.setParams({
            cont : component.get('v.contact')
        })
        action.setCallback(this,function(response){
            console.log('In Success');
            var state = response.getState();
            if(state === 'SUCCESS') {
               console.log('In Success>>>>>>');
               console.log('Success');
            }
            else {
               console.log('In Failure>>>>>>');
            }
        })
        $A.enqueueAction(action);
	}
})