import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/framework_data.dart';
import '../models/user_profile_data.dart';
import '../routes.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  final UserProfileData profile;

  const HomePage({super.key, required this.profile});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  Future<void> _openDetail(FrameworkInfo info) async {
    final selectedTab = await Navigator.pushNamed<int>(
      context,
      Routes.detail,
      arguments: info,
    );
    if (!mounted) return;
    if (selectedTab == 1) {
      setState(() => _selectedIndex = 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width > 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: Text(
          _selectedIndex == 0
              ? (wide ? 'Кроссплатформенные фреймворки' : 'Фреймворки')
              : 'Профиль',
        ),
        actions: [
          IconButton(
            tooltip: 'Выход',
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.login,
                  (route) => false,
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _FrameworkCatalog(onDetailRequested: _openDetail),
          ProfilePage(profile: widget.profile),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.lightGreen.shade50,
        indicatorColor: Colors.lightGreen.shade200,
        selectedIndex: _selectedIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
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

class _FrameworkCatalog extends StatelessWidget {
  final ValueChanged<FrameworkInfo> onDetailRequested;

  const _FrameworkCatalog({required this.onDetailRequested});

  void _showFrameworkSnackBar(BuildContext context, FrameworkInfo item) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(item.name),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildFrameworkCard(BuildContext context, int index) {
    final item = frameworks[index];
    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      child: ListTile(
        leading: const Icon(Icons.computer, color: Colors.blue),
        title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(item.description, maxLines: 2, overflow: TextOverflow.ellipsis),
        // Сохраняем SnackBar из практической №4 при нажатии на карточку.
        onTap: () => _showFrameworkSnackBar(context, item),
        // Новая кнопка из практики №6 — открыть экран деталей.
        trailing: IconButton(
          tooltip: 'Подробнее о ${item.name}',
          icon: const Icon(Icons.arrow_forward_ios, size: 20),
          onPressed: () => onDetailRequested(item),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery из методички: адаптация по ширине всего окна.
    final screenWidth = MediaQuery.sizeOf(context).width;
    final wideScreen = screenWidth > 600;
    // kIsWeb / defaultTargetPlatform из методички: дополнительные
    // вертикальные отступы для desktop и браузера.
    final desktop = kIsWeb ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux;
    final double verticalSpacing = desktop ? 24 : 12;

    return LayoutBuilder(
      builder: (context, constraints) {
        // LayoutBuilder определяет размер области, выделенной родителем.
        final double sidePadding = constraints.maxWidth > 600 ? 40 : 16;
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: sidePadding,
            vertical: verticalSpacing,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Кроссплатформенные фреймворки',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: verticalSpacing),
                  const Text(
                    'Кроссплатформенные фреймворки позволяют разрабатывать '
                        'приложения для нескольких операционных систем '
                        'с использованием общей кодовой базы.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: verticalSpacing),
                  // Горизонтальный ListView из практики №4.
                  SizedBox(
                    height: wideScreen ? 175 : 145,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: frameworks.length,
                      itemBuilder: (context, index) {
                        final item = frameworks[index];
                        return Card(
                          margin: const EdgeInsets.only(right: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () => onDetailRequested(item),
                            child: SizedBox(
                              width: wideScreen ? 175 : 145,
                              child: Image.asset(
                                item.imagePath,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: verticalSpacing),
                  const Text(
                    'Список фреймворков',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // >600: GridView в ДВА столбца. <=600: ListView (как в №4).
                  wideScreen
                      ? GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: frameworks.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 12,
                      mainAxisExtent: 118,
                    ),
                    itemBuilder: _buildFrameworkCard,
                  )
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: frameworks.length,
                    itemBuilder: _buildFrameworkCard,
                  ),
                  SizedBox(height: verticalSpacing),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, size: 28),
                      SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          'Зуев Дмитрий Андреевич · ИКБО-67-23',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
