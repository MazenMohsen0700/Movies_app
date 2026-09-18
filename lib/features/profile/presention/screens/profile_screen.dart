import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/features/layout/data/data_sources/profile_remote_data_source.dart';
import 'package:movie_app/features/movie_details/data/data_sources/watchlist_remote_data_source.dart';
import 'package:movie_app/features/movie_details/data/data_sources/history_remote_data_sourse.dart';
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
  final ProfileRemoteDataSource profileDataSource =
  ProfileRemoteDataSource();

  final WatchlistRemoteDataSource watchlistDataSource =
  WatchlistRemoteDataSource();

  final HistoryRemoteDataSource historyDataSource =
  HistoryRemoteDataSource();

  String username = 'John Safwat';
  int selectedAvatar = 0;

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

  // 0 = Watch List
  // 1 = History
  int selectedTab = 0;

  List<Map<String, dynamic>> watchlistMovies = [];

  bool isLoadingWatchlist = true;

  List<Map<String, dynamic>> historyMovies = [];
  bool isLoadingHistory = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _loadWatchlist();
    _loadHistory();
  }


  Future<void> _loadProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    try {
      await user.reload();

      final currentUser = FirebaseAuth.instance.currentUser;

      if (!mounted) {
        return;
      }

      setState(() {
        username = currentUser?.displayName ?? 'John Safwat';
      });
    } catch (e) {
      debugPrint('Load profile error: $e');
    }
  }


  Future<void> _loadHistory() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      if (mounted) {
        setState(() {
          isLoadingHistory = false;
        });
      }
      return;
    }

    try {
      final movies = await historyDataSource.getHistory(
        userId: user.uid,
      );

      if (!mounted) return;

      setState(() {
        historyMovies = movies;
        isLoadingHistory = false;
      });
    } catch (e) {
      debugPrint('Load history error: $e');

      if (!mounted) return;

      setState(() {
        isLoadingHistory = false;
      });
    }
  }

  Future<void> _loadWatchlist() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      if (mounted) {
        setState(() {
          isLoadingWatchlist = false;
        });
      }
      return;
    }

    try {
      final movies = await watchlistDataSource.getWatchlist(
        userId: user.uid,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        watchlistMovies = movies;
        isLoadingWatchlist = false;
      });
    } catch (e) {
      debugPrint('Load watchlist error: $e');

      if (!mounted) {
        return;
      }

      setState(() {
        isLoadingWatchlist = false;
      });
    }
  }

  int selectedCategoryIndex = 0;
  int selectedNavIndex = 2;

  // Mock movie assets for History
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
              padding: const EdgeInsets.only(
                top: 20,
                left: 16,
                right: 16,
              ),
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
                            avatars[selectedAvatar],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 60,
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 45),

                  // Wish List number
                  Column(
                    children: [
                      Text(
                        '${watchlistMovies.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Wish List',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 45),

                  // History number
                  Column(
                    children: [
                  Text(
                  '${historyMovies.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),


                      const SizedBox(height: 8),
                      const Text(
                        'History',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // =====================================================
            // BUTTONS
            // =====================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // Edit Profile
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const UpdateProfileScreen(),
                          ),
                        );

                        _loadProfile();
                      },
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFC400),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Exit
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                        print("object");
                      },
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF2525),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Exit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // =====================================================
            // WATCH LIST / HISTORY TABS
            // =====================================================
            Row(
              children: [
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
                        const SizedBox(height: 3),
                        const Text(
                          'Watch List',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

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
                        const SizedBox(height: 3),
                        const Text(
                          'History',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

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



            // =====================================================
            // CONTENT
            // =====================================================
            Expanded(
              child: selectedTab == 0
                  ? _watchList()
                  : _history(),
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // WATCH LIST
  // =============================================================

  Widget _watchList() {
    if (isLoadingWatchlist) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFFFC400),
        ),
      );
    }

    if (watchlistMovies.isEmpty) {
      return Center(
        child: Image.asset(
          'assets/images/pop_empty.png',
          width: 200,
          height: 200,
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(8, 18, 8, 10),
      itemCount: watchlistMovies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 14,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) {
        final movie = watchlistMovies[index];

        return _watchlistMovieCard(movie);
      },
    );
  }

  Widget _watchlistMovieCard(Map<String, dynamic> movie) {
    final String imagePath = movie['imagePath'] ?? '';
    final String title = movie['title'] ?? '';

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF303030),
                  child: const Center(
                    child: Icon(
                      Icons.movie,
                      color: Colors.white54,
                      size: 45,
                    ),
                  ),
                );
              },
            ),
          ),

          Positioned(
            left: 7,
            right: 7,
            bottom: 7,
            child: Container(
              padding: const EdgeInsets.all(6),
              color: Colors.black.withOpacity(0.75),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // HISTORY
  // =============================================================

  Widget _history() {
    if (isLoadingHistory) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFFFC400),
        ),
      );
    }

    if (historyMovies.isEmpty) {
      return Center(
        child: Image.asset(
          'assets/images/pop_empty.png',
          width: 200,
          height: 200,
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(8, 18, 8, 10),
      itemCount: historyMovies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 14,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) {
        final movie = historyMovies[index];

        return _historyMovieCard(movie);
      },
    );
  }
  Widget _historyMovieCard(Map<String, dynamic> movie) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              movie['imagePath'] ?? '',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.broken_image,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.black54,
              child: Text(
                movie['title'] ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
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
          Positioned.fill(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF303030),
                  child: const Center(
                    child: Icon(
                      Icons.movie,
                      color: Colors.white54,
                      size: 45,
                    ),
                  ),
                );
              },
            ),
          ),

          Positioned(
            top: 7,
            left: 7,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.75),
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '7.7',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(width: 3),
                  Text(
                    '⭐',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}