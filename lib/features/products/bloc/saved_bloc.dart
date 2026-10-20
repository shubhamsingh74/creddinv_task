import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'saved_event.dart';
part 'saved_state.dart';

/// Pieces the shopper marked to revisit. Memory only, same lifetime as the cart.
class SavedBloc extends Bloc<SavedEvent, SavedState> {
  SavedBloc() : super(const SavedState()) {
    on<SavedToggled>(_onToggled);
    on<SavedCleared>(_onCleared);
  }

  void _onToggled(SavedToggled event, Emitter<SavedState> emit) {
    final ids = {...state.ids};
    if (!ids.add(event.productId)) {
      ids.remove(event.productId);
    }
    emit(SavedState(Set.unmodifiable(ids)));
  }

  void _onCleared(SavedCleared event, Emitter<SavedState> emit) {
    if (state.ids.isEmpty) return;
    emit(const SavedState());
  }
}
