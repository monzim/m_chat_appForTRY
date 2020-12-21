import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    backgroundColor: HexColor("#45485A"),
    leading: Image.asset(
      "assets/images/lll-1154.png",
      height: 50,
    ),
    title: Text(
      'MChats',
      style: TextStyle(
        fontFamily: 'Texturina-Variable',
        fontSize: 20,
      ),
    ),
  );
}

Widget appBarDouble(BuildContext context) {
  return AppBar(
    backgroundColor: HexColor("#45485A"),
    actions: [
      Image.asset(
        "assets/images/lll-1154.png",
        height: 50,
        width: 60,
      ),
      SizedBox(
        width: 15,
      ),
      Center(
        child: Text(
          'MChats',
          style: TextStyle(
            fontFamily: 'Texturina-Variable',
            fontSize: 20,
          ),
        ),
      ),
      SizedBox(
        width: 120,
      ),
    ],
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.white54),
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
  );
}

TextStyle simpleTexteStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
}

TextStyle mediumTexteStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 17,
  );
}

TextStyle mediumTexteStyleTwo() {
  return TextStyle(
    color: Colors.black,
    fontSize: 17,
  );
}

TextStyle highTextStyle(color) {
  return TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
}

class PageSorry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDouble(context),
      backgroundColor: Colors.amber,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.adb_outlined,
                size: 50,
              ),
              Text(
                  "This feature is not available now. Please Sign In OR Sign Up using your Email.",
                  style: highTextStyle(Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassSorry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDouble(context),
      backgroundColor: Colors.amber,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.adb_outlined,
                size: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: Column(
                  children: [
                    Text('This feature is not available now.',
                        style: mediumTexteStyleTwo()),
                    Text(' If you forgot your password  ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Text('please contact with Developer.',
                        style: mediumTexteStyleTwo())
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_box, color: HexColor("#fb3958")),
                  SizedBox(width: 10),
                  Text('Instagram:', style: mediumTexteStyleTwo()),
                  SizedBox(width: 10),
                  Text("azraf_al_monzim",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_box,
                    color: Colors.blue[900],
                  ),
                  SizedBox(width: 10),
                  Text('Facebook:', style: mediumTexteStyleTwo()),
                  SizedBox(width: 10),
                  Text("azrafal.monzim",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoAboutAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "https://pbs.twimg.com/profile_images/1322512097301786625/nPJ5GxqQ_400x400.jpg")))),
            // Image.asset(
            //   "assets/images/lll-1154.png",
            //   height: 100,
            //   width: 120,
            // ),
            Text(
              "App Devoloper",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(height: 5),
            Text("Azraf Al Monzim",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            SizedBox(height: 5),
            Container(
              height: 40,
              width: 210,
              child: RaisedButton(
                color: Colors.blueGrey[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/github-sign.png",
                      height: 50,
                    ),
                    SizedBox(width: 5),
                    Text('github.com/monzim'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 40,
              width: 200,
              child: RaisedButton(
                color: Colors.pink[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/instagram.png",
                      height: 50,
                    ),
                    SizedBox(width: 5),
                    Text('azraf_al_monzim'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 40,
              width: 200,
              child: RaisedButton(
                color: Colors.lightBlue[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/facebook.png",
                      height: 50,
                    ),
                    SizedBox(width: 5),
                    Text('azrafal.monzim'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber,
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// _launchURLOne() async {
//   const url = 'https://github.com/monzim';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
