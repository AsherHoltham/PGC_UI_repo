import '../exports.dart';
import 'package:intl/intl.dart';

class PersonalGroupCoordinatorPage extends StatefulWidget {
  const PersonalGroupCoordinatorPage({super.key});
  @override
  State<PersonalGroupCoordinatorPage> createState() => _MyPGCState();
}

class _MyPGCState extends State<PersonalGroupCoordinatorPage> {
  final _mTitleController = TextEditingController();
  final _mLocationController = TextEditingController();
  final _mStartDateController = TextEditingController();
  final _mEndDateController = TextEditingController();

  // Instantiate the TripInfoBloc with the repository
  late final TripInfoBloc _tripInfoBloc;

  @override
  void initState() {
    super.initState();
    _tripInfoBloc = TripInfoBloc(repository: TripInfoRepository());
    // Load initial trip data
    _tripInfoBloc.add(LoadTripInfos());
  }

  @override
  void dispose() {
    // Close the Hive box if needed and dispose controllers.
    Hive.box('trip_info').close();
    _mTitleController.dispose();
    _mLocationController.dispose();
    _mStartDateController.dispose();
    _mEndDateController.dispose();
    _tripInfoBloc.close();
    super.dispose();
  }

  void _openTripDialog(
    BuildContext context,
    TripInfoBloc tripInfoBloc,
    TextEditingController mTitleController,
    TextEditingController mLocationController,
    TextEditingController mStartDateController,
    TextEditingController mEndDateController,
  ) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Trip Input",
      barrierColor: Colors.black.withAlpha(128),
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Material(
          type: MaterialType.transparency,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                // Dialog Card
                margin: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth / 7,
                  vertical: constraints.maxHeight / 10,
                ),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    // Main Content
                    Column(
                      mainAxisSize: MainAxisSize.min, // Wrap content height
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Dialog Title
                        Text(
                          "Create New Trip",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),

                        // Trip Name Field
                        TextFormField(
                          controller: _mTitleController,
                          decoration: InputDecoration(
                            labelText: 'Trip Name',
                            hintText: 'Summer Vacation',
                          ),
                        ),
                        SizedBox(height: 12),

                        // Location Field
                        TextFormField(
                          controller: _mLocationController,
                          decoration: InputDecoration(
                            labelText: 'Location',
                            hintText: 'Search for location...',
                            suffixIcon: Icon(Icons.search),
                          ),
                        ),
                        SizedBox(height: 12),

                        // Placeholder Map Container
                        // Replace with a real map widget if desired
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Map goes here',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),

                        // Date Fields (Start + End)
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _mStartDateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Start Date',
                                  hintText: 'mm/dd/yy',
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    _mStartDateController.text =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                controller: _mEndDateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'End Date',
                                  hintText: 'mm/dd/yy',
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    // Check if a start date has been selected
                                    if (_mStartDateController.text.isNotEmpty) {
                                      DateTime startDate =
                                          DateFormat('yyyy-MM-dd').parse(
                                              _mStartDateController.text);
                                      // Validate that the end date is after the start date
                                      if (pickedDate.isAfter(startDate)) {
                                        _mEndDateController.text =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'End Date must be later than Start Date.'),
                                          ),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Please select a Start Date first.'),
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Create Trip Button
                        ElevatedButton(
                          onPressed: () {
                            final title = _mTitleController.text;
                            final location = _mLocationController.text;
                            final startDate = _mStartDateController.text;
                            final endDate = _mEndDateController.text;

                            // Dispatch an event to add the new trip.
                            _tripInfoBloc.add(
                              AddTripInfoEvent(
                                title: title,
                                location: location,
                                startDate: startDate,
                                endDate: endDate,
                              ),
                            );

                            // Clear fields and close dialog.
                            _mTitleController.clear();
                            _mLocationController.clear();
                            _mStartDateController.clear();
                            _mEndDateController.clear();
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            textStyle: TextStyle(fontSize: 16),
                          ),
                          child: Text('Create Trip'),
                        ),
                      ],
                    ),

                    // "X" close button (top-right)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
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
                backgroundColor: Colors.white,
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
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 30.0,
              right: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      "My Trips",
                      style: TextStyle(
                          fontSize: 15.5, fontWeight: FontWeight.w900),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: SizedBox(
                        width: 100.0,
                        height: 40.0,
                        child: FloatingActionButton(
                          onPressed: () {
                            _openTripDialog(
                              context,
                              _tripInfoBloc,
                              _mTitleController,
                              _mLocationController,
                              _mStartDateController,
                              _mEndDateController,
                            );
                          },
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
