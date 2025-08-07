import 'package:flutter/material.dart';

class PhotoDetailScreen extends StatelessWidget {
  final String id;
  final String title;
  final String url;

  const PhotoDetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.url,
  });

  // Ekstrak warna dari URL (misalnya .../600/92c952 → #92c952)
  Color getColorFromUrl(String url) {
    final uri = Uri.parse(url);
    final segments = uri.pathSegments;
    if (segments.isNotEmpty) {
      final hex = segments.last;
      try {
        return Color(int.parse('0xFF$hex'));
      } catch (_) {}
    }
    return Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = getColorFromUrl(url);

    return Scaffold(
      backgroundColor: bgColor.withOpacity(0.1),
      appBar: AppBar(
        title: const Text('Detail Foto'),
        backgroundColor: bgColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'ID: $id',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Text('Gagal memuat gambar')),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
