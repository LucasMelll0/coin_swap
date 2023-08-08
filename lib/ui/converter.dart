import 'dart:developer';

import 'package:coin_swap/ui/values/dimens.dart';
import 'package:flutter/material.dart';

import '../api/service.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController comparedController = TextEditingController();
  final TextEditingController selectedController = TextEditingController();

  List<DropdownMenuEntry<String>>? coins;

  String? fromCoin;
  String? toCoin;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Future<Map<String, String>> futureCoins = ApiService().getCoins();
    log('future: $futureCoins');
    const DropdownMenuEntry(value: 'BRL', label: 'BRL');

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text('Conversor de moedas',
                  style: theme.textTheme.displaySmall),
              const SizedBox(height: largeSpacing),
              Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const Flexible(
                  fit: FlexFit.tight,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText:
                        'Digite qual valor você quer converter'),
                  )),
              const SizedBox(width: 30),
              Flexible(
                child: FutureBuilder<Map<String, String>>(
                    future: futureCoins, builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var items = snapshot.data!.entries.map((e) =>
                        DropdownMenuEntry(value: e.value, label: e.key))
                        .toList();
                    return DropdownMenu<String>(
                      dropdownMenuEntries: items,
                      initialSelection: items[0].value,
                      onSelected: (String? coin) {
                        setState(() {
                          fromCoin = coin;
                        });
                      });
                  } else if(snapshot.hasError){
                    throw Exception('Error on get coins');
                  }
                  return const CircularProgressIndicator();
                })
            ),
            const SizedBox(width: largeSpacing),
            Flexible(
                child: FutureBuilder<Map<String, String>>(
                    future: futureCoins, builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var items = snapshot.data!.entries.map((e) =>
                        DropdownMenuEntry(value: e.value, label: e.key))
                        .toList();
                    return DropdownMenu<String>(
                        dropdownMenuEntries: items,
                        initialSelection: items[1].value,
                        onSelected: (String? coin) {
                          setState(() {
                            toCoin = coin;
                          });
                        });
                  } else if(snapshot.hasError){
                    throw Exception('Error on get coins');
                  }
                  return const CircularProgressIndicator();
                }))
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                  child: FilledButton(
                      onPressed: () {},
                      child: Text(
                        'Converter',
                        style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.colorScheme.onPrimary),
                      ))),
            ],
          )
          ],
        ),
      ),
    ),)
    ,
    )
    ,
    );
  }
}
