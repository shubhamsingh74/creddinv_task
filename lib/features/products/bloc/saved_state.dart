part of 'saved_bloc.dart';

final class SavedState extends Equatable {
  const SavedState([this.ids = const <String>{}]);

  final Set<String> ids;

  bool contains(String productId) => ids.contains(productId);

  @override
  List<Object?> get props => [ids];
}
