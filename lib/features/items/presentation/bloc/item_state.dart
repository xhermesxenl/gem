part of 'item_bloc.dart';

abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object?> get props => [];
}

class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemLoaded extends ItemState {
  final List<Item> items;
  const ItemLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class ItemError extends ItemState {
  final String message;
  const ItemError(this.message);

  @override
  List<Object?> get props => [message];
}

class ItemActionInProgress extends ItemState {
  @override
  List<Object?> get props => [];
}

class ItemActionSuccess extends ItemState {
  final String message;
  const ItemActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
