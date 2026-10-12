import 'package:flutter/material.dart';
import '../models/movie.dart';

// Step 4: Build Movie Detail Screen
class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      backgroundColor: Colors.white,
      // Step 4.1: Blank Scaffold + AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          movie.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step 4.2: Hero Banner (Stack + Image.network + gradient)
            Stack(
              children: [
                Image.network(
                  movie.posterUrl,
                  width: double.infinity,
                  height: 210,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 210,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.movie, size: 50, color: Colors.grey),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0xD9000000)],
                        stops: [0.55, 1.0],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 12,
                  child: Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // Step 4.3: Title & Genres (Column + Wrap + Chip)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
              child: Wrap(
                spacing: 8,
                children: movie.genres.map((genre) {
                  return Chip(
                    label: Text(
                      genre,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 13,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Step 4.4: Overview text with Padding
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Text(
                movie.overview,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ),

            // Step 4.5: Row of IconButtons (Favorite, Rate, Share)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: _isFavorite
                              ? Colors.red
                              : Colors.grey.shade800,
                        ),
                        const SizedBox(height: 4),
                        const Text('Favorite', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(Icons.star, color: Colors.grey.shade800),
                        const SizedBox(height: 4),
                        const Text('Rate', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(Icons.share, color: Colors.grey.shade800),
                        const SizedBox(height: 4),
                        const Text('Share', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Step 4.6: Trailer list using ListView.builder
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'Trailers',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: movie.trailers.length,
              itemBuilder: (context, index) {
                final trailer = movie.trailers[index];
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.play_circle_fill,
                        color: Colors.grey.shade800,
                      ),
                      title: Text(trailer.title),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      onTap: () {},
                    ),
                    Divider(
                      height: 1,
                      indent: 16,
                      color: Colors.grey.shade300,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
