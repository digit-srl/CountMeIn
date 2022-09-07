import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countmein/domain/entities/event_ids.dart';

class Cloud {
  static CollectionReference<Map<String, dynamic>> credentialsCollection =
      FirebaseFirestore.instance.collection('credentials');

  static CollectionReference<Map<String, dynamic>> providerRequests =
      FirebaseFirestore.instance.collection('providerRequests');

  static CollectionReference<Map<String, dynamic>> eventsCollection(
          String providerId) =>
      providerCollection.doc(providerId).collection('events');

  static final CollectionReference<Map<String, dynamic>> usersCollection =
      FirebaseFirestore.instance.collection('users');

  static final CollectionReference<Map<String, dynamic>> providerCollection =
      FirebaseFirestore.instance.collection('providers');

  static CollectionReference<Map<String, dynamic>> pendingInviteCollection(
          String providerId) =>
      providerCollection.doc(providerId).collection('pendingInvite');

  static CollectionReference<Map<String, dynamic>> eventUsersCollection(
      EventIds ids) {
    if (ids.subEventId != null) {
      return eventsCollection(ids.providerId)
          .doc(ids.eventId)
          .collection('subEvents')
          .doc(ids.subEventId)
          .collection('users');
    }
    return eventsCollection(ids.providerId)
        .doc(ids.eventId)
        .collection('users');
  }

  static DocumentReference<Map<String, dynamic>> eventDoc(
          String providerId, String eventId) =>
      eventsCollection(providerId).doc(eventId);

  static DocumentReference<Map<String, dynamic>> userProfileDoc(
          String userId) =>
      usersCollection.doc(userId);
}
