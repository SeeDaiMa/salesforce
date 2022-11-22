/*******************************************************************************
 *  Summary         : 客户地点触发器处理类
 *  Refer Object    : Account_Address__c
 *  Author          : Andy Yin      
 *  CreatedDate     : 2020-02-06
 *  Change Log      : 
 ******************************************************************************/
public without sharing class AccountTriggerHandler extends TriggerHandler{
    public static Boolean isExcute = true;//是否执行当前触发器的逻辑
    public override Boolean isExcute(){return isExcute;}

    // public override void afterInsert(Map<Id, SObject> newItems){
    //     for(Account item : (List<Account>)newItems.values()){
    //         System.debug('插入后的新的数据列表：'+item);
    //     }
    // }
    // public override void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems){
    // 	for(Account newItem : (List<Account>)newItems.values()){
    // 		Account oldItem = (Account)oldItems.get(newItem.Id);
    //         System.debug('更新前的数据： '+oldItem);
    // 	}
	// }
    
}