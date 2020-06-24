public class AccountInlineEditCLs {
public List<account> acclst=new List<account>();
//Tests This is a commit from Vamshi_develop Feature1

public List<account> getAccounts(){
 acclst=[select name,industry,type,Description from account];
 //This is a comment from Feature2 branch developr
      return acclst;

}

public void save1() {
     //This is  a comment from feature one.
     update acclst;
}
}