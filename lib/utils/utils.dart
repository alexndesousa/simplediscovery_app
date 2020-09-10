import 'dart:math';

String generateRandomString(int length) {
  var text = "";
  const possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

  while(text.length <= length) {
    text += possible[(Random().nextInt(possible.length))];
  }

  print("random string");

  return text;
}