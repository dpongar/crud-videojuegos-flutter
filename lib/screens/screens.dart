import 'home_screen.dart';
import 'insert_screen.dart';
import 'update_screen.dart';

final appRoutes = {
  '/': (context) => const HomeScreen(),
  '/insert': (context) => const InsertScreen(),
  '/update': (context) => const UpdateScreen(),
};
