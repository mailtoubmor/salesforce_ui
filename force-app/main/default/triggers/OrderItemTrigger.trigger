/***
**Developed by : Umesh Mor.
**Description : OrderItem Trigger 
** Invoked during record event
***/
trigger OrderItemTrigger on OrderItem(before insert, before update) {
  list<OrderItem> listOrderItem = new List<OrderItem>();
  if (Trigger.isBefore && (Trigger.IsInsert || Trigger.isUpdate)) {
    for (OrderItem orderItm : Trigger.New) {
      if (orderItm.Product2Id != null) {
        listOrderItem.add(orderItm);
      }
      if (
        Trigger.isUpdate &&
        orderItm.Product2Id != Trigger.oldMap.get(orderItm.Id).Product2Id
      ) {
        listOrderItem.add(Trigger.oldMap.get(orderItm.Id));
      }
    }
    //handler method invocation
    OrderItemTriggerHandler.processOrderItems(listOrderItem);
  }
}
