import '../exports.dart';
import 'package:intl/intl.dart';

// TEST DATA
final List<TimelineStopData> testStops = [
  TimelineStopData(
    locationLabel: '84071 Amalfi, SA, Italy',
    startDate: 'Jun 5',
    endDate: 'Jun 10',
  ),
  TimelineStopData(
    locationLabel: '80067 Sorrento, Metropolitan City of Naples, Italy',
    startDate: 'Jun 10',
    endDate: 'Jun 13',
  ),
  TimelineStopData(
    locationLabel: '80100 Napoli, Metropolitan City of Naples, Italy',
    startDate: 'Jun 13',
    endDate: 'Jun 16',
  ),
  TimelineStopData(
    locationLabel: '80045 Pompei, Metropolitan City of Naples, Italy',
    startDate: 'Jun 16',
    endDate: 'Jun 20',
  ),
];

class TripPage extends StatelessWidget {
  final TripInfo tripInfo;

  const TripPage({
    super.key,
    required this.tripInfo,
  });

  String _formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('MMM d, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final startDateStr = _formatDate(tripInfo.startDate);
    final endDateStr = _formatDate(tripInfo.endDate);

    // Light background color for the entire page
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ------------------------------------------------------------------
            // Top “header” area
            // ------------------------------------------------------------------
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                children: [
                  // Row with "Back" on the left and "Delete Trip" on the right
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Back'),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // TODO: Implement "Delete Trip" functionality
                        },
                        child: const Text('Delete Trip'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Centered column for title, location (with icon), dates (with icon), and tabs
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        tripInfo.title,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),

                      // Row with location_pin icon and location text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/location_pin.svg',
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            tripInfo.location,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Row with calendar icon and date range
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/pgc_calendar_icon.svg',
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '$startDateStr - $endDateStr',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Center the tabs row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          _TabButton(label: 'Details', isSelected: true),
                          SizedBox(width: 12),
                          _TabButton(label: 'Calendar'),
                          SizedBox(width: 12),
                          _TabButton(label: 'Map'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ------------------------------------------------------------------
            // Trip Timeline (UPDATED)
            // ------------------------------------------------------------------
            const SizedBox(height: 24),

            // Title row with location_pin icon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/location_pin.svg',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Trip Timeline',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Four "Stop" cards with test data
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                // Generate a list of Widgets from our testStops
                children: List.generate(testStops.length, (index) {
                  final stop = testStops[index];
                  return Column(
                    children: [
                      // Timeline stop card
                      _TimelineStopCard(
                        stopNumber: index + 1,
                        locationLabel: stop.locationLabel,
                        startDate: stop.startDate,
                        endDate: stop.endDate,
                      ),
                      // Add spacing between cards (except after the last one)
                      if (index < testStops.length - 1)
                        const SizedBox(height: 8),
                    ],
                  );
                }),
              ),
            ),

            const SizedBox(height: 24),

