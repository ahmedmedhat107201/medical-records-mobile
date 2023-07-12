import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:medical_records_mobile/view/screens/splash_screen.dart';
import 'constant.dart';
import '/view/screens/sections/chat/chatHomeScreen.dart';
import '/view/screens/sections/medicalRecords/scanMedicalRecord.dart';
import 'view/screens/sections/chat/chatRoomsScreen.dart';
import 'view/screens/sections/medicalRecords/createMedicalRecordScreen.dart';
import 'view/screens/sections/medicalRecords/medicalRecordScreen.dart';
import 'view/screens/loginScreen.dart';
import 'view/screens/sections/QRCheckScreen.dart';
import 'view/screens/sections/chat/chatScreen.dart';
import 'view/screens/sections/chat/getDoctorsScreen.dart';
import 'view/screens/sections/homeScreen.dart';

void main() async {
  await initHiveForFlutter();
  HttpOverrides.global = MyHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> initGraphQlClient() async {
    final String graphqlHttpUri =
        'https://ec2-3-138-142-207.us-east-2.compute.amazonaws.com:3000/graphql';

    final String graphqlWsUri =
        'https://ec2-3-138-142-207.us-east-2.compute.amazonaws.com:3000/graphql';

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer ' + globalToken!,
    );

    final WebSocketLink websocketLink = WebSocketLink(
      graphqlWsUri,
      config: SocketClientConfig(
        autoReconnect: true,
        inactivityTimeout: Duration(seconds: 30),
      ),
      subProtocol: GraphQLProtocol
          .graphqlTransportWs, // This line is important, by default protocol is GraphQLProtocol.graphqlWs
    );

    // for queries and mutations
    final HttpLink httpLink = HttpLink(graphqlHttpUri);

    //for subscriptions using websockets
    final Link link = Link.split((request) => request.isSubscription,
        authLink.concat(websocketLink), authLink.concat(httpLink));

    setState(() {
      graphqlClient = ValueNotifier(
        GraphQLClient(
          link: link,
          // The default store is the InMemoryStore, which does NOT persist to disk
          cache: GraphQLCache(store: HiveStore()),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.initGraphQlClient();
    });
  }

  @override
  Widget build(BuildContext context) {
    return graphqlClient == null
        ? Center(child: CircularProgressIndicator())
        : GraphQLProvider(
            client: graphqlClient,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary,
                ),
              ),
              home: SplashScreen(),
              routes: {
                LoginScreen.routeID: (context) => LoginScreen(),
                HomeScreen.routeID: (context) => HomeScreen(),
                MedicalRecordScreen.routeID: (context) =>
                    MedicalRecordScreen(isScanned: false),
                CreateMedicalRecordScreen.routeID: (context) =>
                    CreateMedicalRecordScreen(),
                QRCheckScreen.routeID: (context) => QRCheckScreen(),
                ChatHomeScreen.routeID: (context) => ChatHomeScreen(),
                ChatRoomsScreen.routeID: (context) => ChatRoomsScreen(),
                ChatScreen.routeID: (context) => ChatScreen(),
                GetDoctorsScreen.routeID: (context) => GetDoctorsScreen(),
                ScanMedicalRecord.routeID: (context) => ScanMedicalRecord(),
              },
            ),
          );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) =>
          true;
  }
}
