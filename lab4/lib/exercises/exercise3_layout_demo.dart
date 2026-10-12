import 'package:flutter/material.dart';

class MovieItem {
  final String title;
  final String description;

  const MovieItem({
    required this.title,
    required this.description,
  });

  String get initial => title.isNotEmpty ? title[0].toUpperCase() : '?';
}

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  static const List<MovieItem> _movies = [
    MovieItem(title: 'Avatar', description: 'Sample description'),
    MovieItem(title: 'Inception', description: 'Sample description'),
    MovieItem(title: 'Interstellar', description: 'Sample description'),
    MovieItem(title: 'Joker', description: 'Sample description'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3 – Layout Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'Now Playing',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  final movie = _movies[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.indigo.shade100,
                            child: Text(
                              movie.initial,
                              style: TextStyle(
                                color: Colors.indigo.shade900,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          title: Text(
                            movie.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            movie.description,
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
