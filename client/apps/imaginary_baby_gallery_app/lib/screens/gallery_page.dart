import 'package:flutter/material.dart';
import 'package:imaginary_baby_gallery_app/components/custom_app_bar.dart';
import 'package:imaginary_baby_gallery_app/provider/album_provider.dart';
import 'package:imaginary_baby_gallery_app/provider/authProvider.dart';
import 'package:imaginary_baby_gallery_app/provider/gallery_provider.dart';
import 'package:provider/provider.dart';

import 'album_page.dart';

class GalleryPage extends StatefulWidget {
  final int id;
  const GalleryPage({super.key, required this.id});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  void initState() {
    super.initState();
    final galleryProvider =
        Provider.of<GalleryProvider>(context, listen: false);
    // Fetch photos for the specific album ID when the page loads
    galleryProvider.fetchGallery().then((_) {
      setState(() {}); // Update the UI after fetching data
    });
  }

  void onpress() async {
    final authProvider = Provider.of<LoginProvider>(context, listen: false);

    await authProvider.logout();
  }

  @override
  Widget build(BuildContext context) {
    final albumProvider = Provider.of<AlbumProvider>(context);
    final galleryProvider = Provider.of<GalleryProvider>(context);

    if (albumProvider.isLoading || galleryProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Check if albums and gallery data are loaded and contain elements
    if (albumProvider.albums.isEmpty || galleryProvider.gallery.isEmpty) {
      return const Center(child: Text("No data available"));
    }

    final filteredData = galleryProvider.gallery
        .where((gallery) =>
            gallery.albumId == albumProvider.albums[widget.id - 1].id)
        .toList();

    print("filteredData: ${filteredData[widget.id - 1].thumbnailUrl}");

    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: "Gallery",
        onLogout: onpress,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Center(
            child: Text(
              albumProvider.albums[widget.id - 1].title.toString(),
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: galleryProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      padding: const EdgeInsets.all(10.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        final photo = filteredData[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AlbumPage(
                                          id: widget.id,
                                        )));
                          },
                          child: GridTile(
                            footer: GridTileBar(
                              title: Text(
                                photo.title,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Image.network(
                                photo.thumbnailUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.broken_image,
                                    size: 120,
                                    color: Colors.grey,
                                  ); // or replace with any local asset as a placeholder
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
