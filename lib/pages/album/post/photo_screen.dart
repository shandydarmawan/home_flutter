import 'package:flutter/material.dart';
import 'package:api_flutter/models/photo_model.dart';
import 'package:api_flutter/services/photo_service.dart';
import 'package:api_flutter/pages/album/post/detail_photo_screen.dart';

class ListPhoto extends StatelessWidget {
  const ListPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final Color darkBlue = Colors.blue.shade900;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo Gallery',
      theme: ThemeData(
        primaryColor: darkBlue,
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: AppBarTheme(
          backgroundColor: darkBlue,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('📷 Photo Gallery'),
          centerTitle: true,
        ),
        body: FutureBuilder<List<PhotoModel>>(
          future: PhotoService.listphoto(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '❌ Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            final photos = snapshot.data ?? [];
            if (photos.isEmpty) {
              return const Center(
                child: Text("📭 Tidak ada data photo."),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                final photo = photos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        photo.thumbnailUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                      ),
                    ),
                    title: Text(
                      photo.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: darkBlue,
                      ),
                    ),
                    subtitle: Text(
                      'ID: ${photo.id}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    trailing: Icon(Icons.chevron_right, color: darkBlue),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PhotoDetailScreen(
                            id: photo.id.toString(),
                            title: photo.title,
                            url: photo.url,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
