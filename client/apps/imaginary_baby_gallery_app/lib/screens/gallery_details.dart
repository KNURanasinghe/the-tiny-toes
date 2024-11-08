import 'package:flutter/material.dart';
import 'package:imaginary_baby_gallery_app/components/custom_app_bar.dart';
import 'package:imaginary_baby_gallery_app/provider/album_provider.dart';
import 'package:imaginary_baby_gallery_app/provider/authProvider.dart';
import 'package:imaginary_baby_gallery_app/provider/gallery_provider.dart';
import 'package:imaginary_baby_gallery_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../components/custom_text.dart';
import 'loginScreen.dart';

class GalleryDetails extends StatefulWidget {
  final int id;
  const GalleryDetails({super.key, required this.id});

  @override
  State<GalleryDetails> createState() => _GalleryDetailsState();
}

class _GalleryDetailsState extends State<GalleryDetails> {
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
    final userProvider = Provider.of<UserProvider>(context);
    final galleryProvider = Provider.of<GalleryProvider>(context);

    // Fetch the album, user, and gallery item details based on `id`
    final album = albumProvider.albums[widget.id - 1].title.toString();
    final author =
        userProvider.user[albumProvider.albums[widget.id - 1].userId - 1].name;
    final galleryItem = galleryProvider.gallery[widget.id - 1].thumbnailUrl;
    final imageTitle = galleryProvider.gallery[widget.id - 1].title;

    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: "Gallery",
        onLogout: onPress,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            Text(
              imageTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 70),

            // Display album image from GalleryProvider
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(galleryItem),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 70),
            // Display author name and album name
            Column(
              children: [
                CustomText(
                  main: "Artist: ",
                  sub: author,
                ),
                const SizedBox(height: 30),
                CustomText(
                  main: "Album: ",
                  sub: album,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