            // ------------------------------------------------------------------
            // PEOPLE SECTION
            // ------------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  Text(
                    'People',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(),
                  // "Customize Columns" and "Add Persons" buttons
                  ElevatedButton(
                    onPressed: () {
                      // TODO
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      elevation: 0,
                      side: const BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Customize Columns'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // TODO
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Add Persons'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // People Table
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFE6ECF3)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(
                    const Color(0xFFF9FBFD),
                  ),
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Arrival')),
                    DataColumn(label: Text('Flight In')),
                    DataColumn(label: Text('Departure')),
                    DataColumn(label: Text('Flight Out')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: [
                    DataRow(cells: [
                      const DataCell(Text('John Doe')),
                      const DataCell(Text('2/28/2025')),
                      const DataCell(Text('AF 123')),
                      const DataCell(Text('3/4/2025')),
                      const DataCell(Text('AF 456')),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Booked',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const DataCell(Text('Edit')),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Jane Smith')),
                      const DataCell(Text('2/28/2025')),
                      const DataCell(Text('AF 789')),
                      const DataCell(Text('3/4/2025')),
                      const DataCell(Text('AF 101')),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Canceled',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const DataCell(Text('Edit')),
                    ]),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ------------------------------------------------------------------
            // MAP + CHAT + CHECKLIST ROW
            // ------------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool canShowSideBySide = constraints.maxWidth > 900;
                  return Flex(
                    direction:
                        canShowSideBySide ? Axis.horizontal : Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // MAP
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 400,
                          margin: EdgeInsets.only(
                            right: canShowSideBySide ? 16 : 0,
                            bottom: canShowSideBySide ? 0 : 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xFFE6ECF3)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Map + route goes here',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // CHAT + CHECKLIST
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            // CHAT
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xFFE6ECF3)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: SizedBox(
                                height: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        'Trip Chat',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                      ),
                                      child: Text(
                                        'Share flight deals, accommodations, and travel ideas with your group here',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    const Divider(height: 24),
                                    // "Type a message..." field
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              decoration: InputDecoration(
                                                hintText: 'Type a message...',
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 8,
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          ElevatedButton(
                                            onPressed: () {
                                              // TODO: Send message
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: const Text('Send'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // CHECKLIST
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xFFE6ECF3)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: SizedBox(
                                height: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        'Trip Checklist',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    // "Add new" text field or button
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              decoration: InputDecoration(
                                                hintText: 'Add new...',
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 8,
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          ElevatedButton(
                                            onPressed: () {
                                              // TODO: Add item
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: const Text('Add'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(height: 24),
                                    const Expanded(
                                      child: Center(
                                        child: Text(
                                          'No items in checklist',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // ------------------------------------------------------------------
            // PINNED PLACES
            // ------------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Pinned Places',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFE6ECF3)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    _PlaceChip(label: 'Bayard'),
                    _PlaceChip(label: 'Pompei Ruins, Parking + MAP, PARKING'),
                    _PlaceChip(
                      label: 'Via Cesare Sersale, 13, 80139 Napoli, NA, Italy',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------
// CUSTOM WIDGETS
// ------------------------------------------------------------------

// Updated Timeline "Stop" card
class _TimelineStopCard extends StatelessWidget {
  final int stopNumber;
  final String locationLabel;
  final String startDate;
  final String endDate;

  const _TimelineStopCard({
    super.key,
    required this.stopNumber,
    required this.locationLabel,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Light blue background to match the screenshot
      decoration: BoxDecoration(
        color: const Color(0xFFE9F0FF),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: location text + Stop # on the far right
          Row(
            children: [
              Expanded(
                child: Text(
                  locationLabel,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                'Stop #$stopNumber',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Bottom row: calendar icon + date range
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/pgc_calendar_icon.svg',
                width: 16,
                height: 16,
              ),
              const SizedBox(width: 8),
              Text(
                '$startDate - $endDate',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Simple placeholder for the three top tabs
class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _TabButton({
    super.key,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : Colors.blue,
        backgroundColor: isSelected ? Colors.blue : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side:
            isSelected ? BorderSide.none : const BorderSide(color: Colors.blue),
      ),
      onPressed: () {
        // TODO: Implement tab switching logic
      },
      child: Text(label),
    );
  }
}

// Simple chip for pinned places
class _PlaceChip extends StatelessWidget {
  final String label;
  const _PlaceChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: const Color(0xFFF5F9FF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      side: const BorderSide(color: Colors.blue, width: 0.5),
    );
  }
}

class TimelineStopData {
  final String locationLabel;
  final String startDate;
  final String endDate;

  TimelineStopData({
    required this.locationLabel,
    required this.startDate,
    required this.endDate,
  });
}

// // Represents a location returned by the Google Maps API
// class GoogleLocation {
//   final String placeId;
//   final String name;
//   final String address;
//   final double latitude;
//   final double longitude;

//   GoogleLocation({
//     required this.placeId,
//     required this.name,
//     required this.address,
//     required this.latitude,
//     required this.longitude,
//   });
// }

// // Data model for the overall trip information, now using GoogleLocation for location data
// class TripInfo {
//   final String title;
//   final GoogleLocation location;
//   final String startDate; // ISO date string
//   final String endDate;   // ISO date string

//   TripInfo({
//     required this.title,
//     required this.location,
//     required this.startDate,
//     required this.endDate,
//   });
// }

// // Data model for timeline stops, with location data coming from Google Maps API
// class TimelineStopData {
//   final GoogleLocation location;
//   final String startDate; // ISO date string
//   final String endDate;   // ISO date string

//   TimelineStopData({
//     required this.location,
//     required this.startDate,
//     required this.endDate,
//   });
// }

// // Data model for a person in the People table
// class PersonData {
//   final String name;
//   final String arrival;    // Date string, e.g., "2/28/2025"
//   final String flightIn;
//   final String departure;  // Date string, e.g., "3/4/2025"
//   final String flightOut;
//   final String status;     // e.g., "Booked" or "Canceled"

//   PersonData({
//     required this.name,
//     required this.arrival,
//     required this.flightIn,
//     required this.departure,
//     required this.flightOut,
//     required this.status,
//   });
// }

// // Data model for chat messages in the Trip Chat section
// class ChatMessage {
//   final String sender;
//   final String message;
//   final DateTime timestamp;

//   ChatMessage({
//     required this.sender,
//     required this.message,
//     required this.timestamp,
//   });
// }

// // Data model for a checklist item in the Trip Checklist section
// class ChecklistItem {
//   final String description;
//   final bool isCompleted;

//   ChecklistItem({
//     required this.description,
//     this.isCompleted = false,
//   });
// }

// // Data model for a pinned place, which now uses GoogleLocation for location details
// class PinnedPlace {
//   final GoogleLocation location;

//   PinnedPlace({
//     required this.location,
//   });
// }
