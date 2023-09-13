

import 'package:intl/intl.dart';
import 'package:new_project_setup/screens/cv_portfolio%20_module/cv_portfolio_view.dart';
import 'package:new_project_setup/screens/work_experience_module/work_experience_controller.dart';

import '../../base_class/base_button.dart';
import '../../base_class/base_textfield.dart';
import '../../constants/app.export.dart';

class WorkExperienceView extends StatelessWidget {
  const WorkExperienceView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: WorkExperienceController(),
        dispose: (_) => Get.delete<WorkExperienceController>(),
        builder: (_){
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorRes.gradiantPrimaryColor,
            appBar: getAppBar(),
            body: mainBody(_ , context),
          );
        });
  }

  getAppBar() {
    return AppBar(
      title: BaseText(
        text: "Work Experience",
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

  mainBody(WorkExperienceController _ , BuildContext context){
    return SafeArea(
        child: Column(
          children: [
            Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  children: [
                    SizedBox(height: Utils.getSize(20),),
                    getQuestionText(onTap: () {},),
                    SizedBox(height: Utils.getSize(10),),
                    BaseText(text: "Don’t worry if you don’t have any yet, that‘s what Sprout is here for. Just skip ahead!"
                      ,color: ColorRes.gradiantTextColor,fontSize: 18,),
                    ...List.generate(_.controllerList.length, (index) {
                     // _.getIndex = index;
                      return getAddQualificationFunc(_ , index , context);
                    }),

                    SizedBox(height: Utils.getSize(30),),

                    BaseTextField(
                      onTap: (){
                        _.getAddExperienceFunc();
                      },
                      readOnly: true,
                      hintText: "+ Add more Qualification",
                      borderColor: ColorRes.primaryColor,
                      fillColor: ColorRes.transparentColor,
                      cursorColor: ColorRes.primaryColor,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
            ),
            getSaveButton(),
          ],
        )
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
          Get.off(() => CvPortfolioScreen());
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
      "Share with us your experience in this industry.",
      fontWeight: FontWeight.w600,
      fontSize: 20,
    );
  }

  getAddQualificationFunc(WorkExperienceController _ , int index , BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Utils.getSize(20),),
        BaseText(text: "Company’s name",color: ColorRes.gradiantTextColor,fontSize: 18,),
        SizedBox(height: Utils.getSize(6),),
        BaseTextField(
          controller: _.controllerList[index].companyName,
          borderColor: ColorRes.primaryColor,
          fillColor: ColorRes.transparentColor,
          cursorColor: ColorRes.primaryColor,
        ),

        SizedBox(height: Utils.getSize(10),),
        BaseText(text: "Position",color: ColorRes.gradiantTextColor,fontSize: 18,),
        SizedBox(height: Utils.getSize(6),),
        BaseTextField(
          controller: _.controllerList[index].position,
          borderColor: ColorRes.primaryColor,
          fillColor: ColorRes.transparentColor,
          cursorColor: ColorRes.primaryColor,
          textInputAction: TextInputAction.done,
        ),

        SizedBox(height: Utils.getSize(10),),
        BaseText(text: "Experience",color: ColorRes.gradiantTextColor,fontSize: 18,),
        SizedBox(height: Utils.getSize(6),),
        Row(
          children: [
            Expanded(
                child: BaseTextField(
                  onTap: (){
                    _.selectDate(context, index,_.startDate,_.controllerList[index].starDate);
                  },
                  controller: _.controllerList[index].starDate,
                  readOnly: true,
                  hintText: "MMMYYYY",
                  borderColor: ColorRes.primaryColor,
                  fillColor: ColorRes.transparentColor,
                  cursorColor: ColorRes.primaryColor,
                ),
            ),
            SizedBox(width: Utils.getSize(10),),
            Expanded(
              child: BaseTextField(
                onTap: (){
                  _.selectDate(context, index,_.endDate,_.controllerList[index].endDate);
                },
                controller: _.controllerList[index].endDate,
                readOnly: true,
                hintText: "MMMYYYY",
                borderColor: ColorRes.primaryColor,
                fillColor: ColorRes.transparentColor,
                cursorColor: ColorRes.primaryColor,
              ),
            ),
          ],
        ),


        SizedBox(height: Utils.getSize(10),),
        (index > 0) ? GestureDetector(
          onTap: (){
            _.removeExperienceFunc(index);
          },
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: ColorRes.primaryColor,
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
