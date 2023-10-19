import { LightningElement ,wire} from 'lwc';
import fetchAccountDetails from '@salesforce/apex/FetAccountDetails.fetchAllAccounts'
export default class WireApexDemo extends LightningElement {
    @wire(fetchAccountDetails)
    accounts;
    connectedCallback(){
        
    }

    renderedCallback(){
        console.log('Data'+JSON.stringify(this.accounts.data));
    }
}