import 'package:driver_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  static const routeName = '/driver-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Dashboard'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) =>
                      const DriverLoginScreen(supabaseReady: true),
                ),
                (_) => false,
              );
            },
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Logout'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          _DriverHero(),
          SizedBox(height: 20),
          _DriverOperationsGrid(),
          SizedBox(height: 20),
          _ShiftChecklist(),
        ],
      ),
    );
  }
}

class _DriverHero extends StatelessWidget {
  const _DriverHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE76F51), Color(0xFF7A351F)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shift Control Center',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Review trip status, departure readiness, and route alerts before going live.',
            style: TextStyle(color: Color(0xFFFFE4DB), height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _DriverOperationsGrid extends StatelessWidget {
  const _DriverOperationsGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: MediaQuery.of(context).size.width > 720 ? 4 : 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.18,
      children: const [
        _DriverMetricCard(
          title: 'Trip Status',
          value: 'Ready',
          icon: Icons.play_circle_outline_rounded,
        ),
        _DriverMetricCard(
          title: 'Fuel Check',
          value: 'Done',
          icon: Icons.local_gas_station_outlined,
        ),
        _DriverMetricCard(
          title: 'Route Alerts',
          value: '01',
          icon: Icons.warning_amber_rounded,
        ),
        _DriverMetricCard(
          title: 'Passengers',
          value: '34',
          icon: Icons.groups_2_outlined,
        ),
      ],
    );
  }
}

class _DriverMetricCard extends StatelessWidget {
  const _DriverMetricCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 30),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}

class _ShiftChecklist extends StatelessWidget {
  const _ShiftChecklist();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Departure checklist',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 14),
            Text('1. Bus inspection completed'),
            SizedBox(height: 8),
            Text('2. Ticket scanner synchronized'),
            SizedBox(height: 8),
            Text('3. Route and dispatch notes reviewed'),
            SizedBox(height: 8),
            Text('4. Emergency contacts confirmed'),
          ],
        ),
      ),
    );
  }
}
