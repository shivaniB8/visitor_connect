import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:host_visitor_connect/common/res/colors.dart';
import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:host_visitor_connect/common/shared_prefs.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/branches_bloc.dart';
import 'package:host_visitor_connect/features/dashboard/bloc/user_details_bloc.dart';
import 'package:host_visitor_connect/features/login/blocs/post_data_bloc.dart';
import 'package:host_visitor_connect/features/login/ui/model/login_model.dart';
import 'package:host_visitor_connect/features/visitors/visitor_listing/blocs/virtual_numbers_bloc.dart';
import 'package:host_visitor_connect/generated/l10n.dart';
import 'package:host_visitor_connect/splash.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'common/constant/globalVariable.dart';

Future mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  SharedPrefs.getOnBoarding();
  final loginModel = LoginModel();
  final userDetailsBloc = UserDetailsBloc();
  final branchesBloc = BranchesBloc();
  final virtualMobileNumberBloc = VirtualNumbersBloc();
  final postDataBloc = PostDataBloc();

  await Future.wait([
    if (SharedPrefs.getInt(keyUserId) != null) userDetailsBloc.userDetails(),
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => loginModel,
        ),
        BlocProvider(
          create: (_) => userDetailsBloc,
        ),
        BlocProvider(
          create: (_) => branchesBloc,
        ),
        BlocProvider(
          create: (_) => virtualMobileNumberBloc,
        ),
        BlocProvider(
          create: (_) => postDataBloc,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height / 1.5,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Visitors Connect',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primaryColor: primary_color,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.grey,
            accentColor: Colors.grey,
          ),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: GlobalVariable.fontFamily,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.grey,
          ),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              //CupertinoPageTransitionsBuilder
              //ZoomPageTransitionsBuilder
              //FadeUpwardsPageTransitionsBuilder
              //OpenUpwardsPageTransitionsBuilder
              //FadeUpwardsPageTransitionsBuilder
              TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            },
          ),
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: const SplashScreen(),
        ),
      ),
    );
  }
}
