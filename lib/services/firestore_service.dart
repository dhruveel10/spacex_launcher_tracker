import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/launch.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveLaunch(Launch launch) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).collection('savedLaunches').doc(launch.id).set({
          'id': launch.id,
          'name': launch.name,
          'dateUtc': launch.dateUtc,
          'rocket': launch.rocket,
          'launchpad': launch.launchpad,
          'imageUrl': launch.imageUrl,
          'missionDetails': launch.missionDetails,
          'webcastLink': launch.webcastLink,
        });
      }
    } catch (e) {
      print('Error saving launch: $e');
    }
  }

  Future<void> unsaveLaunch(Launch launch) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).collection('savedLaunches').doc(launch.id).delete();
      }
    } catch (e) {
      print('Error unsaving launch: $e');
    }
  }

  Stream<List<Launch>> getSavedLaunches() {
    final user = _auth.currentUser;
    if (user != null) {
      return _firestore.collection('users').doc(user.uid).collection('savedLaunches').snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => _launchFromFirestore(doc.data())).toList());
    } else {
      return Stream.empty();
    }
  }

  Launch _launchFromFirestore(Map<String, dynamic> data) {
    return Launch(
      id: data['id'],
      name: data['name'],
      dateUtc: (data['dateUtc'] as Timestamp).toDate(),
      rocket: data['rocket'],
      launchpad: data['launchpad'],
      imageUrl: data['imageUrl'],
      missionDetails: data['missionDetails'],
      webcastLink: data['webcastLink'],
    );
  }

  Future<bool> isLaunchSaved(Launch launch) async {
    final user = _auth.currentUser;
    if (user != null) {
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('savedLaunches')
          .doc(launch.id)
          .get();
      return snapshot.exists;
    } else {
      return false;
    }
  }
}
