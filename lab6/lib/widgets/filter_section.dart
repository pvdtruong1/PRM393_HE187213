// Lab 6.2 – Search, Genre Chips & Sort Bar
import 'package:flutter/material.dart';

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
