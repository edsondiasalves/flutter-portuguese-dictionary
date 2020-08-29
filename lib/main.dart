import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portuguese_dictionary/multitab.dart';
import 'package:portuguese_dictionary/routes.dart';
import 'package:portuguese_dictionary/services/services.dart';

import 'modules/intro/intro.dart';

int main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Main(
    initialRoute: Routes.intro,
    firebaseApp: Firebase.initializeApp(),
  ));
  return 1;
}

class Main extends StatelessWidget {
  final String initialRoute;
  final Future<FirebaseApp> firebaseApp;
  final FirebaseFirestore firestore;

  const Main({this.initialRoute, this.firebaseApp, this.firestore});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebaseApp,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          FirebaseFirestore firestoreInstance;

          if (firestore == null) {
            firestoreInstance = FirebaseFirestore.instance;
          } else {
            firestoreInstance = firestore;
          }

          final newsCollection = firestoreInstance.collection('news');
          final entriesCollection = firestoreInstance.collection('entries');

          return MaterialApp(
            initialRoute: this.initialRoute,
            routes: {
              Routes.intro: (context) => Intro(),
              Routes.multitab: (context) => Multitab(
                    homeService: HomeService(
                      collection: newsCollection,
                    ),
                    definitionService: DefinitionService(
                      collection: entriesCollection,
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
