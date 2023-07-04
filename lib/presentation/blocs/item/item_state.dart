part of 'item_bloc.dart';

abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemLoaded extends ItemState {
  final List<Item> items;

  const ItemLoaded({this.items = const <Item>[]});

  @override
  List<Object> get props => [items];
}

class ItemError extends ItemState {
  final String errorMessage;

  const ItemError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class AddItem extends ItemEvent {
  final String name;
  final DateTime createdAt;

  const AddItem({
    required this.name,
    required this.createdAt,
  });

  @override
  List<Object> get props => [name, createdAt];
}

class EditItem extends ItemEvent {
  final dynamic id;
  final String name;
  final DateTime createdAt;

  const EditItem({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  @override
  List<Object> get props => [id, name, createdAt];
}

class DeleteItem extends ItemEvent {
  final int id;
  const DeleteItem({required this.id});

  @override
  List<Object> get props => [id];
}
