import 'package:biriyani/common/back_ground_container.dart';
import 'package:biriyani/common/image/my_circular_image.dart';
import 'package:biriyani/provider/user_provider.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        leading: Icon(
          Icons.person_pin,
          color:Colors.white.withOpacity(0.8),
          size: 35.sp,
        ),
        title: Text(user?.phone ?? 'Hey Guest',
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: Colors.white)),
        subtitle: Text(
          user == null ? 'Please log in' : user.userName,
          style:
              Theme.of(context).textTheme.bodySmall!.apply(color: Colors.white),
        ),
        trailing: IconButton(
          onPressed: widget.onPressed,
          icon: const Icon(Iconsax.edit, color: Colors.white),
        ));
  }
}
