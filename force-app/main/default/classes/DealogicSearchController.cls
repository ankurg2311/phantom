public class DealogicSearchController {
/*
    public Dealogic_Event_Conference__c dealogicEventConf{get;set;}
    public List<Dealogic_Event_Conference__c> dealogicEventConfList {get;set;}
    public String searchKey{get;set;}
    ApexPages.StandardSetController con {get;set;}
    
 // create a list of strings to hold the conditions
    List<string> conditions = new List<string>();
    public integer totalRecs = 0;
    public integer OffsetSize = 10;
    public decimal pageSize = 1.0;
    public integer LimitSize= 1000;
    public integer TotalPages= 0;
    
    public DealogicSearchController(){
        system.debug('==>DealogicSearchController  is calling==>');
        dealogicEventConf = new Dealogic_Event_Conference__c();
        dealogicEventConfList = new List<Dealogic_Event_Conference__c>();
        dealogicEventConf.Name = ApexPages.currentPage().getParameters().get('key');
        if((dealogicEventConf.Name !=null && dealogicEventConf.Name !='')){
            searchCon();
        }
    }
    
    
    public void searchCon(){
        //dealogicEventConfList = new List<Contact>();
        totalRecs = 0;
        OffsetSize = 0;
        
        if(dealogicEventConfList !=null && dealogicEventConfList.size()>0){
            dealogicEventConfList=null;
        }
        searchContacts();
        conditions.clear();
    }
    public Void searchContacts(){
        System.debug('Total Records is ==>'+totalRecs);
        System.debug('OffsetSize is ==>'+OffsetSize);
        
            if(dealogicEventConfList != null && !dealogicEventConfList.isEmpty()){
                dealogicEventConfList.clear();
            }
        searchKey = dealogicEventConf.Name;
        String strQuery ='SELECT Id,Name,Start_Date__c,End_Date__c,External_Id__c From Dealogic_Event_Conference__c';
        if((dealogicEventConf.Name !=null && dealogicEventConf.Name !='')){
            conditions.add('Name Like \'%' +String.escapeSingleQuotes(dealogicEventConf.Name) +'%\'' );
        }
        if (conditions.size() > 0) {
            strQuery += '  WHERE ' + conditions[0];
            for (Integer i = 1; i < conditions.size(); i++)
                strQuery += '  AND ' + conditions[i];
        }
        system.debug('strQuery ==>'+strQuery );
        strQuery += ' ORDER BY Name  ASC, CreatedDate DESC LIMIT :LimitSize';
        system.debug('strQuery 12333==>'+strQuery );
        con = new ApexPages.StandardSetController(Database.query(strQuery));
        //dealogicEventConfList  =Database.query(strQuery);
        con.setPageSize(Integer.valueOf(pageSize));
        TotalPages = Integer.valueOf((con.getResultSize()/pageSize).round(System.RoundingMode.CEILING));
        dealogicEventConfList =  con.getRecords();
    }
    
    public void FirstPage()
    {
       con.first();
        dealogicEventConfList = con.getRecords();
    }
    public void previous()
    {
        con.previous();
        dealogicEventConfList = con.getRecords();
    }
    public void next()
    {
       con.next();
        dealogicEventConfList = con.getRecords();
    }
    public void LastPage()
    {
        con.last();
        dealogicEventConfList = con.getRecords();
    }
    public boolean getprev()
    {
      
            return con.getHasPrevious();
        
    }
    public boolean getnxt()
    {
        system.debug('con.getHasNext();  @@@  '+con.getHasNext());
            return con.getHasNext();
    }
    
    public Integer getpageNumber() {
    
            return con.getPageNumber();
    }
    
    public Integer gettotalPageNo(){
        
        return TotalPages;
    }
    
   */
    
}