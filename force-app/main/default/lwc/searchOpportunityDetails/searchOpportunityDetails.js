import { LightningElement } from 'lwc';
import fetOppDetails from '@salesforce/apex/OpportunitySearchController.fetchOpportunityDetails';
const columns = [
    { label: 'Opportunity Name', fieldName: 'name' , type : 'text'},
    { label: 'Opportunity Description', fieldName: 'description', type: 'text' },
    { label: 'Opportunity Close Date', fieldName: 'closeDate', type: 'date' },
    { label: 'Opportunity Account', fieldName: 'account', type: 'text' },
    { label: 'Rescent Opp Account Contact', fieldName: 'oppAccRecCon', type: 'text' },
    { label: 'Rescent Opp Account Contact Email', fieldName: 'oppAccRecConEmail', type: 'text' },
    { label: 'Rescent Opp Account Contact Phone', fieldName: 'oppAccRecConPhone', type: 'text' },
];
export default class SearchOpportunityDetails extends LightningElement {
    columns = columns;
    data = [];
    searchTerm = ''; 
    handleOnchange(event){
        console.log('In MEthod');
        this.searchTerm = event.target.value;
        console.log('In MEthod entered value'+this.searchTerm)
        if(this.searchTerm.length >= 4){
            console.log('IN IF');
            fetOppDetails({searchTerm : this.searchTerm})
            .then(result=>{
                console.log('Data is'+JSON.stringify(result));
                this.data = result;
                //console.log('Data is'+JSON.stringify(this.data));
            })
            .catch(error=>{
                console.log('In Error'+JSON.stringify(error));
            })
        }
    }

    get doesDataExists(){
        if(this.data){
            return true ;
        }
        return false ;
    }
}