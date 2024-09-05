// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '/src/constants/app_colors.dart';

class RoundTextField extends StatelessWidget {
  const RoundTextField({super.key, this.controller, this.onSubmitted});

  final TextEditingController? controller;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: AppColors.white,
      ),
      controller: controller,
      onSubmitted: onSubmitted,
      decoration: const InputDecoration(
        contentPadding:
            EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        fillColor: AppColors.accentBlue,
        focusColor: AppColors.accentBlue,
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.grey,
        ),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: AppColors.grey,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
