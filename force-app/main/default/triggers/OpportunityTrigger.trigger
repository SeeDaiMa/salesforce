trigger OpportunityTrigger on Opportunity (before delete, before insert, before update, 
                                    after delete, after insert, after update) {
    new OpportunityTriggerHandler().run();
}