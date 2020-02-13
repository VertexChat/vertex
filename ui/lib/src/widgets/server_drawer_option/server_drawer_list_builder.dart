import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vertex_ui/src/models/channel_model.dart';

/// This class is used for building the lists of voice channels and text channels inside the
/// drawer. This class requires a list of Channel Models which hold the name of the list, name of the channel
/// and the icon that will be used.
// https://stackoverflow.com/questions/45669202/how-to-add-a-listview-to-a-column-in-flutter
// https://api.flutter.dev/flutter/widgets/ListView-class.html

class ServerDrawerListBuilder extends StatelessWidget {
  //Variables
  final List<ChannelModel> items;

  const ServerDrawerListBuilder({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: items == null ? 1 : items.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          //Display heading above the list
          return new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                items[index].listName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ],
          );
        }
        index -= 1;
        // Display channels in container
        return Container(
            height: 40,
            color: Colors.blue,
            child: RaisedButton(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(items[index].iconData),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            items[index].title,
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
  }//End builder
}//End class
