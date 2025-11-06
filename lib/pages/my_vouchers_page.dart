import 'package:flutter/material.dart';

class MyVouchersPage extends StatefulWidget {
  const MyVouchersPage({Key? key}) : super(key: key);

  @override
  State<MyVouchersPage> createState() => _MyVouchersPageState();
}

class _MyVouchersPageState extends State<MyVouchersPage> {
  // Mock voucher data
  final List<Map<String, dynamic>> _vouchers = [
    {
      'id': '1',
      'title': 'At-Home Market: 15% Off',
      'description': 'Tặng 50K mua hàng tại nhà',
      'discount': '15%',
      'expiryDate': '2025-12-31',
      'image': 'assets/images/voucher1.png',
      'used': false,
    },
    {
      'id': '2',
      'title': 'F&B Voucher: Get 100K',
      'description': 'Voucher ăn uống 100K',
      'discount': '100K',
      'expiryDate': '2025-11-30',
      'image': 'assets/images/voucher2.png',
      'used': true,
    },
    {
      'id': '3',
      'title': 'Grocery Voucher: 50K Off',
      'description': 'Giảm 50K cho tạp hóa',
      'discount': '50K',
      'expiryDate': '2025-12-15',
      'image': 'assets/images/voucher3.png',
      'used': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'My Vouchers',
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
      body: _vouchers.isEmpty
          ? const Center(
              child: Text(
                'No vouchers found',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _vouchers.length,
              itemBuilder: (context, index) {
                final voucher = _vouchers[index];
                return _buildVoucherCard(voucher);
              },
            ),
    );
  }

  Widget _buildVoucherCard(Map<String, dynamic> voucher) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Voucher Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(voucher['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Voucher Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voucher['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    voucher['description'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.discount,
                        size: 16,
                        color: Color(0xFF2BA84A),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        voucher['discount'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2BA84A),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Expires ${_formatDate(voucher['expiryDate'])}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Status
            Column(
              children: [
                if (voucher['used'])
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Used',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  ElevatedButton(
                    onPressed: () => _useVoucher(voucher['id']),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2BA84A),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                    child: const Text(
                      'Use',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]}';
  }

  void _useVoucher(String voucherId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Use Voucher'),
        content: const Text('Are you sure you want to use this voucher?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                final voucher = _vouchers.firstWhere((v) => v['id'] == voucherId);
                voucher['used'] = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Voucher used successfully')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2BA84A),
            ),
            child: const Text('Use'),
          ),
        ],
      ),
    );
  }
}