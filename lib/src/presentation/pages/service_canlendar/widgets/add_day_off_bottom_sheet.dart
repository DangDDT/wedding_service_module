import 'package:flutter/material.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/src/presentation/widgets/dragger.dart';
import 'package:wedding_service_module/src/presentation/widgets/selection_button.dart';

class AddDayOffBottomSheet extends StatelessWidget {
  const AddDayOffBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: kTheme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            kGapH8,
            const Dragger(width: 68),
            kGapH12,
            Text(
              'Thêm ngày nghỉ',
              style: kTheme.textTheme.titleLarge,
            ),
            kGapH24,
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SelectionButton(
                    label: 'Ngày nghỉ',
                    content: 'Bấm để chọn',
                    isNull: true,
                    onPressed: () {},
                  ),
                  kGapH12,
                  SelectionButton(
                    label: 'Chọn dịch vụ',
                    content: 'Bấm để chọn',
                    isNull: true,
                    onPressed: () {},
                  ),
                  kGapH12,
                  TextFormField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Lý do',
                      hintText: 'Nhập lý do',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
