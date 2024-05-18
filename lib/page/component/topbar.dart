import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar TopBar(BuildContext context,
    {String title = 'Inventori Apotek Duma',
    List<Widget> actions = const [],
    Widget? lead = null,
    TabBar? tabBar}) {
  return AppBar(
    title: Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottom: tabBar,
    actions: (actions.isNotEmpty)
        ? actions
        : [IconButton(onPressed: () {}, icon: const Icon(Icons.logout))],
    leading: (lead != null)
        ? lead
        : IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.menu)),
  );
}
