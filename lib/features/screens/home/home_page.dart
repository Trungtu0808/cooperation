import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        child: GestureDetector(
          child: Center(child: 'logout'.text.make()),
          onTap: (){
            Get.find<FireBaseAuthRepo>().logOut();
            Get.find<UserSecureStorage>().clear();
            debugPrint('logout');
          },
        ),
      ),
    );
  }
}
