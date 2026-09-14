import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/features/profile/presention/screens/update_profile.dart';

import '../../../../core/constants/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});
  int selectedCategoryIndex = 0;
  int selectedNavIndex = 2;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // 0 = Watch List
  // 1 = History
  int selectedTab = 0;
  int selectedCategoryIndex = 0;
  int selectedNavIndex = 2;

  // Mock movie assets
  final List<String> movies = [
    'assets/images/black_widow2.png',
    'assets/images/hobbs.png',
    'assets/images/1917.png',
    'assets/images/avengers.png',
    'assets/images/avengers2.png',
    'assets/images/black_widow.png',
    'assets/images/black_panther.png',
    'assets/images/doctor_strange.png',
    'assets/images/doctor_who.png',
    'assets/images/godzilla.png',
    'assets/images/wednesday.png',
    'assets/images/iron_man.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),

      body: SafeArea(
        child: Column(
          children: [
            // =====================================================
            // PROFILE HEADER
            // =====================================================
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile
                  Column(
                    children: [
                      Container(
                        width: 95,
                        height: 95,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF6DD5FA),
                        ),
                        child: CircleAvatar(
                          child: Image.asset(
                            'assets/images/profile1.png',
                            fit: BoxFit.cover,

                            // Mock if asset doesn't exist
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 60,
                              );
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: 8),

                      Text(
                        'John Safwat',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),

                  SizedBox(width: 45),

                  // Wish List number
                  Column(
                    children: [
                      Text(
                        '12',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Wish List',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 45),

                  // History number
                  Column(
                    children: [
                      Text(
                        '10',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'History',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 18),

            // =====================================================
            // BUTTONS
            // =====================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // Edit Profile
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UpdateProfileScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFC400),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 8),

                  // Exit
                  Expanded(
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF2525),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Exit',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),

                          SizedBox(width: 8),

                          // Mock icon
                          Icon(Icons.logout, color: Colors.white, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 18),

            // =====================================================
            // WATCH LIST / HISTORY TABS
            // =====================================================
            Row(
              children: [
                // WATCH LIST
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTab = 0;
                      });
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.list,
                          color: selectedTab == 0
                              ? const Color(0xFFFFC400)
                              : Colors.white,
                          size: 28,
                        ),

                        SizedBox(height: 3),

                        Text(
                          'Watch List',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),

                // HISTORY
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTab = 1;
                      });
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.folder,
                          color: selectedTab == 1
                              ? const Color(0xFFFFC400)
                              : Colors.white,
                          size: 27,
                        ),

                        SizedBox(height: 3),

                        Text(
                          'History',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            // =====================================================
            // YELLOW ACTIVE TAB LINE
            // =====================================================
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 2,
                    color: selectedTab == 0
                        ? const Color(0xFFFFC400)
                        : Colors.transparent,
                  ),
                ),

                Expanded(
                  child: Container(
                    height: 2,
                    color: selectedTab == 1
                        ? const Color(0xFFFFC400)
                        : Colors.transparent,
                  ),
                ),
              ],
            ),

            // Blue divider
            Container(height: 1, color: const Color(0xFF2196F3)),

            // =====================================================
            // CONTENT
            // =====================================================
            Expanded(child: selectedTab == 0 ? _watchList() : _history()),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // WATCH LIST
  // =============================================================

  Widget _watchList() {
    return Center(
      child: Image.asset(
        'assets/images/pop_empty.png',
        width: 200,
        height: 200,
      ),
    );
  }

  // =============================================================
  // HISTORY
  // =============================================================

  Widget _history() {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(8, 18, 8, 10),

      itemCount: movies.length,

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,

        crossAxisSpacing: 12,
        mainAxisSpacing: 14,

        // Poster ratio
        childAspectRatio: 0.62,
      ),

      itemBuilder: (context, index) {
        return _movieCard(movies[index]);
      },
    );
  }

  // =============================================================
  // MOVIE CARD
  // =============================================================

  Widget _movieCard(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),

      child: Stack(
        children: [
          // =====================================================
          // MOVIE POSTER
          // =====================================================
          Positioned.fill(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,

              // Mock poster
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF303030),
                  child: const Center(
                    child: Icon(Icons.movie, color: Colors.white54, size: 45),
                  ),
                );
              },
            ),
          ),

          // =====================================================
          // RATING
          // =====================================================
          Positioned(
            top: 7,
            left: 7,

            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),

              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.75),
                borderRadius: BorderRadius.circular(7),
              ),

              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '7.7',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),

                  SizedBox(width: 3),

                  Text('⭐', style: TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
