import '../repositories/item_repository.dart';

class AddItem {
  final ItemRepository repository;
  AddItem(this.repository);

  Future<void> call(String title, String? description) async {
    await repository.addItem(title, description);
  }
}
