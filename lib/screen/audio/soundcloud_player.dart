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
        'https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/playlists/1722264573%3Fsecret_token%3Ds-4EbLMOtkPZI&color=%23ff5500&auto_play=true&hide_related=false&show_comments=true&show_user=tru';
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
