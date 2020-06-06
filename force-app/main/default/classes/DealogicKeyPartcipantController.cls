public class DealogicKeyPartcipantController {
   /* 
    
    public ID EventID {get;set;}
    public String eventExternalID {get;set;}
    public Dealogic_Key_Participant__c dealogicKeyParticipant {get;set;}
    public Dealogic_Event_Conference__c dec{get;set;}
    public boolean displayPopup {get; set;}   
    public DealogicKeyPartcipantController() {
        dealogicKeyParticipant = new Dealogic_Key_Participant__c ();
        EventID = ApexPages.currentPage().getParameters().get('eventId');
        dealogicKeyParticipant.Dealogic_Event_Conference__c = EventID;
        dec =[Select ID, External_Id__c from Dealogic_Event_Conference__c where ID =:EventID];
        eventExternalID = dec.External_Id__c;
    }
    
    public String searchTerm {get; set;}
 
  
    
    // JS Remoting action called when searching for a movie name
    @RemoteAction
    public static List<Employee__c> searchEmployee(String searchTerm) {
        System.debug('Employee Name is: '+searchTerm );
        List<Employee__c> employees = Database.query('Select Id, Name from Employee__c where name like \'' + String.escapeSingleQuotes(searchTerm) + '%\'');
        return employees;
    }
    public PageReference Save(){
        
        dealogicKeyParticipant.Dealogic_Event_Conference__c = dec.ID;
        insert dealogicKeyParticipant;
        PageReference pageRef = new PageReference('/apex/DealogicDetails?id='+dec.ID);
        return pageRef;
        
    }
    
     public PageReference Cancel(){
        EventID = ApexPages.currentPage().getParameters().get('eventId');
        PageReference pageRef = new PageReference('/apex/DealogicDetails?id='+EventID);
        return pageRef;
        
    }
    
    public void showPopup() {  
        displayPopup = true;   
    }
     public void closePopup() {        
        displayPopup = false;
    }  

*/
}