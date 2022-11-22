public with sharing class OpportunityTriggerHandler extends TriggerHandler{
    
    public static Boolean isExcute = true;//是否执行当前触发器的逻辑
    public override Boolean isExcute(){return isExcute;}
    // 阶段顺序表
    public static final List<String> stageSequenceTable = new List<String>{'Prospecting','Qualification','Needs Analysis','Value Proposition','Id. Decision Makers','Perception Analysis','Proposal/Price Quote','	Negotiation/Review','Closed Won','Closed Lost'};


    private void updateOperationalAcationMoney(Map<Id, SObject> newItems){
        Map<Id,Decimal> AccountIdList = new Map<Id,Decimal>();
        for(Opportunity newItem : (List<Opportunity>)newItems.values()){
            Id AccountId = newItem.AccountId;
            // 客户 与 金额
            AccountIdList.put(AccountId, 0);
    	}
        for(Opportunity newItem :  [select id,
                                        accountId,
                                        Amount 
                                    from Opportunity 
                                    where  accountId in :AccountIdList.keySet()
                                    and Amount!=null  // 金额不能为null 
                                ]){
            // 业务活动的金额
            Decimal  opportunityAmount = newItem.Amount;
            Id AccountId = newItem.AccountId;
            Decimal opportunityAmount2 = AccountIdList.get(AccountId)+opportunityAmount;
            AccountIdList.put(AccountId, opportunityAmount2);
    	}
        List<Account> accounts = new List<Account>();
        
        for (Account item : [select id,
                                operationalAcationMoney__c,
                                CurrencyIsoCode 
                                from Account
                                where id in :AccountIdList.keySet()] ) {
            List<CurrencyType> currencyTypes =  [select ConversionRate  
                                        from CurrencyType 
                                        where IsoCode = :item.CurrencyIsoCode];
            Account a =new Account();
            a.Id=item.Id;
            a.operationalAcationMoney__c=AccountIdList.get(item.Id)*currencyTypes[0].ConversionRate;
            accounts.add(a);
         }

        // for (id item : AccountIdList.keySet() ) {
           
        //    accounts.add(a);
        // }

        // 


        
        update accounts;


    }

    public override void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems){
        System.debug('**************');
    	updateOperationalAcationMoney(newItems);
        
	}
    public override void afterDelete(Map<Id, SObject> newItems){
        updateOperationalAcationMoney(newItems);
    }

    public override void beforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems){
        for (Id newItemId : newItems.keySet()) {
            for (Id oldItemId : oldItems.keySet()) {
                // id相同
                if(newItemId == oldItemId){
                    // 新旧商机
                  Opportunity newOpportunity =   (Opportunity)newItems.get(newItemId);
                  Opportunity oldOpportunity =   (Opportunity)oldItems.get(oldItemId);
                  // 新旧商机的阶段
                   String newItemStageName =  newOpportunity.StageName;
                   String oldItemStageName = oldOpportunity.StageName;
                    // 新旧阶段不同
                   if(newItemStageName != oldItemStageName){
                    // 新商机索引
                    Integer newIndex =  stageSequenceTable.indexOf(newItemStageName);
                    // 旧商机索引
                    Integer oldIndex =  stageSequenceTable.indexOf(oldItemStageName);
                    // Success
                    if(newIndex-oldIndex == 1 ){
                      System.debug('Success！');
                    }else{
                      // flase
                      if(newIndex < oldIndex){
                          System.debug('业务机会阶段不能逆向跳转');
                          // 对象添加错误
                          newOpportunity.addError('业务机会阶段不能逆向跳转');
                        }
                        if(newIndex-oldIndex > 1){
                          System.debug('业务机会阶段不能跨阶段跳转');
                          newOpportunity.addError('业务机会阶段不能跨阶段跳转');
                        }
                
                    }

                    // 跳转到第二个阶段校验【类型】字段不能为空
                    if(newIndex == 1 ){
                        System.debug('newOpportunity.Type'+newOpportunity.Type);
                        if(newOpportunity.Type==null){
                            newOpportunity.Type.addError('类型字段不能为空');
                        }  
                    }
                    //跳转到第三个阶段校验结束日期不能小于今天（操作当天
                    if(newIndex == 2){
                        System.debug('结束日期'+newOpportunity.CloseDate);
                        System.debug('今天'+Date.today());
                        if(newOpportunity.CloseDate < Date.today()){
                            newOpportunity.CloseDate.addError('结束日期不能小于今天');
                        }
                    
                    }
                    
                  }



                }
            }  
        }

    }



}