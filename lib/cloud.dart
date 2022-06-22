import 'package:cloud_firestore/cloud_firestore.dart';

class Cloud {


  static CollectionReference<Map<String, dynamic>> credentialsCollection =
      FirebaseFirestore.instance.collection('credentials');

  static CollectionReference<Map<String, dynamic>> eventsCollection(
          String activityId) =>
      activitiesCollection.doc(activityId).collection('events');

  // static final CollectionReference<Map<String, dynamic>> eventsCollection =
  //     FirebaseFirestore.instance.collection('events');

  static final CollectionReference<Map<String, dynamic>> activitiesCollection =
      FirebaseFirestore.instance.collection('activities');

  static CollectionReference<Map<String, dynamic>> usersCollection(
          String activityId,String eventId) =>
      eventsCollection(activityId).doc(eventId).collection('users');

  static DocumentReference<Map<String, dynamic>> eventDoc(String activityId, String eventId) =>
      eventsCollection(activityId).doc(eventId);
}
