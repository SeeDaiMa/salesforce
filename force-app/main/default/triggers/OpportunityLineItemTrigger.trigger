trigger OpportunityLineItemTrigger on OpportunityLineItem (before delete, before insert, before update, 
                                                            after delete, after insert, after update) {
    new OpportunityLineItemTriggerHandler().run();
}