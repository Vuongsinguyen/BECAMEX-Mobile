import 'package:flutter/material.dart';
import 'booking_page.dart';

class FacilityPage extends StatefulWidget {
  const FacilityPage({Key? key}) : super(key: key);

  @override
  State<FacilityPage> createState() => _FacilityPageState();
}

class _FacilityPageState extends State<FacilityPage> {
  String _selectedCategory = 'SORA I';

  final List<String> _categories = ['SORA I', 'SORA II', 'SORA III', 'SORA IV'];

  final Map<String, List<FacilityItem>> _facilities = {
    'SORA I': [
      FacilityItem(
        name: 'BBQ Area',
        image: 'assets/images/bbq.jpg',
        category: 'SORA I',
      ),
      FacilityItem(
        name: 'Tennis Court',
        image: 'assets/images/tennis.jpg',
        category: 'SORA I',
      ),
      FacilityItem(
        name: 'Community Room',
        image: 'assets/images/community.jpg',
        category: 'SORA I',
      ),
      FacilityItem(
        name: 'Gymnasium',
        image: 'assets/images/gym.jpg',
        category: 'SORA I',
      ),
      FacilityItem(
        name: 'Swimming Pool',
        image: 'assets/images/pool.jpg',
        category: 'SORA I',
      ),
      FacilityItem(
        name: 'Kids Playground',
        image: 'assets/images/playground.jpg',
        category: 'SORA I',
      ),
    ],
    'SORA II': [
      FacilityItem(
        name: 'BBQ Area',
        image: 'assets/images/bbq.jpg',
        category: 'SORA II',
      ),
      FacilityItem(
        name: 'Tennis Court',
        image: 'assets/images/tennis.jpg',
        category: 'SORA II',
      ),
      FacilityItem(
        name: 'Community Room',
        image: 'assets/images/community.jpg',
        category: 'SORA II',
      ),
      FacilityItem(
        name: 'Gymnasium',
        image: 'assets/images/gym.jpg',
        category: 'SORA II',
      ),
    ],
    'SORA III': [
      FacilityItem(
        name: 'Tennis Court',
        image: 'assets/images/tennis.jpg',
        category: 'SORA III',
      ),
      FacilityItem(
        name: 'Swimming Pool',
        image: 'assets/images/pool.jpg',
        category: 'SORA III',
      ),
    ],
    'SORA IV': [
      FacilityItem(
        name: 'BBQ Area',
        image: 'assets/images/bbq.jpg',
        category: 'SORA IV',
      ),
      FacilityItem(
        name: 'Community Room',
        image: 'assets/images/community.jpg',
        category: 'SORA IV',
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final facilities = _facilities[_selectedCategory] ?? [];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Text(
                'Book Facility',
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
            // Facility Cards Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: facilities.length,
                itemBuilder: (context, index) {
                  final facility = facilities[index];
                  return _buildFacilityCard(facility);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFacilityCard(FacilityItem facility) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingPage(
              facilityName: facility.name,
              facilityCategory: facility.category,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              Image.asset(
                facility.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, size: 50, color: Colors.grey),
                  );
                },
              ),
              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              // Facility Name
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Text(
                  facility.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FacilityItem {
  final String name;
  final String image;
  final String category;

  FacilityItem({
    required this.name,
    required this.image,
    required this.category,
  });
}
