public class AccountInlineEditCLs {
public List<account> acclst=new List<account>();

public List<account> getAccounts(){
 acclst=[select name,industry,type,Description from account];
      return acclst;

}

public void save1() {
     update acclst;
}
}