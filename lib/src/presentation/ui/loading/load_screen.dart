import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/domain/services/init/init_service.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    InitService.initialize();
    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(238, 84, 70, 1),
            Color.fromRGBO(246, 226, 70, 1),
          ], begin: Alignment.bottomRight, end: Alignment.topLeft),
          image: DecorationImage(
            image: AssetImage(Assets.images.splash.path),
            fit: BoxFit.cover,
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
