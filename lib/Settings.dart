import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:yasmina/Scientific/ScientificCommitted.dart';
import 'package:yasmina/settings/contactUs.dart';
import '../UI/user.dart';
import '../main.dart';
import '../model/provider.dart';

import '../screen/direction_home.dart';

class Settingss extends StatefulWidget {
  Settingss();

  @override
  State<Settingss> createState() => _SettingssState();
}

class _SettingssState extends State<Settingss> {
  bool isSwitch = false;
  bool isSwitch2 = false;

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                // Perform logout logic here
                Provider.of<provider>(context, listen: false).logout();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ScientificCommitted()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _shareContent() {
    String content =
        'https://appurl.io/ICZWkYdTcq';

    Share.share(content);
  }

  @override
  Widget build(BuildContext context) {

    provider userProvider = Provider.of<provider>(context);
    final User? user = userProvider.getUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                ),
                padding: const EdgeInsets.all(16),
                child: const Icon(
                  Icons.person,
                  size: 64,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                user?.name ?? 'No user logged in'
                 ,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Text(
                user?.email ?? 'No user logged in',
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 30),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text("Dark Mode"),
                      leading: Icon(
                        MyApp.themeNotifier.value == ThemeMode.light
                            ? Icons.light_mode
                            : Icons.dark_mode,
                      ),
                      trailing: Switch(
                        value: isSwitch,
                        onChanged: (value) {
                          setState(() {
                            isSwitch = value;
                            MyApp.themeNotifier.value =
                            isSwitch ? ThemeMode.dark : ThemeMode.light;
                          });
                        },
                        activeTrackColor: Colors.green,
                        activeColor: Colors.white,
                      ),
                      onTap: () {
                        setState(() {
                          isSwitch = !isSwitch;
                          MyApp.themeNotifier.value =
                          isSwitch ? ThemeMode.dark : ThemeMode.light;
                        });
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text("Notifications"),
                      leading: const Icon(Icons.notifications, color: Colors.green),
                      trailing: Switch(
                        value: isSwitch2,
                        onChanged: (value) {
                          setState(() {
                            isSwitch2 = value;
                          });
                        },
                        activeTrackColor: Colors.green,
                        activeColor: Colors.white,
                      ),
                      onTap: () {

                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text("Contact Us"),
                      leading: const Icon(Icons.phone, color: Colors.green),
                      onTap: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const ContactUss()));
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text("Change Language"),
                      leading: const Icon(Icons.language, color: Colors.green),
                      trailing: const CountryCodePicker(
                        onChanged: print,
                        initialSelection: 'IT',
                        favorite: ['+39', 'FR'],
                        showCountryOnly: false,
                        flagWidth: 12,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text("Location"),
                      leading: const Icon(Icons.location_on, color: Colors.green),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('Share App'),
                      leading: const Icon(Icons.share, color: Colors.green),
                      onTap: () {
                        _shareContent();
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('Logout'),
                      leading: const Icon(Icons.logout, color: Colors.green),
                      onTap: () {
                        _showLogoutDialog(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
