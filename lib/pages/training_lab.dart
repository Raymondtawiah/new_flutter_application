import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/kinetic_theme.dart';
import './active_session.dart';

class TrainingLabPage extends StatefulWidget {
  const TrainingLabPage({super.key});

  @override
  State<TrainingLabPage> createState() => _TrainingLabPageState();
}

class _TrainingLabPageState extends State<TrainingLabPage> {
  int _selectedFilterIndex = 0;
  double _calcWeight = 100.0;
  int _calcReps = 5;

  static const String benchPressImg =
      'https://ais-pre-cb4ztqfq4n4ynostoimym2-971516294115.europe-west2.run.app/assets/images/exercise_bench_press.jpg';
  static const String deadliftImg =
      'https://ais-pre-cb4ztqfq4n4ynostoimym2-971516294115.europe-west2.run.app/assets/images/exercise_deadlift.jpg';
  static const String cableRaiseImg =
      'https://ais-pre-cb4ztqfq4n4ynostoimym2-971516294115.europe-west2.run.app/assets/images/exercise_cable_raise.jpg';
  static const String heroImg =
      'https://ais-pre-cb4ztqfq4n4ynostoimym2-971516294115.europe-west2.run.app/assets/images/kinetic_hero_workout.jpg';

  final List<String> _filters = [
    'ALL PROTOCOLS',
    'PUSH FOCUS',
    'POSTERIOR CHAIN',
    'SHOULDERS & DELTS',
    'QUAD VELOCITY'
  ];

  // 1RM Calculation using Epley formula: weight * (1 + reps / 30)
  int get _estimated1RM => (_calcWeight * (1 + _calcReps / 30.0)).round();

