import 'dart:math';

int generateRandomNumber() {
  final random = Random();
  return 1000000 + random.nextInt(9000000); // 1000000 to 9999999
}