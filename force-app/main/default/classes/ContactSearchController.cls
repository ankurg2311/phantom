public with sharing class ContactSearchController {
    
    public Contact cont{get;set;}
    public List<Contact> contactList {get;set;}
    public List<Contact> originalRecords {get;set;}
    public boolean  setunchecked  {get;set;}
    public boolean  setchecked    {get;set;}
    public boolean  deactivated   {get;set;}
    public String   setAction     {get;set;}
    public String  setCheckUncheck{get;set;}
    public boolean allcheckUncheck{get;set;}
    public String accountName{get;set;}
    public String contactFieldKey {get;set;}
    ApexPages.StandardSetController con {get;set;}
    public List<Contact> contList = new List<Contact>();
    // create a list of strings to hold the conditions
    List<string> conditions = new List<string>();
    public integer totalRecs = 0;
    public integer OffsetSize = 10;
    public decimal pageSize = 5.0;
    public integer LimitSize= 1000;
    public integer TotalPages= 0;
    public set<ID> selectedIDs {get;set;}
    public map<ID,Contact> originalRecordsMap{get;set;}
    public ID selectedId{get;set;}
    
    public ContactSearchController(){
        system.debug('==>ContactSearchController  is calling==>');
        cont = new Contact();
        contactList = new List<Contact>();
        selectedIDs = new Set<ID>();
    }
    
    public void saveUpdate(){
        system.debug('hello');
        closePopup();
        List<Contact> contactListToUpdate =  new List<Contact>();
        /*for(Contact contact:contactList){
            if(!contact.T1C_Base_Inactive__c){
                contactListToUpdate.add(contact);
            }
            
        }
        system.debug('@@@@ ContactListToUpdate @@@@@::  ' +contactListToUpdate.size());
		*/
        for(Integer i = 0; i<contactList.size(); i++){
            if(originalRecords.get(i).T1C_Base_Inactive__c != contactList.get(i).T1C_Base_Inactive__c){
                contactListToUpdate.add(contactList[i]);
            } 
        }
         system.debug('@@@@ ContactListToUpdate @@@@@::  ' +contactListToUpdate.size());
        if(contactListToUpdate.size()>0){
            Database.update(contactListToUpdate,false); 
        }
        
        //---------
        //
        
        
        searchCon();
    }
    
    public void searchCon(){
        //contactList = new List<Contact>();
        totalRecs = 0;
        OffsetSize = 0;
        
        if(contactList !=null && contactList.size()>0){
            contactList=null;
        }
        searchContacts();
        conditions.clear();
    }
    
    
    public Void searchContacts(){
        cont.T1C_Base_Inactive__c = true;
        System.debug('Total Records is ==>'+totalRecs);
        System.debug('OffsetSize is ==>'+OffsetSize);
        List<String> statusString = new List<String> {'Closed','Cut Off',''};
            if(contactList != null && !contactList.isEmpty()){
                contactList.clear();
            }
        String strQuery ='SELECT Id,Name,CreatedDate,T1C_Base_Inactive__c,Parent_Record_Type__c,Account.Name,Account.Substatus__c,Account.T1C_Base_Inactive__c From Contact';
        
        if((contactFieldKey !=null && contactFieldKey !='') && (accountName !=null && accountName !='')){
            // conditions.add('Name Like \'%' +String.escapeSingleQuotes(contactFieldKey) +'%\'' );
            conditions.add('(  Name Like \'%' +String.escapeSingleQuotes(contactFieldKey) +'%\''+ ' OR ' + 'Email Like \'%' +String.escapeSingleQuotes(contactFieldKey) +'%\' )' );
            //conditions.add('Account.Name Like \'%' +  String.escapeSingleQuotes(accountName) +'%\'');
            // conditions.add('Account.Email__c Like \'%' +  String.escapeSingleQuotes(accountName) +'%\'');
            conditions.add('( Account.Name Like \'%' +String.escapeSingleQuotes(accountName) +'%\''+ ' OR ' + 'Account.Email__c Like \'%' +String.escapeSingleQuotes(accountName) +'%\' )' );
            
        } else if((contactFieldKey !='' && contactFieldKey !=null) && (accountName == null || accountName =='')){
            //conditions.add('Name Like \'%' +String.escapeSingleQuotes(contactFieldKey) +'%\'' );
            conditions.add('(  Name Like \'%' +String.escapeSingleQuotes(contactFieldKey) +'%\''+ ' OR ' + 'Email Like \'%' +String.escapeSingleQuotes(contactFieldKey) +'%\' )' );
        } else if((contactFieldKey =='') && (accountName !=null || accountName !='')){
            //conditions.add('Account.Name Like \'%' + String.escapeSingleQuotes(accountName) +'%\'' );
            conditions.add('( Account.Name Like \'%' +String.escapeSingleQuotes(accountName) +'%\''+ ' OR ' + 'Account.Email__c Like \'%' +String.escapeSingleQuotes(accountName) +'%\' )' );
        }
            
         
        if(cont.T1C_Base_Inactive__c){
            deactivated = true;
            setAction = 'Activate';
            setCheckUncheck ='uncheck';
            conditions.add('T1C_Base_Inactive__c = true'); 
        }else{
            conditions.add('T1C_Base_Inactive__c = false');
            deactivated = false;
            setAction = 'Deactivate';
            setCheckUncheck ='check';
        }
        
        conditions.add('Account.T1C_Base_Inactive__c = false');
        conditions.add('Account.Substatus__c IN:statusString');
        if (conditions.size() > 0) {
            strQuery += '  WHERE ' + conditions[0];  
            
            for (Integer i = 1; i < conditions.size(); i++){
                
                strQuery += '  AND ' + conditions[i];
            }
        }
       
       /*if(totalRecs !=null && totalRecs ==0){
        List<Contact> conTemp = Database.query(strQuery);
        totalRecs = (conTemp !=null &&conTemp.size()>0)?conTemp.size():0;
        }
        */
                
        system.debug('strQuery ==>'+strQuery );
        // add sort and limits at the end  
        //strQuery += ' ORDER BY Name  ASC, CreatedDate DESC LIMIT :LimitSize OFFSET :OffsetSize';
        strQuery += ' ORDER BY Name  ASC, CreatedDate DESC LIMIT :LimitSize';
        system.debug('strQuery 12333==>'+strQuery );
        con = new ApexPages.StandardSetController(Database.query(strQuery));
        //contactList  =Database.query(strQuery);
        con.setPageSize(Integer.valueOf(pageSize));
        TotalPages = Integer.valueOf((con.getResultSize()/pageSize).round(System.RoundingMode.CEILING));
        contactList =  con.getRecords();
        originalRecords = new List<Contact>(); 
        //originalRecordsMap = new Map<ID, Contact>();
        for(Contact cont: contactList){
              Contact o1 =new Contact();
                      o1 = cont.clone(true);
				originalRecords.add(o1);
        }
        //system.debug('$$$$$$ ' +originalRecordsMap.values());
        allcheckUncheck = false;
    }
    
    public void FirstPage()
    {
       con.first();
        contactList = con.getRecords();
    }
    public void previous()
    {
        con.previous();
        contactList = con.getRecords();
    }
    public void next()
    {
       con.next();
        contactList = con.getRecords();
    }
    public void LastPage()
    {
        con.last();
        contactList = con.getRecords();
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
    
    public boolean displayPopup {get; set;}     
    public boolean displaymsg {get; set;}  
    
    public void closePopup() {        
        displayPopup = false;
        displaymsg  = false;
    }     
    public void showPopup() { 
        if(deactivated){
            if(setunchecked){ 
                displayPopup = true; 
            }else{
                displaymsg  = true;
            }
        }else{
            if(setchecked){ 
                displayPopup = true; 
            }else{
                displaymsg  = true;
            }
        }
    }
    
    public void queslist () {
        selectedIDs.add(selectedId);
        system.debug('@@@@@@  '+selectedIDs);
    } 
}