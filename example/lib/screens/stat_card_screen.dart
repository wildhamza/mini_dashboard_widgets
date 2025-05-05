import 'package:flutter/material.dart';
import 'package:mini_dashboard_widgets/mini_dashboard_widgets.dart';

class StatCardScreen extends StatelessWidget {
  const StatCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stat Cards'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Stat Cards',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Display metric cards with icons, titles, and values',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 32),
              const Text(
                'Basic Cards',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const StatCard(
                title: 'Revenue',
                value: '\$42,580',
                icon: Icons.attach_money,
                iconColor: Colors.green,
              ),
              const SizedBox(height: 16),
              const StatCard(
                title: 'Orders',
                value: '1,204',
                icon: Icons.shopping_cart,
                iconColor: Colors.blue,
              ),
              const SizedBox(height: 32),
              const Text(
                'Customized Cards',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              StatCard(
                title: 'Visitors',
                value: '24.5K',
                icon: Icons.person,
                iconColor: Colors.purple,
                backgroundColor: Colors.purple.shade50,
                borderRadius: 20,
                elevation: 0,
              ),
              const SizedBox(height: 16),
              StatCard(
                title: 'Conversion Rate',
                value: '4.2%',
                icon: Icons.trending_up,
                iconColor: Colors.white,
                backgroundColor: Colors.orange,
                titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                valueStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                onTap: () {},
              ),
              const SizedBox(height: 32),
              const Text(
                'With Actions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              StatCard(
                title: 'Products',
                value: '423',
                icon: Icons.inventory,
                iconColor: Colors.blue,
                trailing: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {},
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
