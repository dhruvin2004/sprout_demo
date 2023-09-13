import 'package:country_picker/country_picker.dart';
import 'package:new_project_setup/base_class/base_textfield.dart';
import 'package:new_project_setup/screens/login/login_view.dart';
import 'package:new_project_setup/screens/signup_module/signup_controller.dart';
import '../../base_class/base_button.dart';
import '../../constants/app.export.dart';
import '../../res/icon_res.dart';

class SignupView extends StatelessWidget {
  String isTrue;
   SignupView({super.key,required this.isTrue});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetBuilder(
        init: SignupController(),
          dispose: (_) => Get.delete<SignupController>(),
          builder: (_) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: ColorRes.gradiantPrimaryColor,
                appBar: getAppBar(_),
                body: mainBody(_ , context),
              ),
            );
          },
      ),
    );
  }

  getAppBar( SignupController _) {
    return AppBar(
      title: BaseText(
        text: isTrue,
        color: ColorRes.primaryColor,
        fontWeight: FontWeight.w600,
      ),
      elevation: 1,
      toolbarHeight: 80,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: ColorRes.primaryColor,
        ),
      ),
      leadingWidth: 80,
      backgroundColor: ColorRes.gradiantPrimaryColor,
      bottom: TabBar(
        controller: _.tabController,
        labelPadding: EdgeInsets.only(bottom: 5),
        splashFactory: NoSplash.splashFactory,
        labelColor: ColorRes.primaryColor,
        labelStyle:
        TextStyle(fontWeight: FontWeight.w600, fontFamily: "Montserrat"),
        unselectedLabelColor: ColorRes.primaryColorLight,
        unselectedLabelStyle:
        TextStyle(fontWeight: FontWeight.w600, fontFamily: "Montserrat"),
        tabs: const[
          Tab(text: "Phone"),
          Tab(
            text: "Email",
          ),
        ],
      ),
    );
  }

  mainBody(SignupController _ , BuildContext context){
    return SafeArea(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            getPhoneTab(_ ,  context),
            getEmailTab(_),
          ],
        ),
    );
  }

  getPhoneTab(SignupController _ , BuildContext context){
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
            physics: const BouncingScrollPhysics(),
            children: [
              BaseText(text: "CREATE YOUR PROFILE",fontWeight: FontWeight.w600,fontSize: Utils.getSize(22),),
              SizedBox(height: Utils.getSize(15),),
              getNameField(_ , _.phoneNameController),
              SizedBox(height: Utils.getSize(10),),
              (isTrue == false)?Column(
                children: [
                  getCompanyName(_ , _.phoneCompanyNameController),
                  SizedBox(height: Utils.getSize(10),),
                ],
              ):Container(),
              getCountryAndNumber(_, context),
              SizedBox(height: Utils.getSize(10),),
              getCreatePasswordField(_ , _.phonePassword),
              SizedBox(height: Utils.getSize(10),),
              getConfirmPasswordField(_ , _.phoneConfirmPassword),
              SizedBox(height: Utils.getSize(27),),
              getPhoneSignupButton(_),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: getLogIn(_),
        ),
      ],
    );
  }

  Row getCountryAndNumber(SignupController _, BuildContext context) {
    return Row(
              children: [
                Expanded(
                    child: GestureDetector(
                      onTap: (){
                        getCountryCode(context,_);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorRes.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Wrap(
                          children: [
                            BaseText(text: "+${_.countryCodeText}",color: ColorRes.primaryColor,fontWeight: FontWeight.w600,),
                            Icon(Icons.keyboard_arrow_down,color: ColorRes.primaryColorLight,)
                          ],
                        )
                      ),
                    ),
                ),

                SizedBox(
                  width: Utils.getSize(10),
                ),
                Expanded(
                  flex: 3,
                  child: BaseTextField(
                    controller: _.phoneController,
                    fillColor: ColorRes.transparentColor,
                    borderColor: ColorRes.primaryColor,
                    textInputType: TextInputType.number,
                    labelText: "Phone number",
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(10),
                    ],
                  ),
                ),
              ],
            );
  }

  getCountryCode(BuildContext context,SignupController _){
    return showCountryPicker(
      context: context,

      countryListTheme: CountryListThemeData(

        searchTextStyle:TextStyle(fontSize: 16, color: ColorRes.primaryColor,fontWeight: FontWeight.w600,fontFamily: "Montserrat") ,
        flagSize: Utils.getSize(20),
        backgroundColor: ColorRes.gradiantPrimaryColor,
        textStyle: TextStyle(fontSize: 16, color: ColorRes.primaryColor,fontWeight: FontWeight.w600,fontFamily: "Montserrat"),
        bottomSheetHeight: Utils.getSize(500) ,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Utils.getSize(20)),
          topRight: Radius.circular(Utils.getSize(20)),
        ),),
      showPhoneCode: true,
      onSelect: (Country country) {
        _.getCountryData(country);
      },
    );

  }


  getEmailTab(SignupController _){
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.fromLTRB(30, 40, 30, 20),
            physics: BouncingScrollPhysics(),
            children: [
              BaseText(text: "CREATE YOUR PROFILE",fontWeight: FontWeight.w600,fontSize: Utils.getSize(22),),
              SizedBox(height: Utils.getSize(15),),
              getNameField(_ , _.nameEmailController),
              SizedBox(height: Utils.getSize(10),),
              (isTrue == false)?Column(
                children: [
                  getCompanyName(_ , _.companyNameEmailController),
                  SizedBox(height: Utils.getSize(10),),
                ],
              ):Container(),
              getEmailField(_ , _.emailController),
              SizedBox(height: Utils.getSize(10),),
              getCreatePasswordField(_ , _.emailPassword),
              SizedBox(height: Utils.getSize(10),),
              getConfirmPasswordField(_ , _.emailConfirmPassword),
              SizedBox(height: Utils.getSize(27),),
              getEmailSignupButton(_),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: getLogIn(_),
        ),
      ],
    );
  }

  BaseTextField getNameField(SignupController _ , TextEditingController controller) {
    return BaseTextField(
                controller: controller,
              fillColor: ColorRes.transparentColor,
              borderColor: ColorRes.primaryColor,
              labelText: "Your name",
            );
  }

  BaseTextField getCompanyName(SignupController _ , TextEditingController controller) {
    return BaseTextField(
      controller: controller,
      fillColor: ColorRes.transparentColor,
      borderColor: ColorRes.primaryColor,
      labelText: "Company name (Optional)",
    );
  }

  BaseTextField getEmailField(SignupController _ ,  TextEditingController controller) {
    return BaseTextField(
              controller: controller,
              textInputType: TextInputType.emailAddress,
              fillColor: ColorRes.transparentColor,
              borderColor: ColorRes.primaryColor,
              labelText: "Email address",
            );
  }

  BaseTextField getCreatePasswordField(SignupController _ , TextEditingController controller,) {
    return BaseTextField(
              controller: controller,
              fillColor: ColorRes.transparentColor,
              borderColor: ColorRes.primaryColor,
              isSecure: (controller == _.emailPassword) ? _.createEmailPassShow : _.createPhonePassShow,
              labelText: "Create Password",
              suffixIcon:  GestureDetector(
                onTap: (){
                  (controller == _.emailPassword) ? _.createEmailPassShowFunc() : _.createPhonePassShowFunc();
                },
                child: Image(image: ((controller == _.emailPassword) ?_.createEmailPassShow : _.createPhonePassShow) ? AssetImage(
                    Utils.getAssetsIcon(IconRes.eye_close),
                  ) : AssetImage(
                  Utils.getAssetsIcon(IconRes.eye_open),
                ),
                  height: Utils.getSize(10),
                  width: Utils.getSize(10),
                ),
              ),
            );
  }

  BaseTextField getConfirmPasswordField(SignupController _ , TextEditingController controller) {
    return BaseTextField(
              controller: controller,
              fillColor: ColorRes.transparentColor,
              textInputAction: TextInputAction.done,
              borderColor: ColorRes.primaryColor,
              labelText: "Confirm Password",
              isSecure: (controller == _.phoneConfirmPassword) ? _.confirmEmailPassShow : _.confirmPhonePassShow,
              suffixIcon: GestureDetector(
                onTap: (){
                  (controller == _.phoneConfirmPassword) ?  _.confirmEmailPassShowFunc() : _.confirmPhonePassShowFunc();
                },
                child: Image(image: ((controller == _.phoneConfirmPassword) ? _.confirmEmailPassShow : _.confirmPhonePassShow) ? AssetImage(
                  Utils.getAssetsIcon(IconRes.eye_close),
                ) : AssetImage(
                  Utils.getAssetsIcon(IconRes.eye_open),
                ),
                  height: Utils.getSize(10),
                  width: Utils.getSize(10),
                ),
              ),
            );
  }

  BaseRaisedButton getEmailSignupButton(SignupController _) {
    return BaseRaisedButton(
              buttonText: "SIGN UP",
              onPressed: (){
                if(_.nameEmailController.text.isEmpty){
                   Utils.showToast("Please Enter Name");
                }
                 if(_.emailController.text.isEmpty){
                  Utils.showToast("Please Enter Email");
                }
                 else{
                   if(!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                       .hasMatch(_.emailController.text)){
                      Utils.showToast("Please Valid Email");
                   }
                 }

                 if(_.emailPassword.text.isEmpty){
                    Utils.showToast("Please Enter Create Password");
                 }
                 else{
                   if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                       .hasMatch(_.emailPassword.text)){
                      Utils.showToast("Please Enter Valid Create Password");
                   }
                 }

                if(_.emailConfirmPassword.text.isEmpty){
                   Utils.showToast("Please Enter confirm Password");
                }
                  else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                      .hasMatch(_.emailConfirmPassword.text)){
                     Utils.showToast("Please Enter Valid Confirm Password");
                  }
                  else{
                    if(_.emailPassword.text == _.emailConfirmPassword.text){
                      _.getSignUp(
                        role: isTrue.toLowerCase(),
                        password: _.emailPassword.text.trim(),
                        countryCode: "null",
                        email: _.emailController.text.trim(),
                        confirmPassword: _.emailConfirmPassword.text.trim(),
                        companyName: _.companyNameEmailController.text.trim() ?? "null",
                        name: _.nameEmailController.text.trim(),
                        phone: "null",
                        type: "email",
                      );
                    }
                    else{
                       Utils.showToast("Please Enter Valid Password");
                    }
                }


              },
            );
  }

  BaseRaisedButton getPhoneSignupButton(SignupController _) {
    return BaseRaisedButton(
      buttonText: "SIGN UP",
      onPressed: (){
        if(_.phoneNameController.text.isEmpty){
           Utils.showToast("Please Enter Name");
        }

        if(_.countryCodeText.isEmpty){
           Utils.showToast("Please select Country code");
        }
        else{
          if(_.phoneController.text.length != 10){
             Utils.showToast("Please Enter Valid Phone Number");
          }
        }
        if(_.phonePassword.text.isEmpty){
           Utils.showToast("Please Enter Create Password");
        }
        else{
          if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
              .hasMatch(_.phonePassword.text)){
             Utils.showToast("Please Enter Valid Create Password");
          }
        }
        if(_.phoneConfirmPassword.text.isEmpty){
           Utils.showToast("Please Enter confirm Password");
        }
        else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(_.phoneConfirmPassword.text)){
           Utils.showToast("Please Enter Valid Confirm Password");
        }
        else{
          if(_.phonePassword.text == _.phoneConfirmPassword.text){
            _.getSignUp(
              role: isTrue.toLowerCase(),
              password: _.phonePassword.text.trim(),
              countryCode: "+${_.countryCodeText}",
              email: "null",
             confirmPassword: _.phoneConfirmPassword.text.trim(),
              companyName: _.phoneCompanyNameController.text.trim() ?? "null",
              name: _.phoneNameController.text.trim(),
              phone: _.phoneController.text.trim(),
              type: "phone",
            );
          }
          else{
             Utils.showToast("Please Enter Valid Password");
          }
        }
      },
    );
  }


  getLogIn(SignupController _) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        BaseText(
          text: "Already have an account?",
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: ColorRes.primaryColor,
        ),
        GestureDetector(
            onTap: () {
              Get.back();
            },
            child: BaseText(
                text: "Log in here!",
                fontSize: 18,
                fontWeight: FontWeight.w800,
                textDecoration: TextDecoration.underline,
                color: ColorRes.primaryColor))
      ],
    );
  }


}
