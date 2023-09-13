import 'package:flutter/material.dart';

class BaseStatelessWidget extends StatelessWidget with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    print(
        "********************** didChangeAppLifecycleState: $state ***********************");
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BaseStatefulWidget extends StatefulWidget {
  BaseStatefulWidget({Key? key}) : super(key: key);

  @override
  BaseState createState() => BaseState();
}

class BaseState<T extends BaseStatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    print("++++++++++++++++++++ build +++++++++++++++++++");
    return Container();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    print(
        "********************** didChangeAppLifecycleState: $state ***********************");
    if (state == AppLifecycleState.resumed) {
      // Injector.setAppInTime();
    }
    if (state == AppLifecycleState.paused) {
      // this.callAddUserActiveApi();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }
}
