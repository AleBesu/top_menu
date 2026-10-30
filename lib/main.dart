import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_menu/UI/providers/restaurant_provider.dart';
import 'package:top_menu/UI/screens/server_iniciated_screen.dart';
import 'package:top_menu/core/datasourses/hive_restaurant_local_data_source.dart';
import 'package:top_menu/core/services/app_foreground_service/app_foreground_service.dart';

import 'app/theme.dart';
import 'UI/screens/admi_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveRestaurantLocalDataSource.init();
  FlutterForegroundTask.initCommunicationPort();
  runApp(const ProviderScope(child: MenuAdminApp()));
}

final navigatorKey = GlobalKey<NavigatorState>();

class MenuAdminApp extends ConsumerWidget {
  const MenuAdminApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: MaterialApp(
        title: 'TopMenu',

        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ref.watch(menuConfigProvider).isDarkTheme
            ? buildDarkTheme(ref)
            : buildLightTheme(ref),
        home: AdmiMenuScreen(),
      ),
    );
  }
}

// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: StreamBuilder<List<NetworkInterface>?>(
//           stream: Stream.periodic(const Duration(seconds: 1)).asyncExpand(
//             (_) => Stream.fromFuture(
//               NetworkInterface.list(
//                 includeLoopback: false,
//                 type: InternetAddressType.any,
//               ),
//             ),
//           ),
//           builder: (context, snapshot) {
//             return Center(
//               child: SizedBox(
//                 width: double.maxFinite,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     if (snapshot.hasData)
//                       ...snapshot.data!.map((e) => Center(child: Text(e.name))),
//                     // ...snapshot.data!
//                     //     .expand((network) => network.addresses)
//                     //     .map((address) => Text(address.address)),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
