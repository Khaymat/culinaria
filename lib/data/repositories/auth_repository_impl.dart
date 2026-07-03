import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, User>> register(String name, String email, String password) async {
    try {
      final user = await localDataSource.register(name, email, password);
      return Right(user);
    } on CacheException {
      return const Left(CacheFailure('Email sudah terdaftar'));
    }
  }

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final user = await localDataSource.login(email, password);
      return Right(user);
    } on CacheException {
      return const Left(CacheFailure('Email atau password salah'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.logout();
      return const Right(null);
    } on CacheException {
      return const Left(CacheFailure('Gagal logout'));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final user = await localDataSource.getCurrentUser();
      return Right(user);
    } on CacheException {
      return const Left(CacheFailure('Gagal memuat data user'));
    }
  }
}
