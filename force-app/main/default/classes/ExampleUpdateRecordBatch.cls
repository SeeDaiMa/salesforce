global with sharing class ExampleUpdateRecordBatch implements Database.Batchable<sObject>,Database.Stateful,Database.AllowsCallouts {
    public ExampleUpdateRecordBatch() {

    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String queryS = 'SELECT Id,Name FROM Opportunity WHERE DeleteFlg__c = true';
        return Database.getQueryLocator(queryS);
    }
    global void execute(Database.BatchableContext BC, list<sObject> scope) {
        Savepoint sp = Database.setSavepoint();
        try {
            List<Opportunity> newOppList = new List<Opportunity>();
            for(Opportunity opportunityItem : (List<Opportunity>)scope) {
                opportunityItem.stageName = 'Closed Won';
                newOppList.add(opportunityItem);
            }
            update newOppList;
        } catch (Exception ex) {
            Database.rollback(sp);
        }
    }

    global void finish(Database.BatchableContext BC) {

    }
}