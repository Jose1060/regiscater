import 'package:cloud_firestore/cloud_firestore.dart';

class Clients {
  final String? id;
  final String name;
  final String gender;
  final int dni;
  final String email;
  final String civil;
  final int phone;
  final int age;

  Clients(
      {this.id,
      required this.name,
      required this.gender,
      required this.civil,
      required this.dni,
      required this.email,
      required this.phone,
      required this.age});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'email': email,
      'phone': phone,
      'dni': dni,
      'gender': gender,
      'timestamp': Timestamp.now(),
      'civil': civil,
    };
  }

  Clients.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        name = doc.data()!["name"],
        age = doc.data()!["age"],
        email = doc.data()!["salary"],
        phone = doc.data()!['phone'],
        dni = doc.data()!["dni"],
        gender = doc.data()!["gender"],
        civil = doc.data()!["gender"];
}
