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
      final int daysUntilTrip = startDateTime.difference(now).inDays + 1;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trip image at the top
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),

            // Card content
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title (e.g., "NYC")
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Location row with pin icon
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 8),

                  // Trip status row with calendar icon (e.g. "ended 30 days ago")
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
                  const SizedBox(height: 12),

                  // A row with "A" and "H" placeholders + 'View Details' on the right
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/users_icon.svg',
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 4),

                      // Circular placeholder #1
                      Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blueAccent,
                        ),
                        child: const Center(
                          child: Text(
                            'A',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),

                      // Circular placeholder #2
                      Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orangeAccent,
                        ),
                        child: const Center(
                          child: Text(
                            'H',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
