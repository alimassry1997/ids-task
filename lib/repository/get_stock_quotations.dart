import 'package:signalr_netcore/hub_connection.dart';

class Repository {
  static Future<dynamic> getAllQuotes(
      {required HubConnection? hubConnection, required String stocks}) async {
    final response =
        await hubConnection?.invoke("GetMiniStockQuotations", args: [stocks]);

    return response;
  }
}
