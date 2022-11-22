/**
 * Created by 25916 on 2022/11/15.
 */

@IsTest
private class MyFirstCtlTest {

    @TestSetup
    static  void setup(){
        // 初始化
//        List<Account> acc = [select id,name,AccountNumber,AccountSource,Type,Website from account];


        // ApexPages.currentPage().getParameters().put('id', accountId);
    }

    @IsTest
    static void testMyFirstCtl() {
        List<Account> testAccts = new List<Account>();
        for(Integer i=1;i<=50;i++) {
            testAccts.add(new Account(Name = 'TestAcct'+i));
        }
        insert testAccts;
        MyFirstCtl myFirstCtl1 = new MyFirstCtl();
    }


    @IsTest
    static void testMyFirstCtl2() {
        List<Account> testAccts = new List<Account>();
        for(Integer i=1;i<=11;i++) {
            testAccts.add(new Account(Name = 'TestAcct'+i));
        }
        insert testAccts;
        MyFirstCtl myFirstCtl1 = new MyFirstCtl();
    }




    @IsTest
    static void testBeforePage() {
        MyFirstCtl myFirstCtl1 = new MyFirstCtl();
        myFirstCtl1.currentPage = 3;
        myFirstCtl1.beforePage();
    }


    @IsTest
    static void testAfterPage() {
        MyFirstCtl myFirstCtl1 = new MyFirstCtl();
        myFirstCtl1.afterPage();
    }
    @IsTest
    static void testFirstPage() {
        MyFirstCtl myFirstCtl1 = new MyFirstCtl();
        myFirstCtl1.firstPage();
    }
    @IsTest
    static void testEndPage() {
        MyFirstCtl myFirstCtl1 = new MyFirstCtl();
        myFirstCtl1.endPage();
    }

    @IsTest
    static void testAccurateSearch() {
        MyFirstCtl myFirstCtl1 = new MyFirstCtl();
        myFirstCtl1.accurateSearch();
    }


}