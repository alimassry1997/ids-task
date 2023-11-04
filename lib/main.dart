import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idstask/cubits/get_stocks_cubit/get_stocks_cubit.dart';
import 'package:idstask/routes/app_router.dart';
import 'package:idstask/routes/routes.dart';
import 'package:idstask/utils/constants.dart';
import 'package:logging/logging.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

HubConnection? hubConnection;
final hubProtLogger = Logger("SignalR - hub");
final transportProtLogger = Logger("SignalR - transport");

void main() async {
  hubConnection = HubConnectionBuilder()
      .withUrl(serverURL,
          options: HttpConnectionOptions(
              accessTokenFactory: () => getToken(),
              logger: transportProtLogger))
      .configureLogging(hubProtLogger)
      .build();
  await connectToSignalRServer();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => GetStocksCubit()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    registerForUpdateStockQuotations(context, hubConnection);
    return const MaterialApp(
      title: 'IDS FINTECH',
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: Routes.loginScreen,
      debugShowCheckedModeBanner: false,
    );
  }
}
