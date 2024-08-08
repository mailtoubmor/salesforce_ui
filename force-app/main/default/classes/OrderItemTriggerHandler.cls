/***
**Developed by : Umesh Mor.
**Description : Order Item Trigger handler
**Caller : OrderItem Trigger
***/
public class OrderItemTriggerHandler {
/***
  **Description : Thi methods update product inventory record
  **input : list of order item
  **@return :
  ***/
  public static void processOrderItems(list<orderItem> listOrderItems){
      System.debug('Entering the OrderItemTriggerHandler.processOrderItems method');
      Map<Id,Product_Inventory__c> mapProductIdProd = new Map<Id,Product_Inventory__c>();
      set<Id> productIdSet = new set<Id>();
      if(listOrderItems.size() > 0){
          for(OrderItem orderItm : listOrderItems){
              if(orderItm.Product2Id != null){
                  productIdSet.add(orderItm.Product2Id);
              }
          }
      }
      
      try{
        list<Product_Inventory__c> listOfInventoryData = [SELECT Id , Product__c, Available_Quantity__c  FROM  Product_Inventory__c WHERE Product__c IN : productIdSet for Update];
        if(listOfInventoryData.size() > 0){
            for(Product_Inventory__c proIn : listOfInventoryData){
                mapProductIdProd.put(proIn.Product__c,proIn);
            }
        }
    
        list<Product_Inventory__c> listProdIn = new list<Product_Inventory__c>();
        for(OrderItem ordrItem : listOrderItems){
            if(!mapProductIdProd.isEmpty()&& mapProductIdProd.containsKey(ordrItem.Product2Id) && mapProductIdProd.get(ordrItem.Product2Id).Available_Quantity__c >=  ordrItem.Quantity){
                Product_Inventory__c prod = mapProductIdProd.get(ordrItem.Product2Id);
                prod.Available_Quantity__c -= ordrItem.Quantity;
                listProdIn.add(prod);			
            }
            else{
                ordrItem.addError('Stock Unavailable , try when available');
            }
        }
        
        if(listProdIn.size() > 0){
            update listProdIn;
        } 
    }  
    catch(exception ex){
      System.debug('Error processing exception'+ex.getMessage());
    } 
  }
}