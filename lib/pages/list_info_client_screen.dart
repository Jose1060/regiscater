import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regiscater/constants/ui_constants.dart';
import 'package:regiscater/pages/read_client.dart';
import 'package:regiscater/widgets/client_card.dart';
import 'package:rive/rive.dart';
import 'package:timeago/timeago.dart' as timeago;

class ListClientScreen extends StatefulWidget {
  const ListClientScreen({super.key});

  @override
  State<ListClientScreen> createState() => _ListClientScreenState();
}

class _ListClientScreenState extends State<ListClientScreen> {
  /// Controller for playback
  late RiveAnimationController _controller;

  /// Is the animation currently playing?
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = OneShotAnimation(
      'happy',
      autoplay: false,
      onStop: () => setState(() => _isPlaying = false),
      onStart: () => setState(() => _isPlaying = true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: primaryColor,
        icon: const SizedBox(
          height: 55,
          width: 55,
          child: RiveAnimation.asset(
            'lib/assets/rive/white_pencil.riv',
            fit: BoxFit.cover,
          ),
        ),
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
          'Clients',
          style: TextStyle(color: primaryColor, fontSize: 15),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SizedBox(
              height: 55,
              width: 55,
              child: RiveAnimation.asset(
                'lib/assets/rive/avatar.riv',
                animations: const ['idle', 'curves'],
                controllers: [_controller],
              ),
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Happy!!')));
              _isPlaying ? null : _controller.isActive = true;
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Clients',
              style: GoogleFonts.roboto(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Clients')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasData) {
                    return GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      children: snapshot.data!.docs
                          .map((client) => clientCard(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ClientReader(client),
                                    ));
                              }, client))
                          .toList(),
                    );
                  }

                  return Text(
                    'There´s no Clients',
                    style: GoogleFonts.nunito(color: Colors.grey[500]),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
