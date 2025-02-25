import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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

class PersonalGroupCoordinatorPage extends StatefulWidget {
  const PersonalGroupCoordinatorPage({super.key});
  @override
  State<PersonalGroupCoordinatorPage> createState() => _MyPGCState();
}

class _MyPGCState extends State<PersonalGroupCoordinatorPage> {
  void _openTripDialog() async {
    final result = await showGeneralDialog(
      context: context,
      barrierDismissible: false, // Disable dismissing by tapping outside.
      barrierLabel: "Trip Input",
      barrierColor: Colors.black.withAlpha(128), // Dims the background.
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 200, vertical: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              // Use a Stack to position the "X" button over the content.
              child: Stack(
                children: [
                  // Main content of the dialog.
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Plan New Trip:"),
                      // Add additional widgets here for trip creation.
                    ],
                  ),
                  // Positioned "X" button in the top-right corner.
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog.
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        // Scale transition for the "expanding" effect.
        return ScaleTransition(
          scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              toolbarHeight: 50,
              floating: false,
              pinned:
                  false, // keeps a portion of the app bar visible if desired
              titleSpacing: 30.0,
              centerTitle: false,
              title: Text(
                'Personal Group Coordinator',
                style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(2.0),
                child: Container(
                  color: Color.fromARGB(255, 236, 235, 235),
                  height: 2.0,
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 30.0),
                  child: SvgPicture.asset(
                    "assets/icons/sign_out.svg",
                    colorFilter: ColorFilter.mode(
                        Color.fromARGB(255, 0, 0, 0), BlendMode.srcIn),
                    //TODO: Program functionallity to the Sign In button
                  ),
                ),
              ],
            )
          ];
        },
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 30.0, right: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    "My Trips",
                    style:
                        TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: SizedBox(
                      width: 100.0,
                      height: 40.0,
                      child: FloatingActionButton(
                        onPressed: _openTripDialog,
                        backgroundColor: Color.fromARGB(255, 41, 52, 204),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Text(
                                "New Trip",
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  padding: EdgeInsets.only(bottom: 20.0),
                  children: [
                    //TODO: Add a loop to allocate all trip portals dynamically
                    TripPortal(),
                    TripPortal(),
                    TripPortal(),
                    TripPortal(),
                    TripPortal(),
                    TripPortal(),
                    TripPortal(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TripPortal extends StatefulWidget {
  const TripPortal({super.key});
  @override
  TripPortalState createState() => TripPortalState();
}

class TripPortalState extends State<TripPortal> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: Duration(milliseconds: 500),
      transitionType: ContainerTransitionType.fadeThrough,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      closedElevation: 6.0,
      openBuilder: (BuildContext context, VoidCallback _) {
        // The destination page.
        return SecondPage();
      },
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        // The closed state shows a FloatingActionButton.
        return GestureDetector(
          onTap: openContainer,
          child: TripInfoCard(
            title: "Trip Portal",
            description: "Explore the details of this trip.",
            imageUrl:
                "https://images.pexels.com/photos/371633/pexels-photo-371633.jpeg?auto=compress&cs=tinysrgb&h=350",
          ),
          //TODO: Set the child of the button to the Trip Cover
        );
      },
    );
  }
}

class TripInfoCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const TripInfoCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // Ensure the shape of the card has smooth, rounded edges.
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        // Using Expanded and flex factors to split the available space.
        child: Column(
          children: [
            // The image covers the upper third.
            Expanded(
              flex: 1,
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // The text information covers the lower two-thirds.
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//////////////////////****** TEST ******//////////////////////
class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

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
