import 'package:flutter/material.dart';

class DriverIncomePage extends StatefulWidget {
  const DriverIncomePage({super.key});

  @override
  State<DriverIncomePage> createState() => _DriverIncomePageState();
}

class _DriverIncomePageState extends State<DriverIncomePage> {
  String _selectedPeriod = 'day';
  double _totalAmount = 100.0; // Example total amount for the day
  List<Map<String, dynamic>> _orders = [
    {
      'date': '2023-10-01',
      'pickup': 'Point A',
      'destination': 'Point B',
      'income': 20.0,
      'rating': 4.5,
    },
    {
      'date': '2023-10-02',
      'pickup': 'Point C',
      'destination': 'Point D',
      'income': 15.0,
      'rating': 4.0,
    },
    // Add more orders as needed
  ];

  void _changePeriod(String period) {
    setState(() {
      _selectedPeriod = period;
      // Update _totalAmount based on the selected period
      // This is just an example, you should replace it with actual logic
      if (period == 'day') {
        _totalAmount = 100.0;
      } else if (period == 'week') {
        _totalAmount = 500.0;
      } else if (period == 'month') {
        _totalAmount = 2000.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Income'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount: \$$_totalAmount',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
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
