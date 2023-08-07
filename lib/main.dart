import 'package:flutter/material.dart';
import 'package:coin_swap/theme/color_schemes.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(colorScheme: darkColorScheme, useMaterial3: true),
      home: const CurrencyConverterPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              child: Column(
                children: [
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController comparedController = TextEditingController();
  final TextEditingController selectedController = TextEditingController();

  String? selectedCoin;
  String? comparedCoin;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var coins = [
      const DropdownMenuEntry(value: 'BRL', label: 'BRL'),
      const DropdownMenuEntry(value: 'USD', label: 'USD')
    ];
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
                  const SizedBox(height: 30),
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
                        child: DropdownMenu<String>(
                          initialSelection: coins[0].value,
                          dropdownMenuEntries: coins,
                          onSelected: (String? coin) {
                            setState(() {
                              selectedCoin = coin;
                            });
                          },
                        ),
                      ),
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
          ),
        ),
      ),
    );
  }
}
