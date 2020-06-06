trigger contactTrigger on Contact (before update) {

    for(Contact con: Trigger.new){
        
       
            
            system.debug('######  conID' +con.ID);
     
    }
    
}