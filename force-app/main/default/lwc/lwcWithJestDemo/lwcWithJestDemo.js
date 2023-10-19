import { LightningElement } from 'lwc';

export default class LwcWithJestDemo extends LightningElement {
    message = 'Hello JEST - Day One'
    showPara = false ;
    handleBtnClick(event){
        this.showPara = true ;
        this.message = 'data changed';
    }
}