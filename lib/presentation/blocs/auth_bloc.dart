import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../core/usecase/usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/auth_usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Register register;
  final Login login;
  final Logout logout;
  final GetCurrentUser getCurrentUser;

  AuthBloc({
    required this.register,
    required this.login,
    required this.logout,
    required this.getCurrentUser,
  }) : super(AuthInitial()) {
    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await register(RegisterParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ));
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (user) => emit(Authenticated(user)),
      );
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await login(LoginParams(
        email: event.email,
        password: event.password,
      ));
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (user) => emit(Authenticated(user)),
      );
    });

    on<LogoutEvent>((event, emit) async {
      await logout(NoParams());
      emit(Unauthenticated());
    });

    on<CheckAuthEvent>((event, emit) async {
      final result = await getCurrentUser(NoParams());
      result.fold(
        (failure) => emit(Unauthenticated()),
        (user) {
          if (user != null) {
            emit(Authenticated(user));
          } else {
            emit(Unauthenticated());
          }
        },
      );
    });
  }
}
