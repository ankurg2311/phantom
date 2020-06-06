public with sharing class searchAccountController {
 
 @AuraEnabled
 public static List < account > fetchAccount(String searchKeyWord) {
  String searchKey = searchKeyWord + '%';
  List < Account > returnList = new List < Account > ();
  List < Account > lstOfAccount = [select id, Name, Type, Industry, Phone, Fax from account
                                   where Name LIKE: searchKey LIMIT 500];
 
  for (Account acc: lstOfAccount) {
   returnList.add(acc);
  }
  return returnList;
 }
    
    
    @AuraEnabled
    public static Map<String,String> getPiklistValues() {
        List<String> plValues = new List<String>();
        Map<String,String> plValuesMap = new Map<String,String>();
        
        //Get the object type from object name. Here I've used custom object Book.
        Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        //Describe the sObject using its object type.
        //Get the specific field information from field name. Here I've used custom field Genre__c of Book object.
        Map <String, Schema.SObjectField> fieldMap = schemaMap.get('Account').getDescribe().fields.getMap();
        
        
        
        for (Schema.SObjectField  fieldName: fieldMap.Values()) {
            try { 
                schema.describefieldresult dfield = fieldName.getDescribe();
                plValues.add(dfield.getLabel());
                system.debug('####### plValues ' +plValues);
                plValuesMap.put(dfield.getLabel(),dfield.getName());
                system.debug('####### plValuesMap ' +plValuesMap);
            } catch (SObjectException e)    { 
                // Intentional capture 
            }
            
            
            
            //plValuesMap.KeySet().sort();
           
        }
         return plValuesMap;
    }
    
    /**
     * This method is used to return recently view records
     * @param ObjectName - Specify the API name of object to get recently view records
     * @param fieldstoget - Fields from the object need to get
     * @param pageNumber - Number of the page to display in the table
     * @param pageSize - Number of records needs to be displayed in the page
     */ 
    @AuraEnabled public static lightningTableWrapper getRecords(String ObjectName,String fieldstoget,decimal pageNumber, String pageSize, String serachKey, Date fromDate, Date toDate){     
       
        integer offset = (integer.valueOf(pageNumber) - 1) * integer.valueof(pageSize);
        String queryString = 'Select '+ String.escapeSingleQuotes(fieldstoget)+
                             ' from '+ String.escapeSingleQuotes(ObjectName);
        if(String.isNotBlank(serachKey)){
           queryString =  queryString + ' Where  Name Like \'%' +String.escapeSingleQuotes(serachKey) +'%\'' ;               
        }
          
             queryString =  queryString + ' Limit '+ String.escapeSingleQuotes(pageSize) + ' Offset '+offset;      
        lightningTableWrapper ltw = new lightningTableWrapper();
        if(String.isBlank(serachKey)){
            ltw.total = database.countQuery('Select count() from '+String.escapeSingleQuotes(ObjectName));
            ltw.page = Integer.valueOf(pageNumber);  
        }
        system.debug('@@@ queryString @@@ '+queryString);
        ltw.sObjectrecords = database.query(queryString);
        return ltw;
    }

}