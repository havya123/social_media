import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin {
  RxInt number = 0.obs;

  @override
  void onInit() {
    change(null, status: RxStatus.loading());
    super.onInit();
  }

  loadData() async {
    Future.delayed(const Duration(seconds: 2), () {});
  }

  void addNumber() {
    number++;
  }
}
