import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:intl/intl.dart' show DateFormat;

class AudioRecord extends StatefulWidget {
  const AudioRecord({super.key});

  @override
  State<AudioRecord> createState() => _AudioRecordState();
}

class _AudioRecordState extends State<AudioRecord> {
  late FlutterSoundRecorder _recordingSession;
  final recordingPlayer = AssetsAudioPlayer();
  late String pathToAudio;
  bool _playAudio = false;
  String _timerText = '00:00:00';
  @override
  void initState() {
    super.initState();
    initializer();
  }

  void initializer() async {
    pathToAudio = '/sdcard/Download/temp.wav';
    _recordingSession = FlutterSoundRecorder();
    await _recordingSession.openRecorder();
    await _recordingSession.setSubscriptionDuration(Duration(milliseconds: 10));
    await initializeDateFormatting();
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  Future<void> startRecording() async {
    Directory directory = Directory(path.dirname(pathToAudio));
    if (!directory.existsSync()) {
      directory.createSync();
    }
    _recordingSession
        .openRecorder()
        .then((value) => print('value------>$value'));
    await _recordingSession.startRecorder(
      toFile: pathToAudio,
      codec: Codec.pcm16WAV,
    );
    StreamSubscription _recorderSubscription =
        _recordingSession.onProgress!.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
          isUtc: true);
      var timeText = DateFormat('mm:ss:SS', 'en_GB').format(date);
      setState(() {
        _timerText = timeText.substring(0, 8);
        log('time $timeText');
      });
    });
    _recorderSubscription.cancel();
  }

  Future<String> stopRecording() async {
    _recordingSession.closeRecorder();
    var callback = await _recordingSession.stopRecorder();
    return callback!;
  }

  Future<void> playFunc() async {
    recordingPlayer.open(
      Audio.file(pathToAudio),
      autoStart: true,
      showNotification: true,
    );
  }

  Future<void> stopPlayFunc() async {
    recordingPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(title: Text('Audio Recording and Playing')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Container(
              child: Center(
                child: Text(
                  _timerText,
                  style: TextStyle(fontSize: 70, color: Colors.red),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                createElevatedButton(
                  icon: Icons.mic,
                  iconColor: Colors.red,
                  onPressFunc: startRecording,
                ),
                SizedBox(
                  width: 30,
                ),
                createElevatedButton(
                  icon: Icons.stop,
                  iconColor: Colors.red,
                  onPressFunc: stopRecording,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              style:
                  ElevatedButton.styleFrom(elevation: 9.0, primary: Colors.red),
              onPressed: () {
                setState(() {
                  _playAudio = !_playAudio;
                });
                if (_playAudio) playFunc();
                if (!_playAudio) stopPlayFunc();
              },
              icon: _playAudio
                  ? Icon(
                      Icons.stop,
                    )
                  : Icon(Icons.play_arrow),
              label: _playAudio
                  ? Text(
                      "Stop",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    )
                  : Text(
                      "Play",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton createElevatedButton(
      {required IconData icon,
      required Color iconColor,
      required Function() onPressFunc}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(6.0),
        backgroundColor: Colors.white,
        side: BorderSide(
          color: Colors.red,
          width: 4.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 9.0,
      ),
      onPressed: onPressFunc,
      icon: Icon(
        icon,
        color: iconColor,
        size: 38.0,
      ),
      label: Text(''),
    );
  }
}
