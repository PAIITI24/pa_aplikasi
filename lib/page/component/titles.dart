import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class H1 extends StatelessWidget {
  final String text;

  const H1(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.bold));
  }
}

class H2 extends StatelessWidget {
  final String text;

  const H2(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold));
  }
}

class H3 extends StatelessWidget {
  final String text;

  const H3(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold));
  }
}
