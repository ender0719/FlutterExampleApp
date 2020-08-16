import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'package:flutter_app/modal_class/artist.dart';
import 'package:flutter_app/widgets/horizontal_artist.dart';

SpotifyApiCredentials credentials = null;
SpotifyApi spotify = null;
void main() async {
  SpotifyApiCredentials  credentials = SpotifyApiCredentials('b5dd7351577f442d9708e7253a19b1e9', 'cd8cacdde599487a8431780ecb86f019');
  spotify = SpotifyApi(credentials);
  //final artist = await spotify.artists.get('0OdUWJ0sBjDrqHygGUXeCF');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Flutter',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  bool isShown = true;
  bool isPlaying = false;
  final List<ArtistObj> recentlyPlayed = [
    ArtistObj(
        imageSrc: "assets/favourite.jpg",
        title: 'Favourite Songs',
        circular: false),
    ArtistObj(
        imageSrc: "assets/Rain.jpg", title: 'Rain', circular: true),
    ArtistObj(
        imageSrc: "assets/lee.jpg",
        title: '李友廷',
        circular: false),
    ArtistObj(
        imageSrc: "assets/this_is_post_malone.jpg",
        title: 'This is Post Malone',
        circular: false),
  ];

  final List<ArtistObj> heavyRotation = [
    ArtistObj(
        imageSrc: "assets/hailee.jpg",
        title: 'Hailee Steinfeld',
        circular: true),
    ArtistObj(
        imageSrc: "assets/stoney.jpg",
        title: 'Stoney(deluxe)',
        circular: false),
    ArtistObj(
        imageSrc: "assets/this_is_queen.jpg",
        title: 'This is Queen',
        circular: false),
    ArtistObj(
        imageSrc: "assets/queen_best_of.jpg",
        title: 'Queen : Best of',
        circular: false),
    ArtistObj(
        imageSrc: "assets/this_is_post_malone.jpg",
        title: 'This is Post Malone',
        circular: false),
  ];

  final List<ArtistObj> madeForYou = [
    ArtistObj(
        imageSrc: "assets/discover.jpg",
        title: 'Discover Weekly',
        circular: false),
    ArtistObj(
        imageSrc: "assets/time_capsule.jpg",
        title: 'Time Capsule',
        circular: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          title: Text("Home"),
          leading: IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation',
            onPressed: () {
              _scaffoldkey.currentState.openDrawer();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Recently Played',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  SizedBox(
                    child: ArtistList(
                      artists: recentlyPlayed,
                    ),
                    height: 185.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Your Heavy Rotation',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  SizedBox(
                    child: ArtistList(
                      artists: heavyRotation,
                    ),
                    height: 185.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Made for bimsina',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  SizedBox(
                    child: ArtistList(
                      artists: madeForYou,
                    ),
                    height: 185.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('Ender'),
                accountEmail: Text('Ender0719@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/photo.jpg'),
                ),
                decoration: BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage('assets/images/background.jpg'),
                      fit: BoxFit.fill,

                )),
              ),
              ListTile(
                leading: Icon(Icons.headset),
                title: Text('Spotify'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.queue_music),
                title: Text('Song list'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.power_settings_new),
                title: Text('Sign out'),
                onTap: () async {
                  await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                      content: Text("Are you sure to exit current account."),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Cancel"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        FlatButton(
                          child: Text("OK"),
                          onPressed: () => Navigator.pushNamedAndRemoveUntil(
                              context, "/login", ModalRoute.withName('/')),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        )
    );
  }
}