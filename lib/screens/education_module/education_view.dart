import 'package:new_project_setup/base_class/base_textfield.dart';
import 'package:new_project_setup/screens/education_module/education_controller.dart';
import 'package:new_project_setup/screens/set_up_module/set_up_view.dart';
import 'package:new_project_setup/screens/work_experience_module/work_experience_view.dart';

import '../../base_class/base_button.dart';
import '../../constants/app.export.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: EducationController(),
        dispose: (_) => Get.delete<EducationController>(),
        builder: (_){
          return GestureDetector(
            onTap: (){
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: ColorRes.gradiantPrimaryColor,
              appBar: getAppBar(),
              body: mainBody(_),
            ),
          );
        },
    );
  }

  getAppBar() {
    return AppBar(
      title: BaseText(
        text: "Education",
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
              fontSize: 16,
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

  mainBody(EducationController _){
    return SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 25),
                children: [
                  SizedBox(height: Utils.getSize(20),),
                  getQuestionText(onTap: () {},),
                  SizedBox(height: Utils.getSize(10),),
                  BaseText(text: "Please feel free to leave out your early education years! We don’t need to know where you went to kindergarten"
                    ,color: ColorRes.gradiantTextColor,fontSize: 18,),
                  ...List.generate(_.controllerList.length, (index) {
                    return getAddQualificationFunc(_ , index);
                  }),

                  SizedBox(height: Utils.getSize(30),),

                  BaseTextField(
                    onTap: (){
                      _.getAddQualificationFunc();
                    },
                    readOnly: true,
                    hintText: "+ Add more Qualification",
                    borderColor: ColorRes.primaryColor,
                    fillColor: ColorRes.transparentColor,
                    cursorColor: ColorRes.primaryColor,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Utils.getSize(200),),
                ],
              ),
            ),
            getSaveButton(),
          ],
        ),
    );
  }



  getSaveButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: ColorRes.primaryColorLight.withOpacity(0.4),
      ),
      child: BaseRaisedButton(
        buttonText: "SAVE AND NEXT",
        onPressed: () {
          Get.off(() => WorkExperienceView());
        },
        buttonColor: MaterialStateProperty.all(ColorRes.primaryColor),
        textColor: ColorRes.whiteColor,
        borderRadius: 15,
      ),
    );
  }
  getQuestionText({required Function()? onTap}) {
    return BaseText(
      text:
      "Where did you learn how to do what you’re doing? ",
      fontWeight: FontWeight.w600,
      fontSize: 20,
    );
  }

  getAddQualificationFunc(EducationController _ , int index){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Utils.getSize(20),),
        BaseText(text: "Instituition",color: ColorRes.gradiantTextColor,fontSize: 18,),
        SizedBox(height: Utils.getSize(6),),
        BaseTextField(
          controller: _.controllerList[index].institution,
          borderColor: ColorRes.primaryColor,
          fillColor: ColorRes.transparentColor,
          cursorColor: ColorRes.primaryColor,
        ),

        SizedBox(height: Utils.getSize(10),),
        BaseText(text: "Qualification",color: ColorRes.gradiantTextColor,fontSize: 18,),
        SizedBox(height: Utils.getSize(6),),
        BaseTextField(
          controller: _.controllerList[index].qualification,
          borderColor: ColorRes.primaryColor,
          fillColor: ColorRes.transparentColor,
          cursorColor: ColorRes.primaryColor,
        ),

        SizedBox(height: Utils.getSize(10),),
        BaseText(text: "Year Of Completion",color: ColorRes.gradiantTextColor,fontSize: 18,),
        SizedBox(height: Utils.getSize(6),),
        BaseTextField(
          controller: _.controllerList[index].yearOfCompletion,
          borderColor: ColorRes.primaryColor,
          fillColor: ColorRes.transparentColor,
          cursorColor: ColorRes.primaryColor,
        ),

        SizedBox(height: Utils.getSize(10),),
        (index > 0) ? GestureDetector(
          onTap: (){
            _.removeQualificationFunc(index);
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
              child: BaseText(text: "Remove",fontSize: 12,color: ColorRes.whiteColor,),
            ),
          ),
        ) : Container(),

      ],
    );
  }
}
