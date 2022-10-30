import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:regiscater/models/client.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addEmployee(Clients ClientData) async {
    await _db.collection("Clients").add(ClientData.toMap());
  }

  updateClient(Clients ClientData) async {
    await _db
        .collection("Clients")
        .doc(ClientData.id)
        .update(ClientData.toMap());
  }

  Future<void> deleteClient(String documentId) async {
    await _db.collection("Clients").doc(documentId).delete();
  }

  Future<List<Clients>> retrieveClients() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Clients").get();
    return snapshot.docs
        .map((docSnapshot) => Clients.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}
