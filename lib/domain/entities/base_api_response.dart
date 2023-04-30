import 'package:equatable/equatable.dart';

class BaseApiResponse<T>  extends Equatable{
  final String? status;
  final T? message;
  final String? errorMessage;

  const BaseApiResponse({required this.status,  this.message,this.errorMessage});

  @override
  List<Object?> get props => [status, message,errorMessage];
}
