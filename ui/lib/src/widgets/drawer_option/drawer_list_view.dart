import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerListView extends StatelessWidget {
  final List<String> items;

  const DrawerListView({Key key, @required this.items}) : super(key: key);

  // https://stackoverflow.com/questions/45669202/how-to-add-a-listview-to-a-column-in-flutter
  // https://api.flutter.dev/flutter/widgets/ListView-class.html

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            height: 40,
            color: Colors.blue,
            child: RaisedButton(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2.0, 8.0, 8.0, 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.volume_up),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            items[index],
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                onPressed: () => null));
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    ));
  }
}
