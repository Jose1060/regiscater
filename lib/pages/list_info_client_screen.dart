import 'package:flutter/material.dart';
import 'package:regiscater/constants/ui_constants.dart';
import 'package:rive/rive.dart';

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
          'Clientes',
          style: TextStyle(color: primaryColor, fontSize: 12),
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
    );
  }
}
