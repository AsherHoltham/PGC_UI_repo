import '../exports.dart';

class TripPage extends StatelessWidget {
  const TripPage({super.key});

  // The page that appears after the transition.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Page'),
      ),
      body: Center(
        child: Text('Welcome to the Trip page!'),
      ),
    );
  }
}
