import '../repositories/item_repository.dart';

class UpdateItem {
  final ItemRepository repository;
  UpdateItem(this.repository);

  Future<void> call(String id, String title, String? description) async {
    await repository.updateItem(id, title, description);
  }
}
