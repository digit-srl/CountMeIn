import 'package:cloud_firestore/cloud_firestore.dart';

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

  static CollectionReference<Map<String, dynamic>> eventUsersCollection(
          String providerId, String eventId) =>
      eventsCollection(providerId).doc(eventId).collection('users');

  static DocumentReference<Map<String, dynamic>> eventDoc(
          String providerId, String eventId) =>
      eventsCollection(providerId).doc(eventId);
}
