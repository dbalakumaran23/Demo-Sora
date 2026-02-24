import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_widgets.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = Tc.of(context);
    final services = [
      _ServiceData('Papido', 'Food Ordering', Icons.fastfood_rounded,
          const LinearGradient(colors: [Color(0xFFFF6B35), Color(0xFFF7931E)])),
      _ServiceData(
          'Plink It',
          'Digital Payments',
          Icons.account_balance_wallet_rounded,
          const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF818CF8)])),
      _ServiceData(
          'Laundry',
          'Schedule Pickup',
          Icons.local_laundry_service_rounded,
          const LinearGradient(colors: [Color(0xFF14B8A6), Color(0xFF2DD4BF)])),
      _ServiceData('Stationery', 'Order Supplies', Icons.edit_rounded,
          const LinearGradient(colors: [Color(0xFFEC4899), Color(0xFFF472B6)])),
      _ServiceData('Print Shop', 'Print & Copy', Icons.print_rounded,
          const LinearGradient(colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)])),
      _ServiceData('Health', 'Medical Services', Icons.local_hospital_rounded,
          const LinearGradient(colors: [Color(0xFF22C55E), Color(0xFF4ADE80)])),
    ];

    return Scaffold(
      backgroundColor: tc.bg,
      body: Container(
        decoration: BoxDecoration(gradient: tc.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context, tc),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  itemCount: services.length,
                  itemBuilder: (_, i) => _serviceCard(tc, services[i]),
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
          Text('Services',
              style: TextStyle(
                  color: tc.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _serviceCard(Tc tc, _ServiceData s) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                  gradient: s.gradient,
                  borderRadius: BorderRadius.circular(16)),
              child: Icon(s.icon, color: Colors.white, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.name,
                      style: TextStyle(
                          color: tc.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(s.subtitle,
                      style: TextStyle(color: tc.textMuted, fontSize: 13)),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: tc.textMuted, size: 24),
          ],
        ),
      ),
    );
  }
}

class _ServiceData {
  final String name;
  final String subtitle;
  final IconData icon;
  final LinearGradient gradient;
  const _ServiceData(this.name, this.subtitle, this.icon, this.gradient);
}
