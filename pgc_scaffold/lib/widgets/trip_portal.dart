import '../exports.dart';

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
        return TripPage();
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
