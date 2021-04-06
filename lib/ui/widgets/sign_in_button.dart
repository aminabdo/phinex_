import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class SignInButton extends StatelessWidget {
  final String text;
  final SignInOption signInOption;

  const SignInButton({
    Key key,
    @required this.text,
    this.signInOption = SignInOption.Goggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {},
      padding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(
          ScreenUtil().setWidth(12),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400], width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            signInOption == SignInOption.Facebook
                ? Image.asset('assets/images/icon_facebook.png')
                : Image.asset('assets/images/icon_google.png'),
            Text(text),
            Text(''),
          ],
        ),
      ),
    );
  }
}

enum SignInOption {
  Goggle,
  Facebook,
}
