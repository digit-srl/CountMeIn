import 'package:countmein/src/admin/ui/screens/admin_dashboard.dart';
import 'package:countmein/src/common/ui/widgets/my_button.dart';
import 'package:countmein/ui/screens/user_event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
            ElevatedButton(
              onPressed: () {
                // context.go('${UserProviderScreen.routeName}/Yy31B32YBDJDUt7TbZEl');
                context.go('${UserProviderScreen.routeName}/countmein');
              },
              child: Text('vai all evento'),
            ),
            /*
            ElevatedButton(
              onPressed: () {
                try {
                  final file = File('nazioni.dart');
                  final buffer = StringBuffer();
                  buffer.writeln(
                      "import 'package:countmein/domain/entities/nation.dart';");
                  buffer.writeln("final nations = ");
                  buffer.writeln('<Nation>[');
                  for (final c in COMUNI) {
                    if (c[1] == 'EE') {
                      buffer.writeln("Nation(\"${c[2]}\" , \"${c[0]}\"),");
                    }
                  }
                  buffer.writeln('];');
                  file.writeAsString(buffer.toString());
                } catch (ex) {
                  logger.i(ex);
                }
              },
              child: Text('esporta nazioni'),
            ),*/
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
