



import 'package:new_project_setup/base_class/base_button.dart';
import 'package:new_project_setup/screens/home_module/home_controller.dart';

import '../../constants/app.export.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        dispose: (_) => Get.delete<HomeController>(),
        builder: (_){
      return Scaffold(
        body: Center(
          child: Center(
            child: BaseRaisedButton(onPressed: (){
              _.isLogOut();
            },buttonText: "Log Out",buttonColor: MaterialStateProperty.all(ColorRes.primaryColor),textColor: ColorRes.whiteColor,),
          ),
        ),
      );
    });
  }
}
