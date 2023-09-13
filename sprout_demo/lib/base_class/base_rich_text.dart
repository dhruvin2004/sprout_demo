import 'package:new_project_setup/constants/app.export.dart';

class BaseRichText extends StatelessWidget {
  List<TextSpan>? listTextSpan;

  BaseRichText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: listTextSpan,
      ),
    );
  }
}
