// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class ChatThemeModel {
  final Color leftColor;
  final Color rightColor;
  final String name;
  bool isSelected;
  ChatThemeModel({
    required this.leftColor,
    required this.rightColor,
    required this.name,
    required this.isSelected,
  });
}

List<ChatThemeModel> themes = [
  ChatThemeModel(
      leftColor: AppColors.roseGradientLight,
      rightColor: AppColors.roseGradientDeep,
      name: "Rose",
      isSelected: false),
  ChatThemeModel(
      leftColor: AppColors.lavenderGradientLight,
      rightColor: AppColors.lavenderGradientDeep,
      name: "Lavender",
      isSelected: false),
  ChatThemeModel(
      leftColor: AppColors.peachGradientLight,
      rightColor: AppColors.peachGradientDeep,
      name: "Peach",
      isSelected: false),
  ChatThemeModel(
      leftColor: AppColors.oceanGradientLight,
      rightColor: AppColors.oceanGradientDeep,
      name: "Ocean",
      isSelected: false),
  ChatThemeModel(
      leftColor: AppColors.oceanGradientLight,
      rightColor: AppColors.oceanGradientDeep,
      name: "Berry",
      isSelected: false),
  ChatThemeModel(
      leftColor: AppColors.candyGradientLight,
      rightColor: AppColors.candyGradientDeep,
      name: "Candy",
      isSelected: false),
  ChatThemeModel(
      leftColor: AppColors.tulipGradientLight,
      rightColor: AppColors.tulipGradientDeep,
      name: "Tulip",
      isSelected: false),
  ChatThemeModel(
      leftColor: AppColors.honeyGradientLight,
      rightColor: AppColors.honeyGradientDeep,
      name: "Honey",
      isSelected: true),
  ChatThemeModel(
      leftColor: AppColors.kiwiGradientLight,
      rightColor: AppColors.kiwiGradientDeep,
      name: "Kiwi",
      isSelected: false),
];
