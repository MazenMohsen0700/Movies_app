import 'package:flutter/material.dart';



import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/movie_card.dart';
import '../../../movie_details/presentation/screens/movie_details_screen.dart';
import '../../date/models/movie_model.dart';

class BrowseMoviesScreen extends StatefulWidget {
  const BrowseMoviesScreen({super.key});

  @override
  State<BrowseMoviesScreen> createState() => _BrowseMoviesScreenState();
}

class _BrowseMoviesScreenState extends State<BrowseMoviesScreen> {
  int selectedCategoryIndex = 0;
  int selectedNavIndex = 2;

  final List<String> categories = const [
    'Action',
    'Adventure',
    'Animation',
    'Biography',
  ];

  final List<MovieModel> movies = const [
    MovieModel(
      imagePath: 'assets/similar/black_widow.png',
      rating: '7.7',
    ),
    MovieModel(
      imagePath: 'assets/similar/joker.png',
      rating: '7.7',
    ),
    MovieModel(
      imagePath: 'assets/similar/iron_man_3.png',
      rating: '7.7',
    ),
    MovieModel(
      imagePath: 'assets/similar/civil_war.png',
      rating: '7.7',
    ),
    MovieModel(
      imagePath: 'assets/similar/avengers2.png',
      rating: '7.7',
    ),
    MovieModel(
      imagePath: 'assets/images/Doctor Strange 1 (2).png',
      rating: '7.7',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const Center(
        child: Text(
          'Home Screen',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      const Center(
        child: Text(
          'Search Screen',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      _buildBrowseContent(),
      const Center(
        child: Text(
          'Profile Screen',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: selectedNavIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(25),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            currentIndex: selectedNavIndex,
            onTap: (index) {
              setState(() {
                selectedNavIndex = index;
              });
            },
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: AppColors.yellow,
            unselectedItemColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                  size: 28,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: 28,
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.folder_copy_rounded,
                  size: 26,
                ),
                label: 'Browse',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                  size: 28,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrowseContent() {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 12),
          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              itemCount: categories.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 10);
              },
              itemBuilder: (context, index) {
                final isSelected =
                    selectedCategoryIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategoryIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.yellow
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.yellow,
                        width: 1.8,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: isSelected
                              ? Colors.black
                              : AppColors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              itemCount: movies.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 16,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (context, index) {
                final movie = movies[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const MovieDetailsScreen(),
                      ),
                    );
                  },
                  child: MovieCard(
                    imagePath: movie.imagePath,
                    rating: movie.rating,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}