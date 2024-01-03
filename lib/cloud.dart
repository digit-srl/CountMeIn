import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countmein/domain/entities/event_ids.dart';

class Cloud {
  static CollectionReference<Map<String, dynamic>> credentialsCollection =
      FirebaseFirestore.instance.collection('credentials');

  static CollectionReference<Map<String, dynamic>> providerRequests =
      FirebaseFirestore.instance.collection('providerRequests');

  static CollectionReference<Map<String, dynamic>> eventsCollection(
          String providerId) =>
      providerDoc(providerId).collection('events');

  static CollectionReference<Map<String, dynamic>> totemCollection(
    String providerId,
    String eventId,
  ) =>
      eventDoc( providerId, eventId)
          .collection('totems');

  static DocumentReference<Map<String, dynamic>> totemDoc(
    String providerId,
    String eventId,
    String totemId,
  ) =>
      totemCollection(providerId, eventId).doc(totemId);

  static DocumentReference<Map<String, dynamic>> providerDoc(
          String providerId) =>
      providerCollection.doc(providerId);

  static CollectionReference<Map<String, dynamic>> usersCollection(
          String providerId) =>
      providerDoc(providerId).collection('users');

  static final CollectionReference<Map<String, dynamic>> providerCollection =
      FirebaseFirestore.instance.collection('providers');

  static CollectionReference<Map<String, dynamic>> pendingInviteCollection(
          String providerId) =>
      providerDoc(providerId).collection('pendingInvite');

  static CollectionReference<Map<String, dynamic>> eventUsersCollection(
      EventIds ids) {
    if (ids.sessionId != null) {
      return sessionDoc(ids).collection('users');
    }
    return eventDoc(ids.providerId, ids.eventId).collection('users');
  }

  static CollectionReference<Map<String, dynamic>> sessionCollection(
      EventIds ids) {
    return eventDoc(ids.providerId, ids.eventId).collection('sessions');
  }

  static DocumentReference<Map<String, dynamic>> sessionDoc(EventIds ids) =>
      sessionCollection(ids).doc(ids.sessionId);

  static DocumentReference<Map<String, dynamic>> eventDoc(
          String providerId, String eventId) =>
      eventsCollection(providerId).doc(eventId);

  static DocumentReference<Map<String, dynamic>> userProfileDoc(
          String providerId, String userId) =>
      usersCollection(providerId).doc(userId);
}
