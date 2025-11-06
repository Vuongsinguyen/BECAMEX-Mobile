import 'package:flutter/material.dart';

class PenaltyFeePage extends StatefulWidget {
  const PenaltyFeePage({Key? key}) : super(key: key);

  @override
  State<PenaltyFeePage> createState() => _PenaltyFeePageState();
}

class _PenaltyFeePageState extends State<PenaltyFeePage> {
  // Mock penalty data
  final List<Map<String, dynamic>> _penalties = [
    {
      'id': '1',
      'description': 'Late payment for electricity bill',
      'amount': 50000,
      'date': '2025-10-15',
      'status': 'unpaid',
    },
    {
      'id': '2',
      'description': 'Parking violation - wrong spot',
      'amount': 200000,
      'date': '2025-10-10',
      'status': 'paid',
    },
    {
      'id': '3',
      'description': 'Noise complaint fine',
      'amount': 100000,
      'date': '2025-09-28',
      'status': 'paid',
    },
  ];

  double get _totalUnpaid => _penalties
      .where((penalty) => penalty['status'] == 'unpaid')
      .fold(0.0, (sum, penalty) => sum + penalty['amount']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Penalty Fees',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.warning,
                          color: Colors.red,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          'Outstanding Penalties',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${(_totalUnpaid / 1000).toStringAsFixed(0)}K VND',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const Text(
                            'Total unpaid',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      if (_totalUnpaid > 0)
                        ElevatedButton(
                          onPressed: _payAllPenalties,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Pay All'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Penalty List
            const Text(
              'Penalty Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ..._penalties.map((penalty) => _buildPenaltyCard(penalty)).toList(),
            const SizedBox(height: 24),
            // Prevention Tips
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How to Avoid Penalties',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTipItem('Pay utility bills on time'),
                  _buildTipItem('Follow parking rules and regulations'),
                  _buildTipItem('Keep noise levels reasonable'),
                  _buildTipItem('Respect community guidelines'),
                  const SizedBox(height: 16),
                  const Text(
                    'For more information, contact management office.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPenaltyCard(Map<String, dynamic> penalty) {
    final isPaid = penalty['status'] == 'paid';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  penalty['description'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isPaid
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isPaid ? 'Paid' : 'Unpaid',
                  style: TextStyle(
                    fontSize: 12,
                    color: isPaid ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                penalty['date'],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                '${(penalty['amount'] / 1000).toStringAsFixed(0)}K VND',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isPaid ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
          if (!isPaid) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _payPenalty(penalty['id']),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2BA84A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Pay Now'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _payPenalty(String penaltyId) {
    final penalty = _penalties.firstWhere((p) => p['id'] == penaltyId);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pay Penalty'),
        content: Text('Pay VND ${(penalty['amount'] / 1000).toStringAsFixed(0)}K for "${penalty['description']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                penalty['status'] = 'paid';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Penalty paid successfully')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2BA84A),
            ),
            child: const Text('Pay'),
          ),
        ],
      ),
    );
  }

  void _payAllPenalties() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pay All Penalties'),
        content: Text('Pay VND ${(_totalUnpaid / 1000).toStringAsFixed(0)}K for all outstanding penalties?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                for (var penalty in _penalties) {
                  if (penalty['status'] == 'unpaid') {
                    penalty['status'] = 'paid';
                  }
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All penalties paid successfully')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Pay All'),
          ),
        ],
      ),
    );
  }
}