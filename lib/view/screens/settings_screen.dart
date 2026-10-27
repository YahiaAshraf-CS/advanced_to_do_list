import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:advanced_to_do_list/core/routes/app_routes.dart';
import 'package:advanced_to_do_list/data/services/auth_service.dart';
import 'package:advanced_to_do_list/theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthService _authService = AuthService();
  bool _isLoggingOut = false;

  Future<void> _logout() async {
    if (_isLoggingOut) return;

    setState(() => _isLoggingOut = true);

    try {
      await _authService.signOut();

      if (!mounted) return;

      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.login,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logout failed: ${e.message ?? e.code}'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong while logging out.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoggingOut = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView(
              children: [
                _buildSectionHeader('Account'),
                _buildSettingsTile(
                  Icons.person_outline,
                  'Profile Information',
                ),
                _buildSettingsTile(
                  Icons.lock_outline,
                  'Change Password',
                ),
                const SizedBox(height: 16.0),
                _buildSectionHeader('Preferences'),
                _buildSettingsTile(
                  Icons.notifications,
                  'Notifications',
                ),
                const SizedBox(height: 16.0),
                _buildSectionHeader('Support & About'),
                _buildSettingsTile(
                  Icons.help_outline,
                  'Help & FAQ',
                ),
                _buildSettingsTile(
                  Icons.info_outline,
                  'Privacy Policy',
                ),
                const SizedBox(height: 24.0),
                Material(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.circular(12.0),
                  child: InkWell(
                    onTap: _isLoggingOut ? null : _logout,
                    borderRadius: BorderRadius.circular(12.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: AppColors.borderColor,
                        ),
                      ),
                      child: Center(
                        child: _isLoggingOut
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Log Out',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.overdue,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: AppColors.secondaryText,
        ),
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: AppColors.darkText,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16.0,
          color: AppColors.secondaryText,
        ),
        onTap: () {},
      ),
    );
  }
}