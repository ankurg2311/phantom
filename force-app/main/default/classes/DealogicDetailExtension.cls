public class DealogicDetailExtension {
  /*  
    public List<Dealogic_Key_Participant__c> dealogicParticipantsList {get;set;}
    public List<Dealogic_Attendee__c> dealogicAttendeeList {get;set;}
    List<string> conditions = new List<string>();
    public integer totalRecs = 0;
    public integer OffsetSize = 10;
    public decimal pageSize {get;set;}
    public integer LimitSize= 1000;
    public integer TotalPages= 0;
    public ID EventID {get;set;}
    public String searchKey {get;set;}
   
    
    ApexPages.StandardSetController conParticipants {get;set;}
    ApexPages.StandardSetController conAttendees {get;set;}
    public DealogicDetailExtension(ApexPages.StandardController con) {
        pageSize = 2.0;
        dealogicParticipantsList =  new List<Dealogic_Key_Participant__c>();
        dealogicAttendeeList =  new List<Dealogic_Attendee__c>();
        EventID = ApexPages.currentPage().getParameters().get('id');
        searchKey = ApexPages.currentPage().getParameters().get('key');
       
        getKeyParticipants(EventID);
        getAteendees(EventID);
    }
    public Void getKeyParticipants(Id eventID){
        if(eventID != null){
            System.debug('Total Records is ==>'+totalRecs);
            System.debug('OffsetSize is ==>'+OffsetSize);
            
            if(dealogicParticipantsList != null && !dealogicParticipantsList.isEmpty()){
                dealogicParticipantsList.clear();
            }
            String strQuery ='SELECT Id, Name, Account__c, Contact__c, External_Id__c, Status__c, Type__c, Dealogic_Event_Conference__c, Employee__r.Name FROM Dealogic_Key_Participant__c';
            if((eventID !=null)){
                conditions.add('Dealogic_Event_Conference__c = ' +'\''+eventID+'\'');
            }
            if (conditions.size() > 0) {
                strQuery += '  WHERE ' + conditions[0];
                for (Integer i = 1; i < conditions.size(); i++)
                    strQuery += '  AND ' + conditions[i];
            }
            system.debug('strQuery ==>'+strQuery );
            
            strQuery += ' ORDER BY Name  ASC, CreatedDate DESC LIMIT :LimitSize';
            system.debug('strQuery 12333==>'+strQuery );
            conParticipants = new ApexPages.StandardSetController(Database.query(strQuery));
            //dealogicEventConfList  =Database.query(strQuery);
            conParticipants.setPageSize(Integer.valueOf(pageSize));
            TotalPages = Integer.valueOf((conParticipants.getResultSize()/pageSize).round(System.RoundingMode.CEILING));
            dealogicParticipantsList =  conParticipants.getRecords();
        }
    }
    
    public Void getAteendees(Id eventID){
        if(eventID != null){
            System.debug('Total Records is ==>'+totalRecs);
            System.debug('OffsetSize is ==>'+OffsetSize);
            
            if(dealogicAttendeeList != null && !dealogicAttendeeList.isEmpty()){
                dealogicAttendeeList.clear();
            }
            String strQuery ='SELECT Id, Name, Account__r.Name,Contact__r.Name, External_Id__c,Dealogic_Event_Conference__c FROM Dealogic_Attendee__c';
            if((eventID !=null)){
                conditions.add('Dealogic_Event_Conference__c = ' +'\''+eventID+'\'');
            }
            if (conditions.size() > 0) {
                strQuery += '  WHERE ' + conditions[0];
                for (Integer i = 1; i < conditions.size(); i++)
                    strQuery += '  AND ' + conditions[i];
            }
            system.debug('strQuery ==>'+strQuery );
            
            strQuery += ' ORDER BY Name  ASC, CreatedDate DESC LIMIT :LimitSize';
            system.debug('strQuery 12333==>'+strQuery );
            conAttendees = new ApexPages.StandardSetController(Database.query(strQuery));
            //dealogicEventConfList  =Database.query(strQuery);
            conAttendees.setPageSize(Integer.valueOf(pageSize));
            TotalPages = Integer.valueOf((conAttendees.getResultSize()/pageSize).round(System.RoundingMode.CEILING));
            dealogicAttendeeList =  conAttendees.getRecords();
        }
    }
    
    public void FirstPageDKP()
    {
        conParticipants.first();
        dealogicParticipantsList = conParticipants.getRecords();
    }
    public void previousDKP()
    {
        conParticipants.previous();
        dealogicParticipantsList = conParticipants.getRecords();
    }
    public void nextDKP()
    {
        conParticipants.next();
        dealogicParticipantsList = conParticipants.getRecords();
    }
    public void LastPageDKP()
    {
        conParticipants.last();
        dealogicParticipantsList = conParticipants.getRecords();
    }
    public boolean getprevDKP()
    {
        
        return conParticipants.getHasPrevious();
        
    }
    public boolean getnxtDKP()
    {
        system.debug('conParticipants.getHasNext();  @@@  '+conParticipants.getHasNext());
        return conParticipants.getHasNext();
    }
    
    
     public void FirstPageDA()
    {
        conAttendees.first();
        dealogicAttendeeList = conAttendees.getRecords();
    }
    public void previousDA()
    {
        conAttendees.previous();
        dealogicAttendeeList = conAttendees.getRecords();
    }
    public void nextDA()
    {
        conAttendees.next();
        dealogicAttendeeList = conAttendees.getRecords();
    }
    public void LastPageDA()
    {
        conAttendees.last();
        dealogicAttendeeList = conAttendees.getRecords();
    }
    public boolean getprevDA()
    {
        
        return conAttendees.getHasPrevious();
        
    }
    public boolean getnxtDA()
    {
        system.debug('conAttendees.getHasNext();  @@@  '+conAttendees.getHasNext());
        return conAttendees.getHasNext();
    }
    
    
    
   */
    
}