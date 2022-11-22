/**
 * Created by 25916 on 2022/11/11.
 */

// 注解
@IsTest
private class DMLStatement {

    @IsTest
    static void testBehavior() {
        Account a =   new Account(Name='张三');
        insert a;
        Account myAcct = [SELECT Id,Name,BillingCity from Account where id = :a.id];
        myAcct.BillingCity = 'San Francisco';
        update myAcct;
        System.debug('******************'+myAcct);
        // update 可见性效果出不来

    }

    // upsert 在update的基础上 加上的功能 如果说更新的记录 在对象中没有的话，是直接创建 而不是出现异常

    @IsTest
    static void testUpsert(){
        Account a = new Account(Name='李四');
        upsert a;

        // 可见性效果出不来


    }



    @IsTest
    static void testSwitch(){
        Integer i = 5;
        switch on i{
            when 1 {
                System.debug('参数为1');
            }
            when 2 {
                System.debug('参数为2');
            }
            when 3 {
                System.debug('参数为3');
            }
            when else {
                System.debug('其他');
            }
        }

    }

    @IsTest
    static void testSwitch2(){
        Account ac = new Account(name='张三');
        insert  ac;
        List<SObject> a1 = [SELECT  id,name from Account limit 1];
        switch on a1[0]{
            when Account a{
                System.debug('对象为'+a);
            }
            when Contact b{
                System.debug('对象为'+b);
            }
            when else {
                System.debug('其他');
            }
        }

    }


    @IsTest
    static void testDml(){
           Integer a = 10 ;
           String str = 'SalesForce';
        Account account1 = new Account(name='张三');
        insert account1;
        List<Account> accounts = [select id,name from Account];
        Map<Id,Account> accountMap = new Map<Id, Account>(accounts);
        Set<Account> accounts2 = new Set<Account>(accounts);
        System.debug(a +'========='+ str + '============='+accounts+'=============='+accountMap+'==========='+accounts2);
    }


    @IsTest
    static void testMap(){
        Map<String,String> tempMap =  new Map<String,String>();
        tempMap.put('2022年','开始学习salesforce');
        System.debug('containKey******* '+tempMap.containsKey('2022年'));
        System.debug('get******* '+tempMap.get('2022年'));
        tempMap.put('2023年','也在学习salesforce');
        System.debug('keyset******* '+tempMap.keyset());
        System.debug('values******* '+tempMap.values());
        System.debug(LoggingLevel.DEBUG,'size ==============='+tempMap.size());
        System.debug('清空==========');
        tempMap.clear();
        System.debug('size ==============='+tempMap.size());



    }


    @IsTest
    static void testSwitch3(){
        Integer i = 2;
        switch on i{
            when 1{
                System.debug(LoggingLevel.INFO,'该值为1');
            }
            when 2{
                System.debug(LoggingLevel.INFO,'该值为2');
            }
            when 3{
                System.debug(LoggingLevel.INFO,'该值为3');
            }
            when else {
                System.debug(LoggingLevel.INFO,'该值不属于1,2,3其中的一个值');
            }

        }


    }

    @IsTest
    static void testWhileDo(){
        Integer i = 0;

        while (i<=10){
            System.debug('while *********** i ======'+i);
            i++;
        }

        do{
            i++;
            System.debug('do while *********** i===='+i);
        }while (i<=10);



        for (Integer  i1 = 0;i1 < 10 ;i1++ ){
            System.debug('输出for  *******i'+i1);
        }

        Integer[] mouths = new Integer[]{1,2,3,4,5,6,7,8,9,10,11,12};
        for (Integer mouth:mouths){
            System.debug('输出所有的月份 + mouth '+mouth);
        }


    }

    @IsTest
    static  void testSQQl(){
        String sqsl = 'find {' + '测试客户'  + ' or '+ 'Test' +'} in name fields returning ACCOUNT(name,phone),Contact(name,phone)';
        List<List<SObject>> sObjects =  Search.query(sqsl);
        System.debug('******* s'+sObjects);
    }

    @IsTest
    static void sqql(){
        List<Account> accounts = [select id,name from Account limit 1 ];
        System.debug(accounts);
    }



}