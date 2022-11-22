@IsTest
private with sharing class ExampleUpdateRecordBatchTest {
    @TestSetup
    static void initialOrgInfo(){
        String strUserName = 'BatchTest001';
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        User batchTestUser = new User();
        batchTestUser.ProfileId = profile.Id;
        batchTestUser.UserName = strUserName + '@sample.com';
        batchTestUser.FirstName = '';
        batchTestUser.LastName = strUserName;
        batchTestUser.EMail = 'testuser@sample.com';
        batchTestUser.Alias = 'testuser';
        batchTestUser.TimeZoneSidKey = 'Asia/Tokyo';
        batchTestUser.LocaleSidKey = 'ja_JP';
        batchTestUser.EmailEncodingKey = 'ISO-2022-JP';
        batchTestUser.LanguageLocaleKey = 'ja';
        Database.insert(batchTestUser, false);

        PermissionSet permissionSet = [SELECT Id
                                        FROM PermissionSet
                                        WHERE Name = 'Ursus_Park_User'];
        PermissionSetAssignment assignmentAss = new PermissionSetAssignment();
        assignmentAss.AssigneeId = batchTestUser.Id;
        assignmentAss.PermissionSetId = permissionSet.Id;
        Database.insert(assignmentAss, false);
    }
    @IsTest static void testBatch001() {
        User runUser = [SELECT ID, UserName FROM User WHERE username='BatchTest001@sample.com'];
        List <Opportunity> oppList = new List<Opportunity>();
        for(integer i = 0; i<200; i++){
            Opportunity oppItem = new Opportunity(Name='testOpportunity'+ i,
                                StageName='Perception Analysis',
                                Ownerid = runUser.Id,
                                CloseDate = Date.Today(),
                                DeleteFlg__c = true);
            oppList.add(oppItem);
        }
        insert oppList;
        System.runAs(runUser) {
            Test.StartTest();
            ExampleUpdateRecordBatch reassign = new ExampleUpdateRecordBatch();
            ID batchprocessid = Database.executeBatch(reassign, 200);
            Test.StopTest();
        }
        List<Opportunity> oppUpdateList = [SELECT Id,StageName FROM Opportunity WHERE Ownerid = :runUser.Id];
        System.assertEquals(200, oppUpdateList.size());
        if (oppUpdateList != null && oppUpdateList.size() >0) {
            for (Opportunity oppUpdate : oppUpdateList) {
                System.assertEquals('Closed Won', oppUpdate.StageName);
            }
        }
    }
}