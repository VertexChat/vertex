#! /bin/sh

flutter build web
cp /home/cathal/vertex_fyp/vertex/ui/build/web/main.dart.js /home/cathal/Documents/vertex_web/static/
cp /home/cathal/vertex_fyp/vertex/ui/build/web/main.dart.js.map /home/cathal/Documents/vertex_web/static/
cp /home/cathal/vertex_fyp/vertex/ui/build/web/main.dart.js  /home/cathal/Documents/vertex_web/
scp -r /home/cathal/Documents/vertex_web/* nero:/home/cbutler/vertex_web/
