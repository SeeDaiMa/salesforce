/**
 * Created by 25916 on 2022/11/11.
 */

@IsTest
private class IntergerTest {

    @IsTest
    static void testBehavior() {
        Integer age = 23;
        System.debug('age:'+age);
    }

    @IsTest
    static void testDate(){
        Date date1 = Date.today();
        System.debug('Date.today() ：'+date1);//2022-11-11 00:00:00
    }

    @IsTest
    static void testDateTime(){
        System.debug('datetime:'+DateTime.now());// 2022-11-11 07:21:03

    }


    @IsTest
    static void testDateTime1(){
        System.debug('datetime1:'+DateTime.now());
    }


    @IsTest
     static void testOther() {
        Long long1 = 1L;
        String str = '这是一个字符串';
        account a = new account(name = 'account');
        insert a;
        Id myId = a.id;
        Double double1 = 1.1;
        Decimal decimal1 = 1.2;
        System.debug('long1 :'+long1 +',str : '+str +'id :'+myId + 'double ： '+double1 +'decimal : '+decimal1);
        
    }
}