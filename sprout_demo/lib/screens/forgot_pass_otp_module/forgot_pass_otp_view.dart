import 'package:new_project_setup/screens/otp_module/otp_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../base_class/base_button.dart';
import '../../constants/app.export.dart';
import '../../res/Icon_res.dart';
import 'forgot_pass_otp_controller.dart';

class ForgotOtpView extends StatelessWidget {
  String loginType;
  String email;
  String role;
  String countryCode;
   ForgotOtpView({super.key,required this.loginType,required this.countryCode,required this.email,required this.role});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPassOtpController>(
        init: ForgotPassOtpController(),
        dispose: (_) => Get.delete<ForgotPassOtpController>(),
        builder: (_) {
          return GestureDetector(
            onTap: (){
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: getAppBar(_),
              body: mainBody(_,context,loginType,email,role),
              backgroundColor: ColorRes.gradiantPrimaryColor,
            ),
          );
        });
  }
}


getAppBar(ForgotPassOtpController _) {
  return AppBar(
    title: BaseText(
      text: "Verification",
      color: ColorRes.primaryColor,
      fontWeight: FontWeight.w600,
    ),
    elevation: 0,
    centerTitle: true,
    leading: GestureDetector(
      onTap: () async{
        Get.back();
        await Injector.prefs!.remove(PrefKeys.otpAccessToken);
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: ColorRes.primaryColor,
      ),
    ),
    leadingWidth: 80,
    backgroundColor: ColorRes.gradiantPrimaryColor,
  );
}

mainBody(ForgotPassOtpController _,BuildContext context,String loginType,String email,String role) {
  return ListView(
    padding: EdgeInsets.all(20),
    children: [
      BaseText(
        text: "We’ve sent a verification code to your\nEmail address!",
        textAlign: TextAlign.center,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: ColorRes.primaryColor,
      ),
      SizedBox(height: Utils.getSize(20),),
      BaseText(
        text: "PLEASE ENTER CODE HERE",
        textAlign: TextAlign.center,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: ColorRes.primaryColorLight02,
      ),
      SizedBox(height: Utils.getSize(20),),
      PinCodeTextField(
        length: 6,
        obscureText: false,
        animationType: AnimationType.scale,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        textInputAction: TextInputAction.done,
        textStyle: TextStyle(color: ColorRes.primaryColor,fontWeight: FontWeight.w600,fontSize: 18,fontFamily: "Montserrat"),
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
          selectedBorderWidth: 1,
          inactiveBorderWidth: 1,
          activeBorderWidth: 1,
          activeColor: ColorRes.primaryColor,
          inactiveFillColor: ColorRes.transparentColor,
          shape: PinCodeFieldShape.box,
          selectedFillColor: ColorRes.transparentColor,
          selectedColor: ColorRes.primaryColorLight,
          inactiveColor: ColorRes.primaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
          fieldHeight: 42,
          fieldWidth: 42,
          activeFillColor: ColorRes.transparentColor,
        ),
        animationDuration: Duration(milliseconds: 300),
        enableActiveFill: true,
        controller: _.otpController,
        onCompleted: (v) {
          print("Completed");
        },
        onChanged: (value) {
          _.buttonUpdate(value);
        },
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          return true;
        }, appContext: context,
      ),
      SizedBox(height: Utils.getSize(20),),
      getVerificationButton(_,loginType,email,role),
      SizedBox(height: Utils.getSize(20),),
      GestureDetector(
        onTap: (){
          //_.getResend();
        },
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Image.asset(Utils.getAssetsIcon(IconRes.resend),height: Utils.getSize(30),width: Utils.getSize(30),),
            BaseText(text: "Resend",color: ColorRes.primaryColor,fontSize: 18,fontWeight: FontWeight.w700,)
          ],),
      ),
    ],
  );
}



getVerificationButton(ForgotPassOtpController _,String loginType,String email,String role){
  return Theme(
    data: ThemeData(
      highlightColor: ColorRes.transparentColor,
      splashColor: ColorRes.transparentColor,
    ),
    child: BaseRaisedButton(
      buttonVerticalPadding: 16,
      textColor: (_.otp?.length == 6)?ColorRes.whiteColor:ColorRes.primaryColorLight02,
      buttonColor: MaterialStateProperty.all((_.otp?.length == 6)?ColorRes.primaryColor:ColorRes.primaryColorLight.withOpacity(0.3),),buttonText: "Verify",
      onPressed: (){
        if(_.otp!.length == 6){
          _.getOtp(
              type: loginType,
              verificationCode: "${_.otp}",
              email: email,
              role: role, countryCode: '',
          );
        }
        else
        {

          Utils.showToast("Enter otp");
        }
      },
    ),
  );
}