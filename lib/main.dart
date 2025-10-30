import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reckit/core/constants/colors.dart';
import 'package:reckit/core/utils/locator.dart';
import 'package:reckit/features/home_screen/presentation/screens/trips_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Trips App',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: AppColors.blackBackground,
            textTheme: ThemeData.dark().textTheme.apply(
              fontFamily: 'Inter',
            ),
            colorScheme: ColorScheme.dark(
              primary:AppColors.primaryColor,
            ),
          ),
          home: const TripsScreen(),
          builder: (context, child) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 300,
                  maxWidth: 1440,
                ),
                child: child!,
              ),
            );
          },
        );
      },
    );
  }
}
