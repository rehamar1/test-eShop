part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {
  final int skip;
  final int limit;

  FetchProducts({required this.skip, required this.limit});

  @override
  List<Object> get props => [skip, limit];
}