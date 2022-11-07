@IsTest
Private class BClass_ActiveContact_Test {
    @TestSetup
    static void makeData()
    {
        //Creating Account Record
        Account AccountRec = new Account();
        AccountRec = CreateRecord.AccountRecord('CloudCentric');
        Insert AccountRec;

        //Creating Contact record
        List<Contact> ConLst = new List<Contact>();
        for(Integer i = 1; i < 10; i++)
        {
			Contact Con = new Contact();
            Con = CreateRecord.ContactRecord('Test' +i , false , 'Test'+i+'@gmail.com', AccountRec.Id);
           	ConLst.add(Con);
        }
        System.debug('testClassConlist==' +ConLst);
        Insert ConLst;
    }
    private static testMethod void testSequence(){
        TestBatchClass();
        TestAllContactActive();
    }
 	private Static void TestBatchClass()
    {
        Test.startTest();
        BClass_SendEmailToActiveContact B_Inst = new BClass_SendEmailToActiveContact();
        database.executeBatch(B_Inst);
        Test.stopTest();
    }
 	private Static void TestAllContactActive()
    {        
        List<Contact> ListOfCon = [Select Id, IsActive__c From Contact LIMIT 5];
        System.debug(ListOfCon);

        For(Contact Con : ListOfCon)
        {
            System.debug('ActiveInloop==' +Con.IsActive__c);
            System.assertEquals(true, Con.IsActive__c );
        }
    }
}