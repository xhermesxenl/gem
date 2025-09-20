import '../../domain/entities/item.dart';
import '../../domain/repositories/item_repository.dart';
import '../datasources/item_remote_data_source.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemRemoteDataSource remoteDataSource;

  ItemRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Item>> getItems() async {
    return await remoteDataSource.getItems();
  }

  @override
  Future<void> addItem(String title, String? description) async {
    await remoteDataSource.addItem(title, description);
  }

  @override
  Future<void> updateItem(String id, String title, String? description) async {
  await remoteDataSource.updateItem(id, title, description);
  }

  @override
  Future<void> deleteItem(String id) async {
  await remoteDataSource.deleteItem(id);
  }
}
