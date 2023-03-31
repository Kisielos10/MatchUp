import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'project.dart';

void main() {
  runApp(MyApp());
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<MyAppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade400,
              Colors.blue.shade700,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: appState._favoriteProjects.length,
          itemBuilder: (BuildContext context, int index) {
            var project = appState._favoriteProjects[index];
            print(project);
            return ListTile(
              title: Text(
                project.projectName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🌟 ${project.stars}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '👨‍💻 ${project.followers}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '🔢 Commits/Week: ${project.commitsPerWeek}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '📖 Top Languages: ${project.topLanguages.join(", ")}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '🚪 Public Pull Requests Done: ${project.publicPullRequests}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '💼 Pro User: ${project.isProUser}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'My App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
          '/favorites': (context) => FavoritesPage(),
        },
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  List<String> projectList = [
    'Project A',
    'Project B',
    'Project C',
    'Project D',
    'Project E',
  ];
  List<Project> _favoriteProjects = [];

  List<Project> get favoriteProjects => _favoriteProjects;

  void addToFavorites(Project project) {
    _favoriteProjects.add(project);
    notifyListeners();
  }

  void deleteFromFavorites(Project project) {
    _favoriteProjects.remove(project);
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MyAppState appState;
  int currentIndex = 0;
  bool isFavorite = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    appState = Provider.of<MyAppState>(context, listen: false); // initialize appState
  }

  final List<Widget> _children = [
    MyHomePage(),
    FavoritesPage(),
  ];

  void _nextProject() {
    if (currentIndex < appState.projectList.length - 1) {
      setState(() {
        currentIndex++;
        isFavorite = false;
      });
    }
  }

  void _previousProject() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        isFavorite = false;
      });
    }
  }

  void _toggleFavorite() {
    var currentProject = Project(
      projectName: appState.projectList[currentIndex],
      commitsPerWeek: Random().nextInt(100),
      topLanguages: ['Dart', 'Java', 'Swift'],
      publicPullRequests: Random().nextInt(20),
      stars: Random().nextInt(100),
      followers: Random().nextInt(1000),
      isProUser: Random().nextBool(),
    );

    if (isFavorite) {
      appState.deleteFromFavorites(currentProject);
    } else {
      appState.addToFavorites(currentProject);
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }
  @override
  Widget build(BuildContext context) {
    var currentProject = appState.projectList[currentIndex];
    var projectDetails = appState.favoriteProjects
        .firstWhere((project) => project.projectName == currentProject,
        orElse: () => Project());

    return Scaffold(
      appBar: AppBar(
        title: Text('My Projects'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('background.jpg.png'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Center(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentProject,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 5.0),
                        Text(
                          'Commits/Week: ${projectDetails.commitsPerWeek}',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.code),
                        SizedBox(width: 5.0),
                        Text(
                          'Top Languages: ${projectDetails.topLanguages.join(
                              ", ")}',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.public),
                        SizedBox(width: 5.0),
                        Text(
                          'Public Pull Requests Done: ${projectDetails
                              .publicPullRequests}',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star),
                        SizedBox(width: 5.0),
                        Text(
                          'Stars on Public Repositories: ${projectDetails
                              .stars}',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.people),
                        SizedBox(width: 5.0),
                        Text(
                          'Followers: ${projectDetails.followers}',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.verified),
                        SizedBox(width: 5.0),
                        Text(
                          'Pro User: ${projectDetails.isProUser}',
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: _previousProject,
                      child: Text('Previous'),
                    ),
                    SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: _nextProject,
                      child: Row(
                          children: [
                            Text('Next'),
                          ]
                      ),
                    ),
                    SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: _toggleFavorite,
                      child: Row(
                        children: [
                          isFavorite ? Icon(Icons.check) : Icon(Icons
                              .favorite_outline),
                          SizedBox(width: 5.0),
                          Text(isFavorite
                              ? 'Added to favorites!'
                              : 'Add to favorites'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}