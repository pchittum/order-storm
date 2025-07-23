List<Inbound_Order_Status__c> recordsToDelete = [Select Id FROM Inbound_Order_Status__c];

delete recordsToDelete;