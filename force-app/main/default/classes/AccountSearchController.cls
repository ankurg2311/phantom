public class AccountSearchController {
	
    ApexPages.StandardSetController con {get;set;}
    public List<Account> accList  {get;set;}
    public String accountSearchKey {get;set;}
    public AccountSearchController(){
      
        accList = new List<Account>();
        
    }
    

   
    
    public Void searchAccounts(){
       
        String strQuery ='SELECT Id,Name,Substatus__c,T1C_Base_Inactive__c From Account Where Name Like \'%' +String.escapeSingleQuotes(accountSearchKey) +'%\'';
        system.debug('strQuery ==>'+strQuery );
        con = new ApexPages.StandardSetController(Database.query(strQuery));
        accList =  con.getRecords();
    }
    

}