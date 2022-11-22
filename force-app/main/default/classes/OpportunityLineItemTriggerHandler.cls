public with sharing class OpportunityLineItemTriggerHandler extends TriggerHandler {
    

    public static Boolean isExcute = true;//是否执行当前触发器的逻辑
    public override Boolean isExcute(){return isExcute;}

    // // 清空金额
    // private void clearTheAmount(Map<Id, SObject> newItems){
    //     for(OpportunityLineItem item : (List<OpportunityLineItem>)newItems.values()){
    //         Id opportunityId =  item.OpportunityId;
    //         if(opportunityId != null && !item.IsDeleted){
    //             List<Opportunity> opportunities= [select AccountId from Opportunity where id = :opportunityId];
    //             if(opportunities[0] !=null){
    //                 Id accountId =  opportunities[0].AccountId;
    //                 List<Account> accounts = [select id,operationalAcationMoney__c from Account where id =:accountId];
    //                 if(accounts[0]!=null){
    //                     accounts[0].operationalAcationMoney__c = 0;
    //                     update accounts;
    //                 }
    //            }
    //         }
    //      }
    // }

    // private void updateOperationalAcationMoney(Map<Id, SObject> newItems){
    //      // 清空每个客户的商机金额
    //      clearTheAmount(newItems);
    //      for(OpportunityLineItem item : (List<OpportunityLineItem>)newItems.values()){
    //         Id opportunityId =  item.OpportunityId;
    //         system.debug('业务机会的id'+opportunityId);
    //         if(opportunityId != null && !item.IsDeleted){
    //             List<Opportunity> opportunities= [select AccountId,TotalOpportunityQuantity from Opportunity where id = :opportunityId];
    //             if(opportunities[0] != null){
    //             // 获取一个业务机会的所有产品的金额
    //             System.debug('************'+opportunities[0]);
    //             Decimal totalAmount = opportunities[0].Quantity*item.TotalPrice;
    //             Id accountId =  opportunities[0].AccountId;
    //             List<Account> accounts = [select id,operationalAcationMoney__c,name from Account where id =:accountId];
    //             if(accounts[0]!=null){
    //                 accounts[0].operationalAcationMoney__c += totalAmount;
    //                 update accounts;
    //             }
    //             }
    //         }
    //      }
    // }
    
    // public override void afterInsert(Map<Id, SObject> newItems){
    //     updateOperationalAcationMoney(newItems);
    // }
    // public override void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems){
    //     updateOperationalAcationMoney(newItems);
	// }

    // public override void afterDelete(Map<Id, SObject> newItems){
    //     updateOperationalAcationMoney(newItems);
    // }

}