import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _bookingReminders = true;
  bool _voucherAlerts = true;
  bool _facilityUpdates = false;
  bool _maintenanceAlerts = true;
  bool _paymentNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Notifications',
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
            const Text(
              'Notification Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Choose what notifications you want to receive',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            Container(
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
                  _buildNotificationOption(
                    title: 'Booking Reminders',
                    subtitle: 'Get reminded about your upcoming bookings',
                    value: _bookingReminders,
                    onChanged: (value) {
                      setState(() {
                        _bookingReminders = value;
                      });
                    },
                  ),
                  _buildDivider(),
                  _buildNotificationOption(
                    title: 'Voucher Alerts',
                    subtitle: 'Receive notifications about new vouchers',
                    value: _voucherAlerts,
                    onChanged: (value) {
                      setState(() {
                        _voucherAlerts = value;
                      });
                    },
                  ),
                  _buildDivider(),
                  _buildNotificationOption(
                    title: 'Facility Updates',
                    subtitle: 'Updates about facility availability and changes',
                    value: _facilityUpdates,
                    onChanged: (value) {
                      setState(() {
                        _facilityUpdates = value;
                      });
                    },
                  ),
                  _buildDivider(),
                  _buildNotificationOption(
                    title: 'Maintenance Alerts',
                    subtitle: 'Notifications about facility maintenance',
                    value: _maintenanceAlerts,
                    onChanged: (value) {
                      setState(() {
                        _maintenanceAlerts = value;
                      });
                    },
                  ),
                  _buildDivider(),
                  _buildNotificationOption(
                    title: 'Payment Notifications',
                    subtitle: 'Receive payment confirmations and reminders',
                    value: _paymentNotifications,
                    onChanged: (value) {
                      setState(() {
                        _paymentNotifications = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _saveSettings,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2BA84A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save Settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationOption({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF2BA84A),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Colors.grey[200],
      indent: 16,
      endIndent: 16,
    );
  }

  void _saveSettings() {
    // Here you would save the settings to backend or local storage
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notification settings saved successfully')),
    );
    Navigator.pop(context);
  }
}