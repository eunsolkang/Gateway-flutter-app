import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_page/course_select_pages/currentCourseSelect.dart';
import 'package:login_page/pages/main_page.dart';
import 'package:login_page/pages/signup_page.dart';

//Gateway 색 적용
const GateWaycolor = Color(0xff6c63ff);

//LoginPage를 위한 statelesswidget
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: this._appBar,
      body: this._body(context),
    );
  }
}

//Login page 확장
extension on LoginPage {
  Widget get _appBar => AppBar(
        toolbarHeight: 44,
        backgroundColor: Colors.white,
        elevation: 0,
      );

  Widget _body(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 67),
            Container(
              width: 81,
              height: 66,
              child: SvgPicture.asset('asset/Group155.svg'),
            ),
            Expanded(
              flex: 45,
              child: Container(),
            ),
            this._textField("학번", "학번을 입력해주세요", false),
            Expanded(
              flex: 45,
              child: Container(),
            ),
            this._textField("비밀번호", "비밀번호를 입력해주세요", true),
            Expanded(
              flex: 19,
              child: Container(),
            ),
            StayedLogin(),
            Expanded(
              flex: 71,
              child: Container(),
            ),
            ButtonTheme(
              height: 48,
              minWidth: 400,
              child: RaisedButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide(color: GateWaycolor)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Mainpage()));
                },
                child: Text(
                  "로그인",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xffffffff),
                  ),
                ),
                color: GateWaycolor,
              ),
            ),
            Expanded(
              flex: 33,
              child: Container(),
            ),
            this._signup(context),
            Expanded(
              flex: 170,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  //입력 받을 때 사용 widget
  Widget _textField(String labelText, String hintText, bool activation) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        InputForm(hintText: hintText,activation: activation,),
      ],
    );
  }

  //회원 가입 페이지 위한 버튼
  Widget _signup(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("계정이 없으신가요?",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            )),
        SizedBox(
          width: 10,
        ),
        InkWell(
          child: Text("회원가입",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: GateWaycolor)),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignupPage(),
              ),
            ),
          },
        ),
      ],
    );
  }
}

//textfield input검사를 위한 InputForm
//그런데 sufficon이 input에 따라 변화하는게 잘 안됨.. global key를 사용해야 할수도?
class InputForm extends StatefulWidget{
  String hintText;
  bool activation;
  InputForm({Key key,@required this.hintText,this.activation}) : super(key:key);
  @override
  InputFormState createState(){
    return InputFormState();
  }
}

class InputFormState extends State<InputForm>{
  TextEditingController controller= new TextEditingController();
  @override
  void initState(){
    controller = TextEditingController();
    super.initState();
  }
  Widget build(BuildContext){
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIconConstraints: BoxConstraints(
          maxHeight: 8,
          minWidth: 12,
        ),
        suffixIcon: controller?.text==null ? null:Container(
          transform: Matrix4.translationValues(0, 10, 0.0),
          child: SvgPicture.asset(
            'asset/Checkbox.svg',
          ),
        ),
        hintStyle: TextStyle(
            color: Color(0xffdbdbdb),
            fontSize: 12,
            fontWeight: FontWeight.w300),
        contentPadding: EdgeInsets.only(top: 10),
      ),
      obscureText: widget.activation,
    );
  }
}


//로그인 유지 항목을 위한 StayedLogin
class StayedLogin extends StatefulWidget {
  @override
  _StayedLogin createState() => new _StayedLogin();
}

class _StayedLogin extends State<StayedLogin> {
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                checkboxValue = !checkboxValue;
              });
            },
            child: checkboxValue
                ? Container(
                    width: 22,
                    height: 22,
                    child: SvgPicture.asset(
                      'asset/checkerNo.svg',
                    ),
                  )
                : Container(
                    width: 22,
                    height: 22,
                    child: SvgPicture.asset(
                      'asset/checker.svg',
                    ),
                  ),
          ),
          SizedBox(width: 8),
          Text(
            "로그인 유지",
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}