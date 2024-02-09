import 'package:countmein/domain/entities/user_card.dart';
import 'package:countmein/src/admin/domain/entities/cmi_event.dart';
import 'package:countmein/src/admin/ui/widgets/gender_card.dart';
import 'package:countmein/src/totem/ui/embedded_screen.dart';
import 'package:countmein/ui/screens/admin_user_details.dart';
import 'package:countmein/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UsersListWidget extends ConsumerWidget {
  final GenderCount? genderCount;
  final bool anonymous;
  final AsyncValue<List<EventUser>> usersState;

  const UsersListWidget({
    super.key,
    this.genderCount,
    required this.usersState,
    required this.anonymous,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // if ((eventOrSessionClosed ?? false) &&
        //     genderCount != null &&
        //     genderCount.total > 3)
        if (genderCount != null) GenderCard(genderCount: genderCount!),
        const SizedBox(height: 8),
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 48),
                        itemBuilder: (c, index) {
                          final user = list[index];
                          return ListTile(
                            onTap: () {
                              context.push(UserDetailsScreen.routeName,
                                  extra: user);
                            },
                            title: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  user.isGroup
                                      ? user.groupName ?? 'Gruppo'
                                      : anonymous
                                          ? user.id
                                          : user.fullName,
                                ),
                                if (user.isGroup)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Chip(
                                      label: Text(
                                        'GROUP',
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                      backgroundColor: Colors.green,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 0,
                                        vertical: 0,
                                      ),
                                      labelPadding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 0,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            subtitle: user.isGroup
                                ? Text(
                                    '${user.groupCount} persone',
                                    style: Theme.of(context).textTheme.caption,
                                  )
                                : anonymous
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
                                    message: dateFormat.format(user.checkInAt!),
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
                                  ),
                                if (user.participationCount != null)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                        '[${user.participationCount} presenze]'),
                                  ),
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
                        },
                      );
          },
          error: (err, stack) {
            return Center(child: Text(err.toString()));
          },
          loading: () => const Center(child: LoadingWidget()),
        ),
      ],
    );
  }
}
