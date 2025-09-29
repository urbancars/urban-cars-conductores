import 'package:equatable/equatable.dart';
import '../../data/models/pago.dart';

abstract class PagosState extends Equatable {
  const PagosState();

  @override
  List<Object?> get props => [];
}

class PagosInitial extends PagosState {}

class PagosLoading extends PagosState {}

class PagosLoaded extends PagosState {
  final List<Pago> pagos;

  const PagosLoaded(this.pagos);

  @override
  List<Object?> get props => [pagos];
}

class PagosError extends PagosState {
  final String message;

  const PagosError(this.message);

  @override
  List<Object?> get props => [message];
}