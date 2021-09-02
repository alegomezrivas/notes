import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure() : super();
}

// General failures
class CacheFailure extends Failure {
  @override
  List<Object> get props => [];
}
