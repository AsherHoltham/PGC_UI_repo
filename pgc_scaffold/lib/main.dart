import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              toolbarHeight: 50,
              floating: false,
              pinned: false, // keeps a portion of the app bar visible if desired
              titleSpacing: 30.0,
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
                        onPressed: () {},
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
                    TripBtn(),
                    TripBtn(),
                    TripBtn(),
                    TripBtn(),
                    TripBtn(),
                    TripBtn(),
                    TripBtn(),
                    TripBtn(),
                    TripBtn(),

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

class TripBtn extends StatefulWidget {
  TripBtn();
  @override
  TripBtnState createState() => TripBtnState();
}

class TripBtnState extends State<TripBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FloatingActionButton(
      onPressed: () => {},
      child: Text("TripBtn",
          style: TextStyle(
            fontSize: 15,
          )),
    ));
  }
}
