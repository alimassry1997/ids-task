// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idstask/cubits/get_stocks_cubit/get_stocks_cubit.dart';
import 'package:idstask/main.dart';
import 'package:signalr_netcore/hub_connection.dart';

mqw(BuildContext context, num width) =>
    MediaQuery.of(context).size.width * (width / 390);
mqh(BuildContext context, num height) =>
    MediaQuery.of(context).size.height * (height / 844);

const String serverURL =
    'https://tradeapi.ids-fintech.com/Hub.StockQuotation/StockQuotationHub';
const String serverToken =
    'eyJhbGciOiJSUzI1NiIsImtpZCI6ImQ0YjZlODUwZWU0NWQ4ZDU3Njc2Y2NkODJmNzM4YmQwIiwidHlwIjoiSldUIn0.eyJuYmYiOjE2OTkwNzk2NzksImV4cCI6MTY5OTEwODQ3OSwiaXNzIjoiaHR0cHM6Ly92ZXN0aW9pZGVudGl0eS5pZHMtZmludGVjaC5jb20iLCJhdWQiOlsiaHR0cHM6Ly92ZXN0aW9pZGVudGl0eS5pZHMtZmludGVjaC5jb20vcmVzb3VyY2VzIiwiaXNhIl0sImNsaWVudF9pZCI6ImFjY3V0cmFkZXBsdXMiLCJzdWIiOiI4MzMwZTQxZi1hMGEwLTRhMGQtYTIyZi00ZTI2YTlhZmM4YjciLCJhdXRoX3RpbWUiOjE2OTkwNzk2NzksImlkcCI6ImxvY2FsIiwidXNlcnR5cGUiOiIxIiwidmVzdGlvdXNlcmlkIjoiODMzMGU0MWYtYTBhMC00YTBkLWEyMmYtNGUyNmE5YWZjOGI3IiwiTUwiOiJGYWxzZSIsInNjb3BlIjpbIm9wZW5pZCIsImlzYSIsIm9mZmxpbmVfYWNjZXNzIl0sImFtciI6WyJwd2QiXX0.VJ39aP_pXT99JuTGvuma639PD2OdAZO3U68irnuV8LtkwV4A0oDGAi9ZRzyo09kn9JOYRoxx_9pVFHxgZyZI3gGLdNQKAZzmpUWuSPv5UWSAIbn3ICVqTI8kMw2bpl-2M5CoR1wdwNorPTl7rVAPpq8tyByVvk6KbzavFdKD7U4qsvyfIcXILwQEDOPULVI989dItzUHtBvPo0Db-1WpTJlX23RK6EzavLMNH0FDOqW1biZuBpDOP21t0DFTkukKcfBq2JL3xcXR0hRBmoNtCHwjU2abX_fSkpaX20wtZTxRslO74NAovL2Rflgq0H8WcoHBNYgR499A6z2ZdlI_bA';
const String stocksList = "101,102,103,104,105,106,107,108,109";

Future<String> getToken() async {
  return serverToken;
}

Future<void> connectToSignalRServer() async {
  int maxRetryCount = 5;
  int currentRetry = 0;

  while (currentRetry < maxRetryCount) {
    try {
      await hubConnection?.start();
      print('SignalR connection started successfully');
      return;
    } catch (e) {
      print('Error occurred while connecting to SignalR: $e');
      currentRetry++;
      if (currentRetry < maxRetryCount) {
        await Future.delayed(const Duration(seconds: 3));
      } else {
        print('Max retry attempts reached. Connection failed.');
        break;
      }
    }
  }
}

void registerForUpdateStockQuotations(
    BuildContext context, HubConnection? hubConnection) {
  hubConnection?.on("UpdateStockQuotations", (arguments) {
    try {
      context
          .read<GetStocksCubit>()
          .getStocks(hubConnection: hubConnection, stocksList: stocksList);
      print("Received UpdateStockQuotations event: $arguments");
    } catch (e) {
      print('ERRRO $e');
    }
  });
}
