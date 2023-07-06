import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '/view/screens/splash_screen.dart';
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

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> initGraphQlClient() async {
    final String graphqlHttpUri =
        'https://medical-records-server1.onrender.com/graphql';

    final String graphqlWsUri =
        'wss://medical-records-server1.onrender.com/graphql';

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
