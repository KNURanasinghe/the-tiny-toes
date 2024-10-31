import 'package:flutter/material.dart';
import 'package:imaginary_baby_gallery_app/provider/user_provider.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black, // Outline color
              width: 2, // Outline width
            ),
          ),
          child: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white, // Background color of AppBar
            elevation: 0, // Remove default AppBar shadow
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: onPress,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.red, width: 2),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Text(
                  "Users",
                  style: TextStyle(color: Colors.black), // Text color
                ),
                Row(
                  children: [
                    const Text("user"),
                    const SizedBox(width: 20),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.blue, // Circle outline color
                          width: 3, // Circle outline width
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey[200],
                        child: ClipOval(
                          child: Image.network(
                            "",
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.blue,
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.grey,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
                              child: ListTile(
                                leading: Text(
                                  user.name,
                                  style: const TextStyle(fontSize: 20),
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
