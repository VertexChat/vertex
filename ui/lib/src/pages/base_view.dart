import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vertex_ui/locator.dart';

/// This class convert the BaseView into a [StatefulWidget] on use the [onInit] to pass
/// the model back to use in a callback function that can be execute on.
/// Convert the BaseView into a [StatefulWidget] and pass it a Function(T) that
/// returns the model, this model now gives access to the functions inside that class.
/// The [BaseView.onModelReady] is super useful as now the UI element can know
/// if it can display a progress indicator or the data depending on the [BaseModel.state].
///
///
/// Ref: https://www.filledstacks.com/post/flutter-architecture-my-provider-implementation-guide/
/// https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  // Variables
  final Widget Function(BuildContext context, T value, Widget child) builder;
  final Function(T) onModelReady;

  BaseView({@required this.builder, this.onModelReady});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>> {
  T model = locatorGlobal<T>();

  /// Returns model when it is ready using the [initState]
  /// of a [StatefulWidget].
  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(builder: widget.builder),
    );
  }
} //End class
