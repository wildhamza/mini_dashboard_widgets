import 'package:flutter/material.dart';
import 'package:mini_dashboard_widgets/mini_dashboard_widgets.dart';

class PieSummaryScreen extends StatefulWidget {
  const PieSummaryScreen({Key? key}) : super(key: key);

  @override
  State<PieSummaryScreen> createState() => _PieSummaryScreenState();
}

class _PieSummaryScreenState extends State<PieSummaryScreen> {
  // Customization controls
  LegendPosition _legendPosition = LegendPosition.bottom;
  bool _showLegend = true;
  bool _animate = true;
  bool _showCenterLabel = true;
  double _radius = 100.0;
  double _strokeWidth = 20.0;

  // Sample data
  late List<PieData> _defaultData;
  late List<PieData> _budgetData;
  late List<PieData> _deviceData;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    // Default data
    _defaultData = [
      PieData(label: 'Category A', value: 35, color: Colors.blue),
      PieData(label: 'Category B', value: 25, color: Colors.green),
      PieData(label: 'Category C', value: 20, color: Colors.orange),
      PieData(label: 'Category D', value: 15, color: Colors.purple),
      PieData(label: 'Category E', value: 5, color: Colors.red),
    ];

    // Budget data
    _budgetData = [
      PieData(label: 'Housing', value: 1200, color: Colors.indigo),
      PieData(label: 'Food', value: 500, color: Colors.teal),
      PieData(label: 'Transportation', value: 300, color: Colors.amber),
      PieData(label: 'Entertainment', value: 250, color: Colors.deepOrange),
      PieData(label: 'Utilities', value: 200, color: Colors.blue),
      PieData(label: 'Savings', value: 400, color: Colors.green),
      PieData(label: 'Others', value: 150, color: Colors.grey),
    ];

    // Device data
    _deviceData = [
      PieData(label: 'Mobile', value: 55, color: Colors.blue),
      PieData(label: 'Desktop', value: 30, color: Colors.green),
      PieData(label: 'Tablet', value: 15, color: Colors.orange),
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
              'Pie Summary Examples',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'A showcase of PieSummary widget customization options',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 16),
            
            // Customization controls
            _buildCustomizationControls(),
            const SizedBox(height: 24),
            
            // Default pie chart with customization
            Text(
              'Basic Pie Chart',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 350,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PieSummary(
                    data: _defaultData,
                    legendPosition: _legendPosition,
                    showLegend: _showLegend,
                    radius: _radius,
                    strokeWidth: _strokeWidth,
                    animate: _animate,
                    centerLabel: _showCenterLabel ? 'Total' : null,
                    backgroundColor: defaultBackgroundColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Budget example
            Text(
              'Monthly Budget',
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
                        'Expense Breakdown',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Monthly total: \$3,000',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: PieSummary(
                          data: _budgetData,
                          legendPosition: LegendPosition.right,
                          radius: 80,
                          strokeWidth: 30,
                          centerLabel: _showCenterLabel ? '\$3,000' : null,
                          centerLabelStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          backgroundColor: defaultBackgroundColor,
                          legendStyle: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Device distribution example
            Text(
              'Device Distribution',
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
                            'User Devices',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          TextButton.icon(
                            icon: const Icon(Icons.refresh, size: 16),
                            label: const Text('Refresh'),
                            onPressed: () {
                              // In a real app, this would refresh the data
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Data refreshed'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: PieSummary(
                          data: _deviceData,
                          legendPosition: LegendPosition.bottom,
                          radius: 100,
                          strokeWidth: 40,
                          centerLabel: _showCenterLabel ? 'Users' : null,
                          backgroundColor: defaultBackgroundColor,
                          legendItemBuilder: (data, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: data.color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    data.label,
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '(${data.value.toInt()}%)',
                                    style: TextStyle(
                                      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
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
                  child: DropdownButtonFormField<LegendPosition>(
                    decoration: const InputDecoration(
                      labelText: 'Legend Position',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    value: _legendPosition,
                    items: LegendPosition.values.map((position) {
                      return DropdownMenuItem<LegendPosition>(
                        value: position,
                        child: Text(position.toString().split('.').last),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _legendPosition = value);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SwitchListTile(
                    title: const Text('Show Legend'),
                    value: _showLegend,
                    onChanged: (value) => setState(() => _showLegend = value),
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
                    title: const Text('Animate'),
                    value: _animate,
                    onChanged: (value) => setState(() => _animate = value),
                    dense: true,
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    title: const Text('Center Label'),
                    value: _showCenterLabel,
                    onChanged: (value) => setState(() => _showCenterLabel = value),
                    dense: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Radius: ${_radius.toStringAsFixed(1)}'),
            Slider(
              value: _radius,
              min: 50,
              max: 150,
              divisions: 20,
              label: _radius.toStringAsFixed(1),
              onChanged: (value) => setState(() => _radius = value),
            ),
            Text('Stroke Width: ${_strokeWidth.toStringAsFixed(1)}'),
            Slider(
              value: _strokeWidth,
              min: 10,
              max: 50,
              divisions: 40,
              label: _strokeWidth.toStringAsFixed(1),
              onChanged: (value) => setState(() => _strokeWidth = value),
            ),
          ],
        ),
      ),
    );
  }
}
