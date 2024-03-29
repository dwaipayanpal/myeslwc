import { LightningElement, api, wire } from 'lwc';
import getCustomerList from '@salesforce/apex/reservationManagerController.getCustomerList';

export default class CustomerList extends LightningElement {
    customers = [];
    @api sobject='Lead';
    errorMsg;
    msgForUser;
    wiredRecords;

    @wire (getCustomerList, {sObjectType: '$sobject'})
    wiredCustomerData(value){
        console.log(JSON.stringify(value));
        this.wiredRecords = value;
        if(value.error){
            this.errorMsg = value.error;
            this.MsgForUser = 'There was an issue loading customers.';
        }else if (value.data){
            this.customers = value.data;
        }
    }
}