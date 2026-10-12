// Lab 6.3 – Responsive Movie List & Tablet Layout
import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieGridList extends StatelessWidget {
  final List<Movie> movies;

  const MovieGridList({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const Center(
        child: Text(
          'No movies found matching your criteria.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    // Step 8: Responsive LayoutBuilder (maxWidth < 800: ListView, else: GridView.count)
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          // Phone: single-column vertical list
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 100,
                child: MovieCard(movie: movies[index]),
              );
            },
          );
        } else {
          // Tablet / Wide screen: two-column grid
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 3.2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: movies.map((movie) => MovieCard(movie: movie)).toList(),
          );
        }
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    // Step 8: LayoutBuilder inside movie card to adjust poster size based on item width
    return LayoutBuilder(
      builder: (context, constraints) {
        final posterWidth = constraints.maxWidth > 500 ? 110.0 : 80.0;

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              // Movie Poster
              Image.network(
                movie.posterUrl,
                width: posterWidth,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: posterWidth,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.movie, color: Colors.grey),
                  );
                },
              ),
              // Movie Info (Title, Year, Genres, Rating)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${movie.year} • ${movie.genres.join(', ')}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rating: ${movie.rating} / 10',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
