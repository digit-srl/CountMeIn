import 'package:countmein/cloud.dart';
import 'package:countmein/domain/entities/event_ids.dart';
import 'package:countmein/domain/entities/user_card.dart';
import 'package:countmein/src/admin/application/events_stream.dart';
import 'package:countmein/src/admin/application/users_stream.dart';
import 'package:countmein/src/admin/ui/widgets/admin_app_bar.dart';
import 'package:countmein/src/auth/application/auth_notifier.dart';
import 'package:countmein/src/auth/domain/entities/user.dart';
import 'package:countmein/src/common/ui/widgets/cmi_container.dart';
import 'package:countmein/ui/screens/admin.dart';
import 'package:countmein/ui/screens/admin_user_details.dart';
import 'package:countmein/ui/widgets/loading.dart';
import 'package:csv/csv.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_io/io.dart';
import 'package:intl/intl.dart';

class EventUsersScreen extends ConsumerStatefulWidget {
  static const String routeName = '/eventUsers';

  final String eventId;
  final String providerId;
  final String? subEventId;

  const EventUsersScreen({
    Key? key,
    required this.eventId,
    required this.providerId,
    this.subEventId,
  }) : super(key: key);

  @override
  ConsumerState<EventUsersScreen> createState() => _EventUsersScreenState();
}

class _EventUsersScreenState extends ConsumerState<EventUsersScreen> {
  late EventIds ids;

  late DateFormat dateFormat;

