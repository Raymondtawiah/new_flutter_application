import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/kinetic_theme.dart';

class ActiveSessionPage extends StatelessWidget {
  const ActiveSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KineticPulseColors.baseGround,
      appBar: AppBar(
        backgroundColor: KineticPulseColors.baseGround,
        title: Text(
          'ACTIVE SESSION',
          style: GoogleFonts.barlowCondensed(
            fontWeight: FontWeight.w900,
            color: KineticPulseColors.textPrimary,
          ),
        ),
      ),
      body: const Center(child: Text('Active Session')),
    );
  }
}
