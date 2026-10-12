// Step 1: Project Setup & Base Scaffold
import 'package:flutter/material.dart';
import 'data/sample_movies.dart';
import 'models/movie.dart';
import 'widgets/filter_section.dart';
import 'widgets/hero_section.dart';
import 'widgets/movie_grid_list.dart';

void main() {
  runApp(const ResponsiveMovieApp());
}

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
      // Filter by search text (case-insensitive title match)
      final matchesSearch = movie.title.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );

      // Filter by selected genres (OR logic: match at least one selected genre)
      final matchesGenre = _selectedGenres.isEmpty ||
          movie.genres.any((genre) => _selectedGenres.contains(genre));

      return matchesSearch && matchesGenre;
    }).toList();

    // Sort visible movies based on selected sort option
    filtered.sort((a, b) {
      switch (_selectedSort) {
        case 'Z-A':
          return b.title.compareTo(a.title);
        case 'Year':
          return b.year.compareTo(a.year); // Newest first
        case 'Rating':
          return b.rating.compareTo(a.rating); // Highest first
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
