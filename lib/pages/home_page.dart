import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';
import 'facility_page.dart';
import 'voucher_page.dart';
import 'bus_schedule_page.dart';
import 'electricity_page.dart';
import 'water_page.dart';
import 'parking_page.dart';
import 'penalty_fee_page.dart';
import 'management_page.dart';
import 'account_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.9);

  Future<void> _logout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

    List<Widget> get _pages => [
    // Home tab with header and slide card
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3A8DFF), Color(0xFF2BA84A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.only(top: 48, left: 20, right: 20, bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage('assets/images/avatar.png'), // Thay bằng ảnh thật nếu có
                ),
                const SizedBox(width: 16),
                // Greeting and name
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Good Morning,', style: TextStyle(color: Colors.white, fontSize: 16)),
                      SizedBox(height: 2),
                      Text('VO THANH TRUNG', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ],
                  ),
                ),
                // Notification icon
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 22,
                      child: Icon(Icons.notifications_none, color: Color(0xFF3A8DFF), size: 28),
                    ),
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Slide cards
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            height: 140,
            child: PageView(
              controller: _pageController,
              children: [
                // Card 1
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3A8DFF), Color(0xFF2BA84A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Opacity(
                          opacity: 0.18,
                          child: Image.asset(
                            'assets/images/room.jpg',
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 140,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.apartment, color: Colors.white, size: 20),
                                SizedBox(width: 8),
                                Text('BECAMEX TOKYU', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text('SORA II - A1201', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Hold near reader to Unlock', style: TextStyle(color: Colors.white70, fontSize: 14)),
                                Icon(Icons.wifi, color: Colors.white, size: 32),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Card 2
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Opacity(
                          opacity: 0.18,
                          child: Image.asset(
                            'assets/images/room.jpg',
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 140,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.directions_bus, color: Colors.white, size: 20),
                                SizedBox(width: 8),
                                Text('BUS TICKET', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text('Route 123 - City Center', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Tap to validate ticket', style: TextStyle(color: Colors.white70, fontSize: 14)),
                                Icon(Icons.confirmation_number, color: Colors.white, size: 32),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Upcoming card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Upcoming', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 90,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFB2F1E7), Color(0xFFB2E7F1)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Tennis Court', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const Text('SORA II', style: TextStyle(fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Text('Start Time', style: TextStyle(fontSize: 13, color: Colors.black45)),
                                  const SizedBox(width: 32),
                                  const Text('Duration', style: TextStyle(fontSize: 13, color: Colors.black45)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.access_time, size: 16, color: Color(0xFF3A8DFF)),
                                  const SizedBox(width: 4),
                                  const Text('Today, 06:00', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                                  const SizedBox(width: 32),
                                  const Text('3 Hours', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Utility section
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Utility', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 14),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: 1,
                  children: [
                    _utilityCard(
                      icon: Icons.directions_bus,
                      color: Color(0xFFB7B6F7),
                      label: 'Bus Schedule',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BusSchedulePage()),
                        );
                      },
                    ),
                    _utilityCard(
                      icon: Icons.bolt,
                      color: Color(0xFFFFE3B3),
                      label: 'Electricity',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ElectricityPage()),
                        );
                      },
                    ),
                    _utilityCard(
                      icon: Icons.water_drop,
                      color: Color(0xFFB3E6FF),
                      label: 'Water',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const WaterPage()),
                        );
                      },
                    ),
                    _utilityCard(
                      icon: Icons.local_parking,
                      color: Color(0xFFD6FFD6),
                      label: 'Parking',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ParkingPage()),
                        );
                      },
                    ),
                    _utilityCard(
                      icon: Icons.receipt_long,
                      color: Color(0xFFFFE3B3),
                      label: 'Penalty Fee',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PenaltyFeePage()),
                        );
                      },
                    ),
                    _utilityCard(
                      icon: Icons.apartment,
                      color: Color(0xFFB3D6FF),
                      label: 'Management',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ManagementPage()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Voucher section
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Featured Voucher🔥', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedIndex = 1;
                        });
                      },
                      child: const Text('See More', style: TextStyle(color: Color(0xFF2BA84A), fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Large voucher card
                _voucherCardLarge(
                  image: 'assets/images/voucher1.png',
                  title: 'At-Home Market: 15% Off',
                  description: 'Tặng 50K mua hàng tại nhà',
                ),
                const SizedBox(height: 10),
                // Small vouchers row
                Row(
                  children: [
                    Expanded(
                      child: _voucherCardSmall(
                        image: 'assets/images/voucher2.png',
                        title: 'F&B Voucher: Get 100K',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _voucherCardSmall(
                        image: 'assets/images/voucher3.png',
                        title: 'Grocery Voucher: 50K Off',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    // Các tab còn lại giữ nguyên
    const VoucherPage(),
    const FacilityPage(),
    const AccountPage(),
  ];

  // Large voucher card widget
  Widget _voucherCardLarge({required String image, required String title, required String description}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              image,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  // Small voucher card widget
  Widget _voucherCardSmall({required String image, required String title}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              image,
              height: 70,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  // Dummy VoucherListPage for navigation
  // TODO: Replace with real voucher list page
  Widget _buildVoucherListPage() {
    return Scaffold(
      appBar: AppBar(title: const Text('All Vouchers')),
      body: const Center(child: Text('Voucher List Page')),
    );
  }

  // Utility card widget
  Widget _utilityCard({required IconData icon, required Color color, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 32, color: Colors.black54),
            ),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF2BA84A),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_outlined),
            label: 'Voucher',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'Facility',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}