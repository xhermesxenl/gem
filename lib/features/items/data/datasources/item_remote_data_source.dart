import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/item_model.dart';
import '../../../../core/utils/logger.dart';


abstract class ItemRemoteDataSource {
  Future<List<ItemModel>> getItems();
  Future<void> addItem(String title, String? description);
  Future<void> updateItem(String id, String title, String? description);
  Future<void> deleteItem(String id);
}

class ItemRemoteDataSourceImpl implements ItemRemoteDataSource {
  final SupabaseClient client;
  ItemRemoteDataSourceImpl(this.client);

  @override
  Future<List<ItemModel>> getItems() async {
    final response = await client
        .from('items')
        .select()
        .order('title', ascending: true);

    return (response as List)
        .map((json) => ItemModel.fromJson(json))
        .toList();
  }

  @override
  Future<void> addItem(String title, String? description) async {
    final userId = client.auth.currentUser!.id;
    await client.from('items').insert({
      'title': title,
      'description': description,
      'user_id': userId,
    });
  }

  @override
  Future<void> updateItem(String id, String title, String? description) async {
     AppLogger.d("UpdateItem called", {"id": id, "title": title});
     final response =  await client.from('items').update({
      'title': title,
      'description': description,
    }).eq('id', id).select();

     AppLogger.i("Update response", response);
  }

  @override
  Future<void> deleteItem(String id) async {
    AppLogger.d("DeleteItem called", {"id": id});
     final response =  await client.from('items').delete().eq('id', id);
    AppLogger.w("Delete response", response);
  }

}
