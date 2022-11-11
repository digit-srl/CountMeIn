// import 'package:countmein/my_logger.dart';
// import 'package:countmein/src/admin/application/events_stream.dart';
// import 'package:countmein/src/admin/ui/screens/new_event.dart';
// import 'package:countmein/src/auth/domain/entities/user.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:oktoast/oktoast.dart';
//
// import '../../cloud.dart';
// import '../../constants.dart';
// import '../../domain/entities/cmi_provider.dart';
// import '../../src/auth/application/auth_notifier.dart';
// import '../../utils.dart';
// import '../widgets/loading.dart';
// import 'admin.dart';
// import 'event_details.dart';
//
// final activitiesStreamProvider =
//     StreamProvider.family<List<CMIProvider>, String>((ref, userId) async* {
//   logger.i('get acttivities for userId: $userId');
//   final stream = Cloud.providerCollection
//       .where('status', isEqualTo: enumToString(CMIProviderStatus.live))
//       .where('managers', arrayContains: userId)
//       .snapshots();
//
//   await for (final snap in stream) {
//     final list = snap.docs.map((doc) {
//       final s = CMIProvider.fromJson(doc.data());
//       return s;
//     }).toList();
//     yield list;
//   }
// });
//
// class ActivityRequest {
//   final String userId;
//   final String activityId;
//
//   ActivityRequest(this.userId, this.activityId);
// }
//
// /*final activityProvider =
//     Provider.family<AsyncValue<Activity>, ActivityRequest>((ref, request) {
//   return ref.watch(activitiesStreamProvider(request.userId)).whenData((value) =>
//       value.firstWhere((element) => element.id == request.activityId));
// });*/
//
// class ActivitiesScreen extends ConsumerWidget {
//   final String userId;
//
//   const ActivitiesScreen({
//     Key? key,
//     required this.userId,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final activitiesState = ref.watch(activitiesStreamProvider(userId));
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Attività'),
//         /* actions: [
//           if (isMaster)
//             IconButton(
//                 icon: const Icon(Icons.add),
//                 onPressed: () async {
//                   showDialog(
//                       context: context,
//                       builder: (c) {
//                         return Dialog(
//                           child: AddSessionDialog(),
//                         );
//                       });
//                 }),
//         ],*/
//       ),
//       body: activitiesState.when(
//         data: (list) {
//           if (list.isEmpty) {
//             return const Center(
//               child: Text('Non ci sono eventi attivi'),
//             );
//           }
//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: list.length,
//             itemBuilder: (c, index) {
//               final provider = list[index];
//               return ListTile(
//                 title: Text(
//                   provider.name,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//                 subtitle: Text(provider.id),
//                 // leading: Text('${index + 1}'),
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (c) => ActivityScreen(
//                         providerId: provider.id,
//                         providerName: provider.name,
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//         error: (err, stack) {
//           return Text(err.toString());
//         },
//         loading: () => const LoadingWidget(),
//       ),
//     );
//   }
// }
//
// class ActivityScreen extends ConsumerStatefulWidget {
//   final String providerId;
//   final String providerName;
//
//   const ActivityScreen({
//     Key? key,
//     required this.providerId,
//     required this.providerName,
//   }) : super(key: key);
//
//   @override
//   ConsumerState<ActivityScreen> createState() => _ActivityScreenState();
// }
//
// class _ActivityScreenState extends ConsumerState<ActivityScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final eventsState = ref.watch(eventsStreamProvider(widget.providerId));
//     final userRole = ref.watch(userRoleProvider(widget.providerId));
//     final isOwner = userRole == UserRole.admin;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.providerName),
//         actions: [
//           if (isOwner)
//             IconButton(
//               icon: const Icon(Icons.add),
//               onPressed: () async {
//                 context.push(
//                   '${NewEventFormScreen.routeName}/${widget.providerId}',
//                 );
//                 /* showDialog(
//                       context: context,
//                       builder: (c) {
//                         return Dialog(
//                           child: AddSessionDialog(
//                             activityId: widget.activityId,
//                           ),
//                         );
//                       });*/
//               },
//             ),
//           IconButton(
//               icon: const Icon(Icons.copy),
//               onPressed: () {
//                 Clipboard.setData(ClipboardData(
//                     text: '$baseUrl/provider/${widget.providerId}'));
//                 showToast('Url evento copiato negli appunti',
//                     position: ToastPosition.bottom);
//               }),
//         ],
//       ),
//       body: eventsState.when(
//         data: (list) {
//           if (list.isEmpty) {
//             return const Center(
//               child: Text('Non ci sono eventi attivi'),
//             );
//           }
//           return ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: list.length,
//               itemBuilder: (c, index) {
//                 final event = list[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(vertical: 8),
//                   child: ListTile(
//                     title: Text(event.name),
//                     subtitle: isOwner
//                         ? Row(
//                             children: [
//                               const Text('Aperto'),
//                               Switch(
//                                 value: event.isOpen,
//                                 onChanged: (bool value) async {
//                                   if (!value) {
//                                     final answer = await ask(context,
//                                         'Vuoi chiudere l\'evento ${event.name}');
//                                     if (answer ?? false) {
//                                       Cloud.eventDoc(
//                                               widget.providerId, event.id)
//                                           .update({'isOpen': value});
//                                     }
//                                   } else {
//                                     Cloud.eventDoc(widget.providerId, event.id)
//                                         .update({'isOpen': value});
//                                   }
//                                 },
//                               ),
//                               const Spacer(),
//                               IconButton(
//                                 icon: const Icon(Icons.delete),
//                                 color: Colors.red,
//                                 onPressed: () {
//                                   _deleteEvent(context, widget.providerId,
//                                       event.id, event.name);
//                                 },
//                               ),
//                             ],
//                           )
//                         : null,
//                     // subtitle: Text(
//                     //   event.id,
//                     //   style: Theme.of(context).textTheme.caption,
//                     // ),
//                     leading: Text('${index + 1}'),
//                     /*trailing: isOwner
//                         ?
//                               IconButton(
//                                 icon: const Icon(Icons.delete),
//                                 color: Colors.red,
//                                 onPressed: () {
//                                   _deleteEvent(context, widget.providerId,
//                                       event.id, event.name);
//                                 },
//                               )
//
//                         : null,*/
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (c) => EventDetailsScreen(
//                             providerId: widget.providerId,
//                             eventId: event.id,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               });
//         },
//         error: (err, stack) {
//           return Text(err.toString());
//         },
//         loading: () => const LoadingWidget(),
//       ),
//     );
//   }
//
//   _deleteEvent(
//     BuildContext context,
//     String providerId,
//     String eventId,
//     String eventName,
//   ) async {
//     final answer = await ask(context, 'Vuoi eliminare l\'evento $eventName');
//     if (answer ?? false) {
//       try {
//         await Cloud.eventDoc(providerId, eventId).delete();
//       } catch (ex) {
//         logger.i(ex);
//       }
//     }
//   }
// }
