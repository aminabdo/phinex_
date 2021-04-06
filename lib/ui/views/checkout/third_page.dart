import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:phinex/ui/widgets/credit_card_form.dart';
import 'package:phinex/ui/widgets/credit_card_model.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class StepThree extends StatefulWidget {
  @override
  _StepThreeState createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  String selectedMonth;
  String selectedYears = '2020';

  List<String> years = [];

  Map<String, String> months;

  var key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    years = List<String>.generate(61, (i) => '${DateTime.now().year + i}');

    months = {
      'January': '01',
      'February': '02',
      'March': '03',
      'April': '04',
      'May': '05',
      'June': '06',
      'July': '07',
      'August': '08',
      'September': '09',
      'October': '10',
      'November': '11',
      'December': '12',
    };

    selectedMonth = 'January';
  }

  int selectedPayment = 1;

  List<IconData> paymentsIcons = [
    FontAwesomeIcons.paypal,
    FontAwesomeIcons.creditCard,
    FontAwesomeIcons.wallet,
  ];

  bool saveThisCreditCard = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 60,),
          Image.asset('assets/images/pay_on_delivery.png', scale: 2.5,),
          SizedBox(height: 60,),
          Text(AppUtils.translate(context, 'pay_on_delivery'), style: TextStyle(fontSize: 18),),
        ],
      ),
    );
  }

  /*
  * Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            3,
            (index) => GestureDetector(
              onTap: () {
                selectedPayment = index;
                setState(() {});
              },
              child: AnimatedContainer(
                duration: Duration(
                  milliseconds: 300,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(MediaQuery.of(context).size.width / 4.5 - 50),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: deepBlueColor,
                    width: 1,
                  ),
                  color:
                      selectedPayment == index ? deepBlueColor : Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                height: ScreenUtil().setHeight(60),
                margin: EdgeInsets.only(
                  bottom: ScreenUtil().setHeight(8),
                ),
                child: Center(
                  child: Icon(
                    paymentsIcons[index],
                    color: selectedPayment == index ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ),
          ).toList(),
        ),
        CreditCardForm(onCreditCardModelChange: onCreditCardModelChange),
        SizedBox(
          height: ScreenUtil().setHeight(5),
        ),
        ListTile(
          onTap: () {
            saveThisCreditCard = !saveThisCreditCard;
            setState(() {});
          },
          title: Text(
            AppLocalization.of(context).translate('save_this_credit_card'),
          ),
          leading: GestureDetector(
            onTap: () {
              saveThisCreditCard = !saveThisCreditCard;
              setState(() {});
            },
            child: CircleAvatar(
              backgroundColor: greenColor,
              radius: 13,
              child: saveThisCreditCard
                  ? Icon(
                      Icons.check,
                      size: 18,
                    )
                  : SizedBox.shrink(),
            ),
          ),
        ),
      ],
    )
  * */

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
