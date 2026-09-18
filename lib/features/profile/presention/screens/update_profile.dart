import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../layout/data/data_sources/profile_remote_data_source.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final ProfileRemoteDataSource profileDataSource =
  ProfileRemoteDataSource();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    try {
      final profile = await profileDataSource.getProfile(
        userId: user.uid,
      );

      if (profile == null || !mounted) {
        return;
      }

      setState(() {
        usernameController.text = profile['username'] ?? '';
        phoneController.text = profile['phone'] ?? '';
        selectedAvatar = profile['selectedAvatar'] ?? 0;
      });
    } catch (e) {
      debugPrint('Load profile error: $e');
    }
  }

  final TextEditingController usernameController =
  TextEditingController(text: 'John Safwat');

  final TextEditingController phoneController =
  TextEditingController(text: '01200000000');

  final List<String> avatars = [
    'assets/images/profile1.png',
    'assets/images/profile2.png',
    'assets/images/profile3.png',
    'assets/images/profile4.png',
    'assets/images/profile5.png',
    'assets/images/profile6.png',
    'assets/images/profile7.png',
    'assets/images/profile8.png',
    'assets/images/profile9.png',
  ];

  int selectedAvatar = 0;

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(
            14,
            14,
            14,
            20,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFF292A2A),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: avatars.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final bool isSelected =
                  selectedAvatar == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAvatar = index;
                  });

                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF181818),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xFFFFC400),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      avatars[index],
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 45,
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // DELETE ACCOUNT
  Future<void> _deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    final passwordController = TextEditingController();

    final password = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF292A2A),
          title: const Text(
            'Delete account',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              hintText: 'Enter your password',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  passwordController.text,
                );
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );

    passwordController.dispose();

    if (password == null || password.isEmpty) {
      return;
    }

    try {
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      await user.reauthenticateWithCredential(
        credential,
      );

      await user.delete();

      if (!mounted) return;

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message;

      if (e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        message = 'Wrong password';
      } else if (e.code == 'requires-recent-login') {
        message = 'Please login again and try again';
      } else {
        message = e.message ?? 'Delete account failed';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Delete account failed: $e',
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFFFFC400),
                      size: 25,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Pick Avatar',
                        style: TextStyle(
                          color: Color(0xFFFFC400),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25),
                ],
              ),
            ),

            // CURRENT AVATAR
            GestureDetector(
              onTap: _showAvatarPicker,
              child: Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF263238),
                ),
                child: ClipOval(
                  child: Image.asset(
                    avatars[selectedAvatar],
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) {
                      return const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 65,
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // USERNAME
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: TextFormField(
                controller: usernameController,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                cursorColor: const Color(0xFFFFC400),
                decoration: InputDecoration(
                  hintText: 'Username',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF1B1B1B),
                  contentPadding:
                  const EdgeInsets.symmetric(
                    vertical: 13,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: const BorderSide(
                      color: Color(0xFFFFC400),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // PHONE
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                cursorColor: const Color(0xFFFFC400),
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: Colors.grey,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF1B1B1B),
                  contentPadding:
                  const EdgeInsets.symmetric(
                    vertical: 13,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: const BorderSide(
                      color: Color(0xFFFFC400),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),

            // RESET PASSWORD
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 22,
                ),
                child: GestureDetector(
                  onTap: () {
                    // Reset password action
                  },
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(),

            // DELETE ACCOUNT
            GestureDetector(
              onTap: _deleteAccount,
              child: Container(
                width: double.infinity,
                height: 55,
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffE82626),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text(
                    'Delete account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // UPDATE BUTTON
            GestureDetector(
              onTap: () async {
                final user =
                    FirebaseAuth.instance.currentUser;

                if (user == null) {
                  return;
                }

                try {
                  await profileDataSource.updateProfile(
                    userId: user.uid,
                    username:
                    usernameController.text.trim(),
                    phone: phoneController.text.trim(),
                    selectedAvatar: selectedAvatar,
                  );

                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Profile updated successfully',
                      ),
                    ),
                  );
                } catch (e) {
                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Update failed: $e',
                      ),
                    ),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC400),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}