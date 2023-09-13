import 'package:country_picker/country_picker.dart';
import 'package:new_project_setup/base_class/base_button.dart';
import 'package:new_project_setup/base_class/base_textfield.dart';

import '../../constants/app.export.dart';
import '../../res/Icon_res.dart';
import '../forgot_password_module/forgot_password_view.dart';
import '../otp_module/otp_view.dart';
import '../signup_module/signup_view.dart';
import 'login_contoller.dart';

class LoginView extends StatelessWidget {
  String val;

  LoginView({Key? key, required this.val}) : super(key: key);

  @override
  Widget build(context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        dispose: (_) => Get.delete<LoginController>(),
        builder: (_) {
          return SafeArea(
            child: DefaultTabController(
              length: 2,
              child: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: getAppBar(_),
                  body: mainBody(_, context),
                  backgroundColor: ColorRes.gradiantPrimaryColor,
                ),
              ),
            ),
          );
        });
  }

  getSignUp() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        BaseText(
          text: "Don’t have an account?",
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: ColorRes.primaryColor,
        ),
        GestureDetector(
            onTap: () {
              Get.to(() => SignupView(isTrue: val,));
            },
            child: BaseText(
                text: "Sign up here!",
                fontSize: 18,
                fontWeight: FontWeight.w800,
                textDecoration: TextDecoration.underline,
                color: ColorRes.primaryColor))
      ],
    );
  }

  getAppBar(_) {
    return AppBar(
      title: BaseText(
        text: val,
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
        tabs: [
          Tab(text: "Phone"),
          Tab(
            text: "Email",
          ),
        ],
      ),
    );
  }

  mainBody(LoginController _, BuildContext context) {
    return TabBarView(physics: NeverScrollableScrollPhysics(), children: [
      getPhoneTab(_, context),
      getEmailTab(_),
    ]);
  }

  getPhoneTab(LoginController _, BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(Utils.getSize(20)),
            children: [
              SizedBox(
                height: Utils.getSize(10),
              ),
              BaseText(
                text: "LOGIN TO YOUR PROFILE",
                fontSize: 26,
                color: ColorRes.primaryColor,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: Utils.getSize(10),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        getCountryCode(context, _);
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorRes.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Wrap(
                            children: [
                              BaseText(text: "+${_.countryCodeText}",
                                color: ColorRes.primaryColor,
                                fontWeight: FontWeight.w600,),
                              Icon(Icons.keyboard_arrow_down,
                                color: ColorRes.primaryColorLight,)
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
                      controller: _.phoneCon,
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
              ),
              SizedBox(
                height: Utils.getSize(10),
              ),
              BaseTextField(
                controller: _.phonePasswordCon,
                fillColor: ColorRes.transparentColor,
                borderColor: ColorRes.primaryColor,
                isSecure: _.isSecuredPhone,
                labelText: "password",
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                suffixIcon: GestureDetector(
                  onTap: () {
                    _.isTruePhone();
                  },
                  child: Image.asset(
                    Utils.getAssetsIcon((_.isSecuredPhone == true)
                        ? IconRes.eye_close
                        : IconRes.eye_open),
                    height: Utils.getSize(30),
                    width: Utils.getSize(30),
                  ),
                ),
              ),
              SizedBox(
                height: Utils.getSize(10),
              ),
              getForgotPassword(val),
              SizedBox(
                height: Utils.getSize(10),
              ),
              BaseRaisedButton(
                  buttonText: "LOG IN",
                  fontWeight: FontWeight.w700,
                  onPressed: () {
                    if (_.phoneCon.text.isEmpty) {
                      Utils.showToast("Please enter phone number");
                    } else {
                      if (_.phoneCon.text.length != 10) {
                        Utils.showToast("Please enter a 10-digit number");
                      } else {
                        if (_.phonePasswordCon.text.isEmpty) {
                          Utils.showToast("Please enter password");
                        } else {
                          if (!RegExp(
                              r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$&*~]).{8,}$')
                              .hasMatch(_.phonePasswordCon.text)) {
                            Utils.showToast("Please enter a valid password");
                          } else {
                            _.getLogin(
                              countryCode: "+${_.countryCodeText}",
                              emailOrPhone: _.phoneCon.text.trim(),
                              password:_.phonePasswordCon.text.trim(),
                              role:val.toLowerCase(),
                              type:"phone",
                            );
                          }
                        }
                      }
                    }
                  }),
            ],
          ),
        ),
        getSignUp(),
        SizedBox(
          height: Utils.getSize(20),
        ),
      ],
    );
  }


  getEmailTab(LoginController _) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(Utils.getSize(20)),
            children: [
              SizedBox(
                height: Utils.getSize(10),
              ),
              BaseText(
                text: "LOGIN TO YOUR PROFILE",
                fontSize: 26,
                color: ColorRes.primaryColor,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: Utils.getSize(10),
              ),
              BaseTextField(
                controller: _.emailCon,
                fillColor: ColorRes.transparentColor,
                borderColor: ColorRes.primaryColor,
                textInputType: TextInputType.emailAddress,
                labelText: "Email",
              ),
              SizedBox(
                height: Utils.getSize(10),
              ),
              BaseTextField(
                controller: _.emailPasswordCon,
                fillColor: ColorRes.transparentColor,
                borderColor: ColorRes.primaryColor,
                isSecure: _.isSecuredEmail,
                labelText: "password",
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                suffixIcon: GestureDetector(
                  onTap: () {
                    _.isTrueEmail();
                  },
                  child: Image.asset(
                    Utils.getAssetsIcon((_.isSecuredEmail == true)
                        ? IconRes.eye_close
                        : IconRes.eye_open),
                    height: Utils.getSize(30),
                    width: Utils.getSize(30),
                  ),
                ),
              ),
              SizedBox(
                height: Utils.getSize(10),
              ),
              getForgotPassword(val),
              SizedBox(
                height: Utils.getSize(10),
              ),
              BaseRaisedButton(
                  buttonText: "LOG IN",
                  fontWeight: FontWeight.w700,
                  onPressed: () {
                    if (_.emailCon.text.isEmpty) {
                      Utils.showToast("Please enter email");
                    } else {
                      if (!RegExp(r'^.+@[a-zA-Z]+\.[a-zA-Z]+(\.[a-zA-Z]+)?$')
                          .hasMatch(_.emailCon.text)) {
                        Utils.showToast("Please enter a valid email");
                      } else {
                        if (_.emailPasswordCon.text.isEmpty) {
                          Utils.showToast("Please enter password");
                        } else {
                          if (!RegExp(
                              r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$&*~]).{8,}$')
                              .hasMatch(_.emailPasswordCon.text)) {
                            Utils.showToast("Please enter a valid password");
                          } else {
                            _.getLogin(
                              countryCode: "",
                              emailOrPhone: _.emailCon.text.trim(),
                              password:_.emailPasswordCon.text.trim(),
                              role:val.toLowerCase(),
                              type:"email",
                            );
                          }
                        }
                      }
                    }
                  })
            ],
          ),
        ),
        getSignUp(),
        SizedBox(
          height: Utils.getSize(20),
        ),
      ],
    );
  }
}

getCountryCode(BuildContext context, LoginController _) {
  showCountryPicker(
    context: context,
    countryListTheme: CountryListThemeData(
      searchTextStyle: TextStyle(fontSize: 16,
          color: ColorRes.primaryColor,
          fontWeight: FontWeight.w600,
          fontFamily: "Montserrat"),
      flagSize: Utils.getSize(20),
      backgroundColor: ColorRes.gradiantPrimaryColor,
      textStyle: TextStyle(fontSize: 16,
          color: ColorRes.primaryColor,
          fontWeight: FontWeight.w600,
          fontFamily: "Montserrat"),
      bottomSheetHeight: Utils.getSize(500),
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



getForgotPassword(String val){
  return GestureDetector(
    onTap: () {
      Get.to(() => ForgotView(val:val),);
    },
    child: BaseText(
      text: "Forgot Password?",
      fontSize: 14,
      textAlign: TextAlign.right,
      fontWeight: FontWeight.w800,
      color: ColorRes.primaryColor,
      textDecoration: TextDecoration.underline,
    ),
  );
}



