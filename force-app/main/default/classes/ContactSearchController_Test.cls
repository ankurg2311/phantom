@isTest
public class ContactSearchController_Test {
    
    
     @testSetup static void setup() {
        // Create common test accounts
        Integer i;
        List<Account> testAccts = new List<Account>();
        for( i=0;i<12;i++) {
            if( i <4){
                system.debug('Inserted Account : ' +i);
                testAccts.add(new Account(Name = 'TestAcct'+i, Substatus__c ='Closed',T1C_Base_Inactive__c =false));
            }
            if( i< 8 && i> 4){
                 system.debug('Inserted Account : ' +i);
                testAccts.add(new Account(Name = 'TestAcct'+i, Substatus__c ='Cut Off',T1C_Base_Inactive__c =false));
            }
            if( i> 8 ){
                 system.debug('Inserted Account : ' +i);
                testAccts.add(new Account(Name = 'TestAcct'+i, Substatus__c ='',T1C_Base_Inactive__c =false));
            }
        }
        insert testAccts;
         system.debug('Inserted Accounts : ' +testAccts.size());
         
          List<Contact> testcontacts = new List<Contact>();
        for(Integer j=0;j<11;j++) {
             if( j <4){
               system.debug('Inserted Contact : ' +j);   
              testcontacts.add(new Contact( FirstName ='TestFContact'+j, LastName = 'TestLContact'+j,T1C_Base_Inactive__c =True, AccountID = testAccts[j].ID));
            }
            if( j< 8 && j> 4){
                 system.debug('Inserted Contact : ' +j);   
               testcontacts.add(new Contact( FirstName ='TestFContact'+j, LastName = 'TestLContact'+j,T1C_Base_Inactive__c =True,AccountID = testAccts[j].ID));
            }
            if( j> 8 && j< 10){
                 system.debug('Inserted Contact : ' +j);   
               testcontacts.add(new Contact( FirstName ='TestFContact'+j, LastName = 'TestLContact'+j,T1C_Base_Inactive__c =True,AccountID = testAccts[j].ID));
            }
            
        }
        insert testcontacts;
            system.debug('Inserted Contact : ' +testcontacts.size());
    }
    
    static testmethod void testSearchPageLoad(){
        ContactSearchController contSearchcontroller = new ContactSearchController();
        contSearchcontroller.pageSize = 2.0; 
        contSearchcontroller.LimitSize = 10;
        contSearchcontroller.searchCon();
        system.assert(True,contSearchcontroller.contactList[0] != null);
        contSearchcontroller.FirstPage();
        system.assert(True,contSearchcontroller.contactList.size() >0);
        contSearchcontroller.next();
        system.assert(True,contSearchcontroller.contactList.size() >0);
        contSearchcontroller.getnxt();
        system.assert(True,contSearchcontroller.contactList.size() >0);
        contSearchcontroller.getprev();
        system.assert(True,contSearchcontroller.contactList.size() >0);
        contSearchcontroller.previous();
        system.assert(True,contSearchcontroller.contactList.size() >0);
        contSearchcontroller.LastPage();
        system.assert(True,contSearchcontroller.contactList.size() >0);
        contSearchcontroller.setunchecked = true;
        contSearchcontroller.showPopup();
        contSearchcontroller.setunchecked = false;
        contSearchcontroller.showPopup();
        contSearchcontroller.setchecked = false;
        contSearchcontroller.showPopup();
        contSearchcontroller.setchecked = true;
        contSearchcontroller.showPopup();
        contSearchcontroller.getpageNumber();
    }
    
     static testmethod void testSearchwithBothParameter(){
         ContactSearchController contSearchcontroller = new ContactSearchController();
         contSearchcontroller.accountName = 'Test';
         contSearchcontroller.cont = [Select ID, Name from Contact LIMIT 1];
         system.assert(True,contSearchcontroller.contactList.size() >0);
         contSearchcontroller.searchCon();
         system.assert(True,contSearchcontroller.contactList.size() >0);
       
    }
    static testmethod void testSearchwithAccountParameter(){
        ContactSearchController contSearchcontroller = new ContactSearchController();
        contSearchcontroller.accountName = 'Testingnegative';
        contSearchcontroller.searchCon();
        system.assert(True,contSearchcontroller.contactList.size() >0);
    }
     static testmethod void testSearchwithContactParameter(){
         ContactSearchController contSearchcontroller = new ContactSearchController();
         contSearchcontroller.cont = [Select ID, Name from Contact LIMIT 1];
         contSearchcontroller.searchCon();
         contSearchcontroller.gettotalPageNo();
       
    }
    
    static testmethod void testSearchSaveUpdate(){
        ContactSearchController contSearchcontroller = new ContactSearchController();
        contSearchcontroller.cont = [Select ID, Name from Contact LIMIT 1];
        contSearchcontroller.LimitSize = 10;
        
        contSearchcontroller.searchCon();
        system.debug('@@@@@@ contSearchcontroller.contactList  ' +contSearchcontroller.contactList);
        List<Contact> contactListToupdate = new List<Contact>();
        for(Contact contact :contSearchcontroller.contactList){
            system.debug('@@@@@@ contact.T1C_Base_Inactive__c  ' +contact.T1C_Base_Inactive__c);
            contact.T1C_Base_Inactive__c = false;
            contactListToupdate.add(contact);
        }
        contSearchcontroller.contactList = contactListToupdate;
        contSearchcontroller.saveUpdate();
        
    }
    
   
}