import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ItemCardWidget extends StatelessWidget {
  ItemCardWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    required this.subtitle,
    this.trail,
  });

  final String title;
  final Icon icon;
  void Function()? onTap;
  final Widget subtitle;
  final Widget? trail;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        iconColor: Colors.blueAccent,
        textColor: Colors.blueAccent,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: icon,
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: subtitle,
        trailing: trail ??
            (onTap != null ? const Icon(Icons.chevron_right_sharp) : null),
      ),
    );
  }
}
