import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_portfolio/api/Api.dart';
import 'package:my_portfolio/api/Store.dart';
import 'package:my_portfolio/buttons/Button.dart';
import 'package:my_portfolio/controller/BlogsController.dart';
import 'package:my_portfolio/routes/route_path.dart' as routes;
import 'package:my_portfolio/utils/error.dart';
import 'package:my_portfolio/utils/functions.dart';

class AuthNavBar extends StatefulWidget {
  final Widget child;
  final String title;
  final bool showFloatButton;
  AuthNavBar(
      {Key key,
      @required this.child,
      @required this.title,
      this.showFloatButton = true});

  @override
  _AuthNavBarState createState() => _AuthNavBarState();
}

class _AuthNavBarState extends State<AuthNavBar> {
  bool isLoggedIn = false;
  TextEditingController controller = new TextEditingController();
  BlogsController blogController = Get.put(BlogsController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadIsLoggedIn();
    onListen();
  }

  _loadIsLoggedIn() {
    setState(() {
      isLoggedIn = loadIsLoggedIn();
    });
  }

  onListen() {
    GetStorage().listenKey(Store.LOGGED_IN, (value) {
      setState(() {
        isLoggedIn = value;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    onListen().call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          toolbarTextStyle: TextStyle(color: Colors.white),
          backgroundColor: Colors.black87,
          elevation: 1,
          title: Text(widget.title),
          centerTitle: true,
          actions: [
            MyButton(
              title: isLoggedIn ? "Log out" : "Log in",
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
              ),
              onClick: () async {
                if (isLoggedIn) {
                  GetStorage().erase();
                  setState(() {
                    isLoggedIn = false;

                    GetStorage().write(Store.LOGGED_IN, false);
                  });
                } else {
                  _showLoginForm();
                }
              },
            ),
          ],
        ),
        floatingActionButton: widget.showFloatButton && isLoggedIn
            ? FloatingActionButton(
                child: Icon(
                  Icons.add,
                  size: 30,
                ),
                backgroundColor: Colors.blue,
                onPressed: () async {
                  var isSuccess = await Get.toNamed(routes.add_blog);
                  if (isSuccess) {
                    showSuccesfull("Created successfully!");
                  }
                  blogController.loadData();
                })
            : null,
        body: widget.child);
  }

  _showLoginForm() {
    Get.defaultDialog(
        title: "Enter",
        content: Container(
          padding: EdgeInsets.all(10.0),
          child: TextFormField(
            controller: controller,
            enableInteractiveSelection: false,
            autofocus: true,
            obscureText: true,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            onFieldSubmitted: (val) {
              _onSubmit();
            },
          ),
        ),
        actions: [
          InkWell(
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
            ),
            onTap: () {
              controller.clear();
              Get.back();
            },
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Text("Log in",
                  style: TextStyle(color: Colors.green, fontSize: 15)),
            ),
            onTap: () {
              _onSubmit();
            },
          )
        ]);
  }

  _onSubmit() async {
    try {
      Get.back();
      String password = await Server.instance.getPassword();
      bool isRight = MyPassword.instance.checkPwd(controller.text, password);
      if (isRight) {
        setState(() {
          isLoggedIn = true;

          GetStorage().write(Store.LOGGED_IN, true);
        });
      } else {
        _catchLoginFail();
      }

      controller.clear();
    } catch (e) {
      _catchLoginFail();
    }
  }

  _catchLoginFail() {
    showError("Something went wrong!");
  }
}
