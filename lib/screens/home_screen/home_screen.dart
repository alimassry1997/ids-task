// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idstask/cubits/get_stocks_cubit/get_stocks_cubit.dart';
import 'package:idstask/main.dart';
import 'package:idstask/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    if (context.read<GetStocksCubit>().stockListCubit == null) {
      context
          .read<GetStocksCubit>()
          .getStocks(hubConnection: hubConnection!, stocksList: stocksList);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: BlocBuilder<GetStocksCubit, GetStocksState>(
          builder: (context, state) {
            if (state is GetStocksSuccess) {
              var stocks = context.read<GetStocksCubit>().stockListCubit ??
                  state.stockList;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Symbol')),
                      DataColumn(label: Text('Last')),
                      DataColumn(label: Text('Open')),
                      DataColumn(label: Text('Low')),
                      DataColumn(label: Text('High')),
                      DataColumn(label: Text('Volume')),
                      DataColumn(label: Text('Change Percent')),
                    ],
                    rows: stocks.map((stock) {
                      final lastValue = stock.last?.toStringAsFixed(1);
                      final openValue = stock.open?.toStringAsFixed(1);
                      final lowValue = stock.low?.toStringAsFixed(1);
                      final highValue = stock.high?.toStringAsFixed(1);
                      final volumeValue = stock.volume.toString();
                      final changePercentValue =
                          stock.changePercent?.toStringAsFixed(3);

                      final highlight = stock.last != stock.last ? true : false;
                      return DataRow(cells: [
                        DataCell(Text(stock.symbolEn ?? '')),
                        DataCell(
                          AnimatedDefaultTextStyle(
                            style: TextStyle(
                              color: highlight ? Colors.red : Colors.black,
                            ),
                            duration: const Duration(seconds: 1),
                            child: Text(lastValue ?? ''),
                          ),
                        ),
                        DataCell(Text(openValue ?? '')),
                        DataCell(Text(lowValue ?? '')),
                        DataCell(Text(highValue ?? '')),
                        DataCell(Text(volumeValue)),
                        DataCell(Text(changePercentValue ?? '')),
                      ]);
                    }).toList()),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
