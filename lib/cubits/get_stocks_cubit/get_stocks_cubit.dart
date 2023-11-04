import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idstask/models/stock_model.dart';
import 'package:idstask/repository/get_stock_quotations.dart';
import 'package:signalr_netcore/hub_connection.dart';
part 'get_stocks_state.dart';

class GetStocksCubit extends Cubit<GetStocksState> {
  GetStocksCubit() : super(GetStocksInitial());

  List<Stock>? stockListCubit;

  Future getStocks(
      {required HubConnection hubConnection,
      required String stocksList}) async {
    try {
      final response = await Repository.getAllQuotes(
          hubConnection: hubConnection, stocks: stocksList);

      List<Stock> stocks =
          (response as List).map((e) => Stock.fromJson(e)).toList();

      stockListCubit = stocks;
      emit(GetStocksSuccess(stockList: stocks));
    } catch (e) {
      emit(GetStocksFail(e.toString()));
    }
  }
}
