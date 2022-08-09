
import 'package:countmein/src/admin/ui/screens/admin_dashboard.dart';
import 'package:countmein/src/common/ui/widgets/my_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

/*class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && !Platform.isMacOS) {
      return const AuthGate();
    }

    return Container();
  }
}*/

class HomeWebScreen extends StatelessWidget {
  const HomeWebScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(
            child: MUButton(
              text: 'Dashboard',
              onPressed: () {
                context.push(AdminDashboardScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Count Me In',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            /* ElevatedButton(onPressed: (){
              context.go('/activity/$passepartoutActivityId');
            }, child: Text('vai all evento')),*/
            FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (c, AsyncSnapshot<PackageInfo> snap) {
                return Text(snap.data?.version ?? '-');
              },
            ),
          ],
        ),
      ),
    );
  }
}
