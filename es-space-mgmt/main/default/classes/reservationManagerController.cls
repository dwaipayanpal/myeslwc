public with sharing class reservationManagerController {    

        @auraEnabled(cacheable=true)
        public static List<CustomerServices.Customer> getCustomerList (String sObjectType){
            List<CustomerServices.Customer> customers = new List<CustomerServices.Customer>();
            if (sObjectType == 'Lead'){
                for (Lead l  : [select Id, Email, Name, City, State, Status
                               from Lead
                               where Status in ( 'Open - Not Contacted','New - Not Contacted','New') WITH SECURITY_ENFORCED]){
                                CustomerServices.Customer c = new CustomerServices.Customer(l.Name,l.Email,l.City,l.State,l.Status,l.Id);
                                customers.add(c);
                               }
            }

            if (sObjectType == 'Contact'){
                for (Contact c  : [select Id, Email, Name, MailingCity, MailingState, Reservation_Status__c
                               from Contact
                               where Reservation_Status__c in ('Not Started') WITH SECURITY_ENFORCED]){
                                CustomerServices.Customer cu = new CustomerServices.Customer(c.Name,c.Email,c.MailingCity,c.MailingState,c.Status,c.Id);
                                customers.add(cu);
                               }
            }

            return customers;

        } 
      
    
}
