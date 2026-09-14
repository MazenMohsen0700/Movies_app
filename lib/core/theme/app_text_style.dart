import 'package:flutter/material.dart';
import 'app_color.dart';

class AppTextStyle {
  AppTextStyle._();

  // -------------------------------------------------------------
  // Home & Search Screen Text Styles
  // (Named according to: font + size + color + weight)
  // -------------------------------------------------------------

  /// 20px - White - Regular (Home: "Action " category title)
  static const TextStyle font20WhiteRegular = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  /// 20px - White - Bold
  static const TextStyle font20WhiteBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  /// 16px - Yellow (#F6BD00) - Regular (Home: "See More" link)
  static const TextStyle font16YellowRegular = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.primary,
  );

  /// 16px - White - Regular (Home & Search: Rating badge "7.7", Search query text)
  static const TextStyle font16WhiteRegular = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  /// 16px - White - Medium
  static const TextStyle font16WhiteMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  /// 16px - White 70% Opacity - Regular (Search: Search field hint "Search")
  static const TextStyle font16White70Regular = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color(0XFFFFFFFF),
  );

  /// 16px - Grey (#ADADAD) - Regular
  static const TextStyle font16GreyRegular = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // -------------------------------------------------------------
  // Aliases for ThemeData compatibility
  // -------------------------------------------------------------
  static const TextStyle sectionTitle = font20WhiteRegular;
  static const TextStyle seeMore = font16YellowRegular;
  static const TextStyle ratingBadge = font16WhiteRegular;
  static const TextStyle searchInput = font16WhiteRegular;
  static const TextStyle searchHint = font16White70Regular;
  static const TextStyle movieTitleLarge = font20WhiteBold;
  static const TextStyle movieTitleMedium = font20WhiteRegular;
  static const TextStyle bodyLarge = font16WhiteRegular;
  static const TextStyle bodyMedium = font16GreyRegular;
  static const TextStyle buttonPrimary = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.onPrimary,
  );
  static const TextStyle buttonSecondary = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
}
