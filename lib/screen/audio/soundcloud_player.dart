import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SoundCloudPlayer extends StatefulWidget {
  @override
  _SoundCloudPlayerState createState() => _SoundCloudPlayerState();
}

class _SoundCloudPlayerState extends State<SoundCloudPlayer> {
  AudioPlayer audioPlayer = AudioPlayer();

  playSoundCloudAudio() async {
    String soundCloudUrl =
        'https://soundcloud.com/boichitro/t5nvdxnpqyvb/s-J6UDxKcmkx0?in=boichitro/sets/areak-falgun-zahir-raihan/s-4EbLMOtkPZI&si=ea2b7b9931554e21a16a083c9b781295&utm_source=clipboard&utm_medium=text&utm_campa';
    int result = await audioPlayer.play(soundCloudUrl);
    if (result == 1) {
      // success
      print('Playing');
    } else {
      // some error occurred
      print('Error playing SoundCloud audio');
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          playSoundCloudAudio();
        },
        child: Text('Play SoundCloud Audio'),
      ),
    );
  }
}
