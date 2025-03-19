import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:projects_sehatin/Screen/playlist.dart';

class NowPlayingPage extends StatefulWidget {
  final Map<String, String> song;

  const NowPlayingPage({super.key, required this.song});

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  double currentTime = 0;
  double totalTime = 0;

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      await _audioPlayer.setUrl(widget.song['link']!);
      totalTime = _audioPlayer.duration?.inSeconds.toDouble() ?? 0;
      setState(() {});
      _audioPlayer.positionStream.listen((position) {
        setState(() {
          currentTime = position.inSeconds.toDouble();
        });
      });
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  void togglePlayPause() {
    if (isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Playlist())),
        ),
        centerTitle: true,
        title: Text(
          "Putar Sekarang",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.song['image']!,
                width: 300,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.song['title']!,
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Slider(
              value: currentTime,
              min: 0,
              max: totalTime,
              activeColor: Colors.tealAccent[700],
              inactiveColor: Colors.white30,
              onChanged: (value) {
                _audioPlayer.seek(Duration(seconds: value.toInt()));
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${(currentTime ~/ 60).toString().padLeft(2, '0')}:${(currentTime % 60).toString().padLeft(2, '0')}",
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  Text(
                    "${(totalTime ~/ 60).toString().padLeft(2, '0')}:${(totalTime % 60).toString().padLeft(2, '0')}",
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: togglePlayPause,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.tealAccent[700],
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 40,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
            
              ],
            ),
          ],
        ),
      ),
    );
  }
}
