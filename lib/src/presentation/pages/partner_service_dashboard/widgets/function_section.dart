import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/routes/module_router.dart';

class FunctionSection extends StatelessWidget {
  const FunctionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Column(
            children: [
              Text(
                '12',
                style: kTextTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.theme.colorScheme.onPrimary,
                ),
              ),
              kGapH12,
              Text(
                'Dịch vụ',
                style: kTextTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.theme.colorScheme.onPrimary.withOpacity(.8),
                ),
              ),
              kGapH12,
              SizedBox(
                width: double.infinity,
                child: FilledButton.tonal(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      context.theme.colorScheme.onPrimary,
                    ),
                  ),
                  onPressed: () =>
                      Get.toNamed(ModuleRouter.weddingServicesRoute),
                  child: const Text('Quản lý dịch vụ'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
