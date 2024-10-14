import 'package:flutter/material.dart';
import 'package:maths_language/models/content_model.dart';
import 'package:maths_language/view/pages/create_content_page.dart';
import 'package:maths_language/view/pages/edit_content_page.dart';
import 'package:maths_language/view/pages/home_page.dart';
import 'package:maths_language/view/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/file_controller.dart';
import 'utils/utils_firebase/firebase_options.dart';
import 'view/pages/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ContentController contentController = ContentController();

  @override
  void initState() {
    super.initState();
    contentController.initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          theme: ThemeData(
            fontFamily: "Roboto",
          ),
          onGenerateRoute: (settings) {
            if (settings.name == "/edit") {
              final Map<String, dynamic> params =
                  settings.arguments as Map<String, dynamic>;

              return MaterialPageRoute(
                builder: (context) => EditContentPage(
                  content: ContentModel(
                      name: params["title"],
                      description: params["description"],
                      updatedAt: params["date"],
                      thumbnailPath: params["imagePath"],
                      contentFilePath: params["file"]),
                ),
              );
            }
          },
          routes: {
            "/": (context) => SplashPage(),
            "/auth": (context) => AuthenticationPage(),
            "/home": (context) => HomePage(),
            "/create": (context) => CreateContentPage(),
          },
        );
      },
    );
  }
}
