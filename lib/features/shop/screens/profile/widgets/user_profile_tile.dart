import 'package:biriyani/common/image/my_circular_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UserProfileTile extends StatefulWidget {
  const UserProfileTile({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  State<UserProfileTile> createState() => _UserProfileTileState();
}

class _UserProfileTileState extends State<UserProfileTile> {
  @override
  Widget build(BuildContext context) {
    String userName = 'Hello!';
    String email = 'NotLoggedIn@gmail.com';
    return ListTile(
        leading: const MyCircularImage(
            image: 'assets/images/man.png', width: 50, height: 50, padding: 0),
        title: Text(userName,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: Colors.white)),
        subtitle: Text(
          email,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .apply(color: Colors.white),
        ),
        trailing: IconButton(
          onPressed: widget.onPressed,
          icon: const Icon(Iconsax.edit, color: Colors.white),
        ));
  }
}
