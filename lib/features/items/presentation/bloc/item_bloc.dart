import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/item.dart';
import '../../domain/usecases/get_items.dart';
import '../../domain/usecases/add_item.dart';
import '../../domain/usecases/update_item.dart';
import '../../domain/usecases/delete_item.dart';
import '../../../../core/utils/logger.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final GetItems getItems;
  final AddItem addItem;
  final UpdateItem updateItem;
  final DeleteItem deleteItem;

  ItemBloc(this.getItems, this.addItem, this.updateItem, this.deleteItem)
      : super(ItemInitial()) {
    on<LoadItemsEvent>((event, emit) async {
      emit(ItemLoading());
      try {
        final items = await getItems();
        emit(ItemLoaded(items));
      } catch (e, st) {
        AppLogger.e("Erreur load items", e, st);
        emit(ItemError("Impossible de charger les items"));
      }
    });

    on<AddItemEvent>((event, emit) async {
      emit(ItemActionInProgress()); // loader activé
      try {
        await addItem(event.title, event.description);
        emit(ItemActionSuccess("Item ajouté ✅"));
        final items = await getItems();
        emit(ItemLoaded(items));
      } catch (e, st) {
        AppLogger.e("Erreur add item", e, st);
        emit(ItemError("Impossible d’ajouter l’item"));
      }
    });

    on<UpdateItemEvent>((event, emit) async {
      emit(ItemActionInProgress()); // loader activé
      try {
        await updateItem(event.id, event.title, event.description);
        emit(ItemActionSuccess("Item modifié ✅"));
        final items = await getItems();
        emit(ItemLoaded(items));
      } catch (e, st) {
        AppLogger.e("Erreur update item", e, st);
        emit(ItemError("Impossible de modifier l’item"));
      }
    });

    on<DeleteItemEvent>((event, emit) async {
      emit(ItemActionInProgress()); // loader activé
      try {
        await deleteItem(event.id);
        emit(ItemActionSuccess("Item supprimé ✅"));
        final items = await getItems();
        emit(ItemLoaded(items));
      } catch (e, st) {
        AppLogger.e("Erreur delete item", e, st);
        emit(ItemError("Impossible de supprimer l’item"));
      }
    });
  }
}
