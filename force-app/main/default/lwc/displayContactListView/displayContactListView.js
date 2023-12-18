import { LightningElement,wire } from 'lwc';
import getContactList from '@salesforce/apex/ContactListForLwcUI.FetchContactList';
const columns = [
    {   
        label: 'First Name', 
        fieldName: 'FirstName', 
        type: 'text' 
    },
    {
        label: 'Last Name',
        fieldName: 'LastName',
        type: 'text'
    },
    {
        label: 'Email',
        fieldName: 'Email',
        type: 'text'
    },
    {
        label: 'Phone',
        fieldName: 'Phone',
        type: 'text'
    }
]
export default class DisplayContactListView extends LightningElement {
    contactList  ;
    columns = columns;
    @wire(getContactList)
    contacts({data,error}){
        if(data){
            this.contactList = data;
            console.log('DATA..'+JSON.stringify(data))
        }
        else if(error){
            console.log('ERROR'+JSON.stringify(error))
        }
    }

    getSelectedName(event){
        console.log('Row Selected'+event);
    }
}