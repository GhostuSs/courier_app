import 'package:courier_app/res/barrels/barrel.dart';

class ColorSlider extends StatefulWidget {
  final double height;
  final Function onComplete;

  const ColorSlider({Key? key, required this.height, required this.onComplete}) : super(key: key);

  @override
  _ColorSliderState createState() => _ColorSliderState();
}

class _ColorSliderState extends State<ColorSlider> {
  double _sliderPosition = 0.0; // Позиция ползунка
  Color _currentColor = Colors.red; // Начальный цвет

  void _updateColor() {
    // Изменяем цвет от красного к зеленому в зависимости от позиции
    double ratio = _sliderPosition / MediaQuery.of(context).size.width;
    setState(() {
      _currentColor = Color.lerp(AppColors.red, AppColors.green, ratio)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          // Обновляем позицию ползунка на основе перемещения
          _sliderPosition = (_sliderPosition + details.delta.dx).clamp(0.0, MediaQuery.of(context).size.width-(90.w),);
          _updateColor(); // Обновляем цвет
        });
      },
      onHorizontalDragEnd: (details) async {
        // Вычисляем 80% ширины экрана
        double screenWidth = MediaQuery.of(context).size.width;
        double threshold = screenWidth * 0.65;

        if (_sliderPosition >= threshold) {
          await widget.onComplete();
          setState(() {
            _sliderPosition = 0.0; // Сбрасываем позицию ползунка
            _currentColor = AppColors.red; // Сбрасываем цвет
          });
        } else {
          setState(() {
            _sliderPosition = 0.0;
            _currentColor = AppColors.red;
          });
        }
      },
      child: Container(
        height: widget.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: _currentColor,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Stack(
          children: [
            Positioned(
              left: _sliderPosition + 5.w,
              top: (widget.height-46.h)/2,
              child: Container(
                width: 46.w,
                height: 46.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white, // Цвет ползунка
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
