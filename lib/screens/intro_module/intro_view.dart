import 'package:new_project_setup/base_class/base_button.dart';
import 'package:new_project_setup/screens/intro_module/intro_controller.dart';
import 'package:new_project_setup/screens/otp_module/otp_view.dart';
import '../../constants/app.export.dart';
import '../../res/image_res.dart';
import '../login/login_view.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: IntroController(),
        dispose: (_) => Get.delete<IntroController>(),
        builder: (_){
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: mainBody(_),
          );
        }
    );
  }
  mainBody(IntroController _){
    return SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                ColorRes.gradiantPrimaryColor,
                ColorRes.gradiantPrimaryColorLight,
              ],
            )
          ),
          child: ListView(
            children: [
              SizedBox(height: Utils.getSize(76),),
              BaseText(text: "Welcome to",textAlign: TextAlign.center,fontWeight: FontWeight.w600,fontSize: 22,),
              Image(
                image: AssetImage(Utils.getAssetsImg(ImageRes.logo),),
                height: Utils.getSize(66),
                width: Utils.getSize(208),
              ),
              SizedBox(height: Utils.getSize(42),),
              Image(image: AssetImage(Utils.getAssetsImg(ImageRes.introLogo),),
                height: 230,
                width: 224,
              ),
              SizedBox(height: Utils.getSize(66),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 79),
                child: BaseText(text: "The best way for you to thrive in the media industry",textAlign: TextAlign.center,fontWeight: FontWeight.w600,fontSize: 18,),
              ),
              SizedBox(height: Utils.getSize(76),),
              getFreelancerButton(),
              SizedBox(height: Utils.getSize(10),),
              getHireButton(),
            ],
          ),
        ),
    );
  }
}



getFreelancerButton(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 28),
    child: BaseRaisedButton(
      buttonText: "I’m a Freelancer",
      onPressed: (){
        Get.to(()=> LoginView(val: "Freelancer",));
      },
    ),
  );
}



getHireButton(){
  return   Padding(
    padding: const EdgeInsets.symmetric(horizontal: 28),
    child: BaseRaisedButton(
      buttonText: "I want to Hire someone",
      textColor: ColorRes.primaryColor,
      onPressed: (){
        // Get.to(()=> OtpView());
        Get.to(()=> LoginView(val: "Hirer",));
      },
      borderSideColor: ColorRes.primaryColor,
      buttonColor: MaterialStateProperty.all(ColorRes.transparentColor),
    ),
  );
}