import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:new_project_setup/base_class/base_button.dart';
import 'package:new_project_setup/screens/about_me_module/about_me_controller.dart';
import 'package:new_project_setup/screens/education_module/education_view.dart';

import '../../base_class/base_textfield.dart';
import '../../constants/app.export.dart';

class AboutMeView extends StatelessWidget {
  const AboutMeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutMeController>(
        init: AboutMeController(),
        dispose: (_) => Get.delete<AboutMeController>(),
        builder: (_) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: getAppBar(),
              backgroundColor: ColorRes.gradiantPrimaryColor,
              body: mainBody(_, context),
            ),
          );
        });
  }
}

getAppBar() {
  return AppBar(
    title: BaseText(
      text: "About Me",
      color: ColorRes.primaryColor,
      fontWeight: FontWeight.w600,
    ),
    backgroundColor: ColorRes.gradiantPrimaryColor,
    actions: [
      GestureDetector(
        onTap: () {},
        child: Center(
          child: BaseText(
            text: "Skip",
            color: ColorRes.primaryColor,
            textDecoration: TextDecoration.underline,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      SizedBox(
        width: 10,
      ),
    ],
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(0),
      child: Container(
        height: 1,
        color: ColorRes.primaryColor,
      ),
    ),
    centerTitle: true,
    elevation: 0,
  );
}

mainBody(AboutMeController _, BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          children: [
            BaseText(
              text: "We want to get to you know\nbetter.",
              color: ColorRes.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 21,
            ),
            SizedBox(
              height: Utils.getSize(10),
            ),
            BaseText(
              text: "Don’t worry, we’re not stealing your\nidentity :)",
              color: ColorRes.gradiantTextColor,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
            SizedBox(
              height: Utils.getSize(10),
            ),
            BaseText(
              text: "ABOUT  ME",
              color: ColorRes.gradiantTextColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            SizedBox(
              height: Utils.getSize(10),
            ),
            getAboutMeTextField(_),
            SizedBox(
              height: Utils.getSize(10),
            ),
            BaseText(
              text: "Gender",
              color: ColorRes.gradiantTextColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            SizedBox(
              height: Utils.getSize(10),
            ),
            getGenderDropDown(_),
            SizedBox(
              height: Utils.getSize(10),
            ),
            BaseText(
              text: "EMAIL  ADDRESS",
              color: ColorRes.gradiantTextColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            SizedBox(
              height: Utils.getSize(10),
            ),
            getEmailTextField(_),
            SizedBox(
              height: Utils.getSize(10),
            ),
            BaseText(
              text: "BIRTHDAY",
              color: ColorRes.gradiantTextColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            SizedBox(
              height: Utils.getSize(10),
            ),
            getBirthDate(_, context),
            SizedBox(
              height: Utils.getSize(10),
            ),
            BaseText(
              text: "languageList SPOKEN",
              color: ColorRes.gradiantTextColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            getLanguageLists(_, context),
            SizedBox(
              height: Utils.getSize(10),
            ),

            BaseText(
              text: "SOCIAL MEDIA  ACCOUNT  (OPTIONAL) ",
              color: ColorRes.gradiantTextColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            SizedBox(
              height: Utils.getSize(4),
            ),

            getSocialMedialAccount(_),
            SizedBox(
              height: Utils.getSize(10),
            ),
            BaseText(
              text: "ADDITIONAL INFO (OPTIONAL)",
              color: ColorRes.gradiantTextColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            SizedBox(
              height: Utils.getSize(10),
            ),
            getAdditionalInfo(_),
          ],
        ),
      ),
      getSaveButton(_),
    ],
  );
}


getAboutMeTextField(AboutMeController _) {
  return BaseTextField(
    controller: _.aboutMeCon,
    fillColor: ColorRes.transparentColor,
    borderColor: ColorRes.primaryColor,
    textInputType: TextInputType.emailAddress,
    hintText: "What would you like hirers to know about you?",
    hintStyle: TextStyle(
        fontSize: 12,
        color: ColorRes.gradiantTextColor.withOpacity(0.6),
        fontWeight: FontWeight.w400),
    maxLines: 5,
  );
}


getGenderDropDown(AboutMeController _) {
  return DropdownButtonHideUnderline(
    child: DropdownButton2(
      onMenuStateChange: (val) {
        _.showDropDownButton();
      },
      isExpanded: true,
      hint: Row(
        children: [
          Expanded(
            child: BaseText(
                text: "Gender",
                color: ColorRes.primaryColor,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                fontSize: Utils.getFontSize(22)),
          ),
        ],
      ),
      items: _.items
          .map((item) =>
          DropdownMenuItem<String>(
            value: item,
            child: BaseText(
              text: item,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorRes.primaryColor,
              overflow: TextOverflow.ellipsis,
            ),
          ))
          .toList(),
      value: _.gender,
      onChanged: (value) {
        _.selectRole(value: value as String);
      },
      buttonStyleData: ButtonStyleData(
        padding:
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ColorRes.primaryColor,
          ),
          color: ColorRes.transparentColor,
        ),
        elevation: 0,
      ),
      iconStyleData: IconStyleData(
        icon: Icon(
          (_.showDrop)
              ? Icons.keyboard_arrow_down
              : Icons.keyboard_arrow_up,
        ),
        iconSize: 30,
        iconEnabledColor: ColorRes.primaryColor,
        iconDisabledColor: ColorRes.primaryColor,
      ),
      dropdownStyleData: DropdownStyleData(
        padding: null,
        decoration: BoxDecoration(
          border: Border.all(color: ColorRes.primaryColor),
          borderRadius: BorderRadius.circular(10),
          color: ColorRes.gradiantPrimaryColor,
        ),
        elevation: 0,
        maxHeight: 250,
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: MaterialStateProperty.all<double>(6),
          thumbVisibility: MaterialStateProperty.all<bool>(true),
        ),
      ),
      menuItemStyleData: MenuItemStyleData(
        height: Utils.getSize(40),
        padding: EdgeInsets.only(left: 14, right: 14),
      ),
    ),
  );
}

getEmailTextField(AboutMeController _) {
  return BaseTextField(
    controller: _.emailCon,
    fillColor: ColorRes.transparentColor,
    borderColor: ColorRes.primaryColor,
    hintText: "Email",
    textInputType: TextInputType.text,
    textInputAction: TextInputAction.done,

  );
}

getBirthDate(AboutMeController _, BuildContext context) {
  return BaseTextField(
    onTap: () {
      _.selectBirthDate(context);
    },
    controller: _.birthDateCon,
    fillColor: ColorRes.transparentColor,
    borderColor: ColorRes.primaryColor,
    readOnly: true,
    hintText: "DD/MM/YYYY",
    textInputType: TextInputType.text,
    textInputAction: TextInputAction.done,
  );
}


getLanguageLists(AboutMeController _, BuildContext context) {
  return Column(
    children: [
      GridView.builder(
        //physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 5),
        itemCount: _.spokenList.length,
        itemBuilder: (context, index) {
          return Container(
            color: ColorRes.transparentColor,
            child: Row(
              children: [
                Theme(
                  data : ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      fillColor: MaterialStateProperty.all(ColorRes.primaryColor)
                    )
                  ),
                  child: Checkbox(
                    value: _.spokenList[index].checkBoxValue,

                    onChanged: (val) {
                      if(val != null){
                        _.addLanguageSelectedCheckBox(val , index);
                      }
                     //  if(val != null){
                     //    _.addLanguageSelectedCheckBox(val, index);
                     //    print("datatatatat ${ _.addLanguageSelectedCheckBox(val, index)}");
                     //  }

                    },
                    side: BorderSide(color: ColorRes.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
                BaseText(
                  text: _.spokenList[index].languageName,
                  color: ColorRes.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          );
        },
      ),
      GestureDetector(
        onTap: () async {
          showCustomDialog(context);
        },
        child: Container(
          color: ColorRes.transparentColor,
          child: Row(
            children: [
              SizedBox(
                width: 14,
              ),
              Container(
                padding: EdgeInsets.all(1),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: ColorRes.primaryColor,
                ),
                child:
                Icon(Icons.add, color: ColorRes.whiteColor, size: 20),
              ),
              SizedBox(
                width: 12,
              ),
              BaseText(
                text: "Add other",
                color: ColorRes.primaryColor,
                fontWeight: FontWeight.w600,
              ),


            ],
          ),
        ),
      ),
    ],
  );
}

getSocialMedialAccount(AboutMeController _) {
  return Column(
    children: [
      ...List.generate(_.controllerList.length, (index) {
        return getAddSocialMediaFunc(_, index);
      }),
      SizedBox(height: Utils.getSize(20),),

      BaseTextField(
        onTap: () {
          _.getAddLinkFunc();
        },
        readOnly: true,
        hintText: "+ Add more Qualification",
        borderColor: ColorRes.primaryColor,
        fillColor: ColorRes.transparentColor,
        cursorColor: ColorRes.primaryColor,
        textAlign: TextAlign.center,
      ),
    ],
  );
}

getAddSocialMediaFunc(AboutMeController _, int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: Utils.getSize(6),
      ),
      BaseTextField(
        controller: _.controllerList[index],
        borderColor: ColorRes.primaryColor,
        fillColor: ColorRes.transparentColor,
        cursorColor: ColorRes.primaryColor,
        hintText: "Past link here",
        onChanged: (val){
          _.addSocialMediaLinksScreenList.add(val);
          print("${_.addSocialMediaLinksScreenList}");
        },
      ),
      SizedBox(
        height: Utils.getSize(6),
      ),
      (index > 0) ? GestureDetector(
        onTap: () {
          _.removeLinkFunc(index);
        },
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: ColorRes.redColor,
                borderRadius: BorderRadius.circular(8)
            ),
            // alignment: Alignment.topRight,
            child: BaseText(
              text: "Remove", fontSize: 12, color: ColorRes.whiteColor,),
          ),
        ),
      ) : Container(),
    ],
  );
}

