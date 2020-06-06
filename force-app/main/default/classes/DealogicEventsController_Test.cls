@isTest
public class DealogicEventsController_Test {
//This is test class 
      @testSetup static void setup() {
        // Create common test data
        Integer i;
        List<Dealogic_Event_Conference__c> testDEC = new List<Dealogic_Event_Conference__c>();
        Date temDate = Date.today();
        for( i=0;i<12;i++) {
            if( i <4){
                system.debug('added Dealogic_Event_Conference__c : ' +i);
                testDEC.add(new Dealogic_Event_Conference__c(Name = 'testDEC'+i, Start_Date__c =Date.today(),End_Date__c =temDate.addDays(i),External_Id__c ='CONFERENCE1000'+i,Status__c='C'));
            }
            if( i< 8 && i> 4){
                system.debug('added Dealogic_Event_Conference__c : ' +i);
                testDEC.add(new Dealogic_Event_Conference__c(Name = 'testDEC'+i, Start_Date__c =Date.today(),End_Date__c =temDate.addDays(i),External_Id__c ='CONFERENCE1000'+i,Status__c='C'));
            }
            if( i> 8 ){
                system.debug('added Dealogic_Event_Conference__c : ' +i);
                testDEC.add(new Dealogic_Event_Conference__c(Name = 'testDEC'+i, Start_Date__c =Date.today(),End_Date__c =temDate.addDays(i),External_Id__c ='CONFERENCE1000'+i,Status__c='C'));
            }
        }
        insert testDEC;
        system.debug('Inserted Dealogic_Event_Conference__c : ' +testDEC.size());
        
        T1C_Base_Employee__c Emp = new T1C_Base_Employee__c();
        Emp.Name = 'TestEmp';
        insert Emp;
        Account acct = new Account(Name = 'TestAcct');
        insert acct;
        Contact cont = new Contact(FirstName ='TestFContact', LastName = 'TestLContact', AccountID = acct.ID);
        insert cont;
        
             List<Dealogic_Key_Participant__c> testDEP = new List<Dealogic_Key_Participant__c>();
         List<Dealogic_Attendee__c> testDA = new List<Dealogic_Attendee__c>();
        for(Integer j=0;j<11;j++) {
            if( j <4){
                system.debug('added Dealogic_Key_Participant__c : ' +j);   
                testDEP.add(new Dealogic_Key_Participant__c( Name =Emp.Name, Account__c = 'TestLAccount'+j,Contact__c ='TestLContact'+j,External_Id__c =Emp.Name +':test'+testDEC[j].External_Id__c ,Employee__c = Emp.ID, Parent__c = testDEC[j].ID));
                testDA.add(new Dealogic_Attendee__c( Name ='TestLDA'+j, Account__c = acct.ID,Contact__c =cont.ID,External_Id__c =Emp.Name +':'+testDEC[j].External_Id__c , Event__c = testDEC[j].ID));
            }
            if( j< 8 && j> 4){
                system.debug('added Dealogic_Key_Participant__c : ' +j);   
                testDEP.add(new Dealogic_Key_Participant__c( Name =Emp.Name, Account__c = 'TestLAccount'+j,Contact__c ='TestLContact'+j,External_Id__c =Emp.Name +':test'+testDEC[j].External_Id__c ,Employee__c =Emp.ID , Parent__c = testDEC[j].ID));
                testDA.add(new Dealogic_Attendee__c(Name ='TestLDA'+j, Account__c = acct.ID,Contact__c =cont.ID,External_Id__c =Emp.Name +':'+testDEC[j].External_Id__c , Event__c = testDEC[j].ID));
                
            }
            if( j> 8 && j< 10){
                system.debug('added Dealogic_Key_Participant__c : ' +j);   
                testDEP.add(new Dealogic_Key_Participant__c( Name =Emp.Name, Account__c = 'TestLAccount'+j,Contact__c ='TestLContact'+j,External_Id__c =Emp.Name +':test'+testDEC[j].External_Id__c ,Employee__c = Emp.ID, Parent__c = testDEC[j].ID));
                testDA.add(new Dealogic_Attendee__c( Name ='TestLDA'+j, Account__c = acct.ID,Contact__c =cont.ID,External_Id__c =Emp.Name +':'+testDEC[j].External_Id__c , Event__c = testDEC[j].ID));
                
            }
            
        }
        insert testDEP;
            system.debug('added Dealogic_Key_Participant__c : ' +testDEP.size());
         insert testDA;
            system.debug('added Dealogic_Attendee__c : ' +testDA.size());
        
        
    }
    
