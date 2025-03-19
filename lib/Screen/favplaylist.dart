import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects_sehatin/Screen/nowplaying.dart';

class PlaylistFavoritePage extends StatelessWidget {
  final List<Map<String, String>> favoriteSongs;
  final Function(Map<String, String>) onRemoveFavorite;

  const PlaylistFavoritePage(this.favoriteSongs, this.onRemoveFavorite, {super.key});

  void goToNowPlaying(BuildContext context, Map<String, String> song) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NowPlayingPage(song: song)),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: 
      AppBar(backgroundColor: Colors.transparent, elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context),),
        centerTitle: true,
        title: Text('Playlist Favorit', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),),),
      
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: favoriteSongs.isEmpty? 
        Center( child: Text("Belum ada lagu favorit", style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),),)
        
        : ListView.builder(itemCount: favoriteSongs.length, itemBuilder: (context, index) {
            var song = favoriteSongs[index];
            return Card(color: Colors.blueGrey[800], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile( onTap: () => goToNowPlaying(context, song), leading: Stack(alignment: Alignment.center,
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset(song['image']!, width: 50, height: 50, fit: BoxFit.cover,),),
                  Container(width: 50, height: 50, decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(10),),),
                  const Icon(Icons.play_arrow, color: Colors.white, size: 24,),
                ],
              ), 
                title: Text(song["title"]!, style: GoogleFonts.poppins(fontSize: 14, color: Colors.white)), subtitle: Text(song["duration"]!, style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70)),
                trailing: IconButton(icon: const Icon(Icons.favorite, color: Colors.red), onPressed: () {onRemoveFavorite(song); Navigator.pop(context);}),
              ),
            );
          },),
      ),
    );
  }
}
