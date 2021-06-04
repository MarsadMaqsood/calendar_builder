import '../models/cb_config.dart';

import 'package:get/get.dart';

///Main controller for all the datas
class CbController extends GetxController {
  ///data configuration  for [cbcontroller]
  CbConfig? cbConfig;

  ///add config
  void changeConfig(CbConfig config) {
    cbConfig = config;
  }
}
