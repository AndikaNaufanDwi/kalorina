import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:projects_sehatin/Screen/favplaylist.dart';
import 'package:projects_sehatin/Screen/nowplaying.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Playlist extends StatefulWidget {
  const Playlist({super.key});

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  List<Map<String, String>> allSongs = [];
  List<Map<String, String>> favoriteSongs = [];
  final String baseUrl = "http://127.0.0.1:5000";

    String? _accessToken;

  Future<void> fetchFavoriteSongs() async {
    final url = Uri.parse("$baseUrl/lagu/favorite");

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_accessToken", // Pastikan JWT dikirimkan
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        favoriteSongs = data.map<Map<String, String>>((song) {
          return {
            "title": song["title"],
            "id": song["id"],
            "duration": "00:00",
            "image": song["image"],
            "link": song["link"],
          };
        }).toList(); // Update UI jika pakai Provider
      } else {
        print("Error: ${response.body}");
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }

  Future<void> _loadAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _accessToken = prefs.getString('access_token');
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAccessToken();
    fetchSongs();
    fetchFavoriteSongs();
  }

  Future<void> fetchSongs() async {
    final String baseUrl = "http://127.0.0.1:5000/lagu";
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
setState(() {
  allSongs = data.map((song) {
    return {
      'title': song['judul'].toString(),
      'id': song['id'].toString(),
      'duration': '00:00',
      'image': song['gambar'].toString(),
      'link': song['link'].toString(),
    };
  }).toList().cast<Map<String, String>>(); // Cast ke List<Map<String, String>>
});

      } else {
        throw Exception("Failed to load songs");
      }
    } catch (e) {
      print("Error fetching songs: $e");
    }
  }


Future<void> addFavorite(int makananId) async {
    if (_accessToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Token tidak tersedia, silakan login ulang!")),
      );
      return;
    }

    final url = Uri.parse('http://127.0.0.1:5000/lagu/$makananId/like');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_accessToken',
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Berhasil menambahkan ke favorit!")),
        );
         Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaylistFavoritePage(favoriteSongs, removeFromFavorite),
      ),
    );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal menambahkan ke favorit: ${response.body}")),
        );
        print(response.body);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    }
  }

  void removeFromFavorite(Map<String, String> song) {
    setState(() {
      favoriteSongs.remove(song);
    });
  }

  void goToFavoritePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaylistFavoritePage(favoriteSongs, removeFromFavorite),
      ),
    );
  }

  void goToNowPlaying(BuildContext context, Map<String, String> song) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NowPlayingPage(song: song),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
          automaticallyImplyLeading: false, // Menghilangkan tombol back

        title: Text(
          'Musik Tidur',
          style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 3.5 / 100),
        ),
        backgroundColor: Colors.blueGrey[900],
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Eksplor Lebih Lengkap',
              style: TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Tidur lebih nyenyak dengan lagu santai',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: allSongs.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: allSongs.length,
                      itemBuilder: (context, index) {
                        final song = allSongs[index];
                        final isFavorite = favoriteSongs.contains(song);
                        return _buildPlaylistItem(song, isFavorite);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String text, bool isActive) {
    return ElevatedButton(
      onPressed: () {
        if (text == 'Favorit') {
          goToFavoritePage();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.tealAccent[700] : Colors.blueGrey[700],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        text,
        style: TextStyle(color: isActive ? Colors.black : Colors.white),
      ),
    );
  }

  Widget _buildPlaylistItem(Map<String, String> song, bool isFavorite) {
    return Card(
      color: Colors.blueGrey[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        onTap: () => goToNowPlaying(context, song),
        leading: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                song['image']!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const Icon(Icons.play_arrow, color: Colors.white, size: 24),
          ],
        ),
        title: Text(song['title']!,
            style: const TextStyle(color: Colors.white, fontSize: 14)),
        subtitle: Text(song['duration']!,
            style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ),
    );
  }
}