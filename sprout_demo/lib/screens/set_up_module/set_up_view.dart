import 'package:new_project_setup/base_class/base_button.dart';
import 'package:new_project_setup/screens/about_me_module/about_me_view.dart';
import 'package:new_project_setup/screens/set_up_module/set_up_controller.dart';

import '../../constants/app.export.dart';

class SetUpView extends StatelessWidget {
  const SetUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SetUpController(),
        dispose: (_) => Get.delete<SetUpController>(),
        builder: (_) {
          return Scaffold(
            body: mainBody(_),
            backgroundColor: ColorRes.gradiantPrimaryColor,
          );
        });
  }
}

mainBody(SetUpController _) {
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.all(Utils.getSize(20)),
      child: Column(
        children: [
          getSkipButtonOrTitle(
            onTap: () {},
          ),
          SizedBox(
            height: Utils.getSize(10),
          ),
          BaseText(
            text: "Please select all the production jobs "
                "you are interested in.",
            color: ColorRes.gradiantTextColor,
          ),
          SizedBox(
            height: Utils.getSize(15),
          ),
          Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {

                return Theme(
                  data: ThemeData(
                      dividerColor: ColorRes.transparentColor,
                      iconTheme:
                          IconThemeData(color: ColorRes.gradiantPrimaryColor)),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      // Remove padding within the ExpansionTile
                      iconColor: ColorRes.gradiantTextColor,
                      trailing: Container(
                        width: constraints.maxWidth * 0.22,
                      ),
                      onExpansionChanged: (val) {
                        _.expansionChangedVal(val);
                      },

                      title: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                            color: ColorRes.gradiantPrimaryColorLight03,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: BaseText(
                                text: _.jobType[index].jobTypesName.toString(),
                                fontSize: 18,
                                color: ColorRes.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: Utils.getSize(10),
                            ),
                            (_.expansionChanged)
                                ? Icon(
                                    Icons.keyboard_arrow_up_sharp,
                                    size: 22,
                                    color: ColorRes.primaryColor,
                                  )
                                : Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 22,
                                    color: ColorRes.primaryColor,
                                  )
                          ],
                        ),
                      ),
                      children: [
                        SizedBox(
                          height: Utils.getSize(5),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Wrap(
                            spacing: 10,
                            children: [
                              ...List.generate(
                          _.jobType[index].subCategories!.length,
                                (index2) {
                                  final subCategory = _.jobType[index].subCategories![index2];
                                  final isSelected = _.selectSubCategory.contains(subCategory.subJobTypeId);
                                  return GestureDetector(
                              onTap: () {
                                if (isSelected) {
                                  _.getAdd(subCategory);
                                } else {
                                  _.getRemove(subCategory);
                                }
                              },
                              child: Chip(
                                label: BaseText(
                                  text:
                                  "${_.jobType[index].subCategories![index2].subJobTypeName}",
                                  color: isSelected ?ColorRes.whiteColor : ColorRes.primaryColor,
                                  fontWeight: FontWeight.w600,fontSize: 18,
                                ),
                                backgroundColor: (isSelected)
                                    ? ColorRes.primaryColor:ColorRes.gradiantPrimaryColorLight03,
                                padding: EdgeInsets.all(10),
                              ),
                            );
                                } ,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10,
                );
              },
              itemCount: _.jobType.length,
            ),
          ),
          SizedBox(
            height: Utils.getSize(10),
          ),
          getSaveButton(_),
        ],
      ),
    ),
  );
}

getSkipButtonOrTitle({required Function()? onTap}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: BaseText(
          text:
              "Tell us a little bit about yourself! Are you a jack of all trades or a master of one?",
          fontWeight: FontWeight.w600,
          fontSize: 21,
        ),
      ),
      SizedBox(
        width: Utils.getSize(50),
      ),
      GestureDetector(
          onTap: onTap,
          child: BaseText(
            text: "Skip",
            color: ColorRes.primaryColor,
            textDecoration: TextDecoration.underline,
            fontWeight: FontWeight.w500,
          ))
    ],
  );
}

getSaveButton(SetUpController _) {
  return BaseRaisedButton(
    buttonText: "SAVE AND NEXT",
    onPressed: () {
      _.getSelectJobResponse();
    },
    buttonColor: MaterialStateProperty.all(ColorRes.primaryColor),
    textColor: ColorRes.whiteColor,
    borderRadius: 15,
  );
}
