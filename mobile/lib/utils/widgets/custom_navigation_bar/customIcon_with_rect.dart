import '/exports.dart';

class CustomIconWithRect extends StatelessWidget {
  final IconData icon;
  final bool isSelected;

  const CustomIconWithRect({
    Key? key,
    required this.icon,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: isSelected ? 3.0 : 0.0, // Прямоугольник сверху
          width: 40.0,
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        SizedBox(height: 3.0),
        Icon(
          icon,
          size: 20.0,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
      ],
    );
  }
}
