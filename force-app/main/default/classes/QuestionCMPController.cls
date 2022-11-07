public class QuestionCMPController {
    @AuraEnabled
    public static String getQuestions(){
        List<QWrapper> listQWrapper = new List<QWrapper>();
        integer i = 0;
        // Map<String, Schema.SObjectField> fieldMap;
        // fieldMap = Schema.SObjectType.Question__c.fields.getMap();
        // for (String fieldMap : fieldMap.keySet()) 
        // {
            
        // }
        // Schema.SObjectField field = M.get('Fax');
        // Schema.DisplayType FldType = field.getDescribe().getType();


        for (Question__c obj : [SELECT Id, Question_Description__c FROM Question__c LIMIT 500]) 
        {
            QWrapper qObj = new QWrapper();
            i = i + 1;
            qObj.sNo = i;
            qObj.question = obj.Question_Description__c;
            qObj.Id = obj.Id;
            qObj.answer = '';
            listQWrapper.add(qObj);
        }
        system.debug(listQWrapper);
        
        return JSON.serialize(listQWrapper);
    }

    @AuraEnabled
    public static String createQuestionAnswersRecords(String q_Ans_JsWrapper, String leadId){

        list<QWrapper> lst_Q_AnswerObj = new List<QWrapper>();
        String message = '';
        List<Question_Answers__c> lstQuestionAnswers = new List<Question_Answers__c>();

        
        try {
            if (Q_Ans_JsWrapper != null && Q_Ans_JsWrapper != '') 
            {
                lst_Q_AnswerObj = (list<QWrapper>)JSON.deserialize(q_Ans_JsWrapper, list<QWrapper>.class);
            }

            System.debug('lst_Q_AnswerObj===='+lst_Q_AnswerObj);

            if (lst_Q_AnswerObj != null && lst_Q_AnswerObj.size()>0) 
            {
                for (QWrapper qObj : lst_Q_AnswerObj) 
                {
                    if(qObj.answer != null && qObj.answer != '' )
                    {
                        Question_Answers__c q_AObj = new Question_Answers__c();
                        q_AObj.Question__c = qObj.question;
                        q_AObj.Answer__c = qObj.answer;
                        q_AObj.Lead__c = leadId;
                        lstQuestionAnswers.add(q_AObj);
                    }
                }
                if(lstQuestionAnswers != null && lstQuestionAnswers.size()>0)
                {
                    insert lstQuestionAnswers;
                    message = 'Records successfully created!!';
                }
            }else {
                message = 'Records Did not created - JSWrapper Blank!!';
            }
        } catch (Exception e) {
            throw new AuraHandledException('Records Did not created-- '+e.getMessage());
        }
        return message;
    }

    public class QWrapper{
        public Integer sNo;
        public String Id;
        public String question;
        public String answer;
    }

}