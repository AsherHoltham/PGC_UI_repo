import 'exports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PGC',
      theme: ThemeData(
        textTheme:
            GoogleFonts.nunitoSansTextTheme(), // Apply Nunito Sans globally
      ),
      home: const PersonalGroupCoordinatorPage(),
    );
  }
}
