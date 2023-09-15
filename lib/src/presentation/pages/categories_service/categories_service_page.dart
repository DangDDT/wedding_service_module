import 'package:flutter/material.dart';
import 'package:wedding_service_module/core/core.dart';

class CategoriesServicePage extends StatelessWidget {
  const CategoriesServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh mục dịch vụ'),
      ),
      body: const CategoriesServiceView(),
    );
  }
}
