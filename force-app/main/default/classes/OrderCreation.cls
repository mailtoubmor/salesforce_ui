// Apex class to create Order and Order Items
public class OrderCreation {

    // Method to create Order and Order Items
    public static void createOrderAndItems(String accountId, Map<String, Integer> productQuantities) {
        // Create Order
        Order newOrder = new Order();
        newOrder.AccountId = accountId;
        newOrder.EffectiveDate = Date.today();
        newOrder.Status = 'Draft'; // Set status as per your requirement
        insert newOrder;
        
        // Create Order Items
        List<OrderItem> orderItems = new List<OrderItem>();
        for(String productName : productQuantities.keySet()) {
            Integer quantity = productQuantities.get(productName);
            
            OrderItem orderItem = new OrderItem();
            orderItem.OrderId = newOrder.Id;
            orderItem.Quantity = quantity;
            // Assuming Product2 is the standard Product object in Salesforce
            Product2 product = [SELECT Id FROM Product2 WHERE Name = :productName LIMIT 1];
            orderItem.PricebookEntryId = [SELECT Id FROM PricebookEntry WHERE Product2Id = :product.Id LIMIT 1].Id;
            orderItem.UnitPrice = [SELECT UnitPrice FROM PricebookEntry WHERE Product2Id = :product.Id LIMIT 1].UnitPrice;
            orderItems.add(orderItem);
        }
        insert orderItems;
    }
}