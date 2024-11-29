import 'package:flutter/material.dart';
import 'driver_income_sample.dart';

class DriverStatsPage extends StatefulWidget {
  const DriverStatsPage({super.key});

  @override
  State<DriverStatsPage> createState() => _DriverStatsPageState();
}

class _DriverStatsPageState extends State<DriverStatsPage> {
  String _selectedPeriod = 'day';
  double _totalAmount = 0.0;
  double _averageRating = 0.0;
  List<Map<String, dynamic>> _orders = sampleOrders;

  @override
  void initState() {
    super.initState();
    _calculateTotalAmount();
    _calculateAverageRating();
  }

  void _calculateTotalAmount() {
    DateTime now = DateTime(2024, 11, 29); // Set the current date to 29/11/2024
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime startOfWeek = startOfDay.subtract(Duration(days: now.weekday - 1));
    DateTime startOfMonth = DateTime(now.year, now.month, 1);

    double totalDay = 0.0;
    double totalWeek = 0.0;
    double totalMonth = 0.0;

    for (var order in _orders) {
      DateTime orderDate = DateTime.parse(order['date']);
      if (orderDate.isAfter(startOfDay) ||
          orderDate.isAtSameMomentAs(startOfDay)) {
        totalDay += order['income'];
      }
      if (orderDate.isAfter(startOfWeek) ||
          orderDate.isAtSameMomentAs(startOfWeek)) {
        totalWeek += order['income'];
      }
      if (orderDate.isAfter(startOfMonth) ||
          orderDate.isAtSameMomentAs(startOfMonth)) {
        totalMonth += order['income'];
      }
    }

    setState(() {
      if (_selectedPeriod == 'day') {
        _totalAmount = totalDay;
      } else if (_selectedPeriod == 'week') {
        _totalAmount = totalWeek;
      } else if (_selectedPeriod == 'month') {
        _totalAmount = totalMonth;
      }
    });
  }

  void _calculateAverageRating() {
    double totalRating = 0.0;
    for (var order in _orders) {
      totalRating += order['rating'];
    }
    setState(() {
      _averageRating = totalRating / _orders.length;
    });
  }

  void _changePeriod(String period) {
    setState(() {
      _selectedPeriod = period;
      _calculateTotalAmount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Stats'), backgroundColor: Colors.grey[300]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount: \$$_totalAmount',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Overall Rating: ${_averageRating.toStringAsFixed(1)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                PopupMenuButton<String>(
                  onSelected: _changePeriod,
                  itemBuilder: (BuildContext context) {
                    return {'day', 'week', 'month'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.filter_list),
                      const SizedBox(width: 8),
                      Text(_selectedPeriod),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _orders.length,
                reverse: true, // Show most recent orders first
                itemBuilder: (context, index) {
                  final order = _orders[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(order['date']),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Pickup: ${order['pickup']}'),
                              Text('Income: \$${order['income']}'),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Destination: ${order['destination']}'),
                              Text('Rating: ${order['rating']}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