  @override
  void initState() {
    super.initState();
    dateFormat = DateFormat('HH:mm');
    ids = EventIds(
      providerId: widget.providerId,
      eventId: widget.eventId,
      subEventId: widget.subEventId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventState = ref.watch(eventProvider(ids));
    final usersState = ref.watch(eventUsersStreamProvider(ids));
    final subEvent = ids.subEventId == null ? null : ref.watch(subEventProvider(ids)).value;
    // final role = ref.watch(userRoleProvider(widget.providerId));
    // final isOwner = role == UserRole.admin;
    final hasData = usersState is AsyncData;
    final anonymous = eventState.value?.anonymous ?? true;
    return Scaffold(
      appBar: const AdminAppBar(
        title: 'Iscritti',
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (subEvent?.genderCount != null)
            CMICard(
              child: Column(
                children: [
                  Text('Genere'),
                  SizedBox(
                    height: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: PieChart(
                            PieChartData(
                              pieTouchData: PieTouchData(
                                touchCallback:
                                    (FlTouchEvent event, pieTouchResponse) {
                                  // setState(() {
                                  //   if (!event.isInterestedForInteractions ||
                                  //       pieTouchResponse == null ||
                                  //       pieTouchResponse.touchedSection == null) {
                                  //     touchedIndex = -1;
                                  //     return;
                                  //   }
                                  //   touchedIndex = pieTouchResponse
                                  //       .touchedSection!.touchedSectionIndex;
                                  // });
                                },
                              ),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 0,
                              centerSpaceRadius: 0,
                              sections: showingSections(
                                subEvent?.genderCount?.male ?? 0,
                                subEvent?.genderCount?.female ?? 0,
                                subEvent?.genderCount?.notBinary ?? 0,
                                subEvent?.genderCount?.notAvailable ?? 0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // const Text('M'),
                                Icon(
                                  Icons.male,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 8),
                                Text(subEvent?.genderCount?.male.toString() ?? '-')
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // const Text('F'),
                                Icon(
                                  Icons.female,
                                  color: Colors.pink,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                    subEvent?.genderCount?.female.toString() ?? '-'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // const Text('?'),
                                Icon(Icons.not_interested, color: Colors.green),
                                const SizedBox(width: 8),
                                Text(subEvent?.genderCount?.notBinary.toString() ??
                                    '-'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // const Text('?'),
                                Icon(Icons.not_interested, color: Colors.grey),
                                const SizedBox(width: 8),
                                Text(subEvent?.genderCount?.notAvailable.toString() ??
                                    '-'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          Text(
            'Utenti',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 16),
          usersState.when(
            data: (list) {
              return list.isEmpty
                  ? const Center(
                      child: Text(
                        'Non ci sono utenti per questo evento',
                      ),
                    )
                  : anonymous
                      ? Text(list.length == 1
                          ? 'C\'è un iscritto'
                          : 'Ci sono ${list.length} iscritti')
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: list.length,
                          shrinkWrap: true,
                          itemBuilder: (c, index) {
                            final user = list[index];
                            return ListTile(
                              onTap: () {
                                context.push(UserDetailsScreen.routeName,
                                    extra: user);
                              },
                              title: Text(anonymous ? user.id : user.fullName),
                              subtitle: anonymous
                                  ? null
                                  : Text(
                                      user.cf ?? '-',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                              leading: Text('${index + 1}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (user.checkInAt != null)
                                    Tooltip(
                                      message:
                                          dateFormat.format(user.checkInAt!),
                                      child: const Icon(
                                        Icons.arrow_circle_down,
                                        color: Colors.green,
                                      ),
                                    ),
                                  const SizedBox(width: 16),
                                  if (user.checkOutAt != null)
                                    Tooltip(
                                      message:
                                          dateFormat.format(user.checkOutAt!),
                                      child: const Icon(
                                        Icons.arrow_circle_up,
                                        color: Colors.red,
                                      ),
                                    )
                                ],
                              ),
                              // trailing: isOwner
                              //     ? IconButton(
                              //         icon: const Icon(Icons.delete),
                              //         color: Colors.red,
                              //         onPressed: () {
                              //           _deleteUser(user.id, user.fullName);
                              //         })
                              //     : null,
                            );
                          });
            },
            error: (err, stack) {
              return Center(child: Text(err.toString()));
            },
            loading: () => const Center(child: LoadingWidget()),
          ),
        ],
      ),
      floatingActionButton: anonymous
          ? null
          : usersState.maybeWhen(
              data: (list) {
                if (list.isNotEmpty) {
                  return FloatingActionButton(
                    child: const Icon(Icons.import_export),
                    onPressed: () async {
                      // final activity = eventState.asData!.value;
                      // final event = activity.copyWith(id: Uuid().v4());
                      // await Cloud.activitiesCollection.doc(activity.id)
                      // .collection('events')
                      //     .doc(event.id)
                      //     .set(event.toJson());
                      // final batch = FirebaseFirestore.instance.batch();
                      // for (final user in list) {
                      //   batch.set(
                      //       Cloud.activitiesCollection
                      //           .doc(activity.id)
                      //           .collection('events')
                      //           .doc('47969dfe-038c-406a-8bf6-a9cec914391d')
                      //           .collection('users')
                      //           .doc(user.id),
                      //       user.toJson());
                      // }
                      // batch.commit();
                      // return;
                      if (hasData) {
                        final list = (usersState as AsyncData).value;
                        showDialog(
                            context: context,
                            builder: (c) => const LoadingWidget(),
                            barrierDismissible: false);
                        final file = await getCsv(
                            list, eventState.asData?.value.name ?? 'event_csv');
                        if (mounted) {
                          Navigator.of(context).pop();
                          if (file != null) {
                            Share.shareFiles([file.path]);
                          } else {
                            showToast('Si è verificato un errore!',
                                position: ToastPosition.bottom);
                          }
                        }
                      }
                    },
                  );
                }
                return const SizedBox.shrink();
              },
              orElse: () => const SizedBox.shrink(),
            ),
    );
  }

  _deleteUser(String userId, String name) async {
    final answer = await showDialog(
        context: context,
        builder: (c) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Sicuro di voler eliminare l\'utente $name?',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(c).pop();
                          },
                          child: const Text('Annulla')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(c).pop(true);
                          },
                          child: const Text('Sì'))
                    ],
                  ),
                ],
              ),
            ),
          );
        });
    if (answer ?? false) {
      Cloud.eventUsersCollection(
              EventIds(providerId: widget.providerId, eventId: widget.eventId))
          .doc(userId)
          .delete();
    }
  }

  Future<File?> getCsv(List<EventUser> users, String eventName) async {
    try {
      final filename = eventName.replaceAll(' ', '_').toLowerCase();
      final statuses = await [
        Permission.storage,
      ].request();
      if (await Permission.storage.request().isGranted) {
        final dir =
            (await getExternalStorageDirectory())!.path + "/$filename.csv";

        final f = File(dir);

        final data = users.map((e) => e.toCsvList()).toList();
        final csv = const ListToCsvConverter().convert(data);
        await f.writeAsString(csv);
        return f;
      }
      return null;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  List<PieChartSectionData> showingSections(int m, int f, int nB, int na) {
    final total = m + f + na;
    final mPercentage = m / total * 100;
    final fPercentage = f / total * 100;
    final nbPercentage = nB / total * 100;
    final naPercentage = na / total * 100;
    return List.generate(4, (i) {
      // final isTouched = i == touchedIndex;
      final isTouched = false;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: mPercentage,
            title: '${mPercentage.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget:
                CircleAvatar(radius: 20, child: const Icon(Icons.male)),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.pink,
            value: fPercentage,
            title: '${fPercentage.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget:
                CircleAvatar(radius: 20, child: const Icon(Icons.female)),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.green,
            value: nbPercentage,
            title: '${nbPercentage.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: Icon(Icons.female),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: Colors.grey,
            value: naPercentage,
            title: '${naPercentage.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: Icon(Icons.female),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw 'Oh no';
      }
    });
  }
}

/*class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.svgAsset, {
    Key? key,
    required this.size,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: SvgPicture.asset(
          svgAsset,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}*/
