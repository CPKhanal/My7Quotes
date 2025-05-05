import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  void showQuickSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 80, right: 20, left: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoritesBox = Hive.box('favorites');
    final favoriteQuotes = favoritesBox.values.toList().cast<String>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('💾 Saved Quotes'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: favoriteQuotes.isEmpty
          ? const Center(
              child: Text(
                'No saved quotes yet.\nStart saving some!',
                style: TextStyle(color: Colors.white70, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: favoriteQuotes.length,
              itemBuilder: (context, index) {
                final quoteText = favoriteQuotes[index];

                return Dismissible(
                  key: Key(quoteText),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    final keyToRemove = favoritesBox.keys.firstWhere(
                      (key) => favoritesBox.get(key) == quoteText,
                      orElse: () => null,
                    );
                    if (keyToRemove != null) {
                      favoritesBox.delete(keyToRemove);
                      showQuickSnack(context, '❌ Removed from saved');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        '"$quoteText"',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
