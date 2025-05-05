# Mini Dashboard Widgets

[![pub package](https://img.shields.io/pub/v/mini_dashboard_widgets.svg)](https://pub.dev/packages/mini_dashboard_widgets)
[![GitHub stars](https://img.shields.io/github/stars/wildhamza/mini_dashboard_widgets.svg?style=social)](https://github.com/wildhamza/mini_dashboard_widgets)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Flutter package that provides beautiful, highly customizable dashboard widgets including stat cards and charts. Perfect for creating modern, responsive dashboards in your Flutter applications.

<p align="center">
  <img src="https://raw.githubusercontent.com/wildhamza/mini_dashboard_widgets/main/screenshots/dashboard_preview.png" alt="Dashboard Preview" width="600"/>
</p>

## 📋 Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
  - [StatCard](#statcard)
  - [PieSummary](#piesummary)
  - [ActivityBar](#activitybar)
  - [Theming](#theming)
- [Customization](#customization)
- [Example](#example)
- [Contributing](#contributing)
- [License](#license)

## ✨ Features

- **StatCard**: Sleek, customizable metric cards with icons, titles, and values
- **PieSummary**: Interactive pie charts with customizable legends and animations
- **ActivityBar**: Horizontal and vertical bar charts for visualizing trends and metrics
- **Theming System**: Comprehensive theming support with light/dark mode adaptability
- **Responsive**: All widgets are designed to work across different screen sizes
- **Highly Customizable**: Extensive customization options for each widget
- **Material Design 3**: Follows latest Material Design guidelines

## 📥 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  mini_dashboard_widgets: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## 🚀 Usage

Import the package:

```dart
import 'package:mini_dashboard_widgets/mini_dashboard_widgets.dart';
```

### StatCard

StatCard is a modern, customizable card widget for displaying key metrics with an icon, title, and value.

```dart
StatCard(
  title: 'Total Sales',
  value: '$15,349',
  icon: Icons.attach_money,
  iconColor: Colors.green,
  // Optional customizations
  backgroundColor: Colors.white,
  borderRadius: 12.0,
  elevation: 2.0,
  onTap: () => print('Card tapped!'),
  // Advanced customizations
  titleStyle: TextStyle(fontWeight: FontWeight.w500),
  valueStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  trailing: Badge(label: Text('New')),
)
```

### PieSummary

PieSummary is an interactive pie chart widget with customizable sections and legends.

```dart
final List<PieData> pieData = [
  PieData(label: 'Category 1', value: 35, color: Colors.blue),
  PieData(label: 'Category 2', value: 25, color: Colors.green),
  PieData(label: 'Category 3', value: 20, color: Colors.orange),
  PieData(label: 'Category 4', value: 15, color: Colors.purple),
];

PieSummary(
  data: pieData,
  radius: 120,
  sectionStrokeWidth: 25,
  legendPosition: LegendPosition.right,
  // Optional center widget
  centerWidget: Text('Total: 95'),
  // Advanced customizations
  animationDuration: Duration(milliseconds: 800),
  legendTextStyle: TextStyle(fontSize: 12),
  showPercentages: true,
  onSectionTap: (index) => print('Tapped section $index'),
)
```

### ActivityBar

ActivityBar is a flexible bar chart widget for visualizing data trends.

```dart
final List<BarData> barData = [
  BarData(label: 'Mon', value: 30),
  BarData(label: 'Tue', value: 45),
  BarData(label: 'Wed', value: 25),
  BarData(label: 'Thu', value: 60),
  BarData(label: 'Fri', value: 40),
];

ActivityBar(
  data: barData,
  orientation: BarOrientation.vertical, // or .horizontal
  barWidth: 16.0,
  barRadius: 6.0,
  showGridLines: true,
  // Advanced customizations
  barColor: Colors.blue,
  barGradient: LinearGradient(
    colors: [Colors.blue.shade300, Colors.blue.shade700],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  animationDuration: Duration(milliseconds: 600),
  showLabels: true,
  showValues: true,
  onBarTap: (index) => print('Tapped bar $index'),
)
```

### Theming

The package includes a theming system that automatically adapts to light and dark modes:

```dart
// Apply custom theme to all widgets
MiniDashboardThemeData themeData = MiniDashboardThemeData(
  primaryColor: Colors.indigo,
  secondaryColor: Colors.amber,
  cardBackgroundLight: Colors.white,
  cardBackgroundDark: Color(0xFF2D2D2D),
  titleStyleLight: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  titleStyleDark: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white70),
  valueStyleLight: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  valueStyleDark: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
);

// Apply theme to your app
MiniDashboardTheme(
  data: themeData,
  child: MyApp(),
)
```

## 🎨 Customization

All widgets support extensive customization including:

- **Colors and styles**: Customize colors, text styles, and visual appearance
- **Layout and sizing**: Control padding, margins, and dimensions
- **Effects**: Apply shadows, gradients, and animations
- **Interactions**: Define tap behaviors and feedback
- **Custom builders**: Use builder functions for advanced customization
- **Responsive design**: Adapt to different screen sizes and orientations

## 📱 Example

A complete example app is included in the `/example` directory. It demonstrates all widgets in a cohesive dashboard with navigation between different screens.

To run the example:

```bash
cd example
flutter run
```

## 🤝 Contributing

Contributions are welcome! If you find a bug or want a feature, please open an issue.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

Made with ❤️ by [Hamza](https://github.com/wildhamza)
