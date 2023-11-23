import 'package:currencyfx/model/currencymodel.dart';
import 'package:get/get.dart';

class Data extends GetxController {
  DateTime startDate = DateTime.now().subtract(Duration(days: 1000));
  DateTime endDate = DateTime.now().subtract(Duration(days: 900));

  List<dynamic> allcurrencies = [];
  List<CurrencyRate> allData = [];
  RxDouble maxVal = 0.0.obs;
  RxDouble minVal = 0.0.obs;
  DateTime? maxDate;
  DateTime? minDate;
}
