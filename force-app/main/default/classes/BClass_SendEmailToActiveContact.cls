global class BClass_SendEmailToActiveContact implements Database.Batchable<sObject>, database.stateful
{
   	 static List<messaging.SingleEmailMessage> EmailsToSend = new List<messaging.SingleEmailMessage>();
     		List<Contact> UpdateCons = new List<Contact>();
     		List<String> ConEmail = new List<String>();

    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator([SELECT Id, IsActive__c, Email FROM Contact where CreatedDate= last_n_days:2]);
    }
                                                       //batch size 200
    global void execute(Database.BatchableContext BC , List<Contact> Conlist)
    {
        for (Contact Con : Conlist) 
        {
            if(Con.IsActive__c == false)
            {
                Con.IsActive__c = true;
                
                UpdateCons.add(Con);
            }
            System.debug(Con.IsActive__c);
            if(Con.Email != NULL && Con.Email!= '' )
            {
                system.debug('Con.Email==' +Con.Email);
                if(Con.Email.contains('.net'))
                {
                    Con.Email = Con.Email + '.com';
                	system.debug('Con.Email==' +Con.Email);
                	ConEmail.add(Con.Email);
                }
                else{
                    ConEmail.add(Con.Email);
                }
                
            }
        }
       	Database.Update(UpdateCons, false);
        system.debug('ConEmail==' + ConEmail);
    }
    
    global void finish(Database.BatchableContext BC) 
    {
        /*
        system.debug('finish method start');
        //List<messaging.SingleEmailMessage> EmailsToSend = new List<messaging.SingleEmailMessage>();
        if(ConEmail.size()>0)
        {
            Messaging.SingleEmailMessage SingleMail = new Messaging.SingleEmailMessage();
            
           
           		system.debug('ConEmail==' + ConEmail);
                SingleMail.setToAddresses(ConEmail);
                SingleMail.setSubject('Send Emails to Active Contacts');
                SingleMail.setPlainTextBody('Hi Active Contact,' + ' you are active so you get the mail hahahah');
                EmailsToSend.add(SingleMail); //Adding to list of emails to send
        }
             	
       
        Messaging.sendEmail(EmailsToSend);    */
    }
}