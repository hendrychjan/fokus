import 'package:get/get.dart';

class AppController extends GetxController {
  var count = 0;
  void increment() {
    count++;
    update();
  }
}
