import 'package:biriyani/common/image/my_circular_image.dart';
import 'package:biriyani/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class UserProfileTile extends ConsumerStatefulWidget {
  const UserProfileTile({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  ConsumerState<UserProfileTile> createState() => _UserProfileTileState();

}



class _UserProfileTileState extends ConsumerState<UserProfileTile> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return ListTile(
        leading: const MyCircularImage(
            image: 'assets/images/man.png', width: 50, height: 50, padding: 0),
        title: Text(user?.phone ?? 'User id not available',
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: Colors.white)),
        subtitle: Text(
          user?.id ?? 'User id not available',
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
