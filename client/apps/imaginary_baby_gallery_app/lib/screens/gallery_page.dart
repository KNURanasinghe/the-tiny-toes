import 'package:flutter/material.dart';
import 'package:imaginary_baby_gallery_app/components/custom_app_bar.dart';
import 'package:imaginary_baby_gallery_app/provider/album_provider.dart';
import 'package:imaginary_baby_gallery_app/provider/authProvider.dart';
import 'package:imaginary_baby_gallery_app/provider/gallery_provider.dart';
import 'package:imaginary_baby_gallery_app/screens/gallery_details.dart';
import 'package:provider/provider.dart';

import 'loginScreen.dart';

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
    galleryProvider.fetchGallery();
  }

  void onPress() async {
    final logoutProvider = Provider.of<LoginProvider>(context, listen: false);

    await logoutProvider.logout();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final albumProvider = Provider.of<AlbumProvider>(context);
    final galleryProvider = Provider.of<GalleryProvider>(context);

    if (albumProvider.isLoading || galleryProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (albumProvider.albums.isEmpty || galleryProvider.gallery.isEmpty) {
      return const Center(child: Text("No data available"));
    }

    if (widget.id - 1 >= albumProvider.albums.length) {
      return const Center(child: Text("Album not found"));
    }

    final filteredData = galleryProvider.gallery
        .where((gallery) =>
            gallery.albumId == albumProvider.albums[widget.id - 1].id)
        .toList();

    if (filteredData.isEmpty) {
      return const Center(child: Text("No images available for this album"));
    }

    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: "Gallery",
        onLogout: onPress,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Text(
              albumProvider.albums[widget.id - 1].title.toString(),
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      2, // Adjusting to 2 columns to prevent overflow
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  final photo = filteredData[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GalleryDetails(id: widget.id),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              photo.thumbnailUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.broken_image,
                                  size: 80,
                                  color: Colors.grey,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          photo.title,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
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
