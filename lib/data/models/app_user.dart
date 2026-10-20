import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  const AppUser({required this.email, required this.displayName});

  final String email;
  final String displayName;

  @override
  List<Object?> get props => [email, displayName];
}
