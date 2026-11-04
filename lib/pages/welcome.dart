import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Kinetic Pulse Design System Colors
class KineticPulseColors {
  static const Color baseGround = Color(0xFF08090A);
  static const Color surfaceTier1 = Color(0xFF121418);
  static const Color surfaceTier2 = Color(0xFF1A1D24);
  static const Color surfaceTier3 = Color(0xFF242833);
  
  // Neon Accents
  static const Color electricLime = Color(0xFFD8FF00); // Primary Action
  static const Color textOnLime = Color(0xFF0D0E11);
  static const Color neonCyan = Color(0xFF00F0FF);     // Secondary Telemetry
  static const Color blazeOrange = Color(0xFFFF4D00);  // High Exertion
  
  // Neutrals
  static const Color textPrimary = Color(0xFFF4F6FB);
  static const Color textSecondary = Color(0xFF8D93A5);
  static const Color hairline = Color(0x1AFFFFFF);     // 10% white
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _selectedTrackIndex = 0;

  final List<Map<String, dynamic>> _trainingTracks = [
    {
      'title': 'HYPERTROPHY OVERLOAD',
      'tag': 'VOLUME & RPE',
      'desc': 'Optimized eccentric tempo, high-threshold motor unit recruitment, and progressive microcycles.',
      'color': KineticPulseColors.electricLime,
    },
    {
      'title': 'MAXIMAL POWER & 1RM',
      'tag': 'VELOCITY & STRENGTH',
      'desc': 'Rate of force development (RFD), submaximal wave loading, and neuromuscular readiness.',
      'color': KineticPulseColors.neonCyan,
    },
    {
      'title': 'METABOLIC CONDITIONING',
      'tag': 'THRESHOLD & ZONES',
      'desc': 'Zone 4/5 lactate threshold intervals, rapid heart rate recovery, and continuous bio-telemetry.',
      'color': KineticPulseColors.blazeOrange,
    },
  ];

  void _onGetStarted() {
    HapticFeedback.heavyImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: KineticPulseColors.surfaceTier2,
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Initialized ${_trainingTracks[_selectedTrackIndex]['title']} Track',
          style: GoogleFonts.barlowCondensed(
            color: KineticPulseColors.electricLime,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KineticPulseColors.baseGround,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Hero Photo with Dark Athletic Scrim
          Positioned.fill(
            child: Image.network(
              'https://your-domain.com/assets/kinetic_hero_workout.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.35, 0.65, 1.0],
                  colors: [
                    KineticPulseColors.baseGround.withValues(alpha: 0.4),
                    KineticPulseColors.baseGround.withValues(alpha: 0.85),
                    KineticPulseColors.baseGround.withValues(alpha: 0.98),
                    KineticPulseColors.baseGround,
                  ],
                ),
              ),
            ),
          ),

          // Scrollable Body Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  // Brand Header Lockup
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: KineticPulseColors.electricLime,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(2)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'KINETIC PULSE',
                            style: GoogleFonts.barlowCondensed(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.0,
                              color: KineticPulseColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: KineticPulseColors.surfaceTier2.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: KineticPulseColors.hairline),
                        ),
                        child: Text(
                          'PRO DIVISION',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                            color: KineticPulseColors.neonCyan,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(flex: 2),

                  // Hero Display Typography
                  Text(
                    'UNLEASH RAW',
                    style: GoogleFonts.barlowCondensed(
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      height: 0.95,
                      letterSpacing: -1.0,
                      color: KineticPulseColors.textPrimary,
                    ),
                  ),
                  Text(
                    'MOMENTUM.',
                    style: GoogleFonts.barlowCondensed(
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      height: 0.95,
                      letterSpacing: -1.0,
                      color: KineticPulseColors.electricLime,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'High-threshold biomechanical logging, live heart-rate zone telemetry, and precision rest cadence engineered for elite athletic output.',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      height: 1.4,
                      color: KineticPulseColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Training Focus Selector Pills
                  Text(
                    'SELECT TARGET TRAINING TRACK',
                    style: GoogleFonts.barlowCondensed(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: KineticPulseColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Column(
                    children: List.generate(_trainingTracks.length, (index) {
                      final item = _trainingTracks[index];
                      final isSelected = index == _selectedTrackIndex;
                      final Color accent = item['color'];

                      return GestureDetector(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          setState(() => _selectedTrackIndex = index);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected ? KineticPulseColors.surfaceTier2 : KineticPulseColors.surfaceTier1.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected ? accent : KineticPulseColors.hairline,
                              width: isSelected ? 1.5 : 1.0,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: accent.withValues(alpha: 0.15),
                                      blurRadius: 16,
                                      offset: const Offset(0, 4),
                                    )
                                  ]
                                : null,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected ? accent : KineticPulseColors.surfaceTier3,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '0${index + 1}',
                                  style: GoogleFonts.barlowCondensed(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: isSelected ? KineticPulseColors.textOnLime : KineticPulseColors.textSecondary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title'],
                                      style: GoogleFonts.barlowCondensed(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: isSelected ? KineticPulseColors.textPrimary : KineticPulseColors.textSecondary,
                                      ),
                                    ),
                                    Text(
                                      item['tag'],
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: accent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(Icons.check_circle, color: accent, size: 20),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),

                  const Spacer(),

                  // Primary Action Button (Electric Lime min-height 54px)
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _onGetStarted,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: KineticPulseColors.electricLime,
                        foregroundColor: KineticPulseColors.textOnLime,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'ENTER TRAINING LAB',
                        style: GoogleFonts.barlowCondensed(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Secondary Action (Transparent with Cyan outline)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: KineticPulseColors.neonCyan, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'AUTHENTICATE WITH PRO ID',
                        style: GoogleFonts.barlowCondensed(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                          color: KineticPulseColors.textPrimary,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
