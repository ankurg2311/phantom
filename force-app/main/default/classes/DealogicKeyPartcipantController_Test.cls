@isTest
public class DealogicKeyPartcipantController_Test {
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
            
        }
        insert testDEC;
         system.debug('Inserted Dealogic_Event_Conference__c : ' +testDEC.size());
         Employee__c Emp = new Employee__c();
        Emp.Name = 'TestEmp';
        insert Emp;
       
    }
    static testmethod void testSearchPageLoad(){
        PageReference myVfPage = Page.DealogicKeyParticipantsNew;
        Test.setCurrentPage(myVfPage);
        List<Dealogic_Event_Conference__c> DEC = [Select ID, Name from Dealogic_Event_Conference__c LIMIT 1];
        ApexPages.currentPage().getParameters().put('eventId',DEC[0].Id);
        DealogicKeyPartcipantController dealogicKeyPartcipantController = new DealogicKeyPartcipantController();
        DealogicKeyPartcipantController.searchTerm = [Select Name from Employee__C LIMIT 1][0].Name;
        String searchTERM =  DealogicKeyPartcipantController.searchTerm;
        DealogicKeyPartcipantController.Save();
        DealogicKeyPartcipantController.Cancel();
        DealogicKeyPartcipantController.showPopup();
        DealogicKeyPartcipantController.closePopup();
        
        Test.startTest();
       // DealogicKeyPartcipantController.searchEmployee(searchTERM);
        Test.stopTest();
    }
     static testmethod void testSearchPageLoad2(){
        String searchTerm = [Select Name from Employee__C LIMIT 1][0].Name;
        DealogicKeyPartcipantController.searchEmployee(searchTerm);
     }

*/
}