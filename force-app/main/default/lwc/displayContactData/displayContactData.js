import { LightningElement ,wire} from 'lwc';
import getContactRecords from '@salesforce/apex/FetchContactController.getContactRecords';
export default class DisplayContactData extends LightningElement {
    @wire(getContactRecords)
    conList;
}