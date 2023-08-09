class CurrencyValue {
  final String? name;
  final String? code;
  final String? value;
  final String? codeIn;

  const CurrencyValue(
      {required this.name,
      required this.code,
      required this.codeIn,
      required this.value});

  factory CurrencyValue.fromJson(Map<String, dynamic> json) {
    var data = json.entries.first.value;
    return CurrencyValue(
        name: data?['name'],
        code: data?['code'],
        codeIn: data?['codein'],
        value: data?['high']);
  }
}