getAdditionalInfo(AboutMeController _) {
  return BaseTextField(
    controller: _.additionalCon,
    fillColor: ColorRes.transparentColor,
    borderColor: ColorRes.primaryColor,
    textInputType: TextInputType.emailAddress,
    hintText: "What would you like hirers to know about you?",
    hintStyle: TextStyle(
        fontSize: 12,
        color: ColorRes.gradiantTextColor.withOpacity(0.6),
        fontWeight: FontWeight.w400),
    maxLines: 5,
  );
}

getSaveButton(AboutMeController _) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    decoration: BoxDecoration(
      color: ColorRes.primaryColorLight.withOpacity(0.4),
    ),
    child: BaseRaisedButton(
      buttonText: "SAVE AND NEXT",
      onPressed: () {
        if(_.aboutMeCon.text.isEmpty){
          return Utils.showToast("Please Enter About Me");
        }
        if(_.gender == null){
          return Utils.showToast("Please Enter Gender");
        }
        if(_.emailCon.text.isEmpty){
          return Utils.showToast("Please Enter Email");
        }
        if(_.birthDateCon.text.isEmpty){
          return Utils.showToast("Please Enter BirthDate");
        }
        if(_.selectedLanguageList.isEmpty){
          return Utils.showToast("Please Enter Select Language List");
        }
        else{
          _.getAboutMeResponse(
            isSkip: true,
            aboutMe: _.aboutMeCon.text,
            gender: _.gender ?? "null",
            email: _.emailCon.text ,
            postalCode: "null",
            birthDate: _.birthDateCon.text,
            language: _.selectedLanguageList.join(", "),
            socialLinks: _.addSocialMediaLinksScreenList,
            additionalInfo: _.additionalCon.text ?? "null",
          );

        }
      },
      buttonColor: MaterialStateProperty.all(ColorRes.primaryColor),
      textColor: ColorRes.whiteColor,
      borderRadius: 15,
    ),
  );
}

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutMeController>(
        init: AboutMeController(),
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Dialog(
              backgroundColor: ColorRes.gradiantPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: BaseTextField(
                      controller: _.searchCon,
                      fillColor: ColorRes.transparentColor,
                      borderColor: ColorRes.primaryColor,
                      hintText: "Search",
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      suffixIcon: Icon(Icons.search),
                      onChanged: (val){
                        _.searchFunc(val);
                      },

                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: _.languageList.length,
                      itemBuilder: (context, index) {
                        if (_.languageList[index].name!.toUpperCase().contains(
                            _.searchText.value.toUpperCase())) {
                          return GestureDetector(
                            onTap: () {
                              _.addLanguageScreen(index);
                             // _.addLanguage(_.languageList[index].name.toString());
                            },
                            child: ListTile(
                              title: BaseText(
                                text: "${_.languageList[index].name}",
                                color: ColorRes.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        } else {
                          return Container(color: ColorRes.redColor,);                         }
                      },
                      separatorBuilder: (BuildContext context, int index) {
                         if (_.languageList[index].name!.toUpperCase().contains(
                            _.searchText.value.toUpperCase())) {
                           return Divider(
                             height: 1,
                             color: ColorRes.primaryColor,
                           );
                         }
                         else{
                           return SizedBox();
                         }
                      },
                    )

                  ),
                ],
              ),
            ),
          );
        });
  }
}

void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog();
    },
  );
}
