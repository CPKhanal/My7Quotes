import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/quote.dart';
import '../widgets/quote_card.dart';
import '../screens/favorites_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/music_toggle_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _initialPage = 0;

  Future<void> _loadLastPage() async {
    final prefs = await SharedPreferences.getInstance();
    _initialPage = prefs.getInt('last_page') ?? 0;
    setState(() {
      _pageController = PageController(initialPage: _initialPage);
    });
  }

  Future<void> _saveLastPage(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_page', index);
  }

  Future<List<Quote>> fetchQuotes() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('quotes').get();
    return snapshot.docs.map((doc) => Quote.fromMap(doc.data())).toList();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(); // Temporary init
    _loadLastPage(); // Async actual init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder<List<Quote>>(
              future: fetchQuotes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No quotes found."));
                }

                final quotes = snapshot.data!;

                return PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: quotes.length,
                  onPageChanged: _saveLastPage,
                  itemBuilder: (context, index) {
                    return QuoteCard(quote: quotes[index], index: index);
                  },
                );
              },
            ),

            // 🎵 Music + 🔖 Favorites buttons
            Positioned(
              top: 10,
              right: 10,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const MusicToggleButton(),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.bookmark, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FavoritesScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
