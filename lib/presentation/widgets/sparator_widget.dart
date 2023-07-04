import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SparatorWIdget extends StatelessWidget {
  const SparatorWIdget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 17,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
