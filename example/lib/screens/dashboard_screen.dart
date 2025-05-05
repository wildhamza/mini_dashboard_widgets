import 'package:flutter/material.dart';
import 'package:mini_dashboard_widgets/mini_dashboard_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Demo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mini Dashboard Widgets',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Beautiful, customizable dashboard components',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),
              const Text(
                'Stats',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildStatCards(),
              const SizedBox(height: 24),
              const Text(
                'Sales Breakdown',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: _buildPieChart(),
              ),
              const SizedBox(height: 24),
              const Text(
                'Weekly Performance',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: _buildBarChart(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCards() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        StatCard(
          title: 'Total Sales',
          value: '\$15,349',
          icon: Icons.attach_money,
          iconColor: Colors.green,
        ),
        StatCard(
          title: 'Customers',
          value: '1,249',
          icon: Icons.people,
          iconColor: Colors.blue,
        ),
        StatCard(
          title: 'Products',
          value: '374',
          icon: Icons.inventory,
          iconColor: Colors.orange,
        ),
        StatCard(
          title: 'Revenue',
          value: '\$9,271',
          icon: Icons.trending_up,
          iconColor: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildPieChart() {
    final List<PieData> pieData = [
      const PieData(
        label: 'Electronics',
        value: 35,
        color: Colors.blue,
      ),
      const PieData(
        label: 'Clothing',
        value: 25,
        color: Colors.green,
      ),
      const PieData(
        label: 'Food',
        value: 20,
        color: Colors.orange,
      ),
      const PieData(
        label: 'Home',
        value: 15,
        color: Colors.purple,
      ),
      const PieData(
        label: 'Other',
        value: 5,
        color: Colors.grey,
      ),
    ];

    return PieSummary(
      data: pieData,
      centerWidget: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Total',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            '\$15,349',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    final List<BarData> barData = [
      const BarData(label: 'Mon', value: 30),
      const BarData(label: 'Tue', value: 45),
      const BarData(label: 'Wed', value: 25),
      const BarData(label: 'Thu', value: 60),
      const BarData(label: 'Fri', value: 40),
      const BarData(label: 'Sat', value: 25),
      const BarData(label: 'Sun', value: 15),
    ];

    return ActivityBar(
      data: barData,
    );
  }
}
