import 'package:flutter/material.dart';
import 'package:passenger_app/screens/login_screen.dart';

class PassengerHomeScreen extends StatelessWidget {
  const PassengerHomeScreen({super.key, required this.passengerName});

  final String passengerName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Passenger Dashboard'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) =>
                      const PassengerLoginScreen(supabaseReady: true),
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
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0B8793), Color(0xFF1E4667)],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back, $passengerName',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Track buses in real time, review service updates, and monitor your next trip from one place.',
                  style: TextStyle(color: Color(0xFFE3F3F5), height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const _PassengerMetricGrid(),
          const SizedBox(height: 20),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today\'s trip brief',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 12),
                  Text('Preferred route: Colombo Fort to Maharagama'),
                  SizedBox(height: 8),
                  Text('Next predicted arrival: 8 minutes'),
                  SizedBox(height: 8),
                  Text('Network sync: healthy'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PassengerMetricGrid extends StatelessWidget {
  const _PassengerMetricGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: MediaQuery.of(context).size.width > 720 ? 4 : 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.28,
      children: const [
        _MetricCard(
          title: 'Saved Routes',
          value: '04',
          icon: Icons.route_rounded,
        ),
        _MetricCard(
          title: 'Live Buses',
          value: '12',
          icon: Icons.alt_route_rounded,
        ),
        _MetricCard(
          title: 'Alerts',
          value: '02',
          icon: Icons.notifications_active_outlined,
        ),
        _MetricCard(
          title: 'Tickets',
          value: '18',
          icon: Icons.confirmation_number_outlined,
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
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
            Icon(icon, size: 28),
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
