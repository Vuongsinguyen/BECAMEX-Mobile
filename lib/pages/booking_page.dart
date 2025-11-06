import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  final String facilityName;
  final String facilityCategory;

  const BookingPage({
    Key? key,
    required this.facilityName,
    required this.facilityCategory,
  }) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime _selectedDate = DateTime.now();
  String? _startTime;
  String? _endTime;

  final List<String> _timeOptions = [
    '06:00',
    '07:00',
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
    '21:00',
    '22:00',
    '23:00',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2BA84A),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }

  void _confirmBooking() {
    if (_startTime == null || _endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both start and end time'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validate that end time is after start time
    final startIndex = _timeOptions.indexOf(_startTime!);
    final endIndex = _timeOptions.indexOf(_endTime!);

    if (endIndex <= startIndex) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('End time must be after start time'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Booking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Facility: ${widget.facilityName}'),
            Text('Location: ${widget.facilityCategory}'),
            Text('Date: ${_formatDate(_selectedDate)}'),
            Text('Time: $_startTime - $_endTime'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking confirmed successfully!'),
                  backgroundColor: Color(0xFF2BA84A),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2BA84A),
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header with Back Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.facilityName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Facility Info Card
                    Container(
                      padding: const EdgeInsets.all(16),
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
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2BA84A).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: Color(0xFF2BA84A),
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.facilityName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.facilityCategory,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Date Selection
                    const Text(
                      'Select Date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: Color(0xFF2BA84A),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              _formatDate(_selectedDate),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.grey[400],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Time Range Selection
                    const Text(
                      'Select Time Range',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Legend
                    Row(
                      children: [
                        _buildLegendItem(const Color(0xFF2BA84A), 'Start - End'),
                        const SizedBox(width: 16),
                        _buildLegendItem(const Color(0xFF2BA84A).withOpacity(0.3), 'Range'),
                        const SizedBox(width: 16),
                        _buildLegendItem(Colors.red.withOpacity(0.2), 'Booked'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 2,
                      ),
                      itemCount: _timeOptions.length,
                      itemBuilder: (context, index) {
                        final time = _timeOptions[index];
                        return _buildTimeSlot(time);
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Book Button
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _confirmBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2BA84A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildTimeSlot(String time) {
    final isStartTime = _startTime == time;
    final isEndTime = _endTime == time;
    final isBooked = _isTimeBooked(time);
    final isInRange = _isTimeInRange(time);

    Color backgroundColor;
    Color textColor;
    FontWeight fontWeight;

    if (isBooked) {
      backgroundColor = Colors.red.withOpacity(0.2);
      textColor = Colors.black38;
      fontWeight = FontWeight.normal;
    } else if (isStartTime || isEndTime) {
      backgroundColor = const Color(0xFF2BA84A);
      textColor = Colors.white;
      fontWeight = FontWeight.bold;
    } else if (isInRange) {
      backgroundColor = const Color(0xFF2BA84A).withOpacity(0.3);
      textColor = Colors.black87;
      fontWeight = FontWeight.w500;
    } else {
      backgroundColor = Colors.white;
      textColor = Colors.black87;
      fontWeight = FontWeight.normal;
    }

    return GestureDetector(
      onTap: isBooked ? null : () {
        setState(() {
          if (_startTime == null) {
            // Set start time
            _startTime = time;
          } else if (_endTime == null) {
            // Set end time
            final startIndex = _timeOptions.indexOf(_startTime!);
            final currentIndex = _timeOptions.indexOf(time);

            if (currentIndex > startIndex) {
              _endTime = time;
            } else {
              // If clicked before start, reset and set as new start
              _startTime = time;
              _endTime = null;
            }
          } else {
            // Reset and start over
            _startTime = time;
            _endTime = null;
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: (isStartTime || isEndTime)
                ? const Color(0xFF2BA84A)
                : Colors.grey[300]!,
            width: (isStartTime || isEndTime) ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            time,
            style: TextStyle(
              color: textColor,
              fontWeight: fontWeight,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  bool _isTimeBooked(String time) {
    // Mock data: simulate some booked slots
    final bookedSlots = ['09:00', '10:00'];
    return bookedSlots.contains(time);
  }

  bool _isTimeInRange(String time) {
    if (_startTime == null || _endTime == null) return false;

    final startIndex = _timeOptions.indexOf(_startTime!);
    final endIndex = _timeOptions.indexOf(_endTime!);
    final currentIndex = _timeOptions.indexOf(time);

    return currentIndex > startIndex && currentIndex < endIndex;
  }
}
