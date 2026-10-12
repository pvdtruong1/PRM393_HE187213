// Step 2: Define Sample Data
import '../models/movie.dart';

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
