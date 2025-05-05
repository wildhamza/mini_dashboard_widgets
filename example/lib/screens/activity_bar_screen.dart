import 'package:flutter/material.dart';
import 'package:mini_dashboard_widgets/mini_dashboard_widgets.dart';

class ActivityBarScreen extends StatelessWidget {
  const ActivityBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Bars'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Activity Bars',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Visualize trends and activities with bar charts',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 32),
              const Text(
                'Vertical Bars',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: _buildVerticalBars(),
              ),
              const SizedBox(height: 32),
              const Text(
                'Horizontal Bars',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: _buildHorizontalBars(),
              ),
              const SizedBox(height: 32),
              const Text(
                'Customized Bars',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: _buildCustomizedBars(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalBars() {
    final List<BarData> barData = [
      const BarData(label: 'Jan', value: 30),
      const BarData(label: 'Feb', value: 45),
      const BarData(label: 'Mar', value: 25),
      const BarData(label: 'Apr', value: 60),
      const BarData(label: 'May', value: 40),
      const BarData(label: 'Jun', value: 80),
    ];

    return ActivityBar(
      data: barData,
      orientation: BarOrientation.vertical,
    );
  }

  Widget _buildHorizontalBars() {
    final List<BarData> barData = [
      const BarData(label: 'USA', value: 80),
      const BarData(label: 'UK', value: 55),
      const BarData(label: 'Japan', value: 45),
      const BarData(label: 'Germany', value: 40),
      const BarData(label: 'France', value: 35),
    ];

    return ActivityBar(
      data: barData,
      orientation: BarOrientation.horizontal,
    );
  }

  Widget _buildCustomizedBars() {
    final List<BarData> barData = [
      BarData(label: 'Q1', value: 45, color: Colors.blue.shade300),
      BarData(label: 'Q2', value: 65, color: Colors.blue.shade500),
      BarData(label: 'Q3', value: 35, color: Colors.blue.shade700),
      BarData(label: 'Q4', value: 85, color: Colors.blue.shade900),
    ];

    return ActivityBar(
      data: barData,
      barWidth: 30,
      barRadius: 10,
      showGridLines: false,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade50,
            Colors.blue.shade100,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
    );
  }
}
