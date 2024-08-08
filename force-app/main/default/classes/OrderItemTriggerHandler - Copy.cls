/**
 * An apex class that updates inventroy details
   Its Invokved by OrderItem 
 */
public class OrderItemTriggerHandler {
  public static void processOrderItems(list<orderItem> listOrderItems) {
    Map<Id, Product_Inventory__c> mapProductIdProd = new Map<Id, Product_Inventory__c>();
    set<Id> productIdSet = new Set<Id>();
    if (listOrderItems.size() > 0) {
      for (OrderItem orderItm : listOrderItems) {
        if (orderItm.Product2Id != null) {
          productIdSet.add(orderItm.Product2Id);
        }
      }
    }

    list<Product_Inventory__c> listOfInventoryData = [
      SELECT Id, Product__c, Available_Quantity__c
      FROM Product_Inventory__c
      WHERE Product__c IN :productIdSet
      FOR UPDATE
    ];
    if (listOfInventoryData.size() > 0) {
      for (Product_Inventory__c proIn : listOfInventoryData) {
        mapProductIdProd.put(proIn.Product__c, proIn);
      }
    }

    list<Product_Inventory__c> listProdIn = new List<Product_Inventory__c>();
    for (OrderItem ordrItem : listOrderItems) {
      if (
        !mapProductIdProd.isEmpty() &&
        mapProductIdProd.containsKey(ordrItem.Product2Id) &&
        mapProductIdProd.get(ordrItem.Product2Id).Available_Quantity__c >=
        ordrItem.Quantity
      ) {
        Product_Inventory__c prod = mapProductIdProd.get(ordrItem.Product2Id);
        prod.Available_Quantity__c -= ordrItem.Quantity;
        listProdIn.add(prod);
      } else {
        ordrItem.addError('Stock Unavailable , try when available');
      }
    }

    if (listProdIn.size() > 0) {
      update listProdIn;
    }
  }
}
