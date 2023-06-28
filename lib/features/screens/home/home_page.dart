import 'package:app_chat_firebase/import_file/import_all.dart';
import 'package:app_chat_firebase/widgets/icons/icon_button.dart';
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
      //backgroundColor: Colors.green,
      appBar: DefaultAppBar(
        leading: ActionIconButton(
            onTab: () {
              Get.find<FireBaseAuthRepo>().logOut();
              Get.find<UserSecureStorage>().clear();
              debugPrint('logout');
            },
            icon: Icons.menu),
        trailing: [
          ActionIconButton(
              onTab: () => context.router.push(const SearchRoute()), icon: Icons.search)
        ],
      ),
      body: GestureDetector(
        child: Center(child: 'logout'.text.make()),
        onTap: () {},
      ),
    );
  }
}
