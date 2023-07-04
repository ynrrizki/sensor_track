import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sensor_track/data/models/item.dart';
import 'package:sensor_track/data/repositories/item_repository.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepository _itemRepository;
  StreamSubscription? _itemSubscription;

  ItemBloc({required ItemRepository itemRepository})
      : _itemRepository = itemRepository,
        super(ItemLoading()) {
    on<LoadItem>(_onLoadItem);
    on<UpdateItem>(_onUpdateItem);
    on<AddItem>((event, emit) async {
      await _itemRepository.addItem(
        const Item().copyWith(
          name: event.name,
          createdAt: event.createdAt,
        ),
      );
    });
    on<EditItem>((event, emit) async {
      await _itemRepository.updateItem(
        const Item().copyWith(
          id: event.id,
          name: event.name,
          createdAt: event.createdAt,
        ),
      );
    });
    on<DeleteItem>((event, emit) async {
      await _itemRepository.deleteItem(event.id);
    });
  }

  void _onLoadItem(
    LoadItem event,
    Emitter<ItemState> emit,
  ) {
    log('when add LoadItem', name: 'ItemBloc');
    _itemSubscription?.cancel();
    _itemSubscription = _itemRepository.getAllItem().listen(
          (value) => add(
            UpdateItem(value),
          ),
        );
  }

  void _onUpdateItem(
    UpdateItem event,
    Emitter<ItemState> emit,
  ) {
    emit(ItemLoading());
    emit(ItemLoaded(items: event.items));
  }

  @override
  Future<void> close() async {
    _itemSubscription?.cancel();
    super.close();
  }
}
