




import 'package:new_project_setup/res/image_res.dart';

import '../../constants/app.export.dart';
import 'splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<SplashController>(
        init: SplashController(),
        dispose: (_) => Get.delete<SplashController>(),
        builder: (_){
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: mainBody(_),
      );
    });
  }
}


mainBody(SplashController _){
  return SafeArea(
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient:RadialGradient(colors: [
          ColorRes.gradiantPrimaryColorLight,
          ColorRes.gradiantPrimaryColor,
        ]),
      ),
      child: getLogo(),
    ),
  );
}


getLogo(){
  return Image.asset(Utils.getAssetsImg(ImageRes.logo),height: 100,width: 250,);
}