import 'dart:ui';

import 'package:flutter/cupertino.dart';
import '../../base_class/base_button.dart';
import '../../base_class/base_textfield.dart';
import '../../constants/app.export.dart';
import 'cv_portfolio_controller.dart';

class CvPortfolioScreen extends StatelessWidget {
  const CvPortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CvPortfolioController(),
        dispose: (_)=> Get.delete<CvPortfolioController>(),
        builder: (_){
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorRes.gradiantPrimaryColor,
            appBar: getAppBar(),
            body: mainBody(_),
          );
        }
    );
  }

  mainBody(CvPortfolioController _){
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
                  BaseText(text: "Don’t worry if you don’t have any yet, that‘s what Sprout is here for. Just skip ahead!"
                    ,color: ColorRes.gradiantTextColor,fontSize: 18,),
                  SizedBox(height: Utils.getSize(20),),
                  BaseText(
                    text: "CV",
                    color: ColorRes.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                  SizedBox(height: Utils.getSize(10),),
                  getUploadPdfFileContainer(_),
                  SizedBox(height: Utils.getSize(20),),
                  BaseText(
                              text: "IMAGES OR VIDEOS",
                              color: ColorRes.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                  SizedBox(height: Utils.getSize(20),),
                  addImageVideoContainer(_),
                  SizedBox(height: Utils.getSize(20),),
                  ...List.generate(_.controllerList.length, (index) {
                    return getAddLinksFunc(_,index);
                  }),
                  SizedBox(height: Utils.getSize(20),),
                  BaseTextField(
                    onTap: (){
                      _.getAddLinksFunc();
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
            getSaveButton(_),
          ],
        )
    );
  }


  GestureDetector getUploadPdfFileContainer(CvPortfolioController _) {
    return GestureDetector(
              onTap: (){
               if( _.cvFile == null)
                {
                  _.uploadPDF();
                }
               else{
                 getPdfSelectionBottomSheet(_);
               }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:(_.cvFile == null)? ColorRes.transparentColor:ColorRes.primaryColor,
                  border: Border.all(
                    color: ColorRes.primaryColor,
                  )
                ),
                alignment: Alignment.center,
                child: (_.cvFile == null) ?
                BaseText(text: "+ Add Your CV (PDF) ",fontSize: 15,color: ColorRes.primaryColorLight,) :
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: BaseText(text: "${_.filePdfName} ",color: ColorRes.whiteColor,fontSize: 18,)),
                          BaseText(text: "${_.formatFilePdfSize}",color: ColorRes.whiteColor,fontSize: 18,)
                        ],
                      ),
                    ),
              ),
            );
  }
  static getPdfSelectionBottomSheet(CvPortfolioController _) {
    Get.bottomSheet(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: ColorRes.transparentColor,
          margin: EdgeInsets.symmetric(horizontal: Utils.getSize(28), vertical: Utils.getSize(25)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x28000000),
                      blurRadius: 18,
                      offset: Offset(0, 4),
                    ),
                  ],
                  color: ColorRes.whiteColor,
                ),
                child: Column(
                  children: [
                    InkResponse(
                      onTap: () {
                        _.uploadPDF();
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: Utils.getSize(20), bottom: Utils.getSize(15)),
                        child: Center(
                          child: BaseText(
                            text: "Upload File",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: ColorRes.blackColor,
                          ),
                        ),
                      ),
                    ),
                    Divider(color: ColorRes.textGreyColor,),
                    InkResponse(
                      onTap: () {
                        _.removeCv();
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: Utils.getSize(15), bottom: Utils.getSize(20)),
                        child: Center(
                          child: BaseText(
                            text: "Delete File",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: ColorRes.redColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Utils.getSize(20)),
              InkResponse(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x28000000),
                        blurRadius: 18,
                        offset: Offset(0, 4),
                      ),
                    ],
                    color: ColorRes.whiteColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: Utils.getSize(20)),
                      BaseText(
                        text: "Cancel",
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: ColorRes.redColor,
                      ),
                      SizedBox(height: Utils.getSize(20)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addImageVideoContainer(CvPortfolioController _){
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 3,
      children: [
        ...List.generate(_.fileImageVideoList.length, (index) {
          return Stack(
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorRes.primaryColor,
                    image: DecorationImage(
                        image: FileImage(_.fileImageVideoList[index]['image']),
                        fit: BoxFit.cover
                    )
                ),
                child: (_.fileImageVideoList[index]['bool'] == true)?Container(
                  decoration: BoxDecoration(
                    color: ColorRes.blackColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),

                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.play_arrow,color: ColorRes.whiteColor,size: Utils.getSize(40),),
                ):Container(),
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: (){
                    _.removeImageFunc(index);
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    height: Utils.getSize(20),
                    width: Utils.getSize(20),
                    decoration: BoxDecoration(
                        color: ColorRes.redColor,
                        borderRadius: BorderRadius.circular(2)
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.close,size: Utils.getSize(18),),
                  ),
                ),
              ),
            ],
          );
    }),
        GestureDetector(
          onTap: (){
            _.uploadImage();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorRes.transparentColor,
              border: Border.all(width: 1,color: ColorRes.primaryColor)
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  BaseText(text: "+",color: ColorRes.primaryColorLight,fontSize: Utils.getSize(14),),
                  SizedBox(height: 2,),
                  BaseText(text: "jpeg/jpg/(max 5mb) mp4(max to 10 mb)",color: ColorRes.primaryColorLight,fontWeight: FontWeight.w400,fontSize: Utils.getSize(14),textAlign: TextAlign.center,),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  getAppBar() {
    return AppBar(
      title: BaseText(
        text: "Portfolio & CV",
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

  getQuestionText({required Function()? onTap}) {
    return BaseText(
      text:
      "We’d love to see what your capable of!",
      fontWeight: FontWeight.w600,
      fontSize: 20,
    );
  }

  getSaveButton(CvPortfolioController _) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: ColorRes.primaryColorLight.withOpacity(0.4),
      ),
      child: BaseRaisedButton(
        buttonText: "SAVE AND NEXT",
        onPressed: () {
         _.getCvRespones();
        },
        buttonColor: MaterialStateProperty.all(ColorRes.primaryColor),
        textColor: ColorRes.whiteColor,
        borderRadius: 15,
      ),
    );
  }

  getAddLinksFunc(CvPortfolioController _ , int index){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Utils.getSize(6),),
        BaseTextField(
          controller: _.controllerList[index],
          borderColor: ColorRes.primaryColor,
          fillColor: ColorRes.transparentColor,
          cursorColor: ColorRes.primaryColor,
          hintText: "Name of the show/ad/Film",
        ),


        SizedBox(height: Utils.getSize(10),),
        (index > 0) ? GestureDetector(
          onTap: (){
            _.removeLinks(index);
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
