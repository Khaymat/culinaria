import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Register implements UseCase<User, RegisterParams> {
  final AuthRepository repository;
  Register(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) async {
    return await repository.register(params.name, params.email, params.password);
  }
}

class RegisterParams {
  final String name;
  final String email;
  final String password;
  const RegisterParams({required this.name, required this.email, required this.password});
}

class Login implements UseCase<User, LoginParams> {
  final AuthRepository repository;
  Login(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;
  const LoginParams({required this.email, required this.password});
}

class Logout implements UseCase<void, NoParams> {
  final AuthRepository repository;
  Logout(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.logout();
  }
}

class GetCurrentUser implements UseCase<User?, NoParams> {
  final AuthRepository repository;
  GetCurrentUser(this.repository);

  @override
  Future<Either<Failure, User?>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
