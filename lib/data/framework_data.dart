class FrameworkInfo {
  final String name;
  final String imagePath;
  final String description;
  final String details;

  const FrameworkInfo({
    required this.name,
    required this.imagePath,
    required this.description,
    required this.details,
  });
}

const List<FrameworkInfo> frameworks = [
  FrameworkInfo(
    name: 'Flutter',
    imagePath: 'assets/images/flutter.png',
    description: 'Фреймворк Google для разработки приложений на Dart',
    details: 'Flutter — фреймворк Google для разработки кроссплатформенных '
        'приложений на языке Dart. Он позволяет использовать общую кодовую '
        'базу и собственную систему виджетов для интерфейса.',
  ),
  FrameworkInfo(
    name: 'React Native',
    imagePath: 'assets/images/react_native.png',
    description: 'Фреймворк для мобильной разработки на JavaScript',
    details: 'React Native позволяет разрабатывать мобильные приложения '
        'с помощью JavaScript и React. Интерфейс связывается с нативными '
        'компонентами платформ.',
  ),
  FrameworkInfo(
    name: '.NET MAUI',
    imagePath: 'assets/images/dotnet_maui.png',
    description: 'Платформа Microsoft для кроссплатформенных приложений',
    details: '.NET MAUI — технология Microsoft для создания приложений '
        'под несколько платформ на C# и .NET с общей структурой проекта.',
  ),
  FrameworkInfo(
    name: 'Ionic',
    imagePath: 'assets/images/ionic.png',
    description: 'Фреймворк для мобильных приложений на веб-технологиях',
    details: 'Ionic помогает создавать приложения с использованием '
        'HTML, CSS и JavaScript, переиспользуя веб-технологии.',
  ),
  FrameworkInfo(
    name: 'NativeScript',
    imagePath: 'assets/images/nativescript.png',
    description: 'Фреймворк для нативных приложений на JavaScript',
    details: 'NativeScript используется для разработки приложений '
        'с доступом к нативным API и общей логикой на JavaScript или TypeScript.',
  ),
];