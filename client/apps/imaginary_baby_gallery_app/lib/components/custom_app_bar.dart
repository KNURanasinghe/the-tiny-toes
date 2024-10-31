import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLogout;

  const CustomAppBar({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white, // Background color of AppBar
      elevation: 0, // Remove default AppBar shadow
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
