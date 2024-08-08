import { LightningElement ,wire , track} from 'lwc';
import fetchOpportunityDetails from '@salesforce/apex/SearchSObjectDataController.fetchOpportunityData';
export default class SearchSObjectData extends LightningElement {
    @track pagenumber = 1;
    @track recordstart = 0;
    @track recordend = 0;
    @track totalrecords = 0;
    @track pagesize = 3;
    @track totalpages = 1;
    @track showpagination=true;
    @track pagelist;
    @track isLoaded = false;
    @track oppData;
    searchTerm = '';
    @track oppColumns = [
        {
            label: 'Name ', 
            fieldName: 'Name', 
            type: 'text'
        },
        { 
            label: 'Description', 
            fieldName: 'Description', 
            type: 'text'
        },
        { 
            label: 'Close Date', 
            fieldName: 'CloseDate', 
            type: 'date'
        },
        { 
            label: 'Account Name', 
            fieldName: 'accountName', 
            type: 'text'
        },
        { 
            label: 'Account Recent Contact', 
            fieldName: 'accountRecentContact', 
            type: 'text'
        },
        { 
            label: 'Recent Contact Email', 
            fieldName: 'rescentContactEmail', 
            type: 'text'
        },
        { 
            label: 'Recent Contact Phone', 
            fieldName: 'recentContactPhone', 
            type: 'text'
        }
    ];

    handleInputChange(event){
        console.log('IN INPUT Change======>');
        this.searchTerm = event.target.value;
        console.log('Proceeding with apex call');
        if(this.searchTerm.length >=4){
            console.log('Changed value'+this.searchTerm);
            fetchOpportunityDetails(
                {
                    pageNumber: "$pagenumber",
                    pageSize: "$pagesize",
                    searchTerm : this.searchTerm
                }
            )
            .then(result=>{
                    console.log('Fetched Successful');
                    this.oppData = result.data;
                    this.totalrecords = result.totalRecords;
                    this.recordstart = result.recordStart;
                    this.recordend = result.recordEnd;
                    this.totalpages = Math.ceil(this.totalrecords / this.pagesize);
                    this.generatePage
                    List(this.pagenumber, this.totalpages);
        
                    this.isLoaded = false;
                    if(this.totalpages==1){
                        this.showpagination=false;
                    }else{
                    this.showpagination=true; 
                    }
            })
            .catch(error=>{
                console.log('Call Failed');
                console.log(JSON.stringify(error));
            })
        }
       
    }

    generatePageList = (pagenumber, totalpages) => {
        var pagenumber = parseInt(pagenumber);
        var pageList = [];
        var totalpages = this.totalpages;
        this.pagelist = [];
        if (totalpages > 1) {
            if (totalpages < 3) {
                if (pagenumber == 1) {
                    pageList.push(1, 2);
                }
                if (pagenumber == 2) {
                    pageList.push(1, 2);
                }
            } else {
                if (pagenumber + 1 < totalpages && pagenumber - 1 > 0) {
                    pageList.push(pagenumber - 1, pagenumber, pagenumber + 1);
                } else if (pagenumber == 1 && totalpages > 2) {
                    pageList.push(1, 2, 3);
                } else if (pagenumber + 1 == totalpages && pagenumber - 1 > 0) {
                    pageList.push(pagenumber - 1, pagenumber, pagenumber + 1);
                } else if (pagenumber == totalpages && pagenumber - 1 > 0) {
                    pageList.push(pagenumber - 2, pagenumber - 1, pagenumber);
                }
            }
        }
        this.pagelist = pageList;
    };

    handleFirst(event) {
        this.isLoading = true;
        var pagenumber = 1;
        this.pagenumber = pagenumber;
    }

    processMe(event) {
        var checkpage = this.pagenumber;
        this.pagenumber = parseInt(event.target.name);
        if (this.pagenumber != checkpage) {
        this.isLoading = true;
        }
    }

    get disableFirst() {
        if (this.pagenumber == 1) {
        return true;
        }
        return false;
    }

    get disableNext() {
        if (
        this.pagenumber == this.totalpages ||
        this.pagenumber >= this.totalpages
        ) {
        return true;
        }
        return false;
    }

    handlePrevious(event) {
        this.isLoading = true;
        this.pagenumber--;
    }

    handleNext(event) {
        this.isLoading = true;
        this.pagenumber = this.pagenumber + 1;
    }

    handleLast(event) {
        this.isLoading = true;
        this.pagenumber = this.totalpages;
    }


}