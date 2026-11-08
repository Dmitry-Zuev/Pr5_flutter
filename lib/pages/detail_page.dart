import 'package:flutter/material.dart';

import '../data/framework_data.dart';


class DetailPage extends StatelessWidget {
  final FrameworkInfo framework;

  const DetailPage({super.key, required this.framework});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 600;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: Text(framework.name),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isWide ? 42 : 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 850),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      width: isWide ? 330 : 240,
                      height: isWide ? 230 : 180,
                      color: Colors.grey.shade100,
                      child: Image.asset(framework.imagePath, fit: BoxFit.contain),
                    ),
                  ),
                ),
                SizedBox(height: isWide ? 38 : 22),
                Text(
                  'Описание ${framework.name}',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                Text(framework.details, style: const TextStyle(fontSize: 17, height: 1.5)),
              ],
            ),
          ),
        ),
      ),
      // Возвращаем результат (0 или 1) главному экрану: выбрать нужную вкладку.
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) => Navigator.pop(context, index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
