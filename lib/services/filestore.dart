// Step 5: Make a filestore service
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference persons = FirebaseFirestore.instance.collection(
    'persons',
  );

  // Create
  Future<void> addPerson(String personName, String personEmail, int personAge) {
    return persons.add({
      'personName': personName,
      'personEmail': personEmail,
      'personAge': personAge,
      'timeStamp': Timestamp.now(),
    });
  }

  // Read
  Stream<QuerySnapshot> getPersons() {
    return persons.orderBy('timeStamp', descending: true).snapshots();
  }

  // Get by id
  Future<Map<String, dynamic>> getPersonById(String personId) async {
    final doc = await persons.doc(personId).get();
    return (doc.data() as Map<String, dynamic>?) ?? {};
  }

  // Update
  Future<void> updatePerson(
    String personID,
    String personName,
    String personEmail,
    int personAge,
  ) {
    return persons.doc(personID).update({
      'personName': personName,
      'personEmail': personEmail,
      'personAge': personAge,
      'timestamp': Timestamp.now(),
    });
  }

  // Delete
  Future<void> deletePerson(String personId) {
    return persons.doc(personId).delete();
  }
}
