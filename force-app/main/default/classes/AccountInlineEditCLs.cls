public class AccountInlineEditCLs {
public List<account> acclst=new List<account>();
//Tests :Feature_1
public List<account> getAccounts(){
 acclst=[select name,industry,type,Description from account];
 system.debug('Hello from Feature_2 & Feature_1');
      return acclst;

}

public void save1() {
     update acclst;
}
}