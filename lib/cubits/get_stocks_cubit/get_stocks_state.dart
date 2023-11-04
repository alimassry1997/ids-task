part of 'get_stocks_cubit.dart';

sealed class GetStocksState {}

final class GetStocksInitial extends GetStocksState {}

class GetStocksLoading extends GetStocksState {}

class GetStocksFail extends GetStocksState {
  GetStocksFail(this.error);
  final String error;
}

class GetStocksSuccess extends GetStocksState {
  final List<Stock> stockList;
  GetStocksSuccess({required this.stockList});
}
