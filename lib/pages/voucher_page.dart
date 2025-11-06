import 'package:flutter/material.dart';
import 'voucher_detail_page.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({Key? key}) : super(key: key);

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  String _selectedCategory = 'Featured';

  final List<String> _categories = ['Featured', 'F&B', 'Shopping', 'Platform'];

  final Map<String, List<VoucherItem>> _vouchers = {
    'Featured': [
      VoucherItem(
        title: 'At-Home Market: 15% Off',
        description: 'Tặng 50K mua hàng tại nhà',
        image: 'assets/images/voucher1.png',
        discount: '15% OFF',
        validUntil: 'Valid until Dec 31, 2025',
        terms: 'Minimum purchase: 200K\nApplicable for all items\nOne use per customer',
      ),
      VoucherItem(
        title: 'Grocery Voucher: 50% OFF',
        description: 'Voucher lộc phát mua sắm',
        image: 'assets/images/voucher3.png',
        discount: '50% OFF',
        validUntil: 'Valid until Dec 15, 2025',
        terms: 'Maximum discount: 100K\nMinimum purchase: 300K',
      ),
      VoucherItem(
        title: 'F&B Voucher: Get 100k',
        description: 'Chào mừng Tất Niên',
        image: 'assets/images/voucher2.png',
        discount: '100K OFF',
        validUntil: 'Valid until Jan 10, 2026',
        terms: 'Applicable for restaurant bills\nMinimum 3 people',
      ),
      VoucherItem(
        title: '30% off fun for residents',
        description: 'Giải trí cư dân',
        image: 'assets/images/voucher1.png',
        discount: '30% OFF',
        validUntil: 'Valid until Dec 25, 2025',
        terms: 'For residents only\nEntertainment facilities',
      ),
    ],
    'F&B': [
      VoucherItem(
        title: 'F&B Voucher: Get 100k',
        description: 'Chào mừng Tất Niên',
        image: 'assets/images/voucher2.png',
        discount: '100K OFF',
        validUntil: 'Valid until Jan 10, 2026',
        terms: 'Applicable for restaurant bills\nMinimum 3 people',
      ),
      VoucherItem(
        title: 'Coffee Shop: Buy 1 Get 1',
        description: 'Ưu đãi đặc biệt',
        image: 'assets/images/voucher1.png',
        discount: 'BUY 1 GET 1',
        validUntil: 'Valid until Nov 30, 2025',
        terms: 'All coffee drinks\nNot applicable with other promotions',
      ),
    ],
    'Shopping': [
      VoucherItem(
        title: 'At-Home Market: 15% Off',
        description: 'Tặng 50K mua hàng tại nhà',
        image: 'assets/images/voucher1.png',
        discount: '15% OFF',
        validUntil: 'Valid until Dec 31, 2025',
        terms: 'Minimum purchase: 200K\nApplicable for all items\nOne use per customer',
      ),
      VoucherItem(
        title: 'Grocery Voucher: 50% OFF',
        description: 'Voucher lộc phát mua sắm',
        image: 'assets/images/voucher3.png',
        discount: '50% OFF',
        validUntil: 'Valid until Dec 15, 2025',
        terms: 'Maximum discount: 100K\nMinimum purchase: 300K',
      ),
    ],
    'Platform': [
      VoucherItem(
        title: 'Bác Sĩ Đa Khoa Club: 0.5%',
        description: 'Ưu đãi thành viên',
        image: 'assets/images/voucher2.png',
        discount: '0.5% OFF',
        validUntil: 'Valid until Dec 31, 2025',
        terms: 'For members only\nAccumulated points applicable',
      ),
      VoucherItem(
        title: 'Early Bird Coffee Class',
        description: 'Lớp học cà phê sáng sớm',
        image: 'assets/images/voucher1.png',
        discount: 'FREE CLASS',
        validUntil: 'Valid until Nov 20, 2025',
        terms: 'Limited seats\nRegistration required',
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final vouchers = _vouchers[_selectedCategory] ?? [];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Text(
                'Voucher',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            // Chip Tabs Selection
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: ChoiceChip(
                      label: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      backgroundColor: Colors.grey[200],
                      selectedColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Voucher Cards Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: vouchers.length,
                itemBuilder: (context, index) {
                  final voucher = vouchers[index];
                  return _buildVoucherCard(voucher);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoucherCard(VoucherItem voucher) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VoucherDetailPage(voucher: voucher),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Voucher Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.asset(
                voucher.image,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, size: 50, color: Colors.grey),
                  );
                },
              ),
            ),
            // Voucher Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voucher.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    voucher.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VoucherItem {
  final String title;
  final String description;
  final String image;
  final String discount;
  final String validUntil;
  final String terms;

  VoucherItem({
    required this.title,
    required this.description,
    required this.image,
    required this.discount,
    required this.validUntil,
    required this.terms,
  });
}
