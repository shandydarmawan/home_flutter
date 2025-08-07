import 'package:api_flutter/models/post_model.dart';
import 'package:api_flutter/services/post_service.dart';
import 'package:flutter/material.dart';

class ListPostScreen extends StatelessWidget {
  const ListPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Postingan"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: const Color(0xFFEFEFFF),
        child: FutureBuilder<List<PostModel>>(
          future: PostService.listpost(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                  child: Text('Terjadi kesalahan: ${snapshot.error}'));
            }

            final dataPost = snapshot.data ?? [];

            if (dataPost.isEmpty) {
              return const Center(child: Text("Tidak ada data."));
            }

            return ListView.builder(
              itemCount: dataPost.length,
              itemBuilder: (context, index) {
                final post = dataPost[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Text(
                        post.id.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      post.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text("User ID: ${post.userId}"),
                    onTap: () {
                      // TODO: Navigasi ke detail
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
