import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';

class IncomeExpenseToggle extends StatelessWidget {
  final bool isIncome;
  final Function(bool) onToggle;
  final Size size;

  const IncomeExpenseToggle({
    super.key,
    required this.isIncome,
    required this.onToggle,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return isIncome
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: AppColors.white,
                ),
                height: 55.h,
                width: size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Income (selected)
                    Container(
                      height: 53.h,
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: AppColors.black,
                      ),
                      child: Center(
                        child: Text(
                          'Income',
                          style: AppFonts.getAppFont(
                            color: AppColors.white,
                            context: context,
                            size: 14,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    // Expense (unselected, make the entire area tappable)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          onToggle(false); // Notify parent to switch to Expense
                        },
                        child: Container(
                          height: 53.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: AppColors.white,
                          ),
                          child: Center(
                            child: Text(
                              'Expense',
                              style: AppFonts.getAppFont(
                                color: AppColors.black,
                                context: context,
                                size: 14,
                                weight: FontWeight.w700,
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
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: AppColors.white,
                ),
                height: 55.h,
                width: size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Income (unselected, make the entire area tappable)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          onToggle(true); // Notify parent to switch to Income
                        },
                        child: Container(
                          height: 53.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: AppColors.white,
                          ),
                          child: Center(
                            child: Text(
                              'Income',
                              style: AppFonts.getAppFont(
                                color: AppColors.black,
                                context: context,
                                size: 14,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Expense (selected)
                    Container(
                      height: 53.h,
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: AppColors.black,
                      ),
                      child: Center(
                        child: Text(
                          'Expense',
                          style: AppFonts.getAppFont(
                            color: AppColors.white,
                            context: context,
                            size: 14,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
