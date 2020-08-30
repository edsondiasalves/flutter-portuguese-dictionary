import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portuguese_dictionary/multitab.dart';
import 'package:portuguese_dictionary/routes.dart';
import 'package:portuguese_dictionary/services/services.dart';

import 'modules/intro/intro.dart';

int main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Main(
      initialRoute: Routes.intro,
      firebaseApp: Firebase.initializeApp(),
    ),
  );
  return 1;
}

class Main extends StatelessWidget {
  final String initialRoute;
  final Future<FirebaseApp> firebaseApp;

  const Main({this.initialRoute, this.firebaseApp});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebaseApp,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final firestoreInstance = FirebaseFirestore.instanceFor(
            app: snapshot.data,
          );

          return MaterialApp(
            initialRoute: this.initialRoute,
            routes: {
              Routes.intro: (context) => Intro(),
              Routes.multitab: (context) => Multitab(
                    homeService: HomeService(
                      firestore: firestoreInstance,
                    ),
                    definitionService: DefinitionService(
                      firestore: firestoreInstance,
                    ),
                  ),
            },
          );
        }

        return CircularProgressIndicator();
      },
    );
  }
}