     static testmethod void testSearchPageLoad(){
        List<Dealogic_Event_Conference__c> DEC = [Select ID, Name from Dealogic_Event_Conference__c LIMIT 1];
          ApexPages.currentPage().getParameters().put('id',DEC[0].ID);
        DealogicEventsController dealogicSearchController = new DealogicEventsController();
        dealogicSearchController.pageSize = 2.0; 
        dealogicSearchController.LimitSize = 10;
        dealogicSearchController.searchEvents();
        system.assert(True,dealogicSearchController.dealogicEventConfList[0] != null);
        dealogicSearchController.FirstPage();
        system.assert(True,dealogicSearchController.dealogicEventConfList.size() >0);
        dealogicSearchController.next();
        system.assert(True,dealogicSearchController.dealogicEventConfList.size() >0);
        dealogicSearchController.getnxt();
        system.assert(True,dealogicSearchController.dealogicEventConfList.size() >0);
        dealogicSearchController.getprev();
        system.assert(True,dealogicSearchController.dealogicEventConfList.size() >0);
        dealogicSearchController.previous();
        system.assert(True,dealogicSearchController.dealogicEventConfList.size() >0);
        dealogicSearchController.LastPage();
        system.assert(True,dealogicSearchController.dealogicEventConfList.size() >0);
        dealogicSearchController.getpageNumber();
        dealogicSearchController.gettotalPageNo();
        dealogicSearchController.getDealogicDetails();
         
        dealogicSearchController.FirstPageDKP();
        system.assert(True,dealogicSearchController.dealogicParticipantsList.size() >0);
        dealogicSearchController.nextDKP();
        system.assert(True,dealogicSearchController.dealogicParticipantsList.size() >0);
        dealogicSearchController.getnxtDKP();
        system.assert(True,dealogicSearchController.dealogicParticipantsList.size() >0);
        dealogicSearchController.getprevDKP();
        system.assert(True,dealogicSearchController.dealogicParticipantsList.size() >0);
        dealogicSearchController.previousDKP();
        system.assert(True,dealogicSearchController.dealogicParticipantsList.size() >0);
        dealogicSearchController.LastPageDKP();
        system.assert(True,dealogicSearchController.dealogicParticipantsList.size() >0);
         
        dealogicSearchController.FirstPageDA();
        system.assert(True,dealogicSearchController.dealogicAttendeeList.size() >0);
        dealogicSearchController.nextDA();
        system.assert(True,dealogicSearchController.dealogicAttendeeList.size() >0);
        dealogicSearchController.getnxtDA();
        system.assert(True,dealogicSearchController.dealogicAttendeeList.size() >0);
        dealogicSearchController.getprevDA();
        system.assert(True,dealogicSearchController.dealogicAttendeeList.size() >0);
        dealogicSearchController.previousDA();
        system.assert(True,dealogicSearchController.dealogicAttendeeList.size() >0);
        dealogicSearchController.LastPageDA();
        system.assert(True,dealogicSearchController.dealogicAttendeeList.size() >0);
       

    }
    static testmethod void testSearchPageLoad2(){
        List<Dealogic_Event_Conference__c> DEC = [Select ID, External_Id__c,Name from Dealogic_Event_Conference__c LIMIT 1];
        ApexPages.currentPage().getParameters().put('id',DEC[0].ID);
        DealogicEventsController dealogicSearchController = new DealogicEventsController();
        dealogicSearchController.DealogicKeyPartcipantNew();
        dealogicSearchController.searchTerm = [Select id, Name from T1C_Base_Employee__c LIMIT 1][0].Name;
        String searchTERM =  dealogicSearchController.searchTerm;
        Dealogic_Key_Participant__c DEK = new Dealogic_Key_Participant__c(Employee__c =[Select id, Name from T1C_Base_Employee__c LIMIT 1][0].id,
                                                                          Name =  [Select id, Name from T1C_Base_Employee__c LIMIT 1][0].Name,External_Id__c =[Select id, Name from T1C_Base_Employee__c LIMIT 1][0].Name+':'+ DEC[0].External_Id__c);
        dealogicSearchController.dealogicKeyParticipant = DEK;
        dealogicSearchController.Save();
        dealogicSearchController.Cancel();
        dealogicSearchController.showPopup();
        dealogicSearchController.closePopup();
        
    }
    static testmethod void testSearchPageLoad3(){
        String searchTerm = [Select Name from T1C_Base_Employee__c LIMIT 1][0].Name;
        DealogicEventsController.searchEmployee(searchTerm);
    }

}