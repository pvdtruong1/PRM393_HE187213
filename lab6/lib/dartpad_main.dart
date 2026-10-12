// ============================================================================
// Lab 6 – Building a Responsive Movie Genre Browsing Screen (DartPad Single File)
// ============================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveMovieApp());
}

// Step 2: Define Data Model
class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  const Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

// Step 2: Sample Data
const List<String> allGenres = [
  'Action',
  'Adventure',
  'Animation',
  'Comedy',
  'Drama',
  'Sci-Fi',
];

const List<Movie> allMovies = [
  Movie(
    title: 'Inception',
    year: 2010,
    genres: ['Action', 'Sci-Fi'],
    posterUrl: 'https://images.unsplash.com/photo-1534447677768-be436bb09401?w=800',
    rating: 8.8,
  ),
  Movie(
    title: 'The Dark Knight',
    year: 2008,
    genres: ['Action', 'Drama'],
    posterUrl: 'https://images.unsplash.com/photo-1509281373149-e957c6296406?w=800',
    rating: 9.0,
  ),
  Movie(
    title: 'Interstellar',
    year: 2014,
    genres: ['Adventure', 'Drama', 'Sci-Fi'],
    posterUrl: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800',
    rating: 8.7,
  ),
  Movie(
    title: 'Parasite',
    year: 2019,
    genres: ['Comedy', 'Drama'],
    posterUrl: 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=800',
    rating: 8.5,
  ),
  Movie(
    title: 'Spirited Away',
    year: 2001,
    genres: ['Animation', 'Adventure'],
    posterUrl: 'https://images.unsplash.com/photo-1579783902614-a3fb3927b675?w=800',
    rating: 8.6,
  ),
  Movie(
    title: 'Coco',
    year: 2017,
    genres: ['Animation', 'Comedy'],
    posterUrl: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800',
    rating: 8.4,
  ),
];

// Step 3: Build the Base Scaffold
class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Movie Genre Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GenreScreen(),
    );
  }
}

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  // Step 4: State for search query
  String _searchQuery = '';

  // Step 5: State for selected genres
  final Set<String> _selectedGenres = {};

  // Step 6: State for selected sort option
  String _selectedSort = 'A-Z';

  // Step 7: Filter and Sort the Movie List
  List<Movie> get _visibleMovies {
    final filtered = allMovies.where((movie) {
      final matchesSearch = movie.title.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      final matchesGenre = _selectedGenres.isEmpty ||
          movie.genres.any((genre) => _selectedGenres.contains(genre));
      return matchesSearch && matchesGenre;
    }).toList();

    filtered.sort((a, b) {
      switch (_selectedSort) {
        case 'Z-A':
          return b.title.compareTo(a.title);
        case 'Year':
          return b.year.compareTo(a.year);
        case 'Rating':
          return b.rating.compareTo(a.rating);
        case 'A-Z':
        default:
          return a.title.compareTo(b.title);
      }
    });

    return filtered;
  }

  void _onGenreToggled(String genre) {
    setState(() {
      if (_selectedGenres.contains(genre)) {
        _selectedGenres.remove(genre);
      } else {
        _selectedGenres.add(genre);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Lab 6.1 – Responsive Hero & Heading Section
              const HeroSection(),
              const SizedBox(height: 8),

              // Lab 6.2 – Search, Genre Chips & Sort Bar
              FilterSection(
                searchQuery: _searchQuery,
                onSearchChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                genres: allGenres,
                selectedGenres: _selectedGenres,
                onGenreToggled: _onGenreToggled,
                selectedSort: _selectedSort,
                onSortChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedSort = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 12),

              // Lab 6.3 – Responsive Movie List & Tablet Layout
              Expanded(
                child: MovieGridList(movies: _visibleMovies),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Lab 6.1 – Responsive Hero & Heading Section
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth >= 800;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find a Movie',
            style: TextStyle(
              fontSize: isWideScreen ? 32 : 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Explore movies by genre, title, and year',
            style: TextStyle(
              fontSize: isWideScreen ? 16 : 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

// Lab 6.2 – Search, Genre Chips & Sort Bar
class FilterSection extends StatelessWidget {
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final List<String> genres;
  final Set<String> selectedGenres;
  final ValueChanged<String> onGenreToggled;
  final String selectedSort;
  final ValueChanged<String?> onSortChanged;

  const FilterSection({
    super.key,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.genres,
    required this.selectedGenres,
    required this.onGenreToggled,
    required this.selectedSort,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step 4: Implement a Responsive Search Bar
        TextField(
          onChanged: onSearchChanged,
          decoration: InputDecoration(
            hintText: 'Search movies by title...',
            prefixIcon: const Icon(Icons.search),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Step 5: Implement Genre Chips Using Wrap
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: genres.map((genre) {
            final isSelected = selectedGenres.contains(genre);
            return FilterChip(
              label: Text(genre),
              selected: isSelected,
              onSelected: (_) => onGenreToggled(genre),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),

        // Step 6: Implement Sort Dropdown
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Sort by:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            DropdownButton<String>(
              value: selectedSort,
              items: const [
                DropdownMenuItem(value: 'A-Z', child: Text('A–Z')),
                DropdownMenuItem(value: 'Z-A', child: Text('Z–A')),
                DropdownMenuItem(value: 'Year', child: Text('Year')),
                DropdownMenuItem(value: 'Rating', child: Text('Rating')),
              ],
              onChanged: onSortChanged,
            ),
          ],
        ),
      ],
    );
  }
}

// Lab 6.3 – Responsive Movie List & Tablet Layout
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
