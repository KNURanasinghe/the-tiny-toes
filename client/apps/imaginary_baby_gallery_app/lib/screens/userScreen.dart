import 'package:flutter/material.dart';
import 'package:imaginary_baby_gallery_app/components/custom_app_bar.dart';
import 'package:imaginary_baby_gallery_app/provider/user_provider.dart';
import 'package:imaginary_baby_gallery_app/screens/album_page.dart';
import 'package:provider/provider.dart';

import '../provider/authProvider.dart';
import 'loginScreen.dart';

class Userscreen extends StatefulWidget {
  const Userscreen({super.key});

  @override
  State<Userscreen> createState() => _UserscreenState();
}

class _UserscreenState extends State<Userscreen> {
  @override
  void initState() {
    super.initState();
    // Ensure fetchUsers is called on init to load data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchUsers();
    });
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
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(onLogout: onPress),
      body: userProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : userProvider.errorMessage != null
              ? Center(
                  child: Text(
                    userProvider.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 40),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, // Outline color
                            width: 2, // Outline width
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView.builder(
                          shrinkWrap:
                              true, // Make the ListView take only needed space
                          physics:
                              const NeverScrollableScrollPhysics(), // Prevent inner scrolling
                          itemCount: userProvider.user.length,
                          itemBuilder: (context, index) {
                            final user = userProvider.user[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AlbumPage(
                                              id: user.id,
                                            )),
                                  );
                                },
                                child: ListTile(
                                  leading: Text(
                                    user.name,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}
