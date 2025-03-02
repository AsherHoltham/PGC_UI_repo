import '../exports.dart';

class TripInfoCard extends StatelessWidget {
  final String title;
  final String location;
  final String startDate;
  final String endDate;
  final String imageUrl;

  const TripInfoCard({
    super.key,
    required this.title,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime startDateTime = DateTime.tryParse(startDate) ?? now;
    DateTime endDateTime = DateTime.tryParse(endDate) ?? now;

    String tripStatus;
    if (now.isBefore(startDateTime)) {
      final int daysUntilTrip = startDateTime.difference(now).inDays;
      tripStatus = "in $daysUntilTrip day${daysUntilTrip == 1 ? "" : "s"}";
    } else if (now.isAfter(endDateTime)) {
      final int daysSinceTripEnded = now.difference(endDateTime).inDays;
      tripStatus =
          "ended $daysSinceTripEnded day${daysSinceTripEnded == 1 ? "" : "s"} ago";
    } else {
      tripStatus = "currently happening";
    }

    return ClipRRect(
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
        child: Column(
          children: [
            // Trip image
            Expanded(
              flex: 4,
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Text information
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Bold and larger title just below the image.
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18, // larger than the other info
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Location info with icon directly below the title.
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/location_pin.svg',
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                        height: 8), // offset the trip status below location.
                    // Trip status info with calendar icon.
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/pgc_calendar_icon.svg',
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          tripStatus,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
