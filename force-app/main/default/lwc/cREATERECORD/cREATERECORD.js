/* eslint-disable no-console */
import { LightningElement,api, track,wire} from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import ACCOUNT_TYPE from '@salesforce/schema/Account.Account_Type__c';
import ACCOUNT_TRADER from '@salesforce/schema/Account.Sales_Person_Trader__c';
import ACCOUNT_GFUND from '@salesforce/schema/Account.Government_Fund__c';
import CONTACT_BR_COM from '@salesforce/schema/Contact.BR_com__c';
import CONTACT_Geo_Response from '@salesforce/schema/Contact.Geographical_Responsibility__c';
import CONTACT_Role from '@salesforce/schema/Contact.Role__c';
import CONTACT_Influence from '@salesforce/schema/Contact.Influence__c';
import { NavigationMixin } from 'lightning/navigation';
import STREET_FIELD from '@salesforce/schema/Account.BillingStreet';
import CITY_FIELD from '@salesforce/schema/Account.BillingCity';
import POSTCODE_FIELD from '@salesforce/schema/Account.BillingState';
//import ACCOUNT_OBJECT from '@salesforce/schema/Account';
/*import NAME_FIELD from '@salesforce/schema/Account.Name';

import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import CONTACT_FIRST_NAME from '@salesforce/schema/Contact.FirstName';
import CONTACT_LAST_NAME from '@salesforce/schema/Contact.LastName';
import CONTACT_EMAIL from '@salesforce/schema/Contact.Email';*/
import createAccountContact from '@salesforce/apex/createAcc.createAccountContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreateRecordWithFieldIntigrity extends LightningElement {

    @track mapMarkers;
    @api recordId;
    @wire(getRecord, {
        recordId: '$recordId',
        fields: [ STREET_FIELD, CITY_FIELD, POSTCODE_FIELD ]
    })
    fetchAcc({ data, error }) {
        if (data) {
            this.mapMarkers = [
                {
                    location: {
                        Street: data.fields.BillingStreet.value,
                        City: data.fields.BillingCity.value,
                        State: data.fields.BillingState.value
                    }

                    
                }
            ];
            console.log('this.mapMarkers => ', JSON.stringify(this.mapMarkers));
        } else if (error) {
            console.error('ERROR => ', error);
        }
    }
    @wire(getPicklistValues, {
        recordTypeId : '012000000000000AAA',
        fieldApiName : INDUSTRY_FIELD
    })
    wiredPickListValue({ data, error }){
        console.log(` Picklist values are `);
        if(data){
            console.log(` Picklist values are `, data.values);
            this.industry = data.values;
            this.error = undefined;
        }
        if(error){
            console.log(` Error while fetching Picklist values  ${error}`);
            this.error = error;
            this.industry = undefined;
        }
    }

    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: ACCOUNT_TYPE })
    setPicklistOptionsType({error, data}) {
        if (data) {
            this.optionsAccountType = data.values;
        } else (error)
            console.log(error);
        
    }
    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: ACCOUNT_TRADER })
    setPicklistOptionsTrader({error, data}) {
        if (data) {
            this.optionsAccountTrader = data.values;
        } else (error)
            console.log(error);
        
    }

    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: ACCOUNT_GFUND })
    setPicklistOptionsGFund({error, data}) {
        if (data) {
            this.optionsFund = data.values;
        } else (error)
            console.log(error);
        
    }
    @wire(getPicklistValues, { recordTypeId: '0122v000001X2Ni', fieldApiName: CONTACT_BR_COM })
    setPicklistOptionsBR({error, data}) {
        if (data) {
            this.optionsBRcom = data.values;
        } else (error)
            console.log(error);
        
    }

    @wire(getPicklistValues, { recordTypeId: '0122v000001X2Ni', fieldApiName: CONTACT_Geo_Response })
    setPicklistOptionsGR({error, data}) {
        if (data) {
            this.optionsProductResponse = data.values;
        } else (error)
            console.log(error);
        
    }
    @wire(getPicklistValues, { recordTypeId: '0122v000001X2Ni', fieldApiName: CONTACT_Role })
    setPicklistOptionsRole({error, data}) {
        if (data) {
            this.optionsRole = data.values;
        } else (error)
            console.log(error);
        
    }
    @wire(getPicklistValues, { recordTypeId: '0122v000001X2Ni', fieldApiName: CONTACT_Influence })
    setPicklistOptionsInfluence({error, data}) {
        if (data) {
            this.optionsInfluence = data.values;
        } else (error)
            console.log(error);
        
    }
    
    @track name = '';
    @track trader = '';
    @track industry ;
    @track phone = '';
    @track GFund ='';
    @track AccountType ='';
    @track contactFname = '';
    @track contactLname = '';
    @track contactEmail = '';
    @track formcompleted = false;
    @track recordId;
    @track open = false;
    @track recordCreated = false;
    @track CRole ='';
    @track CName = '';
    @track Title = '';
    @track Influence = '';
    @track BRcom = '';
    @track
    optionsFund;
    @track
    optionsRole;
    @track
    optionsAccountType ;
    @track
    optionsAccountTrader ;
    @track
    optionsInfluence;
    @track
    optionsBRcom ;
    @track
    optionsProductResponse ;
    @track
    MainPhone;
    @track
    PrimaryLB ='';
    @track
    AssestUM ='';
    @track
    ProductOption = '';
    @track
    accountID;
    @track
    BillingCity;
    @track
    BillingCountry;
    @track
    BillingPostalCode;
    @track
    BillingState;
    @track
    BillingStreet; 
    @track
    formCreate = true;
    @track
    rec;


    

    rec = {
        Trader :this.trader,
        Name : this.name,
        MainPhone :this.MainPhone,
        PrimaryLB :this.PrimaryLB,
        AssestUM :this.AssestUM,
        Industry : this.industry,
        Phone : this.phone,
        FName : this.contactFname,
        LName : this.contactLname,
        GFund : this.GFund,
        CRole : this.CRole,
        CName : this.CName,
        Title : this.Title,
        CEmail :this.contactEmail,
        accRecordID:this.recordId,
        optionsProductResponse : this.optionsProductResponse,
        Influence : this.Influence,
        BRcom : this.BRcom,
        AccountType : this.AccountType,
        ProductOption : this.ProductOption,
        BillingCity : this.BillingCity,
        BillingState : this.BillingState,
        BillingStreet:this.BillingStreet,
        BillingCountry:this.BillingCountry,
        BillingPostalCode: this.BillingPostalCode,
     
        accountID : this.accountID

    }
    navigateToRecordEditPage(recordID) {
        // Opens the Account record modal
        // to view a particular record.
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordID,
                objectApiName: 'Account', // objectApiName is optional
                actionName: 'edit'
            }
        });
    }
    handleNameChange(event) {
        this.rec.Name = event.target.value;
        console.log("name1", this.rec.Name);
    }
    handleMainPhoneChange(event) {
        this.rec.MainPhone = event.target.value;
        console.log("MainPhone", this.rec.MainPhone);
    }
    handlePrimaryLBChange(event) {
        this.rec.PrimaryLB = event.target.value;
        console.log("PrimaryLB", this.rec.PrimaryLB);
    }
    handleAssestUMChange(event) {
        this.rec.AssestUM = event.target.value;
        console.log("AssestUM", this.rec.AssestUM);
    }
    handleGFundchange(event) {
        this.rec.GFund = event.target.value;
        console.log("GFund", this.rec.GFund);
    }
    handleAddressChange(event) {
        this.rec.BillingCity = event.target.city;
        this.rec.BillingCountry = event.target.country;
        this.rec.BillingState = event.target.province;
        this.rec.BillingPostalCode = event.target.postal-code;
        console.log("city", event.target.city);
        console.log("country", event.target.country);
        console.log("province", event.target.province);
        console.log("BillingPostalCode", event.target.BillingPostalCode);
    }
    handleIndChange(event) {
        this.rec.Industry = event.target.value;
        console.log("Industry", this.rec.Industry);
    }
    handleAccountTraderChange(event) {
        this.rec.trader = event.target.value;
        console.log("Trader", this.rec.trader);
    }

    handlePhnChange(event) {
        this.rec.Phone = event.target.value;
        console.log("Phone", this.rec.Phone);
    }

    handleFNameChange(event) {
        this.rec.FName = event.target.value;
        console.log("Fname", this.rec.FName);
    }
    handleCNameChange(event) {
        this.rec.CName = event.target.value;
        console.log("CName", this.rec.CName);
    }
    handleCTitleChange(event) {
        this.rec.Title = event.target.value;
        console.log("Title", this.rec.Title);
    }
    handleLNameChange(event) {
        this.rec.LName = event.target.value;
        console.log("Lname", this.rec.LName);
    }
    handleradiochange(event) {
        this.rec.GFund = event.target.value;
        console.log("GFund", this.rec.GFund);
    }
    handleradiochangeAcType(event) {
        this.rec.AccountType = event.target.value;
        console.log("AccountType", this.rec.AccountType);
    }
    handleradiochangeCRole(event) {
        this.rec.CRole = event.target.value;
        console.log("CRole", this.rec.CRole);
    }
    handleradiochangeInfluence(event) {
        this.rec.Influence = event.target.value;
        console.log("Influence", this.rec.Influence);
    }
    handleradiochangeBRcom(event) {
        if(this.rec.BRcom != ''){
            this.rec.BRcom += '; ' + event.target.value;
        }else {
            this.rec.BRcom = event.target.value;
        }
        console.log("BRcom", this.rec.BRcom);
    }
    handleCEmailChange(event) {
        this.rec.CEmail = event.target.value;
        console.log("CEmail", this.rec.CEmail);
    }
    handleChangeProductOption(event) {
        if(this.rec.ProductOption != ''){
            this.rec.ProductOption += '; ' + event.target.value;
        }else {
            this.rec.ProductOption = event.target.value;
        }
        
        console.log("ProductOption", this.rec.ProductOption);
    }
    handleEditASClick(event) {
        this.formcompleted = false;
        this.formCreate = true;
    }
    handleSubmitClick(event){
        this.formcompleted = true;
        this.formCreate = false;
    }
    handleClick() {
        createAccountContact({ wrapper : this.rec })
            .then(result => {
                this.message = result;
                this.error = undefined;
                if(this.message !== undefined) {
                    /*this.rec.Name = '';
                    this.rec.Industry = '';
                    this.rec.Phone = '';
                    this.rec.FName = '';
                    this.rec.LName = '';
                    this.rec.CEmail = '';*/
                    this.rec=result;
                    this.formcompleted = false;
                    this.recordCreated = true;
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Account and Contact created  with Account ID :  '+result.accountID,
                            variant: 'success',
                        }),
                      
                    );
                   
                }
                
               // console.log(JSON.stringify(result));
                //console.log("result", this.message);
                
            })
            .catch(error => {
                this.message = undefined;
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
                console.log("error", JSON.stringify(this.error));
            });

            
    }



    handleClickforEdit(event) {
        console.log("In HandleClick");
        const recId = event.target.name;
        this.rec2Id = event.currentTarget.name;
        console.log("Selected Account Id:::", recId);
        console.log("Selected Account Id rec2Id :::", this.rec2Id);
        this.open = true;
    }

    closeModal() {
        console.log("In closeModal");
        this.open = false;
    }

    
}