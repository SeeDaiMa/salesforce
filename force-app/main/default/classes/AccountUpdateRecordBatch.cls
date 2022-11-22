global  class AccountUpdateRecordBatch implements Database.Batchable<sObject>,Database.Stateful {
    public AccountUpdateRecordBatch() {

    }


    global Database.QueryLocator start(Database.BatchableContext BC) {
        String queryS = 'SELECT Id,Name FROM Account limit 100';
        return Database.getQueryLocator(queryS);
    }
    global void execute(Database.BatchableContext BC, list<sObject> scope) {
        Savepoint sp = Database.setSavepoint();
        try {
            List<Account> newOppList = new List<Account>();
            for(Account accountItem : (List<Account>)scope) {
                accountItem.name += '_a';
                newOppList.add(accountItem);
            }
            update newOppList;
        } catch (Exception ex) {
            Database.rollback(sp);
        }
    }

    global void finish(Database.BatchableContext BC) {

    }
}