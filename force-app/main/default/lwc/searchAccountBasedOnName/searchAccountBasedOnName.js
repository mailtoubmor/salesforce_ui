import { LightningElement } from 'lwc';
import searchAccountBasedOnName from '@salesforce/apex/SearchAccountBasedOnName.searchAccountByNameLatest';
const columns = [
    {   
        label: 'Ide', 
        fieldName: 'Id', 
        type: 'text' 
    },
    {
        label: 'Name',
        fieldName: 'Name',
        type: 'text'
    },
    {
        label: 'AnnualRevenue',
        fieldName: 'AnnualRevenue',
        type: 'text'
    },
    {
        label: 'AccountNumber',
        fieldName: 'AccountNumber',
        type: 'text'
    }
]
export default class SearchAccountBasedOnName extends LightningElement {
    contactList ;
    searchTerm = '';
    columns = columns;

    connectedCallback(){
        this.getAccountData();
    }
    handleInputSearchChange(event){
        this.searchTerm = event.target.value;
    }

    handleClick(){
        console.log('Clicked-----'+this.searchTerm);
        this.getAccountData();
    }

    get contactDataExists(){
        if(this.contactList){
            return true ;
        }
        return false ;
    }

    getAccountData(){
        searchAccountBasedOnName({name : this.searchTerm})
        .then(result=>{
            console.log('RESULT'+result);
            this.contactList = result;
        })
        .catch(error=>{
            console.log('Error'+error);
        }) 
    }
}