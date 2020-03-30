import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vertex_ui/locator.dart';

/// This class convert the BaseView into a stateful widget on use the onInit to pass
/// the model back to use in a callback function that we can execute on.
/// Convert the BaseView into a stateful widget and pass it a Function(T) that
/// returns the model to us.
/// Ref: https://www.filledstacks.com/post/flutter-architecture-my-provider-implementation-guide/
/// https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple


class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget child) builder;
  final Function(T) onModelReady;

  BaseView({@required this.builder, this.onModelReady});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>> {
  T model = locatorGlobal<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(builder: widget.builder),
    );
  }
} //End class
