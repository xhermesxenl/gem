part of 'item_bloc.dart';

abstract class ItemEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadItemsEvent extends ItemEvent {}

class AddItemEvent extends ItemEvent {
  final String title;
  final String? description;
  AddItemEvent(this.title, this.description);

  @override
  List<Object?> get props => [title, description];
}

class UpdateItemEvent extends ItemEvent {
  final String id;
  final String title;
  final String? description;

  UpdateItemEvent(this.id, this.title, this.description);

  @override
  List<Object?> get props => [id, title, description];
}

class DeleteItemEvent extends ItemEvent {
  final String id;
  DeleteItemEvent(this.id);

  @override
  List<Object?> get props => [id];
}
