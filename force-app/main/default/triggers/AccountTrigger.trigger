trigger AccountTrigger on Account (before delete, before insert, before update, 
                                    after delete, after insert, after update)  {

    new AccountTriggerHandler().run();
    
    // if(trigger.isBefore){
    //     if(trigger.isInsert){
    //         system.debug('插入前 新出来的数据：trigger.newMap'+trigger.newMap);


    //     }
    //     if(trigger.isUpdate){
    //         System.debug('更新前的数据: trigger.oldMap'+trigger.oldMap);
    //     }
        
    // }else{
    //     if(trigger.isInsert){
    //         System.debug(' 插入后 新的数据： '+ trigger.newMap);
    //     }
    //     if(trigger.isUpdate){
    //         System.debug( '更新后的数据：'+trigger.newMap);   
    //     }
    // }
    


}