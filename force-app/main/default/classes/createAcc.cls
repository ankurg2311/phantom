public class createAcc {
 


    @AuraEnabled
    public static WrapperClass createAccountContact(WrapperClass wrapper) {
        system.debug('wrapper'+wrapper);
        system.debug('wrapper.accountID'+wrapper.accountID);
        if(wrapper.accountID == null || wrapper.accountID ==''){
        Account acct = new Account();
        Contact cont =  new Contact();
        acct.Name = wrapper.Name;
        acct.Sales_Person_Trader__c = wrapper.Trader;
        acct.Phone = wrapper.MainPhone;
        acct.Primary_line_of_Business__c = wrapper.PrimaryLB;
        acct.Assets_under_management__c = wrapper.AssestUM;
        acct.Government_Fund__c = wrapper.GFund;
        acct.Account_Type__c = wrapper.AccountType;
        acct.BillingCity = wrapper.BillingCity;
        acct.BillingCountry = wrapper.BillingCountry;
        acct.BillingPostalCode = wrapper.BillingPostalCode;
        acct.BillingState = wrapper.BillingState;
        insert acct;
        
        if(acct.ID != null){ 
            cont.FirstName = wrapper.FName;
            cont.LastName = wrapper.LName;
            cont.Email  = wrapper.CEmail;
            cont.Role__c  = wrapper.CRole;
            cont.Title__c  = wrapper.Title;
            cont.Geographical_Responsibility__c = wrapper.ProductOption;
            cont.Influence__c = wrapper.Influence;
            cont.BR_com__c = wrapper.BRcom;
            cont.AccountID = acct.ID; 
            insert cont;
        }
        if (acct.ID != null && cont.ID != null){
            wrapper.contactID = cont.ID;
            wrapper.accountID =acct.ID;
            return wrapper;

        }
    }else{
        Account acct = new Account();
        Contact cont =  new Contact();
        acct.Name = wrapper.Name;
        acct.Industry = wrapper.Industry;
        acct.Phone = wrapper.Phone;
        acct.ID = wrapper.accountID;
        update acct; 
        cont.FirstName = wrapper.FName;
        cont.LastName = wrapper.LName;
        cont.Email  = wrapper.CEmail;
        cont.AccountID =wrapper.accountID; 
        cont.ID = wrapper.contactID;
        update cont;
        return wrapper;
    }
        return null;
    }

    public class WrapperClass{
        @AuraEnabled
        public   String Name {get;set;}
           @AuraEnabled
           public  String Industry {get;set;}
           @AuraEnabled
           public String Phone {get;set;}
           @AuraEnabled
           public String FName {get;set;}
           @AuraEnabled
           public String LName {get;set;}
           @AuraEnabled
           public  String CEmail {get;set;}
           @AuraEnabled
           public  String accountID {get;set;}
           @AuraEnabled
           public  String contactID {get;set;}
           @AuraEnabled
           public  String Trader {get;set;}
           @AuraEnabled
           public  String MainPhone {get;set;}
           @AuraEnabled
           public  String PrimaryLB {get;set;}
           @AuraEnabled
           public  String AssestUM {get;set;}
           @AuraEnabled
           public  String GFund {get;set;}
           @AuraEnabled
           public  String AccountType {get;set;}
           @AuraEnabled
           public  String CRole {get;set;}
           @AuraEnabled
           public  String Title {get;set;}
           @AuraEnabled
           public  String ProductOption {get;set;}
           @AuraEnabled
           public  String Influence {get;set;}
           @AuraEnabled
           public  String BRcom {get;set;}
           @AuraEnabled
           public  String BillingState {get;set;}
           @AuraEnabled
           public  String BillingCity {get;set;}
           @AuraEnabled
           public  String BillingCountry {get;set;}
           @AuraEnabled
           public  String BillingPostalCode {get;set;}
        
    }
    


}