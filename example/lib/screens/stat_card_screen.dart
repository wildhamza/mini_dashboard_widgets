import 'package:flutter/material.dart';
import 'package:mini_dashboard_widgets/mini_dashboard_widgets.dart';

class StatCardScreen extends StatefulWidget {
  const StatCardScreen({Key? key}) : super(key: key);

  @override
  State<StatCardScreen> createState() => _StatCardScreenState();
}

class _StatCardScreenState extends State<StatCardScreen> {
  bool _useCustomStyles = false;
  bool _showTrailing = true;
  bool _showFooter = true;
  double _elevation = 2.0;
  double _borderRadius = 12.0;

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
              'Stat Card Examples',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'A showcase of StatCard widget customization options',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 16),
            
            // Customization controls
            _buildCustomizationControls(),
            const SizedBox(height: 24),
            
            // Basic examples
            Text(
              'Basic Examples',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            GridView.count(
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
                  backgroundColor: defaultBackgroundColor,
                  titleStyle: _useCustomStyles 
                      ? const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ) 
                      : null,
                  valueStyle: _useCustomStyles 
                      ? const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ) 
                      : null,
                  elevation: _elevation,
                  borderRadius: BorderRadius.circular(_borderRadius),
                  trailing: _showTrailing 
                      ? Container(
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
                        ) 
                      : null,
                  footer: _showFooter 
                      ? const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Last updated: Today',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ) 
                      : null,
                  onTap: () => _showSnackBar(context, 'Users card tapped'),
                ),
                StatCard(
                  title: 'Revenue',
                  value: '\$24,580',
                  icon: Icons.attach_money,
                  iconColor: Colors.green,
                  backgroundColor: defaultBackgroundColor,
                  titleStyle: _useCustomStyles 
                      ? const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ) 
                      : null,
                  valueStyle: _useCustomStyles 
                      ? const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ) 
                      : null,
                  elevation: _elevation,
                  borderRadius: BorderRadius.circular(_borderRadius),
                  trailing: _showTrailing 
                      ? Container(
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
                        ) 
                      : null,
                  footer: _showFooter 
                      ? const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Last updated: Today',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ) 
                      : null,
                  onTap: () => _showSnackBar(context, 'Revenue card tapped'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Advanced examples
            Text(
              'Custom Styles',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // Gradient background example
                StatCard(
                  title: 'New Orders',
                  value: '384',
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6448FE), Color(0xFF5FC6FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(_borderRadius),
                  ),
                  titleStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                  ),
                  valueStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  iconBuilder: (context, icon, color) {
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
                        color: color,
                        size: 24,
                      ),
                    );
                  },
                  elevation: _elevation,
                  borderRadius: BorderRadius.circular(_borderRadius),
                  trailing: _showTrailing 
                      ? Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            '+8%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ) 
                      : null,
                  footer: _showFooter 
                      ? const LinearProgressIndicator(
                          value: 0.8,
                          backgroundColor: Colors.white24,
                          color: Colors.white,
                        ) 
                      : null,
                  onTap: () => _showSnackBar(context, 'Orders card tapped'),
                ),
                
                // Custom border example
                StatCard(
                  title: 'Completed Tasks',
                  value: '75%',
                  icon: Icons.task_alt,
                  iconColor: Colors.purple,
                  decoration: BoxDecoration(
                    color: defaultBackgroundColor,
                    borderRadius: BorderRadius.circular(_borderRadius),
                    border: Border.all(
                      color: Colors.purple.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  titleStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.purple,
                  ),
                  valueStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.purple,
                  ),
                  elevation: _elevation,
                  borderRadius: BorderRadius.circular(_borderRadius),
                  trailing: _showTrailing 
                      ? const Icon(
                          Icons.arrow_upward,
                          color: Colors.purple,
                          size: 20,
                        ) 
                      : null,
                  footer: _showFooter 
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: const LinearProgressIndicator(
                            value: 0.75,
                            backgroundColor: Colors.grey,
                            color: Colors.purple,
                            minHeight: 8,
                          ),
                        ) 
                      : null,
                  onTap: () => _showSnackBar(context, 'Tasks card tapped'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Custom layouts
            Text(
              'Custom Layouts',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            StatCard(
              title: 'Server Status',
              value: 'Online',
              icon: Icons.cloud_done,
              iconColor: Colors.teal,
              backgroundColor: defaultBackgroundColor,
              elevation: _elevation,
              borderRadius: BorderRadius.circular(_borderRadius),
              header: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Production Server',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              footer: _showFooter 
                  ? Container(
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('CPU', style: TextStyle(fontSize: 10, color: Colors.grey)),
                              Text('32%', style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('RAM', style: TextStyle(fontSize: 10, color: Colors.grey)),
                              Text('45%', style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('DISK', style: TextStyle(fontSize: 10, color: Colors.grey)),
                              Text('78%', style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ) 
                  : null,
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
                  child: SwitchListTile(
                    title: const Text('Custom Styles'),
                    value: _useCustomStyles,
                    onChanged: (value) => setState(() => _useCustomStyles = value),
                    dense: true,
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    title: const Text('Show Trailing'),
                    value: _showTrailing,
                    onChanged: (value) => setState(() => _showTrailing = value),
                    dense: true,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    title: const Text('Show Footer'),
                    value: _showFooter,
                    onChanged: (value) => setState(() => _showFooter = value),
                    dense: true,
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(height: 8),
            Text('Elevation: ${_elevation.toStringAsFixed(1)}'),
            Slider(
              value: _elevation,
              min: 0,
              max: 20,
              divisions: 20,
              label: _elevation.toStringAsFixed(1),
              onChanged: (value) => setState(() => _elevation = value),
            ),
            Text('Border Radius: ${_borderRadius.toStringAsFixed(1)}'),
            Slider(
              value: _borderRadius,
              min: 0,
              max: 32,
              divisions: 32,
              label: _borderRadius.toStringAsFixed(1),
              onChanged: (value) => setState(() => _borderRadius = value),
            ),
          ],
        ),
      ),
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
