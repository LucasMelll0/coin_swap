import 'dart:developer';

import 'package:coin_swap/api/constants.dart';
import 'package:coin_swap/model/currency.dart';
import 'package:coin_swap/ui/values/dimens.dart';
import 'package:flutter/material.dart';

import '../api/service.dart';
import '../utils/string_utils.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController amountController = TextEditingController();

  List<DropdownMenuEntry<String>>? coins;
  Future<Map<String, String>> futureCodes = ApiService().getCoins();

  String? codeToConvert;
  Future<CurrencyValue>? response;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var hasResponse = response != null;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Conversor de moedas',
                      style: theme.textTheme.displaySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: largeSpacing),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Digite qual valor você quer converter'),
                    ),
                    const SizedBox(height: largeSpacing),
                    FutureBuilder<Map<String, String>>(
                        future: futureCodes,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var items = snapshot.data!.entries
                                .map((e) => DropdownMenuItem(
                                    key: Key(e.value),
                                    value: e.key,
                                    child: Text(e.value)))
                                .toList();
                            items.sort((a, b) =>
                                a.key.toString().compareTo(b.key.toString()));
                            codeToConvert ?? {codeToConvert = items[0].value};
                            return SingleChildScrollView(
                              child: DropdownButton<String>(
                                  hint: Text(
                                    codeToConvert ??
                                        'Selecione qual conversão você deseja fazer',
                                    textAlign: TextAlign.center,
                                  ),
                                  items: items,
                                  onChanged: (String? coin) {
                                    setState(() {
                                      codeToConvert = coin;
                                    });
                                  }),
                            );
                          } else if (snapshot.hasError) {
                            throw Exception('Error on get coins');
                          }
                          return const CircularProgressIndicator();
                        }),
                    const SizedBox(height: largeSpacing),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                            fit: FlexFit.tight,
                            child: FilledButton(
                                onPressed: () {
                                  if (codeToConvert != null) {
                                    log("${ApiConstants.baseUrl}/last/$codeToConvert");
                                    setState(() {
                                      response = ApiService()
                                          .getCurrency(codeToConvert!);
                                    });
                                  } else {
                                    log("Erro");
                                  }
                                },
                                child: Text(
                                  'Converter',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                      color: theme.colorScheme.onPrimary),
                                ))),
                      ],
                    ),
                    const SizedBox(height: largeSpacing,),
                    Visibility(
                        visible: hasResponse,
                        maintainAnimation: true,
                        maintainState: true,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.bounceInOut,
                          opacity: hasResponse ? 1 : 0,
                          child: FutureBuilder<CurrencyValue>(
                            future: response,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                log(snapshot.data?.value.toString() ?? "Error");
                                var amount =
                                    isNumeric(amountController.value.text)
                                        ? double.parse(amountController.text)
                                        : 1.0;

                                return CurrencyValueCard(
                                    amount: amount,
                                    currencyValue: snapshot.data!);
                              } else if (snapshot.hasError) {
                                return const Text("Failed");
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CurrencyValueCard extends StatelessWidget {
  const CurrencyValueCard({
    super.key,
    required this.amount,
    required this.currencyValue,
  });

  final double amount;
  final CurrencyValue currencyValue;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surfaceVariant,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              currencyValue.name ?? '',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: largeSpacing),
            Text(
              "$amount ${currencyValue.code} vale ${(double.parse(currencyValue.value!) * amount).toStringAsFixed(2)} ${currencyValue.codeIn}",
              style: theme.textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
