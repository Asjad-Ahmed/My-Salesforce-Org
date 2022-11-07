Global class ScheduleClassForBatch implements Schedulable
{
	global void execute(SchedulableContext sc)
    {
        BClass_SendEmailToActiveContact b = new BClass_SendEmailToActiveContact();
        Database.executeBatch(b);
    }
}

/* In Anynomous Window run
   String CronEXP = '0 0 20 * * ?';
   BClass_SendEmailToActiveContact b = new BClass_SendEmailToActiveContact();
   system.schedule('Everyday at 8pm', CronEXP, b);*/