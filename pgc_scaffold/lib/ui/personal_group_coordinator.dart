import '../exports.dart';

class PersonalGroupCoordinatorPage extends StatefulWidget {
  const PersonalGroupCoordinatorPage({super.key});
  @override
  State<PersonalGroupCoordinatorPage> createState() => _MyPGCState();
}

class _MyPGCState extends State<PersonalGroupCoordinatorPage> {
  final _mTitleController = TextEditingController();
  final _mLocationController = TextEditingController();

  // Instantiate the TripInfoBloc with the repository
  late final TripInfoBloc _tripInfoBloc;

  @override
  void initState() {
    super.initState();
    _tripInfoBloc = TripInfoBloc(repository: TripInfoRepository());
    // Load initial trip data
    _tripInfoBloc.add(LoadTripInfos());

    // (Optional) Listeners to update cursor position for the text fields.
    _mTitleController.addListener(() {
      final text = _mTitleController.text;
      _mTitleController.value = _mTitleController.value.copyWith(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    });
    _mLocationController.addListener(() {
      final text = _mLocationController.text;
      _mLocationController.value = _mLocationController.value.copyWith(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    });
  }

  @override
  void dispose() {
    // Close the Hive box if needed and dispose controllers.
    Hive.box('trip_info').close();
    _mTitleController.dispose();
    _mLocationController.dispose();
    _tripInfoBloc.close();
    super.dispose();
  }

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
                borderRadius: BorderRadius.circular(20),
              ),
              // Use a Stack to position the "X" button over the content.
              child: Stack(
                children: [
                  // Main content of the dialog.
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Plan New Trip", style: TextStyle(fontSize: 16.5)),
                      TextFormField(
                        controller: _mTitleController,
                        decoration: InputDecoration(labelText: 'Title'),
                      ),
                      TextFormField(
                        controller: _mLocationController,
                        decoration: InputDecoration(labelText: 'Location'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final title = _mTitleController.text;
                          final location = _mLocationController.text;
                          // Dispatch an event to add the new trip.
                          _tripInfoBloc.add(
                            AddTripInfoEvent(title: title, location: location),
                          );
                          
                          Navigator.of(context).pop(); // Close the dialog.
                        },
                        child: Text('Submit'),
                      ),
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
    return BlocProvider(
      create: (_) => _tripInfoBloc,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                toolbarHeight: 50,
                floating: false,
                pinned: true, // Keeps a portion of the app bar visible.
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
                      style: TextStyle(
                          fontSize: 15.5, fontWeight: FontWeight.w500),
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
                // Use BlocBuilder to rebuild the GridView based on state changes.
                Expanded(
                  child: BlocBuilder<TripInfoBloc, TripInfoState>(
                    builder: (context, state) {
                      if (state is TripInfoLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is TripInfoLoaded) {
                        // Dynamically create TripPortal widgets from the trip data.
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            int crossAxisCount = constraints.maxWidth ~/ 300 > 3
                                ? 3
                                : constraints.maxWidth ~/ 300;
                            return GridView.count(
                              crossAxisCount: crossAxisCount,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              padding: EdgeInsets.only(bottom: 20.0),
                              children: state.trips
                                  .map((trip) => TripPortal(tripInfo: trip))
                                  .toList(),
                            );
                          },
                        );
                      } else if (state is TripInfoError) {
                        return Center(child: Text("Error: ${state.error}"));
                      }
                      return Container();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
