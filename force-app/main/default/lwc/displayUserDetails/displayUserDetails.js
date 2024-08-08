import { LightningElement } from 'lwc';
import CONTACT_FIRSTNAME from '@salesforce/schema/Contact.FirstName';
import CONTACT_PHONE from '@salesforce/schema/Contact.Phone';
import CONTACT_LASTNAME from '@salesforce/schema/Contact.LastName';
import CONTACT_EMAIL from '@salesforce/schema/Contact.Email';
import createContact from '@salesforce/apex/CreateContacts.createContact';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class DisplayUserDetails extends LightningElement {
_title = "Sample Title";
_message = "Sample Message";
_variant = "error";
conRec = {}
handleOnchange(event){
    let targetName = event.target.name;
    if(targetName === 'firstName'){
        this.conRec[CONTACT_FIRSTNAME.fieldApiName] = event.target.value;
    }
    if(targetName === 'lastName'){
        this.conRec[CONTACT_LASTNAME.fieldApiName] = event.target.value;
    }
    if(targetName === 'Phone'){
        this.conRec[CONTACT_PHONE.fieldApiName] = event.target.value;
    }
    if(targetName === 'Email'){
        this.conRec[CONTACT_EMAIL.fieldApiName] = event.target.value;
    }
}
handleClick(){
    console.log('BTN Clocked is');
    createContact({con : this.conRec})
    .then((result)=>{
        console.log('Result is'+result)
        this._title = "Record Insert";
        this._message = result ;
        this._variant = "success";
        this.showNotification(this._title,this._message,this._variant);
    })
    .catch((error)=>{
        console.log('error is'+error)
        this._title = "Record Insert";
        this._message = error ;
        this._variant = "error";
        this.showNotification(this._title,this._message,this._variant);
    })
}

showNotification(title,message,variant) {
    const evt = new ShowToastEvent({
        title:title,
        message: message,
        variant:variant,
    });
    this.dispatchEvent(evt);
    }
}