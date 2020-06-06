public class DealogicEventsController {

    public Dealogic_Event_Conference__c dealogicEventConf{get;set;}
    public List<Dealogic_Event_Conference__c> dealogicEventConfList {get;set;}
    public String searchKey{get;set;}
	public String searchEventKey{get;set;}
	
    ApexPages.StandardSetController con {get;set;}
    
 // create a list of strings to hold the conditions
    List<string> conditions = new List<string>();
    public integer totalRecs = 0;
    public integer OffsetSize = 10;
    public decimal pageSize = 200.0;
    public integer LimitSize= 1000;
    public integer TotalPages= 0;
    public integer totalRecords {get;set;}
    
    
    public DealogicEventsController(){
        system.debug('==>DealogicSearchController  is calling==>');
        dealogicEventConf = new Dealogic_Event_Conference__c();
        dealogicEventConfList = new List<Dealogic_Event_Conference__c>();
        searchEventKey = ApexPages.currentPage().getParameters().get('key');
        if((searchEventKey !=null && searchEventKey !='')){
            searchEvents();
        }
        
    }
    
    
    public void searchEvents(){
        //dealogicEventConfList = new List<Contact>();
        totalRecs = 0;
        OffsetSize = 0;
        
        if(dealogicEventConfList !=null && dealogicEventConfList.size()>0){
            dealogicEventConfList=null;
        }
        searchEventList();
        conditions.clear();
    }
    public Void searchEventList(){
        System.debug('Total Records is ==>'+totalRecs);
        System.debug('OffsetSize is ==>'+OffsetSize);
        
            if(dealogicEventConfList != null && !dealogicEventConfList.isEmpty()){
                dealogicEventConfList.clear();
            }
        searchKey = searchEventKey;
        String searchExternalKey = 'CONFERENCE';
        String searchStatusKey ='C';
        String strQuery ='SELECT Id,Name,Start_Date__c,End_Date__c,External_Id__c,Status__c From Dealogic_Event_Conference__c';
        if((searchEventKey !=null && searchEventKey !='')){
            conditions.add('Name Like \'%' +String.escapeSingleQuotes(searchEventKey) +'%\'' );
            conditions.add('External_Id__c Like \'%' +String.escapeSingleQuotes(searchEventKey) +'%\'' );
        }else{
  		 conditions.add('CreatedDate = LAST_N_DAYS:21' );
        }
        conditions.add('External_Id__c Like  \''  +searchExternalKey +'%\'' );
        conditions.add('Status__c =:searchStatusKey');
        if (conditions.size() > 0) {
            if(String.isNotBlank(searchEventKey)){
              strQuery += '  WHERE (' + conditions[0];   
            }else{
               strQuery += '  WHERE ' + conditions[0]; 
            }
            
            for (Integer i = 1; i < conditions.size(); i++)
                if(String.isNotBlank(searchEventKey) && i== 1 ){
                    strQuery += '  OR ' + conditions[i] +')';
                }else{
                    strQuery += '  AND ' + conditions[i];
                }
        }
        system.debug('strQuery ==>'+strQuery );
         string sortFullExp = sortExpression  + ' ' + sortDirection; 
        //strQuery += ' ORDER BY Name  ASC, CreatedDate DESC LIMIT :LimitSize';
        strQuery += ' ORDER BY '+ sortFullExp +'  LIMIT :LimitSize';
        system.debug('strQuery 12333==>'+strQuery );
        
        con = new ApexPages.StandardSetController(Database.query(strQuery));
        totalRecords = con.getRecords().size();
        //dealogicEventConfList  =Database.query(strQuery);
        con.setPageSize(Integer.valueOf(pageSize));
        TotalPages = Integer.valueOf((con.getResultSize()/pageSize).round(System.RoundingMode.CEILING));
        dealogicEventConfList =  con.getRecords();
    }
    
    public void FirstPage()
    {
        if(con != null){
            con.first();
            dealogicEventConfList = con.getRecords(); 
        }  
      
    }
    public void previous()
    {
        if(con != null){
        con.previous();
        dealogicEventConfList = con.getRecords();
        }
    }
    public void next()
    {
        if(con != null){
       con.next();
        dealogicEventConfList = con.getRecords();
        }
    }
    public void LastPage()
    {
        if(con != null){
        con.last();
        dealogicEventConfList = con.getRecords();
        }
    }
    public boolean getprev()
    {
         if(con != null){
            return con.getHasPrevious();
         }
        return false;
        
    }
    public boolean getnxt()
    {   if(con != null){
        system.debug('con.getHasNext();  @@@  '+con.getHasNext());
            return con.getHasNext();
    }
      return false;
    }
    
    public Integer getpageNumber() {
       if(con != null){
            return con.getPageNumber();
       }
        return null;
    }
    
    public Integer gettotalPageNo(){
        
        return TotalPages;
    }
    
   //Sorting :
    private String sortDirection = 'DESC';    
    private String sortExp = 'CreatedDate';    
    public String sortExpression    {      
        get      {         return sortExp;      }      
        set      {        //if the column is clicked on then switch between Ascending and Descending modes        
            if (value == sortExp)          
                sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';        
            else          
                sortDirection = 'ASC';        
            sortExp = value;      }    }  
    public String getSortDirection()  {     //if not column is selected     
        if (sortExpression == null || sortExpression == '')       
            return 'ASC';     
        else      
            return sortDirection;  
    }  
    public void setSortDirection(String value)  {      
        sortDirection = value;  
    }      
    
    
//--------------------------------------------------For Page :DealogicDetails.vfp--------------------------------------------------------------//

    public Dealogic_Event_Conference__c dealogicEventConfDetail{get;set;}
    public List<Dealogic_Key_Participant__c> dealogicParticipantsList {get;set;}
    public List<Dealogic_Attendee__c> dealogicAttendeeList {get;set;}
    List<string> conditionsDKP = new List<string>();
    public integer totalRecsDKP = 0;
    public integer OffsetSizeDKP = 10;
    public decimal pageSizeDKP = 5.0;
    public integer LimitSizeDKP = 1000;
    public integer TotalPagesDKP = 0;
    public String searchParticipantKey {get;set;}
    
    //for Attendees
    List<string> conditionsDA = new List<string>();
    public integer totalRecsDA = 0;
    public integer OffsetSizeDA = 10;
    public decimal pageSizeDA = 5.0; 
    public integer LimitSizeDA = 1000;
    public integer TotalPagesDA = 0;
    public boolean displaymsg1 {get; set;} 
    public ID EventID {get;set;}
    //public String searchKey {get;set;}
   
    
    ApexPages.StandardSetController conParticipants {get;set;}
    ApexPages.StandardSetController conAttendees {get;set;}
    public void getDealogicDetails() {
        pageSizeDKP = 5.0;
        dealogicParticipantsList =  new List<Dealogic_Key_Participant__c>();
        dealogicAttendeeList =  new List<Dealogic_Attendee__c>();
        EventID = ApexPages.currentPage().getParameters().get('id');
        dealogicEventConfDetail = new Dealogic_Event_Conference__c();
        dealogicEventConfDetail = [Select Id, Name, Start_Date__c, End_Date__c, External_Id__c from Dealogic_Event_Conference__c  Where ID =:EventID];
        searchKey = ApexPages.currentPage().getParameters().get('key');
        
        getKeyParticipants(EventID);
        getAteendees(EventID);
        DealogicKeyPartcipantNew();
    }
    public void getKeyParticipantsSort(){
        
         getKeyParticipants(ApexPages.currentPage().getParameters().get('id'));
    }
    public void getKeyAttendeesSort(){
        
         getAteendees(ApexPages.currentPage().getParameters().get('id'));
    }
    
    
    
    public Void getKeyParticipants(Id eventID){
        if(eventID != null){
            System.debug('Total Records is :getKeyParticipants ==>'+totalRecsDKP);
            System.debug('OffsetSize is getKeyParticipants ==>'+OffsetSizeDKP);
            
            if(dealogicParticipantsList != null && !dealogicParticipantsList.isEmpty()){
                //dealogicParticipantsList.clear();
                dealogicParticipantsList = new List<Dealogic_Key_Participant__c>();
            }
            String strQuery ='SELECT Id, Name, Account__c, Contact__c, External_Id__c, Status__c, Type__c, Parent__c, Employee__r.Name FROM Dealogic_Key_Participant__c';
            conditionsDKP.clear();
            if((eventID !=null)){
                conditionsDKP.add('Parent__c = ' +'\''+eventID+'\'');
            }
            if(String.isNotBlank(searchParticipantKey)){
                conditionsDKP.add('Name Like  \'%' +String.escapeSingleQuotes(searchParticipantKey) +'%\'' );
            }
            if (conditionsDKP.size() > 0) {
                strQuery += '  WHERE ' + conditionsDKP[0];
                for (Integer i = 1; i < conditionsDKP.size(); i++)
                    strQuery += '  AND ' + conditionsDKP[i];
            }
            system.debug('strQuery ==>'+strQuery );
            
            //strQuery += ' ORDER BY Name  ASC, CreatedDate DESC LIMIT :LimitSizeDKP';
            if(sortExpression == 'CreatedDate'){
               sortDirection = 'DESC'; 
            }
            string sortFullExp = sortExpression  + ' ' + sortDirection; 
             strQuery += ' ORDER BY '+ sortFullExp +' LIMIT :LimitSizeDKP';
            system.debug('strQuery getKeyParticipants ==>'+strQuery );
            conParticipants = new ApexPages.StandardSetController(Database.query(strQuery));
            //dealogicEventConfList  =Database.query(strQuery);
            conParticipants.setPageSize(Integer.valueOf(pageSizeDKP));
            TotalPagesDKP = Integer.valueOf((conParticipants.getResultSize()/pageSizeDKP).round(System.RoundingMode.CEILING));
            dealogicParticipantsList =  conParticipants.getRecords();
        }
    }
    
    public Void getAteendees(Id eventID){
        if(eventID != null){
            System.debug('Total Records is getAteendees==>'+totalRecsDA);
            System.debug('OffsetSize is getAteendees ==>'+OffsetSizeDA);
            
            if(dealogicAttendeeList != null && !dealogicAttendeeList.isEmpty()){
                //dealogicAttendeeList.clear();
                dealogicAttendeeList = new List<Dealogic_Attendee__c>();
            }
            conditionsDA.clear();
            String strQuery ='SELECT Id, Name, Account__r.Name,Contact__r.Name, External_Id__c,Event__c FROM Dealogic_Attendee__c';
            if((eventID !=null)){
                conditionsDA.add('Event__c = ' +'\''+eventID+'\'');
            }
            if (conditionsDA.size() > 0) {
                strQuery += '  WHERE ' + conditionsDA[0];
                for (Integer i = 1; i < conditionsDA.size(); i++)
                    strQuery += '  AND ' + conditionsDA[i];
            }
            system.debug('strQuery getAteendees ==>'+strQuery );
            
           // strQuery += ' ORDER BY Name  ASC, CreatedDate DESC LIMIT :LimitSizeDA';
            string sortFullExp = sortExpression  + ' ' + sortDirection; 
             strQuery += ' ORDER BY '+ sortFullExp +'  LIMIT :LimitSizeDA';
            system.debug('strQuery getAteendees==>'+strQuery );
            conAttendees = new ApexPages.StandardSetController(Database.query(strQuery));
            //dealogicEventConfList  =Database.query(strQuery);
            conAttendees.setPageSize(Integer.valueOf(pageSizeDA));
            TotalPagesDA = Integer.valueOf((conAttendees.getResultSize()/pageSizeDA).round(System.RoundingMode.CEILING));
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
    public Integer getpageNumberDKP() {
        
        return conParticipants.getPageNumber();
    }
    
    public Integer gettotalPageNoDKP(){
        
        return TotalPagesDKP;
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
    public Integer getpageNumberDA() {
        
        return conAttendees.getPageNumber();
    }
    
    public Integer gettotalPageNoDA(){
        
        return TotalPagesDA;
    }
    
//--------------------------------------------------For Page :DealogicKeyParticipantsNew.vfp--------------------------------------------------------------//

    //public ID EventID {get;set;}
    public String eventExternalID {get;set;}
    public Dealogic_Key_Participant__c dealogicKeyParticipant {get;set;}
    public Dealogic_Event_Conference__c dec{get;set;}
    public boolean displayPopup {get; set;} 
    public boolean displaymsg {get; set;}
    public boolean displayExisting {get; set;}
    public void DealogicKeyPartcipantNew() {
        dealogicKeyParticipant = new Dealogic_Key_Participant__c ();
        EventID = ApexPages.currentPage().getParameters().get('id');
        dealogicKeyParticipant.Parent__c = EventID;
        dec =[Select ID, External_Id__c from Dealogic_Event_Conference__c where ID =:EventID];
        eventExternalID = dec.External_Id__c;
    }
    
    public String searchTerm {get; set;}
 
  
    
    // JS Remoting action called when searching for a Employee name
    @RemoteAction
    public static List<T1C_Base_Employee__c> searchEmployee(String searchTerm) {
        List<string> conditionsEmp = new List<string>();
        integer LimitSize = 20;
        String isInActive = 'false';
        System.debug('Employee Name is: '+searchTerm );
        String strQuery = 'Select Id,T1c_base_inactive__c, Name from T1C_Base_Employee__c ';
        conditionsEmp.add('Name like \'' + String.escapeSingleQuotes(searchTerm) + '%\'');
        conditionsEmp.add('T1c_base_inactive__c =:isInActive');
        if (conditionsEmp.size() > 0) {
            strQuery += '  WHERE ' + conditionsEmp[0];
            for (Integer i = 1; i < conditionsEmp.size(); i++)
                strQuery += '  AND ' + conditionsEmp[i];
        }
        strQuery += ' ORDER BY Name  ASC  LIMIT :LimitSize';
        List<T1C_Base_Employee__c> employees = Database.query(strQuery);
        return employees;
    }
    
    public PageReference Save(){
        dealogicKeyParticipant.Parent__c = dec.ID;
        insert dealogicKeyParticipant;
        PageReference pageRef = new PageReference('/apex/DealogicEventDetails?id='+dec.ID);
        pageRef.setRedirect(true);
        return pageRef;
        
    }
    public void SaveModal(){
        dealogicKeyParticipant.Parent__c = dec.ID;
        insert dealogicKeyParticipant;
        sortExpression = 'CreatedDate';
        getKeyParticipantsSort();
        closePopup();
        closePopup1();
    }
    
     public PageReference Cancel(){
        EventID = ApexPages.currentPage().getParameters().get('eventId');
        PageReference pageRef = new PageReference('/apex/DealogicEventDetails?id='+EventID);
        pageRef.setRedirect(true);
        return pageRef;
        
    }
    public boolean checkIfExisting(ID eventID){
        List<Dealogic_Key_Participant__c> dealogicParticipantList =[Select ID from Dealogic_Key_Participant__c Where Parent__c =:eventID And Employee__c =: dealogicKeyParticipant.Employee__c ];
        if(dealogicParticipantList.size()>0){
            return true;
        }else{
            return false;
        }
    }
    public void showPopUp1(){
       dealogicKeyParticipant = new Dealogic_Key_Participant__c();
        displaymsg1 = true;
        
    }
  public void closePopup1() {   
      displaymsg1 = false;

  }

    public void showPopup() { 
        dealogicKeyParticipant.ID = null;
        if(dealogicKeyParticipant.Name != null )  {
            displayPopup = true; 
            displaymsg = false;
            if(checkIfExisting(dec.ID)){ 
                displaymsg = true;
                displayExisting = true;
                displayPopup = false; 
            }
        } else{
            displayExisting = false;
            displaymsg = true;
            displayPopup = false; 
        }
        
    }
     public void closePopup() {        
        displayPopup = false;
          displaymsg = false;
         displayExisting = false;
    }  
    
   //------------------------------------------------------------------------

   
     
   


}