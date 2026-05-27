// Falhas do domínio — independente de qual tecnologia causou
abstract class Failure {
  final String message;
  const Failure(this.message);
  @override
  String toString() => message;
}

class NetworkFailure  extends Failure { const NetworkFailure(super.message); }
class CacheFailure    extends Failure { const CacheFailure(super.message); }
class PermissionFailure extends Failure { const PermissionFailure(super.message); }

