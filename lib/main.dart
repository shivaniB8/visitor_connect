import 'package:host_visitor_connect/build_config.dart';
import 'package:host_visitor_connect/main_common.dart';

Future main() async {
  BuildConfig(
    buildVariant: BuildVariant.dev,

    ///TODO change url when domain is ready
    // apiBaseUrl: '0682-182-78-245-22.ngrok-free.app',
    apiBaseUrl: 'yellow-onions-marry.loca.lt',
  );

  await mainCommon();
}
