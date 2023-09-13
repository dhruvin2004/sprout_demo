import '../../base_class/base_button.dart';
import '../../base_class/base_textfield.dart';
import '../../constants/app.export.dart';
import '../../res/Icon_res.dart';
import '../signup_module/signup_controller.dart';
import 'create_new_password_controller.dart';

class CreateNewPasswordView extends StatelessWidget {
  String emailOrPassword;
  String role;
  String type;
  String countryCode;
  CreateNewPasswordView({super.key,required this.role,required this.countryCode,required this.type,required this.emailOrPassword});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CreateNewPasswordController(),
        dispose: (_) => Get.delete<CreateNewPasswordController>(),
        builder: (_){
          return Scaffold(
            backgroundColor: ColorRes.gradiantPrimaryColor,
            appBar: AppBar(
              backgroundColor: ColorRes.gradiantPrimaryColor,
              elevation: 1.1,
              title: BaseText(text: "Create new password",fontWeight: FontWeight.w600,),
              centerTitle: true,
            ),
            body: mainBody(_),
          );
        },
    );
  }

  mainBody(CreateNewPasswordController _){
    return SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    BaseText(text: "Create new password & log in!",fontWeight: FontWeight.w600,textAlign: TextAlign.center,),
                    SizedBox(height: Utils.getSize(10),),
                    getCreatePasswordField(_ ),
                    SizedBox(height: Utils.getSize(10),),
                    getConfirmPasswordField(_),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: ColorRes.gradiantPrimaryColorLight02,
                border: Border.all(
                  color: ColorRes.primaryColor
                ),
              ),
              child: getEmailSavePasswordButton(_),
            ),
          ],
        ),
    );
  }

  BaseTextField getCreatePasswordField(CreateNewPasswordController _ ) {
    return BaseTextField(
      controller: _.createController,
      fillColor: ColorRes.transparentColor,
      borderColor: ColorRes.primaryColor,
      isSecure: _.createEmailPassShow,
      labelText: "Create Password",
      suffixIcon:  GestureDetector(
        onTap: (){
          _.createEmailPassShowFunc();
        },
        child: Image(
          image: AssetImage((_.createEmailPassShow) ?
          Utils.getAssetsIcon(IconRes.eye_close) :
          Utils.getAssetsIcon(IconRes.eye_open)
          ),
        ),
        // child: Image AssetImage(
        //   Utils.getAssetsIconImg(IconRes.eyeImg),
        // ) : AssetImage(
        //   Utils.getAssetsIconImg(IconRes.showEyeImg),
        // ),
        //   height: Utils.getSize(10),
        //   width: Utils.getSize(10),
        // ),
      ),
    );
  }

  BaseTextField getConfirmPasswordField(CreateNewPasswordController _ ) {
    return BaseTextField(
      controller: _.confirmController,
      fillColor: ColorRes.transparentColor,
      borderColor: ColorRes.primaryColor,
      isSecure: _.confirmEmailPassShow,
      labelText: "Confirm Password",
      suffixIcon:  GestureDetector(
        onTap: (){
          _.confirmEmailPassShowFunc();
        },
        child: Image(
          image: AssetImage((_.confirmEmailPassShow) ?
          Utils.getAssetsIcon(IconRes.eye_close) :
          Utils.getAssetsIcon(IconRes.eye_open)
          ),
        ),
        // child: Image AssetImage(
        //   Utils.getAssetsIconImg(IconRes.eyeImg),
        // ) : AssetImage(
        //   Utils.getAssetsIconImg(IconRes.showEyeImg),
        // ),
        //   height: Utils.getSize(10),
        //   width: Utils.getSize(10),
        // ),
      ),
    );
  }

   getEmailSavePasswordButton(CreateNewPasswordController _) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,10,20,0),
      child: BaseRaisedButton(
        buttonText: "SAVE PASSWORD",
        borderRadius: 10,
        onPressed: (){
          if(_.createController.text.isEmpty){
            Utils.showToast("Please Enter Create Password");
          }
          else{
            if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                .hasMatch(_.createController.text)){
              Utils.showToast("Please Enter Valid Create Password");
            }
          }

          if(_.confirmController.text.isEmpty){
            Utils.showToast("Please Enter confirm Password");
          }
          else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
              .hasMatch(_.confirmController.text)){
            Utils.showToast("Please Enter Valid Confirm Password");
          }
          else{
            if(_.createController.text == _.confirmController.text){
              _.getChangePassword(emailOrPhone: emailOrPassword,
                  countryCode: countryCode,
                  role: role,
                  type: type,
                  password: _.createController.text.trim(),
                  confirmPassword: _.confirmController.text.trim(),
              );
            }
            else{
              Utils.showToast("Please Enter Valid Password");
            }
          }

        },
      ),
    );
  }

}
