import 'package:flutter/material.dart';

class AvatarCarouselSelector extends StatefulWidget {
  final List<String> avatarImages;
  final Function(String selectedAvatar) onAvatarSelected;

  const AvatarCarouselSelector({

    required this.avatarImages,
    required this.onAvatarSelected,
  });

  @override
  State<AvatarCarouselSelector> createState() => _AvatarCarouselSelectorState();
}

class _AvatarCarouselSelectorState extends State<AvatarCarouselSelector> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _selectedIndex,
      viewportFraction: 0.4,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.avatarImages.length,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
          widget.onAvatarSelected(widget.avatarImages[index]);
        },
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;
              if (_pageController.position.haveDimensions) {
                value = (_pageController.page! - index).abs();
                value = (1 - (value * 0.35)).clamp(0.65, 1.0);
              } else {
                value = index == _selectedIndex ? 1.0 : 0.65;
              }

              return Center(
                child: Transform.scale(
                  scale: value,
                  child: Opacity(
                    opacity: value < 0.8 ? 0.6 : 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: index == _selectedIndex ? Colors.amber : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundImage: AssetImage(widget.avatarImages[index]),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}