  final List<Map<String, dynamic>> _protocols = [
    {
      'id': 'p1',
      'title': 'ANTERIOR FORCE OVERLOAD',
      'category': 'PUSH FOCUS',
      'duration': '65 MIN',
      'exercisesCount': 5,
      'volumeTarget': '14,200 KG',
      'intensity': 'HIGH EXERTION · 88% RPE',
      'image': benchPressImg,
      'muscles': ['Clavicular Pectoralis', 'Anterior Deltoid', 'Triceps'],
      'exercises': ['Incline DB Press', 'Barbell Flat Press', 'Cable Flys', 'Dips'],
    },
    {
      'id': 'p2',
      'title': 'POSTERIOR KINETIC CHAIN',
      'category': 'POSTERIOR CHAIN',
      'duration': '70 MIN',
      'exercisesCount': 6,
      'volumeTarget': '18,500 KG',
      'intensity': 'MAXIMAL INTENSITY · 92% RPE',
      'image': deadliftImg,
      'muscles': ['Gluteus Maximus', 'Hamstrings', 'Erector Spinae', 'Lats'],
      'exercises': ['Hex Bar Deadlift', 'RDLs', 'Barbell Rows', 'Facepulls'],
    },
    {
      'id': 'p3',
      'title': 'DELTOID V-TAPER KINETICS',
      'category': 'SHOULDERS & DELTS',
      'duration': '48 MIN',
      'exercisesCount': 5,
      'volumeTarget': '9,600 KG',
      'intensity': 'CONSTANT TENSION · 85% RPE',
      'image': cableRaiseImg,
      'muscles': ['Lateral Deltoid', 'Posterior Deltoid', 'Upper Traps'],
      'exercises': ['Dual Cable Lateral Raise', 'Arnold Press', 'Rear Delt Flys'],
    },
    {
      'id': 'p4',
      'title': 'QUAD EXPLOSIVE VELOCITY',
      'category': 'QUAD VELOCITY',
      'duration': '60 MIN',
      'exercisesCount': 5,
      'volumeTarget': '16,800 KG',
      'intensity': 'NEUROMUSCULAR SPEED · 90% RPE',
      'image': heroImg,
      'muscles': ['Quadriceps', 'Glutes', 'Adductors', 'Calves'],
      'exercises': ['Barbell High-Bar Squat', 'Bulgarian Split Squats', 'Leg Extensions'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProtocols = _selectedFilterIndex == 0
        ? _protocols
        : _protocols
            .where((p) => p['category'] == _filters[_selectedFilterIndex])
            .toList();

    return Scaffold(
      backgroundColor: KineticPulseColors.baseGround,
      appBar: AppBar(
        backgroundColor: KineticPulseColors.baseGround,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: KineticPulseColors.textSecondary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'TRAINING LAB',
          style: GoogleFonts.barlowCondensed(
            fontWeight: FontWeight.w900,
            fontSize: 24,
            letterSpacing: 1.5,
            color: KineticPulseColors.textPrimary,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: KineticPulseColors.surfaceTier2,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: KineticPulseColors.hairline),
            ),
            child: Row(
              children: [
                const Icon(Icons.bolt, color: KineticPulseColors.neonCyan, size: 16),
                const SizedBox(width: 4),
                Text(
                  '94% READINESS',
                  style: GoogleFonts.barlowCondensed(
                    fontWeight: FontWeight.w800,
                    color: KineticPulseColors.neonCyan,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Telemetry Status Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: KineticPulseColors.surfaceTier1,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: KineticPulseColors.hairline),
            ),
            child: Row(
              children: [
                _buildStatItem('WEEKLY TONNAGE', '34,820', 'KG', KineticPulseColors.electricLime),
                Container(width: 1, height: 36, color: KineticPulseColors.hairline),
                _buildStatItem('EXERTION ZONE', '158', 'BPM', KineticPulseColors.blazeOrange),
                Container(width: 1, height: 36, color: KineticPulseColors.hairline),
                _buildStatItem('ACTIVE STREAK', '14', 'DAYS', KineticPulseColors.neonCyan),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 1RM Biomechanical Overload Calculator Widget
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: KineticPulseColors.surfaceTier1,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: KineticPulseColors.neonCyan.withAlpha(80)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calculate_outlined, color: KineticPulseColors.neonCyan, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          '1RM OVERLOAD ESTIMATOR',
                          style: GoogleFonts.barlowCondensed(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                            color: KineticPulseColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: KineticPulseColors.surfaceTier2,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'EPLEY ALGORITHM',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: KineticPulseColors.neonCyan,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                Row(
                  children: [
                    // Weight Stepper
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: KineticPulseColors.surfaceTier2,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: KineticPulseColors.hairline),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('LIFT WEIGHT', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: KineticPulseColors.textSecondary, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _calcBtn('-', () => setState(() => _calcWeight = (_calcWeight - 2.5).clamp(10.0, 400.0))),
                                Text('${_calcWeight.toStringAsFixed(1)} kg', style: GoogleFonts.barlowCondensed(fontSize: 18, fontWeight: FontWeight.w800, color: KineticPulseColors.textPrimary)),
                                _calcBtn('+', () => setState(() => _calcWeight = (_calcWeight + 2.5).clamp(10.0, 400.0))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    // Reps Stepper
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: KineticPulseColors.surfaceTier2,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: KineticPulseColors.hairline),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('REPETITIONS', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: KineticPulseColors.textSecondary, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _calcBtn('-', () => setState(() => _calcReps = (_calcReps - 1).clamp(1, 20))),
                                Text('$_calcReps reps', style: GoogleFonts.barlowCondensed(fontSize: 18, fontWeight: FontWeight.w800, color: KineticPulseColors.textPrimary)),
                                _calcBtn('+', () => setState(() => _calcReps = (_calcReps + 1).clamp(1, 20))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Projected 1RM Result Banner
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: KineticPulseColors.surfaceTier2,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: KineticPulseColors.electricLime.withAlpha(80)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('PROJECTED MAX (1RM)', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: KineticPulseColors.textSecondary, fontWeight: FontWeight.w700)),
                          Text('$_estimated1RM KG', style: GoogleFonts.barlowCondensed(fontSize: 26, fontWeight: FontWeight.w900, color: KineticPulseColors.electricLime)),
                        ],
                      ),
                      Row(
                        children: [
                          _buildPctPill('90%', (_estimated1RM * 0.9).round()),
                          const SizedBox(width: 6),
                          _buildPctPill('80%', (_estimated1RM * 0.8).round()),
                          const SizedBox(width: 6),
                          _buildPctPill('70%', (_estimated1RM * 0.7).round()),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Protocol Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: List.generate(_filters.length, (index) {
                final isSelected = index == _selectedFilterIndex;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      setState(() => _selectedFilterIndex = index);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? KineticPulseColors.electricLime : KineticPulseColors.surfaceTier2,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: isSelected ? KineticPulseColors.electricLime : KineticPulseColors.hairline,
                        ),
                      ),
                      child: Text(
                        _filters[index],
                        style: GoogleFonts.barlowCondensed(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                          color: isSelected ? KineticPulseColors.textOnLime : KineticPulseColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 16),

          // Protocol List Cards
          ...filteredProtocols.map((protocol) => _buildProtocolCard(context, protocol)),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, String unit, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 9, color: KineticPulseColors.textSecondary, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value, style: GoogleFonts.barlowCondensed(fontSize: 22, fontWeight: FontWeight.w900, color: color)),
              const SizedBox(width: 2),
              Text(unit, style: GoogleFonts.barlowCondensed(fontSize: 10, fontWeight: FontWeight.w700, color: KineticPulseColors.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _calcBtn(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: KineticPulseColors.surfaceTier3,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(label, style: GoogleFonts.barlowCondensed(fontSize: 18, fontWeight: FontWeight.w800, color: KineticPulseColors.textPrimary)),
      ),
    );
  }

  Widget _buildPctPill(String pct, int kg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: KineticPulseColors.surfaceTier3,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Text(pct, style: GoogleFonts.spaceGrotesk(fontSize: 9, color: KineticPulseColors.neonCyan, fontWeight: FontWeight.w700)),
          Text('$kg kg', style: GoogleFonts.barlowCondensed(fontSize: 12, fontWeight: FontWeight.w800, color: KineticPulseColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _buildProtocolCard(BuildContext context, Map<String, dynamic> protocol) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: KineticPulseColors.surfaceTier1,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: KineticPulseColors.hairline),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  protocol['image'] as String,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(color: const Color(0xFF16181F)),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        KineticPulseColors.surfaceTier1.withAlpha(240),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: KineticPulseColors.baseGround.withAlpha(210),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: KineticPulseColors.hairline),
                    ),
                    child: Text(
                      protocol['category'] as String,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: KineticPulseColors.neonCyan,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  protocol['title'] as String,
                  style: GoogleFonts.barlowCondensed(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: KineticPulseColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  (protocol['exercises'] as List<String>).join(' · '),
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 12,
                    color: KineticPulseColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),

                // Targeted Muscle Badges
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: (protocol['muscles'] as List<String>).map((m) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: KineticPulseColors.surfaceTier2,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: KineticPulseColors.hairline),
                      ),
                      child: Text(
                        m,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 10,
                          color: KineticPulseColors.textSecondary,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.timer_outlined, size: 16, color: KineticPulseColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(protocol['duration'] as String, style: GoogleFonts.barlowCondensed(fontWeight: FontWeight.w700, color: KineticPulseColors.textSecondary)),
                        const SizedBox(width: 12),
                        const Icon(Icons.fitness_center, size: 16, color: KineticPulseColors.textSecondary),
                        const SizedBox(width: 4),
                        Text('${protocol['exercisesCount']} EXERCISES', style: GoogleFonts.barlowCondensed(fontWeight: FontWeight.w700, color: KineticPulseColors.textSecondary)),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        HapticFeedback.heavyImpact();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ActiveSessionPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.play_arrow, size: 18),
                      label: Text(
                        'START LAB',
                        style: GoogleFonts.barlowCondensed(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: KineticPulseColors.electricLime,
                        foregroundColor: KineticPulseColors.textOnLime,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
