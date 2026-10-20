part of 'saved_bloc.dart';

sealed class SavedEvent extends Equatable {
  const SavedEvent();

  @override
  List<Object?> get props => [];
}

final class SavedToggled extends SavedEvent {
  const SavedToggled(this.productId);

  final String productId;

  @override
  List<Object?> get props => [productId];
}

final class SavedCleared extends SavedEvent {
  const SavedCleared();
}
