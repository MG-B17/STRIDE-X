import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class UnauthenticatedFailure extends Failure {
  const UnauthenticatedFailure(super.message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}

class PermissionDeniedFailure extends Failure {
  const PermissionDeniedFailure(super.message);
}

class CalibrationStreamFailure extends Failure {
  const CalibrationStreamFailure(super.message);
}
