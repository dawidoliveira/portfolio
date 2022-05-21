abstract class Failure implements Exception {
  final String? message;

  Failure([this.message]);
}

class ServerFailure extends Failure {
  ServerFailure([super.message]);
}
