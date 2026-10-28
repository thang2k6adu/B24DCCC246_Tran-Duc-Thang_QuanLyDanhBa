import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data/contact_repository.dart';
import 'screens/contact_list_screen.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  final repository = ContactRepository();
  runApp(ContactManagerApp(repository: repository));
}

class ContactManagerApp extends StatelessWidget {
  final ContactRepository repository;

  const ContactManagerApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản Lý Danh Bạ',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/contacts': (context) => ContactListScreen(repository: repository),
      },
    );
  }
}
