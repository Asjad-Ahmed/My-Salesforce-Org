trigger OnlyOneActiveContact on Contact (after Insert, after Update)
{
    ContactTriggerHandler.OnlyOneActiveContact(Trigger.new, Trigger.oldmap,
                                               Trigger.IsInsert, Trigger.IsUpdate);
}