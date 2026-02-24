// dart:ui removed — no longer needed after BackdropFilter removal
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../theme/app_theme.dart';

class MyIdScreen extends StatelessWidget {
  const MyIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: _buildIdCard(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 12, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: AppColors.textPrimary, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          Text('My ID', style: Theme.of(context).textTheme.titleLarge),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.share_outlined,
                color: AppColors.textSecondary, size: 20),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildIdCard(BuildContext context) {
    const double avatarRadius = 44;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Header ──
          Column(
            children: [
              // Blue gradient header with university name
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 28),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0F3AAE), Color(0xFF3B82F6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.school,
                          color: Colors.white, size: 15),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Pondicherry University',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),
              // Avatar — sits below the gradient, no overlap
              Transform.translate(
                offset: const Offset(0, -20),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.warmGradient,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.bgCard),
                    child: CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: AppColors.bgMedium,
                      child: const Icon(Icons.person_rounded,
                          size: 44, color: AppColors.textMuted),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Negative spacing to compensate for Transform.translate
          const SizedBox(height: 1),

          // ── Name & Role ──
          const Text(
            'Balakumaran D',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.accentTeal.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'POST GRADUATION',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accentTeal,
                  letterSpacing: 1.4),
            ),
          ),

          const SizedBox(height: 22),

          // ── QR Code ──
          SizedBox(
            width: 160,
            height: 160,
            child: CustomPaint(
              painter: _CornerBorderPainter(
                color: AppColors.accentTeal.withValues(alpha: 0.35),
                strokeWidth: 2.5,
                cornerLength: 24,
                cornerRadius: 8,
              ),
              child: Center(
                child: QrImageView(
                  data: 'PUNOVA-S67480-BALAKUMARAN-D',
                  version: QrVersions.auto,
                  size: 128,
                  backgroundColor: Colors.white,
                  eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square, color: Color(0xFF0F2A4A)),
                  dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: Color(0xFF0F2A4A)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text('Scan for campus access',
              style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                  fontStyle: FontStyle.italic)),

          const SizedBox(height: 18),

          // ── Divider ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.transparent,
                  AppColors.glassBorder,
                  Colors.transparent
                ]),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // ── Details ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: _detailBlock(
                            'ID NUMBER', 'S67480', CrossAxisAlignment.start)),
                    _detailBlock(
                        'VALID UPTO', '31/05/2026', CrossAxisAlignment.end),
                  ],
                ),
                const SizedBox(height: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('DEPARTMENT',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textMuted,
                            letterSpacing: 1)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.glassWhite,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.glassBorder),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.computer_rounded,
                              size: 16, color: AppColors.accentTeal),
                          SizedBox(width: 8),
                          Text('Computer Science',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // ── Sync info ──
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.sync_rounded, size: 14, color: AppColors.textMuted),
              const SizedBox(width: 6),
              Text('Last synced: Just now',
                  style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _detailBlock(String label, String value, CrossAxisAlignment align) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
                letterSpacing: 1)),
        const SizedBox(height: 6),
        Text(value,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                letterSpacing: 0.5)),
      ],
    );
  }
}

class _CornerBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double cornerLength;
  final double cornerRadius;

  _CornerBorderPainter(
      {required this.color,
      required this.strokeWidth,
      required this.cornerLength,
      required this.cornerRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final w = size.width, h = size.height, cl = cornerLength, r = cornerRadius;

    canvas.drawPath(
        Path()
          ..moveTo(0, cl)
          ..lineTo(0, r)
          ..quadraticBezierTo(0, 0, r, 0)
          ..lineTo(cl, 0),
        paint);
    canvas.drawPath(
        Path()
          ..moveTo(w - cl, 0)
          ..lineTo(w - r, 0)
          ..quadraticBezierTo(w, 0, w, r)
          ..lineTo(w, cl),
        paint);
    canvas.drawPath(
        Path()
          ..moveTo(0, h - cl)
          ..lineTo(0, h - r)
          ..quadraticBezierTo(0, h, r, h)
          ..lineTo(cl, h),
        paint);
    canvas.drawPath(
        Path()
          ..moveTo(w - cl, h)
          ..lineTo(w - r, h)
          ..quadraticBezierTo(w, h, w, h - r)
          ..lineTo(w, h - cl),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
