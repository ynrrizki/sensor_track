part of 'item_bloc.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class LoadItem extends ItemEvent {}

class UpdateItem extends ItemEvent {
  final List<Item> items;
  const UpdateItem(this.items);

  @override
  List<Object> get props => [items];
}
