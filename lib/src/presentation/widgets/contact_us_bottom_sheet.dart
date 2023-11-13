import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/src/presentation/view_models/services_list_filter_data.dart';

class ContactUsBottomSheet extends StatefulWidget {
  const ContactUsBottomSheet({super.key});

  static Future<ServicesListFilterData?> show() async {
    return Get.dialog(
      const ContactUsBottomSheet(),
    );
  }

  @override
  State<ContactUsBottomSheet> createState() => _ContactUsBottomSheetState();
}

class _ContactUsBottomSheetState extends State<ContactUsBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController slideUpAnimatedController;

  @override
  void initState() {
    slideUpAnimatedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 210),
    )..drive(CurveTween(curve: Curves.linear));

    super.initState();
    slideUpAnimatedController.forward();
  }

  void _onBack() {
    slideUpAnimatedController.reverse().then((_) => Get.back());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onBack,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: SlideTransition(
            position: slideUpAnimatedController.drive(
              Tween<Offset>(
                begin: const Offset(0, .8),
                end: Offset.zero,
              ),
            ),
            child: FadeTransition(
              opacity: slideUpAnimatedController,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.theme.dialogBackgroundColor,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: _onBack,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.close,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Liên hệ với chúng tôi",
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      kGapH16,
                      const Text(
                        'Trong trường hợp bạn có bất kỳ thắc mắc nào, vui lòng liên hệ với chúng tôi qua một trong các kênh sau:',
                      ),
                      kGapH24,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.green.shade300,
                              ),
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.all(16),
                              ),
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.phone),
                          ),
                          IconButton.filled(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.indigo.shade300,
                              ),
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.all(16),
                              ),
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.email),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
