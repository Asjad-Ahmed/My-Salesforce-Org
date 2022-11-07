public class CreateRecord{
    //Creating Account Record For @Testclasses
    public static Account AccountRecord(String Name)
    {
        Account CR_Account = new Account();
        CR_Account.Name = Name;
            
        return CR_Account;
    }
    
    
    //Creating Contact Record For @Testclasses
    public static Contact ContactRecord(String Lastname, Boolean Is_Active, String Email, String Accountid)
    {
        Contact CR_Contact = new Contact();
        CR_Contact.LastName = Lastname;
        CR_Contact.IsActive__c = Is_Active;
        CR_Contact.Email = Email;
        CR_Contact.AccountId = Accountid;

        return CR_Contact;
    }
}