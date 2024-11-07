import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'constants/app_pages.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'services/initial.dart';

void main() async {
  //var result = await BarcodeScanner.scan();
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'fr_FR';
  initializeDateFormatting('fr_FR', '');
  // Initialiser GetStorage
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: StoreBinding(),
      debugShowCheckedModeBanner: false,
      title: 'MyApp',
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
    );
  }
}
