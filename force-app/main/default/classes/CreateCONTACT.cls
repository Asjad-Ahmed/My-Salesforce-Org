Global class CreateCONTACT {
    
    Webservice static void InsrtCon(String AccId)
    {
        Account Acc = [Select id, Phone from Account Where id =: AccId ];
        
        Contact Con = New Contact();
        Con.AccountId = AccId;
        Con.LastName = 'Askjad';
        Con.Email = 'Asjad@CCC.com';
        
        Insert Con;
            
    }

}