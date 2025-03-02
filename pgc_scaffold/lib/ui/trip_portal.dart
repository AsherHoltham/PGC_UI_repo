import '../exports.dart';

class TripPortal extends StatefulWidget {
  final TripInfo tripInfo;
  const TripPortal({super.key, required this.tripInfo});

  @override
  TripPortalState createState() => TripPortalState();
}

class TripPortalState extends State<TripPortal> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 500),
      transitionType: ContainerTransitionType.fadeThrough,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      closedElevation: 6.0,

      // TODO: Pass TripInfo to TripPage to display its details
      openBuilder: (BuildContext context, VoidCallback _) {
        return TripPage(tripInfo: widget.tripInfo);
      },

      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return GestureDetector(
          onTap: openContainer,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.lightBlue, // Light blue border color
                width: 1.0, // Thin border
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: TripInfoCard(
              title: widget.tripInfo.title,
              location: widget.tripInfo.location,
              startDate: widget.tripInfo.startDate,
              endDate: widget.tripInfo.endDate,
              imageUrl:
                  "https://images.pexels.com/photos/371633/pexels-photo-371633.jpeg?auto=compress&cs=tinysrgb&h=350",
            ),
          ),
        );
      },
    );
  }
}
