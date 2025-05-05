import 'package:flutter/material.dart';
import 'package:mini_dashboard_widgets/mini_dashboard_widgets.dart';

class PieSummaryScreen extends StatelessWidget {
  const PieSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pie Summary'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pie Summary',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Visualize proportions with beautiful, interactive pie charts',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 32),
              const Text(
                'Basic Pie Chart',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: _buildBasicPieChart(),
              ),
              const SizedBox(height: 32),
              const Text(
                'With Center Content',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: _buildPieChartWithCenter(),
              ),
              const SizedBox(height: 32),
              const Text(
                'Custom Legend Position',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: _buildPieChartWithCustomLegend(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicPieChart() {
    final List<PieData> pieData = [
      const PieData(
        label: 'Desktop',
        value: 45,
        color: Colors.blue,
        tooltipText: '45% from Desktop',
      ),
      const PieData(
        label: 'Mobile',
        value: 35,
        color: Colors.green,
        tooltipText: '35% from Mobile',
      ),
      const PieData(
        label: 'Tablet',
        value: 20,
        color: Colors.orange,
        tooltipText: '20% from Tablet',
      ),
    ];

    return PieSummary(
      data: pieData,
      radius: 120,
      sectionStrokeWidth: 25,
    );
  }

  Widget _buildPieChartWithCenter() {
    final List<PieData> pieData = [
      const PieData(
        label: 'Completed',
        value: 68,
        color: Colors.green,
      ),
      const PieData(
        label: 'In Progress',
        value: 22,
        color: Colors.blue,
      ),
      const PieData(
        label: 'Pending',
        value: 10,
        color: Colors.orange,
      ),
    ];

    return PieSummary(
      data: pieData,
      radius: 120,
      sectionStrokeWidth: 35,
      centerWidget: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          shape: BoxShape.circle,
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tasks',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              '68%',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text(
              'Complete',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChartWithCustomLegend() {
    final List<PieData> pieData = [
      const PieData(
        label: 'Social',
        value: 40,
        color: Colors.blue,
      ),
      const PieData(
        label: 'Search',
        value: 25,
        color: Colors.green,
      ),
      const PieData(
        label: 'Direct',
        value: 20,
        color: Colors.purple,
      ),
      const PieData(
        label: 'Email',
        value: 15,
        color: Colors.orange,
      ),
    ];

    return PieSummary(
      data: pieData,
      radius: 120,
      sectionStrokeWidth: 35,
      legendPosition: LegendPosition.bottom,
      legendTextStyle: const TextStyle(fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
