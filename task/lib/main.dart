import 'package:flutter/material.dart';

import 'core/app_export.dart';
import 'core/utils/logger.dart';
import 'domain/cubit/language_cubit.dart';
import 'l10n/app_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefUtils.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) {
    runApp(const MyApp());
  });

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    Logger.init(LogMode.debug);
    /*
    await NotificationService.initialize();
    await FirebaseMessagingService.initialize();
    await FirebaseMessagingService.handleInitialMessage();
    await FirebaseMessagingService.onBackgroundMessage();
    await FirebaseMessagingService.generateToken();
    */
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // DeepLinkService.handleIncomingLinks();
  }

  @override
  void dispose() {
    super.dispose();
    // DeepLinkService.linkSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (BuildContext context) => LanguageCubit()),
            // BlocProvider(
            //   create: (BuildContext context) =>
            //       ConnectivityCubit(Connectivity()),
            // ),
          ],
          child: BlocBuilder<LanguageCubit, Locale>(
            builder: (BuildContext context, Locale locale) {
              return MaterialApp.router(
                themeMode: ThemeMode.dark,
                routerConfig: AppRoutes.router,

                debugShowCheckedModeBanner: false,
                locale: locale,
                supportedLocales: const [
                  Locale('en'), // English
                  Locale('es'), // Spanish
                  Locale('fr'), // French
                ],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                title: 'Task',
                theme: theme,
              );
            },
          ),
        );
      },
    );
  }
}
