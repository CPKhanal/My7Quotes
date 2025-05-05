import 'dart:io';
import 'dart:ui';
// ignore: unused_import
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import '../models/quote.dart';
import 'package:flutter/services.dart';


class QuoteCard extends StatefulWidget {
  final Quote quote;
  final int index;

  const QuoteCard({super.key, required this.quote, required this.index});

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;
  final ScreenshotController _screenshotController = ScreenshotController();
  bool isSaved = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    final box = Hive.box('favorites');
    final key = widget.quote.text;
    isSaved = box.containsKey(key);
  }

  void showFloatingSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 80, left: 20, right: 20),
      ),
    );
  }

  Future<void> _shareQuoteImage() async {
    try {
      final image = await _screenshotController.capture();
      if (image == null) return;

      final tempDir = await Directory.systemTemp.createTemp();
      final file = await File('${tempDir.path}/quote_${widget.index}.png').create();
      await file.writeAsBytes(image);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: '"${widget.quote.text}" — from My7Quotes',
      );
    } catch (e) {
      print('Share error: $e');
      showFloatingSnack('⚠️ Failed to share image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenshotController,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://picsum.photos/800/1200?blur=6&random=${widget.index}',
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) =>
                Container(color: Colors.black),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "My7Quotes",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _offsetAnimation,
                        child: GestureDetector(
  onDoubleTap: () async {
    await Clipboard.setData(ClipboardData(text: widget.quote.text));
    showFloatingSnack('📋 Copied to clipboard');
  },
  child: Text(
    '"${widget.quote.text}"',
    style: const TextStyle(
      fontSize: 28,
      fontStyle: FontStyle.italic,
      color: Colors.white,
      height: 1.5,
      shadows: [
        Shadow(
          blurRadius: 6,
          color: Colors.black87,
          offset: Offset(1, 1),
        ),
      ],
    ),
    textAlign: TextAlign.center,
  ),
),

                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: Colors.white70,
                        size: 30,
                      ),
                      onPressed: () async {
                        final box = Hive.box('favorites');
                        final key = widget.quote.text;

                        setState(() {
                          if (isSaved) {
                            box.delete(key);
                            isSaved = false;
                            showFloatingSnack('❌ Removed from favorites');
                          } else {
                            box.put(key, widget.quote.text);
                            isSaved = true;
                            showFloatingSnack('✅ Added to favorites');
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share_outlined,
                          color: Colors.white70, size: 30),
                      onPressed: _shareQuoteImage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
