@IsTest
public class OnlyOneActiveContact_TestClass {
	@TestSetup
    static void makeData()
    {
        //Creating Account Record
        Account AccountRec = new Account();
        AccountRec = CreateRecord.AccountRecord('CloudCentric');
        Insert AccountRec;

        //Creating Contact record
        Contact Con1 = new Contact();
        Con1 = CreateRecord.ContactRecord('Asjad', true , 'asjadahmed51@gmail.com', AccountRec.Id);
        Insert Con1;


        Contact Con2 = new Contact();
        Con2 = CreateRecord.ContactRecord('Vivek', true , 'Vivek@gmail.com', AccountRec.Id);
        Insert Con2;
    }

    @IsTest
    Static void TestActiveContactInsert()
    {
        Contact Con = [Select id, IsActive__c, AccountId From Contact Where LastName = 'Asjad' LIMIT 1];
        System.assertEquals(false, Con.IsActive__c);
    }



    @IsTest
    Static void TestActiveContactUpdate()
    {
        Contact Con = [Select id, IsActive__c, AccountId From Contact Where LastName = 'Asjad' LIMIT 1];
        Con.IsActive__c = true;
        Update Con;

        Contact Con2 = [Select id, IsActive__c, AccountId From Contact Where LastName = 'Vivek' LIMIT 1];
        System.assertEquals(false, Con2.IsActive__c);
    }

}