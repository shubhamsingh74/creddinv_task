import 'package:bloc_test/bloc_test.dart';

import 'package:creddinv_task/features/products/bloc/saved_bloc.dart';

void main() {
  blocTest<SavedBloc, SavedState>(
    'toggles a piece on and off',
    build: SavedBloc.new,
    act: (bloc) => bloc
      ..add(const SavedToggled('kraft-tote'))
      ..add(const SavedToggled('kraft-tote')),
    expect: () => [
      const SavedState({'kraft-tote'}),
      const SavedState(),
    ],
  );

  blocTest<SavedBloc, SavedState>(
    'clear drops every saved piece',
    build: SavedBloc.new,
    seed: () => const SavedState({'heart-denim-shirt'}),
    act: (bloc) => bloc.add(const SavedCleared()),
    expect: () => [const SavedState()],
  );
}
