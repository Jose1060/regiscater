import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:regiscater/models/client.dart';
import 'package:regiscater/pages/read_client.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addEmployee(Clients ClientData, BuildContext context) async {
    await _db
        .collection("Clients")
        .add(ClientData.toMap())
        .then((value) => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text(
                  'Saved',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green[400],
              ))
            })
        .then((value) => Navigator.pop(context))
        .catchError((error) => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Error al subir $error",
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red[400],
              ))
            });
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
