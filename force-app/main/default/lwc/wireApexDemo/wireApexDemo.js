import { LightningElement ,wire} from 'lwc';
import fetchAccountDetails from '@salesforce/apex/FetAccountDetails.fetchAllAccounts'
export default class WireApexDemo extends LightningElement {
    @wire(fetchAccountDetails)
    accounts;
    connectedCallback(){
        console.log('Accounts fetched==='+JSON.stringify(this.accounts));
    }
}