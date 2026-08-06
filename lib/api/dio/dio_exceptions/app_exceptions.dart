class AppException implements Exception{
  String errorMessage;
  int? statusCode;
  AppException({required this.errorMessage,this.statusCode});
}

class ServerErrorException extends AppException{
  ServerErrorException({required super.errorMessage,super.statusCode});
}
class NetworkErrorException extends AppException{
  NetworkErrorException({required super.errorMessage,super.statusCode});

}
class UnExpectedErrorException extends AppException{
  UnExpectedErrorException({required super.errorMessage,super.statusCode});

}