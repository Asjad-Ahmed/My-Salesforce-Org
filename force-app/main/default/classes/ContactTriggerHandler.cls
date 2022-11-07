public class ContactTriggerHandler {

    public static void OnlyOneActiveContact(List<Contact> ConLst_New, Map<id, Contact> ConLst_Oldmap, 
                                      Boolean IsInsert, Boolean IsUpdate)
    {
        Set<id> AccountIds = new Set<id>();    //Set of AccountIds For Contacts     

        Set<Id> ActvConIds = new Set<Id>();    //Set of Active Contact While Inserting of Updating

        List<Contact> Updt_Contacts = new List<Contact>();  // List of Contact for DML Operation

        if(IsInsert||IsUpdate)
        {
            for (Contact Con : ConLst_New)
            {
                if(Con.AccountId!=NULL)
                {
                    if (isUpdate) 
                    {
                        Contact OldCon = ConLst_Oldmap.get(Con.Id);
                        if(OldCon.IsActive__c != Con.IsActive__c)
                        {
                            if(Con.IsActive__c)
                            {
                                ActvConIds.add(Con.Id);
                                AccountIds.add(Con.AccountId);
                            }
                        }
                    }
                    else  //Insert Case
                    {
                        if(Con.IsActive__c)
                        {
                            ActvConIds.add(Con.Id);
                            AccountIds.add(Con.AccountId);
                        }
                    }
                }
            }       
        }
        if(AccountIds.size()>0)
        {
            List<Contact> LstCon = [SELECT Id, IsActive__c, AccountId From Contact Where AccountId IN : AccountIds];
            System.debug(LstCon);
            for (Contact Con : LstCon) 
            {
                if(!ActvConIds.contains(Con.Id)&& Con.IsActive__c ==true) 
                {
                    Con.IsActive__c = false;
                    Updt_Contacts.add(Con);
                }
            }
            Update Updt_Contacts;
        }
    }
}