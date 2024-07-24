// import 'package:device_preview/device_preview.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:eqraa/core/app_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/binding/initinalbinding.dart';
import 'core/localization/changelocal.dart';
import 'core/localization/translation.dart';
import 'core/services/services.dart';
import 'core/utils/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
  // SizeUtils.setScreenSize();
  // Obtain screen dimensions

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      LocaleController controller = Get.put(LocaleController());
      return SafeArea(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: controller.language,
          // builder: DevicePreview.appBuilder,
          title: 'Eqraa',
          translations: MyTranslation(),
          theme: controller.appTheme,
          //routes: routes,
          getPages: routes,
          initialBinding: InitialBindings(),
        ),
      );
    });
  }
}
