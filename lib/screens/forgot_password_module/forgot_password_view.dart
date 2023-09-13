import 'package:country_picker/country_picker.dart';

import '../../base_class/base_button.dart';
import '../../base_class/base_textfield.dart';
import '../../constants/app.export.dart';
import 'forgot_password_controller.dart';

class ForgotView extends StatelessWidget {
  String val;

  ForgotView({super.key, required this.val});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
        init: ForgotPasswordController(),
        dispose: (_) => Get.delete<ForgotPasswordController>(),
        builder: (_) {
          return DefaultTabController(
            length: 2,
            child: GestureDetector(
              onTap: (){
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                appBar: getAppBar(val, _),
                body: mainBody(_, context,val),
                backgroundColor: ColorRes.gradiantPrimaryColor,
              ),
            ),
          );
        });
  }
}

getAppBar(String val, ForgotPasswordController _) {
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

mainBody(ForgotPasswordController _, BuildContext context,String val) {
  return TabBarView(physics: NeverScrollableScrollPhysics(), children: [
    getPhoneForgetPassword(_, context,val),
    getEmailForgetPassword(_,val),
  ]);
}

getPhoneForgetPassword(ForgotPasswordController _, BuildContext context,String val) {
  return ListView(
    padding: EdgeInsets.all(20),
    children: [
      SizedBox(
        height: 30,
      ),
      BaseText(
        text:
        "We’ll send an OTP to your registered email address or mobile numer to create new password.",
        color: ColorRes.primaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 16,
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 30,
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
                      BaseText(
                        text: "+${_.countryCodeText}",
                        color: ColorRes.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: ColorRes.primaryColorLight,
                      )
                    ],
                  )),
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
        height: Utils.getSize(30),
      ),
      BaseRaisedButton(
        onPressed: () {
          if (_.phoneCon.text.isEmpty) {
            Utils.showToast("Please enter phone number");
          }
          else {
            if (_.phoneCon.text.length == 10) {
              _.getForgotPasswordFunc(
                type:'null',
                phone:_.phoneCon.text.trim(),
                email:_.emailCon.text.trim(),
                countryCode:"+${_.countryCodeText}",
                role:val.toLowerCase(),
              );
            }
            else {
              Utils.showToast("Please enter 10 digit number");
            }
          }
        },
        buttonText: "Send OTP",
        buttonColor: MaterialStateProperty.all(ColorRes.primaryColor),
        textColor: ColorRes.whiteColor,
      ),
    ],
  );
}

getEmailForgetPassword(ForgotPasswordController _,String val) {
  return ListView(
    padding: EdgeInsets.all(20),
    children: [
      SizedBox(
        height: 30,
      ),
      BaseText(
        text:
        "We’ll send an OTP to your registered email address or mobile numer to create new password.",
        color: ColorRes.primaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 16,
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 30,
      ),
      BaseTextField(
        controller: _.emailCon,
        fillColor: ColorRes.transparentColor,
        borderColor: ColorRes.primaryColor,
        textInputType: TextInputType.emailAddress,
        labelText: "Email",
      ),
      SizedBox(
        height: Utils.getSize(30),
      ),
      BaseRaisedButton(
        onPressed: () {
          if (_.emailCon.text.isEmpty) {
            Utils.showToast("Please enter email");
          }
          else {
            if (!RegExp(r'^.+@[a-zA-Z]+\.[a-zA-Z]+(\.[a-zA-Z]+)?$')
                .hasMatch(_.emailCon.text)) {
              Utils.showToast("Please enter a valid email");
            }
            else {
              _.getForgotPasswordFunc(
                type:'email',
                phone:"null",
                email:_.emailCon.text.trim(),
                countryCode:"null",
                role:val.toLowerCase(),
              );
            }
          }
        },
        buttonText: "Send OTP",
        buttonColor: MaterialStateProperty.all(ColorRes.primaryColor),
        textColor: ColorRes.whiteColor,
      ),
    ],
  );
}

getCountryCode(BuildContext context, ForgotPasswordController _) {
  showCountryPicker(
    context: context,
    countryListTheme: CountryListThemeData(
      searchTextStyle: TextStyle(
          fontSize: 16,
          color: ColorRes.primaryColor,
          fontWeight: FontWeight.w600,
          fontFamily: "Montserrat"),
      flagSize: Utils.getSize(20),
      backgroundColor: ColorRes.gradiantPrimaryColor,
      textStyle: TextStyle(
          fontSize: 16,
          color: ColorRes.primaryColor,
          fontWeight: FontWeight.w600,
          fontFamily: "Montserrat"),
      bottomSheetHeight: Utils.getSize(500),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Utils.getSize(20)),
        topRight: Radius.circular(Utils.getSize(20)),
      ),
    ),
    showPhoneCode: true,
    onSelect: (Country country) {
      _.getCountryData(country);
    },
  );
}
