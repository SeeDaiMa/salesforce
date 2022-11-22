public with sharing class opportunityTaskScheduleTest implements Schedulable {
    public opportunityTaskScheduleTest() {

    }


// 记录下个时间点
    // public Datetime nextDatetime {get;set;}

    public void execute(SchedulableContext sc){
        // 查询所有的商机
        List<Opportunity> opportunities = [select id,CloseDate,OwnerId from Opportunity];   
        for (Opportunity o : opportunities) {
            // 5天前
            if(Date.today().addDays(5) >= o.CloseDate){
                runTask(o);      
            }
        }
        

    }

    private void runTask(Opportunity o){
        Task t = new task();
        t.WhatId = o.id;
        t.OwnerId = o.OwnerId;//任务通知人员 
        t.Subject = '业务活动结束通知';//任务主题
        t.priority= 'High';//任务等级
        t.ActivityDate = Date.today().addDays(3);//有效期到期日
        t.IsReminderSet = true;
        t.ReminderDateTime = System.now();
        t.description = '您的id为'+o.Id + '的业务活动会在'+o.CloseDate+'的时候结束！'; // 通知内容
        insert t;
    }

}