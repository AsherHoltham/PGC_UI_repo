import '../exports.dart';

class PersonalGroupCoordinatorPage extends StatefulWidget {
  const PersonalGroupCoordinatorPage({super.key});
  @override
  State<PersonalGroupCoordinatorPage> createState() => _MyPGCState();
}

class _MyPGCState extends State<PersonalGroupCoordinatorPage> {
  void _openTripDialog() async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: false, // Disable dismissing by tapping outside.
      barrierLabel: "Trip Input",
      barrierColor: Colors.black.withAlpha(128), // Dims the background.
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Material(
          type: MaterialType.transparency,
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth / 7,
                  vertical: constraints.maxHeight / 10),
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
            );
          }),
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
              pinned: true, // keeps a portion of the app bar visible if desired
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
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth ~/ 300 > 3 ? 3 : constraints.maxWidth ~/ 300;
                    return GridView.count(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      padding: EdgeInsets.only(bottom: 20.0),
                      children: [
                        // Dynamically build your trip portals here
                        TripPortal(),
                        TripPortal(),
                        TripPortal(),
                        TripPortal(),
                        TripPortal(),
                        TripPortal(),
                        TripPortal(),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
