import { LightningElement,track } from 'lwc';
import fetchOpportunityAndRelatedDetails from '@salesforce/apex/FetchOpportunityDetailsController.fetchOpportunityDetails';
import USER_ID from '@salesforce/user/Id';
const DELAY = 200;
export default class OpportunityAndRelatedDetails extends LightningElement {
    @track oppData;
    searchTerm = '';
    visibleOpportunities;
    @track oppColumns = [
        {
            label: 'Name ', 
            fieldName: 'opportunityName', 
            type: 'text'
        },
        { 
            label: 'Description', 
            fieldName: 'opportunityDescription', 
            type: 'text'
        },
        { 
            label: 'Close Date', 
            fieldName: 'closeDate', 
            type: 'date'
        },
        { 
            label: 'Account Name', 
            fieldName: 'associatedAccount', 
            type: 'text'
        },
        { 
            label: 'Account Recent Contact', 
            fieldName: 'associatedResentContact', 
            type: 'text'
        },
        { 
            label: 'Recent Contact Email', 
            fieldName: 'associatedResContactEmail', 
            type: 'text'
        },
        { 
            label: 'Recent Contact Phone', 
            fieldName: 'associatedResContactPhone', 
            type: 'text'
        }
    ];

    handleInputChange(event){
        this.searchTerm = event.target.value;
        window.clearTimeout(this.delayTimeout);
        this.delayTimeout = setTimeout(() => {
            try{
                if(this.searchTerm.length >=4){
                    fetchOpportunityAndRelatedDetails(
                        {
                            searchTerm : this.searchTerm
                        }
                    )
                    .then(result=>{
                        console.log('Fetched Successful');
                        this.oppData = result;
                        for(let i=0; i<this.oppData.length; i++){
                            console.log('Opp Name is'+this.oppData[i].opportunityName);
                            console.log('hasRecordAccess'+this.oppData[i].opportunityName);
                            if(!this.oppData[i].hasRecordAccess){
                                let n = 3;
                                this.oppData[i].opportunityName = '****' + this.oppData[i].opportunityName.slice(n);
                            }
                            console.log('Opp Name is masked'+this.oppData[i].opportunityName);
                        }
                        this.visibleOpportunities = this.oppData;
                        console.log('The data is visible '+JSON.stringify(this.visibleOpportunities));
                    })
                    .catch(error=>{
                        console.log('Call Failed');
                        console.log(JSON.stringify(error));
                    })
                }
            }
            catch (err) {
                console.log(err);
            }
        }, DELAY);
    }

    get dataPresentToDisplay(){
        if(this.visibleOpportunities && this.visibleOpportunities.length > 0){
            return true ;
        }
        return false;
    }

    updateContactHandler(event){
        this.visibleOpportunities=[...event.detail.records]
        console.log('EVENT DATA >>>'+JSON.stringify(event.detail.records));
    }
}