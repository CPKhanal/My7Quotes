class Quote {
  final String text;

  Quote({required this.text});

  factory Quote.fromMap(Map<String, dynamic> data) {
    return Quote(text: data['text'] ?? '');
  }
}
