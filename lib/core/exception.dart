
import 'package:store/core/network/error_model.dart';

class ServerException implements Exception
{
  final ErrorModel errorModel;

 const ServerException(this.errorModel);
}

class LocalDatabaseException implements Exception
{
  final ErrorModel errorModel;

  const LocalDatabaseException(this.errorModel);
}