
bool isNumeric(String s) {
  if(s.isEmpty) {
    return false;
  }
  return double.tryParse(s) != null;
}