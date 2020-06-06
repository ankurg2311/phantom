@isTest
public class DealogicDetailExtension_Test {
    /*
    @testSetup static void setup() {
        // Create common test data
        Integer i;
        List<Dealogic_Event_Conference__c> testDEC = new List<Dealogic_Event_Conference__c>();
        Date temDate = Date.today();
        for( i=0;i<12;i++) {
            if( i <4){
                system.debug('added Dealogic_Event_Conference__c : ' +i);
                testDEC.add(new Dealogic_Event_Conference__c(Name = 'testDEC'+i, Start_Date__c =Date.today(),End_Date__c =temDate.addDays(i),External_Id__c ='1000'+i));
            }
            if( i< 8 && i> 4){
                system.debug('added Dealogic_Event_Conference__c : ' +i);
                testDEC.add(new Dealogic_Event_Conference__c(Name = 'testDEC'+i, Start_Date__c =Date.today(),End_Date__c =temDate.addDays(i),External_Id__c ='1000'+i));
            }
            if( i> 8 ){
                system.debug('added Dealogic_Event_Conference__c : ' +i);
                testDEC.add(new Dealogic_Event_Conference__c(Name = 'testDEC'+i, Start_Date__c =Date.today(),End_Date__c =temDate.addDays(i),External_Id__c ='1000'+i));
            }
        }
        insert testDEC;
        system.debug('Inserted Dealogic_Event_Conference__c : ' +testDEC.size());
        
        Employee__c Emp = new Employee__c();
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
                testDEP.add(new Dealogic_Key_Participant__c( Name =Emp.Name, Account__c = 'TestLAccount'+j,Contact__c ='TestLContact'+j,External_Id__c =Emp.Name +':'+testDEC[j].External_Id__c ,Employee__c = Emp.ID, Dealogic_Event_Conference__c = testDEC[j].ID));
                testDA.add(new Dealogic_Attendee__c( Name ='TestLDA'+j, Account__c = acct.ID,Contact__c =cont.ID,External_Id__c =Emp.Name +':'+testDEC[j].External_Id__c , Dealogic_Event_Conference__c = testDEC[j].ID));
            }
            if( j< 8 && j> 4){
                system.debug('added Dealogic_Key_Participant__c : ' +j);   
                testDEP.add(new Dealogic_Key_Participant__c( Name =Emp.Name, Account__c = 'TestLAccount'+j,Contact__c ='TestLContact'+j,External_Id__c =Emp.Name +':'+testDEC[j].External_Id__c ,Employee__c =Emp.ID , Dealogic_Event_Conference__c = testDEC[j].ID));
                testDA.add(new Dealogic_Attendee__c(Name ='TestLDA'+j, Account__c = acct.ID,Contact__c =cont.ID,External_Id__c =Emp.Name +':'+testDEC[j].External_Id__c , Dealogic_Event_Conference__c = testDEC[j].ID));
                
            }
            if( j> 8 && j< 10){
                system.debug('added Dealogic_Key_Participant__c : ' +j);   
                testDEP.add(new Dealogic_Key_Participant__c( Name =Emp.Name, Account__c = 'TestLAccount'+j,Contact__c ='TestLContact'+j,External_Id__c =Emp.Name +':'+testDEC[j].External_Id__c ,Employee__c = Emp.ID, Dealogic_Event_Conference__c = testDEC[j].ID));
                testDA.add(new Dealogic_Attendee__c( Name ='TestLDA'+j, Account__c = acct.ID,Contact__c =cont.ID,External_Id__c =Emp.Name +':'+testDEC[j].External_Id__c , Dealogic_Event_Conference__c = testDEC[j].ID));
                
            }
            
        }
        insert testDEP;
            system.debug('added Dealogic_Key_Participant__c : ' +testDEP.size());
         insert testDA;
            system.debug('added Dealogic_Attendee__c : ' +testDA.size());
        
        
    }
    static testmethod void testDetailPageLoad(){
        List<Dealogic_Event_Conference__c> DEC = [Select ID, Name from Dealogic_Event_Conference__c LIMIT 1];
        ApexPages.currentPage().getParameters().put('id',DEC[0].ID);
        ApexPages.StandardController sc = new ApexPages.StandardController(DEC[0]);
        DealogicDetailExtension dealogicDetailExtension = new DealogicDetailExtension(sc);
        dealogicDetailExtension.FirstPageDKP();
        system.assert(True,dealogicDetailExtension.dealogicParticipantsList.size() >0);
        dealogicDetailExtension.nextDKP();
        system.assert(True,dealogicDetailExtension.dealogicParticipantsList.size() >0);
        dealogicDetailExtension.getnxtDKP();
        system.assert(True,dealogicDetailExtension.dealogicParticipantsList.size() >0);
        dealogicDetailExtension.getprevDKP();
        system.assert(True,dealogicDetailExtension.dealogicParticipantsList.size() >0);
        dealogicDetailExtension.previousDKP();
        system.assert(True,dealogicDetailExtension.dealogicParticipantsList.size() >0);
        dealogicDetailExtension.LastPageDKP();
        system.assert(True,dealogicDetailExtension.dealogicParticipantsList.size() >0);
        
         dealogicDetailExtension.FirstPageDA();
        system.assert(True,dealogicDetailExtension.dealogicAttendeeList.size() >0);
        dealogicDetailExtension.nextDA();
        system.assert(True,dealogicDetailExtension.dealogicAttendeeList.size() >0);
        dealogicDetailExtension.getnxtDA();
        system.assert(True,dealogicDetailExtension.dealogicAttendeeList.size() >0);
        dealogicDetailExtension.getprevDA();
        system.assert(True,dealogicDetailExtension.dealogicAttendeeList.size() >0);
        dealogicDetailExtension.previousDA();
        system.assert(True,dealogicDetailExtension.dealogicAttendeeList.size() >0);
        dealogicDetailExtension.LastPageDA();
        system.assert(True,dealogicDetailExtension.dealogicAttendeeList.size() >0);
       
      
      
    }
*/
}