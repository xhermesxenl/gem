import '../entities/item.dart';

abstract class ItemRepository {
  Future<List<Item>> getItems();
  Future<void> addItem(String title, String? description); 
  Future<void> updateItem(String id, String title, String? description);
  Future<void> deleteItem(String id);
}
