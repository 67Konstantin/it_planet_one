import '/exports.dart'; // Замените на ваши реальные импорты

/// CustomBottomNavigationBar: Кастомная нижняя навигационная панель
class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Текущий выбранный индекс из BottomNavBarIndexProvider
    final selectedIndex =
        context.watch<BottomNavBarIndexProvider>().selectedIndex;

    // Достаём тему и схему цветов, чтобы использовать в окраске
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Определяем цвет пунктирной линии в зависимости от темы
    final dottedLineColor = theme.brightness == Brightness.light
        ? Colors.black
        : Colors.white;

    return Container(
      // Фон панели — используем colorScheme.surface
      color: colorScheme.surface,
      child: ClipRRect(
        // Скругляем только верхние углы
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: Stack(
          children: [
            // Нижняя навигационная панель с прозрачным фоном
            BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                context.read<BottomNavBarIndexProvider>().selectTab(index);
              },
              backgroundColor: Colors.transparent, // Прозрачный фон для видимости пунктирной линии
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true, // Скрываем подписи
              showUnselectedLabels: false,
              elevation: 0,
              items: _buildBottomNavigationBarItems(
                context,
                selectedIndex,
                colorScheme,
              ),
            ),
            // Позиционированная пунктирная линия над BottomNavigationBar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: DottedLinePainterWidget(color: dottedLineColor),
            ),
          ],
        ),
      ),
    );
  }

  /// Генерируем список пунктов BottomNavigationBar с SVG-иконками и цветами из темы.
  List<BottomNavigationBarItem> _buildBottomNavigationBarItems(
    BuildContext context,
    int selectedIndex,
    ColorScheme colorScheme,
  ) {
    return [
      // _buildNavItem(
      //   assetName: 'main_screen.svg',
      //   index: 0,
      //   selectedIndex: selectedIndex,
      //   label: 'Главная',
      //   colorScheme: colorScheme,
      // ),
      _buildNavItem(
        assetName: 'hack_time.svg',
        index: 0,
        selectedIndex: selectedIndex,
        label: 'ХакTime',
        colorScheme: colorScheme,
      ),
      _buildNavItem(
        assetName: 'kalendar.svg',
        index: 1,
        selectedIndex: selectedIndex,
        label: 'Календарь',
        colorScheme: colorScheme,
      ),
      _buildNavItem(
        assetName: 'chat.svg',
        index: 2,
        selectedIndex: selectedIndex,
        label: 'Чат',
        colorScheme: colorScheme,
      ),
      _buildNavItem(
        assetName: 'account.svg',
        index: 3,
        selectedIndex: selectedIndex,
        label: 'Профиль',
        colorScheme: colorScheme,
      ),
    ];
  }

  /// Создаёт один пункт BottomNavigationBarItem с указанной SVG-иконкой.
  BottomNavigationBarItem _buildNavItem({
    required String assetName,
    required int index,
    required int selectedIndex,
    required String label,
    required ColorScheme colorScheme,
  }) {
    final bool isSelected = (index == selectedIndex);

    return BottomNavigationBarItem(
      icon: Center(
        child: SvgPicture.asset(
          'assets/icons/bottom_nav_bar/$assetName',
          width: 24,
          // Чтобы иконка могла перекрашиваться, не задаём цвет напрямую,
          // а используем colorFilter с BlendMode.srcIn:
          colorFilter: ColorFilter.mode(
            isSelected
                ? colorScheme.primary // Цвет для выбранной иконки
                : colorScheme.onSurface.withAlpha(80), // Цвет для невыбранной иконки
            BlendMode.srcIn,
          ),
        ),
      ),
      label: label,
    );
  }
}

/// Widget для рисования пунктирной линии
class DottedLinePainterWidget extends StatelessWidget {
  final Color color;
  const DottedLinePainterWidget({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedLinePainter(color: color),
      size: const Size(double.infinity, 1), // Высота линии
    );
  }
}

/// Painter, который рисует пунктирную линию вдоль верхнего края
class DottedLinePainter extends CustomPainter {
  final Color color;
  const DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 8;
    const double dashSpace = 6;
    double startX = 0;
    final double y = 0; // Линия будет прямо по верхней границе виджета

    while (startX < size.width) {
      // Рисуем маленький отрезок длины dashWidth
      final double endX = (startX + dashWidth).clamp(0, size.width);
      canvas.drawLine(
        Offset(startX, y),
        Offset(endX, y),
        paint,
      );
      // Пропускаем dashSpace
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
