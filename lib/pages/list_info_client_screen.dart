import 'package:flutter/material.dart';
import 'package:regiscater/constants/ui_constants.dart';

class ListClientScreen extends StatefulWidget {
  const ListClientScreen({super.key});

  @override
  State<ListClientScreen> createState() => _ListClientScreenState();
}

class _ListClientScreenState extends State<ListClientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: primaryColor,
        icon: const Icon(Icons.add),
        extendedIconLabelSpacing: 2,
        label: const Text(
          'Add client',
          style: TextStyle(fontSize: 9),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryColor),
        title: const Text(
          'Clientes',
          style: TextStyle(color: primaryColor, fontSize: 12),
        ),
        centerTitle: true,
      ),
    );
  }
}
