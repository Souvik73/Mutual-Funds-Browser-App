import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'controllers/scheme_list_controller.dart';
import 'router/app_router.dart';
import 'services/api_service.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.authController,
    required this.apiService,
  });

  final AuthController authController;
  final ApiService apiService;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authController),
        ChangeNotifierProvider(
          create: (_) => SchemeListController(apiService),
        ),
      ],
      child: MaterialApp.router(
        title: 'Mutual Fund Browser',
        routerConfig: AppRouter(authController).router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
      ),
    );
  }
}
