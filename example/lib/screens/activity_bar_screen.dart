import 'package:flutter/material.dart';
import 'package:mini_dashboard_widgets/mini_dashboard_widgets.dart';

class ActivityBarScreen extends StatefulWidget {
  const ActivityBarScreen({Key? key}) : super(key: key);

  @override
  State<ActivityBarScreen> createState() => _ActivityBarScreenState();
}

class _ActivityBarScreenState extends State<ActivityBarScreen> {
  // Customization controls
  BarChartOrientation _orientation = BarChartOrientation.vertical;
  bool _showAxisLabels = true;
  bool _showGridLines = true;
  bool _roundedCorners = true;
  bool _animate = true;
  double _barWidth = 20.0;
  double _cornerRadius = 4.0;

  // Sample data sets
  late List<BarData> _weeklyData;
  late List<BarData> _monthlyData;
  late List<BarData> _salesData;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    // Weekly data
    _weeklyData = [
      BarData(label: 'Mon', value: 35, color: Colors.blue),
      BarData(label: 'Tue', value: 42, color: Colors.blue),
      BarData(label: 'Wed', value: 28, color: Colors.blue),
      BarData(label: 'Thu', value: 45, color: Colors.blue),
      BarData(label: 'Fri', value: 38, color: Colors.blue),
      BarData(label: 'Sat', value: 23, color: Colors.blue),
      BarData(label: 'Sun', value: 18, color: Colors.blue),
    ];

    // Monthly data
    _monthlyData = [
      BarData(label: 'Jan', value: 45, color: Colors.purple),
      BarData(label: 'Feb', value: 38, color: Colors.purple),
      BarData(label: 'Mar', value: 52, color: Colors.purple),
      BarData(label: 'Apr', value: 35, color: Colors.purple),
      BarData(label: 'May', value: 60, color: Colors.purple),
      BarData(label: 'Jun', value: 48, color: Colors.purple),
    ];

    // Sales data with different colors
    _salesData = [
      BarData(label: 'Product A', value: 28, color: Colors.blue),
      BarData(label: 'Product B', value: 45, color: Colors.green),
      BarData(label: 'Product C', value: 32, color: Colors.orange),
      BarData(label: 'Product D', value: 18, color: Colors.red),
      BarData(label: 'Product E', value: 38, color: Colors.purple),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBackgroundColor = isDark ? Colors.grey[800]! : Colors.white;
    
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Activity Bar Examples',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'A showcase of ActivityBar widget customization options',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 16),
            
            // Customization controls
            _buildCustomizationControls(),
            const SizedBox(height: 24),
            
            // Basic bar chart with customization
            Text(
              'Weekly Activity',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 350,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ActivityBar(
                    data: _weeklyData,
                    orientation: _orientation,
                    showAxisLabels: _showAxisLabels,
                    showGridLines: _showGridLines,
                    roundedCorners: _roundedCorners,
                    barWidth: _barWidth,
                    cornerRadius: _cornerRadius,
                    animate: _animate,
                    backgroundColor: defaultBackgroundColor,
                    title: 'Daily Activity',
                    xAxisTitle: 'Day of Week',
                    yAxisTitle: 'Activity',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Monthly trend example
            Text(
              'Monthly Trend',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 350,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Monthly Performance',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.purple.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Text(
                              'First Half 2023',
                              style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ActivityBar(
                          data: _monthlyData,
                          backgroundColor: defaultBackgroundColor,
                          barWidth: 30,
                          barSpacing: 30,
                          cornerRadius: 6,
                          showBottomBorder: true,
                          yAxisTitle: 'Score',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Sales comparison example
            Text(
              'Product Sales',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 350,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Performance',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sales in thousands (\$)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ActivityBar(
                          data: _salesData,
                          orientation: BarChartOrientation.horizontal,
                          backgroundColor: defaultBackgroundColor,
                          barWidth: 24,
                          cornerRadius: 8,
                          barSpacing: 24,
                          xAxisTitle: 'Sales',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomizationControls() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customization Options',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<BarChartOrientation>(
                    decoration: const InputDecoration(
                      labelText: 'Orientation',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    value: _orientation,
                    items: BarChartOrientation.values.map((orientation) {
                      return DropdownMenuItem<BarChartOrientation>(
                        value: orientation,
                        child: Text(orientation.toString().split('.').last),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _orientation = value);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SwitchListTile(
                    title: const Text('Axis Labels'),
                    value: _showAxisLabels,
                    onChanged: (value) => setState(() => _showAxisLabels = value),
                    dense: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    title: const Text('Grid Lines'),
                    value: _showGridLines,
                    onChanged: (value) => setState(() => _showGridLines = value),
                    dense: true,
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    title: const Text('Rounded Corners'),
                    value: _roundedCorners,
                    onChanged: (value) => setState(() => _roundedCorners = value),
                    dense: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    title: const Text('Animate'),
                    value: _animate,
                    onChanged: (value) => setState(() => _animate = value),
                    dense: true,
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(height: 16),
            Text('Bar Width: ${_barWidth.toStringAsFixed(1)}'),
            Slider(
              value: _barWidth,
              min: 10,
              max: 40,
              divisions: 30,
              label: _barWidth.toStringAsFixed(1),
              onChanged: (value) => setState(() => _barWidth = value),
            ),
            Text('Corner Radius: ${_cornerRadius.toStringAsFixed(1)}'),
            Slider(
              value: _cornerRadius,
              min: 0,
              max: 16,
              divisions: 16,
              label: _cornerRadius.toStringAsFixed(1),
              onChanged: (value) => setState(() => _cornerRadius = value),
            ),
          ],
        ),
      ),
    );
  }
}
