import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_widgets.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int _selectedSem = 4;

  final Map<int, List<_SubjectGrade>> _results = {
    4: [
      _SubjectGrade('Data Structures', 'A+', 10, AppColors.accentGreen),
      _SubjectGrade('Operating Systems', 'A', 9, AppColors.accentTeal),
      _SubjectGrade('DBMS', 'A+', 10, AppColors.accentGreen),
      _SubjectGrade('Computer Networks', 'B+', 8, AppColors.accentOrange),
      _SubjectGrade('Mathematics III', 'A', 9, AppColors.accentTeal),
    ],
    3: [
      _SubjectGrade('OOP with Java', 'A', 9, AppColors.accentTeal),
      _SubjectGrade('Digital Electronics', 'B+', 8, AppColors.accentOrange),
      _SubjectGrade('Discrete Maths', 'A+', 10, AppColors.accentGreen),
      _SubjectGrade('Data Communication', 'B', 7, AppColors.accentPurple),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final tc = Tc.of(context);
    final grades = _results[_selectedSem] ?? [];
    return Scaffold(
      backgroundColor: tc.bg,
      body: Container(
        decoration: BoxDecoration(gradient: tc.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context, tc),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  children: [
                    _buildSemSelector(tc),
                    const SizedBox(height: 18),
                    _buildGpaSummary(tc),
                    const SizedBox(height: 18),
                    ...grades.map((g) => _gradeCard(tc, g)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, Tc tc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: tc.textPrimary),
              onPressed: () => Navigator.pop(context)),
          const SizedBox(width: 4),
          Text('Results',
              style: TextStyle(
                  color: tc.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildSemSelector(Tc tc) {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (_, i) {
          final sem = i + 1;
          final isSelected = _selectedSem == sem;
          return GestureDetector(
            onTap: () => setState(() => _selectedSem = sem),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 78,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                gradient: isSelected ? AppColors.primaryGradient : null,
                color: isSelected ? null : tc.glassWhite,
                borderRadius: BorderRadius.circular(12),
                border: isSelected ? null : Border.all(color: tc.glassBorder),
              ),
              alignment: Alignment.center,
              child: Text('Sem $sem',
                  style: TextStyle(
                      color: isSelected ? Colors.white : tc.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGpaSummary(Tc tc) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(children: [
            const Text('SGPA',
                style: TextStyle(
                    color: AppColors.accentTeal,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text('9.2',
                style: TextStyle(
                    color: tc.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.w800)),
          ]),
          Container(width: 1, height: 50, color: tc.glassBorder),
          Column(children: [
            const Text('CGPA',
                style: TextStyle(
                    color: AppColors.accentPurple,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text('8.8',
                style: TextStyle(
                    color: tc.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.w800)),
          ]),
          Container(width: 1, height: 50, color: tc.glassBorder),
          Column(children: [
            Text('Credits',
                style: TextStyle(
                    color: tc.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text('22',
                style: TextStyle(
                    color: tc.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.w800)),
          ]),
        ],
      ),
    );
  }

  Widget _gradeCard(Tc tc, _SubjectGrade g) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  color: g.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                  child: Text(g.grade,
                      style: TextStyle(
                          color: g.color,
                          fontWeight: FontWeight.w800,
                          fontSize: 16))),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(g.name,
                      style: TextStyle(
                          color: tc.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  const SizedBox(height: 4),
                  Text('Grade Point: ${g.point}',
                      style: TextStyle(color: tc.textMuted, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubjectGrade {
  final String name, grade;
  final int point;
  final Color color;
  const _SubjectGrade(this.name, this.grade, this.point, this.color);
}
