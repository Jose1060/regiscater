import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:regiscater/constants/ui_constants.dart';
import 'package:rive/rive.dart';
import 'package:timeago/timeago.dart' as timeago;

class ClientReader extends StatefulWidget {
  final QueryDocumentSnapshot doc;
  const ClientReader(this.doc, {super.key});

  @override
  State<ClientReader> createState() => _ClientReaderState();
}

class _ClientReaderState extends State<ClientReader> {
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
    var re = widget.doc['gender'];
    IconData genderIcon;

    if (re == 'Male') {
      genderIcon = Icons.male;
    } else if (re == 'Female') {
      genderIcon = Icons.female;
    } else {
      genderIcon = Icons.person;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryColor),
        title: Text(
          widget.doc['name'],
          style: const TextStyle(color: primaryColor, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: SizedBox(
                    height: 180,
                    width: 180,
                    child: RiveAnimation.asset(
                      'lib/assets/rive/avatar.riv',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: const Icon(Icons.person)),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Created at \n${timeago.format(widget.doc['timestamp'].toDate())}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          backgroundColor: Colors.purple[400],
                        ));
                      },
                      child: SizedBox(
                        width: 280,
                        child: Text(
                          widget.doc['name'],
                          style: const TextStyle(fontSize: 30),
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Click on the name to see the registration date',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Personal data',
                  style: AppStyle.separatorText,
                ),
                Divider(
                  color: Colors.grey[500],
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: const Icon(Icons.alarm_rounded)),
                    Text(
                      widget.doc['age'].toString(),
                      style: AppStyle.dataText,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: const Icon(Icons.card_membership)),
                    Text(
                      widget.doc['dni'].toString(),
                      style: AppStyle.dataText,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: Icon(genderIcon)),
                    Text(
                      widget.doc['gender'],
                      style: AppStyle.dataText,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: const Icon(Icons.cake_sharp)),
                    Text(
                      widget.doc['civil'],
                      style: AppStyle.dataText,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Contact',
                  style: AppStyle.separatorText,
                ),
                Divider(
                  color: Colors.grey[500],
                  height: 10,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: const Icon(Icons.email)),
                    Text(
                      widget.doc['email'],
                      style: AppStyle.dataText,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: const Icon(Icons.phone)),
                    Text(
                      widget.doc['phone'].toString(),
                      style: AppStyle.dataText,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
