@isTest
public class DealogicSearchController_Test {
    
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
         
       
    }
    
    static testmethod void testSearchPageLoad(){
        DealogicSearchController dealogicSearchController = new DealogicSearchController();
        dealogicSearchController.pageSize = 2.0; 
        dealogicSearchController.LimitSize = 10;
        dealogicSearchController.searchCon();
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
    }
    
    

    static testmethod void testSearchwithParameter(){
         DealogicSearchController dealogicSearchController = new DealogicSearchController();
         dealogicSearchController.dealogicEventConf = [Select ID, Name from Dealogic_Event_Conference__c LIMIT 1];
         dealogicSearchController.searchCon();
         system.assert(True,dealogicSearchController.dealogicEventConfList.size() >0);
         dealogicSearchController.gettotalPageNo();
       
    }
    static testmethod void testSearchwithParameterInUrl() {
        PageReference myVfPage = Page.DealogicEventConf;
        Test.setCurrentPage(myVfPage);
        List<Dealogic_Event_Conference__c> DEC = [Select ID, Name from Dealogic_Event_Conference__c LIMIT 1];
        ApexPages.currentPage().getParameters().put('key',DEC[0].Name);
        DealogicSearchController dealogicSearchController = new DealogicSearchController();
        
    }
*/
}