import 'package:flutter/material.dart';
import 'package:mini_dashboard_widgets/mini_dashboard_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mini Dashboard Widgets Demo',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'A showcase of beautiful, customizable dashboard components',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),
            
            // Stat Cards
            Text(
              'Statistics Overview',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildStatCards(context),
            const SizedBox(height: 32),
            
            // Charts
            Text(
              'Performance Metrics',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildCharts(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCards(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.grey[800] : Colors.white;
    
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        StatCard(
          title: 'Total Users',
          value: '8,249',
          icon: Icons.people,
          iconColor: Colors.blue,
          backgroundColor: backgroundColor!,
          onTap: () => _showSnackBar(context, 'Users tapped'),
          trailing: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              '+12%',
              style: TextStyle(
                color: Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        StatCard(
          title: 'Revenue',
          value: '\$24,580',
          icon: Icons.attach_money,
          iconColor: Colors.green,
          backgroundColor: backgroundColor,
          onTap: () => _showSnackBar(context, 'Revenue tapped'),
          trailing: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              '-3%',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        StatCard(
          title: 'Tasks',
          value: '64/128',
          icon: Icons.task_alt,
          iconColor: Colors.orange,
          backgroundColor: backgroundColor,
          onTap: () => _showSnackBar(context, 'Tasks tapped'),
          footer: const LinearProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.grey,
            color: Colors.orange,
          ),
        ),
        StatCard(
          title: 'Conversion',
          value: '24.3%',
          icon: Icons.trending_up,
          iconColor: Colors.purple,
          backgroundColor: backgroundColor,
          onTap: () => _showSnackBar(context, 'Conversion tapped'),
          trailing: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              '+5%',
              style: TextStyle(
                color: Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCharts(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.grey[800] : Colors.white;
    
    // Sample data for pie chart
    final pieData = [
      PieData(label: 'Sales', value: 35, color: Colors.blue),
      PieData(label: 'Marketing', value: 25, color: Colors.green),
      PieData(label: 'Operations', value: 20, color: Colors.orange),
      PieData(label: 'Support', value: 15, color: Colors.purple),
      PieData(label: 'R&D', value: 5, color: Colors.red),
    ];

    // Sample data for bar chart
    final barData = [
      BarData(label: 'Mon', value: 35, color: Colors.blue),
      BarData(label: 'Tue', value: 42, color: Colors.blue),
      BarData(label: 'Wed', value: 28, color: Colors.blue),
      BarData(label: 'Thu', value: 45, color: Colors.blue),
      BarData(label: 'Fri', value: 38, color: Colors.blue),
      BarData(label: 'Sat', value: 23, color: Colors.blue),
      BarData(label: 'Sun', value: 18, color: Colors.blue),
    ];

    return Column(
      children: [
        SizedBox(
          height: 300,
          child: PieSummary(
            data: pieData,
            backgroundColor: backgroundColor!,
            centerLabel: 'Budget',
            legendPosition: LegendPosition.right,
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 300,
          child: ActivityBar(
            data: barData,
            backgroundColor: backgroundColor,
            title: 'Weekly Activity',
            barWidth: 20,
          ),
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
