import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? titleColor;
  final double elevation;
  final bool showSearchBar;
  final Function(String)? onSearchChanged;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = false,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.titleColor,
    this.elevation = 0,
    this.showSearchBar = false,
    this.onSearchChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: !showSearchBar
          ? Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: titleColor ?? Theme.of(context).textTheme.titleLarge?.color,
                    fontWeight: FontWeight.bold,
                  ),
            )
          : Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onChanged: onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search ideas...',
                  border: InputBorder.none,
                  icon: const Icon(Icons.search, color: Colors.grey, size: 20),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
      centerTitle: true,
      leading: showBackButton
          ? (leading ??
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                onPressed: () => Get.back(),
              ))
          : null,
      actions: [
        if (actions != null) ...actions!,
        if (!showSearchBar)
          IconButton(
            icon: const Icon(Icons.search, size: 24),
            onPressed: () {
              // Toggle search bar
            },
          ),
        const SizedBox(width: 8),
        const CircleAvatar(
          radius: 16,
          backgroundColor: Colors.grey,
          // Replace with actual user image
          child: Icon(Icons.person, size: 20, color: Colors.white),
        ),
        const SizedBox(width: 16),
      ],
      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      elevation: elevation,
      automaticallyImplyLeading: showBackButton,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
