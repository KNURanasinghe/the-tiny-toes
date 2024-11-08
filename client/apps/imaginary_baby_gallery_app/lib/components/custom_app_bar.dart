import 'package:flutter/material.dart';
import 'package:imaginary_baby_gallery_app/provider/authProvider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLogout;
  String appBarTitle;

  CustomAppBar({super.key, required this.onLogout, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<LoginProvider>(context);
    final username = userProvider.username ?? "User";
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white, 
      elevation: 0, 
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: onLogout,
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
          Text(
            appBarTitle,
            style: const TextStyle(color: Colors.black), // Text color
          ),
          Row(
            children: [
               Text(username, style: TextStyle(fontSize: 15)),
              const SizedBox(width: 20),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blue, 
                    width: 3, 
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
