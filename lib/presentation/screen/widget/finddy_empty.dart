import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:flutter/widgets.dart';

class FinddyEmpty extends StatelessWidget {
  const FinddyEmpty({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 230,
        height: 230,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/empty.png",
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            FDText.bodyP3(
              text: text,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
