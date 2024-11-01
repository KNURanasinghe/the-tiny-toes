import 'package:flutter/material.dart';
import 'package:imaginary_baby_gallery_app/components/custom_app_bar.dart';
import 'package:imaginary_baby_gallery_app/provider/authProvider.dart';
import 'package:imaginary_baby_gallery_app/screens/gallery_page.dart';
import 'package:provider/provider.dart';

import '../provider/album_provider.dart';
import '../provider/user_provider.dart';

class AlbumPage extends StatefulWidget {
  final int id;
  const AlbumPage({super.key, required this.id});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  void initState() {
    super.initState();
    // Ensure fetchUsers is called on init to load data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AlbumProvider>(context, listen: false).fetchAlbums();
    });
  }

  void onPress() async {
    final logoutProvider = Provider.of<LoginProvider>(context, listen: false);
    await logoutProvider.logout();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final albumProvider = Provider.of<AlbumProvider>(context);

    final filteredData = albumProvider.albums
        .where((album) => album.userId == userProvider.user[widget.id - 1].id)
        .toList();
    print(filteredData);

    return Scaffold(
      appBar: CustomAppBar(
        onLogout: onPress,
        appBarTitle: "Album",
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Center(
            child: Text(
              userProvider.user[widget.id - 1].name,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          albumProvider.albums.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          final album = filteredData[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GalleryPage(
                                            id: albumProvider.albums[index].id,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  // Circular container for the letter
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[
                                          300], // Background color of the circle
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      album.title[0].toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  // Text container with rounded corners
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[
                                            300], // Background color of the text container
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        album.title,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )),
                ),
        ],
      ),
    );
  }
}
