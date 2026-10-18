import 'package:flutter/material.dart';

import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FrameworkPage(),
    );
  }
}

class FrameworkPage extends StatelessWidget {
  const FrameworkPage({super.key});

  static const List<String> images = [
    'assets/images/flutter.png',
    'assets/images/react_native.png',
    'assets/images/dotnet_maui.png',
    'assets/images/ionic.png',
    'assets/images/nativescript.png',
  ];

  static const List<String> names = [
    'Flutter',
    'React Native',
    '.NET MAUI',
    'Ionic',
    'NativeScript',
  ];

  static const List<String> descriptions = [
    'Фреймворк Google для разработки приложений на Dart',
    'Фреймворк для разработки мобильных приложений на JavaScript',
    'Платформа Microsoft для создания кроссплатформенных приложений',
    'Фреймворк для создания мобильных приложений на веб-технологиях',
    'Фреймворк для создания нативных приложений на JavaScript',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Кроссплатформенные фреймворки',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreenAccent,
        actions: [
          IconButton(
            tooltip: 'Авторизация',
            icon: const Icon(Icons.login),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Кроссплатформенные фреймворки',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Кроссплатформенные фреймворки позволяют '
                  'разрабатывать приложения для нескольких '
                  'операционных систем с использованием общей кодовой базы.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Из практики №4: горизонтальный список изображений.
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(right: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: SizedBox(
                      width: 160,
                      child: Image.asset(
                        images[index],
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),


            Expanded(
              child: ListView.builder(
                itemCount: names.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: const Icon(
                        Icons.computer,
                        color: Colors.blue,
                      ),
                      title: Text(
                        names[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(descriptions[index]),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(names[index]),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person, size: 35),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Зуев Дмитрий',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Группа: ИКБО-67-23'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
