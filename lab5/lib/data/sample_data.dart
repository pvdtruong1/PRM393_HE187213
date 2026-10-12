import '../models/movie.dart';

// Step 2: Sample Data
final List<Movie> sampleMovies = [
  const Movie(
    id: '1',
    title: 'Dune: Part Two',
    rating: 8.6,
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    overview:
        'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    posterUrl:
        'https://images.unsplash.com/photo-1506368249639-73a05d6f6488?w=800',
    trailers: [
      Trailer(id: 't1', title: 'Official Trailer #1'),
      Trailer(id: 't2', title: 'IMAX Sneak Peek'),
    ],
  ),
  const Movie(
    id: '2',
    title: 'Deadpool & Wolverine',
    rating: 8.3,
    genres: ['Action', 'Comedy'],
    overview:
        'The multiverse gets messy when Wade Wilson teams up with Wolverine for a not-so-family-friendly mission.',
    posterUrl:
        'https://images.unsplash.com/photo-1513836279014-a89f7a76ae86?w=800',
    trailers: [
      Trailer(id: 't3', title: 'Red Band Trailer'),
      Trailer(id: 't4', title: 'Behind the Scenes'),
    ],
  ),
];
