public with sharing class opportunityTaskSchedule implements Schedulable {

    /*
    Task t = new Task();
    t.WhatId = contract.id;//对象ID
    t.OwnerId = uid;//任务通知人员 
    t.Subject = '合同金额认定_已同意';//任务主题
    t.priority= 'High';//任务等级
    t.ActivityDate = Date.today().addDays(3);//有效期到期日
    t.IsReminderSet = true;
    t.ReminderDateTime = System.now();
    t.description = '合同:'+contract.Contract_Number__c+'商务已完成合同金额认定，认定金额为:'+contract.CurrencyIsoCode+contract.ConfirmAmount__c+'。//通知内容
    */



    public opportunityTaskSchedule(){

    }

    public void execute(SchedulableContext sc){
        List<Task> tasks = new List<Task>();
        // 查询所有的商机
        for (Opportunity o : [select id,CloseDate,OwnerId from Opportunity where CloseDate = :Date.today().addDays(5) ]) {
            // 5天前
           tasks.add(runTask(o));      
        }
        if(tasks.size()>0){
            insert tasks;
        }
    }

    private Task runTask(Opportunity o){
        Task t = new task();
        t.WhatId = o.id;
        t.OwnerId = o.OwnerId;//任务通知人员 
        t.Subject = '业务活动结束通知';//任务主题
        t.priority= 'High';//任务等级
        t.ActivityDate = Date.today().addDays(3);//有效期到期日
        t.IsReminderSet = true;
        t.ReminderDateTime = System.now();
        t.description = '您的id为'+o.Id + '的业务活动会在'+o.CloseDate+'的时候结束！'; // 通知内容
        return t;
    }

}