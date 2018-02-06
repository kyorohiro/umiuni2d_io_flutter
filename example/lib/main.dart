library app;
import 'package:flutter/material.dart';
import 'package:umiuni2d_io_flutter/umiuni2d_io.dart' as uni;
import 'package:umiuni2d_io/umiuni2d_io.dart' as umi;

import 'dart:async';
import 'dart:convert' as conv;

void main() {
  runApp(new MaterialApp(
    title: 'Flutter Tutorial',
    home: new FileList(),
  ));
}

class FileList extends StatefulWidget {
  umi.Entry currentDir;
  List<umi.Entry> files =[];
  uni.FileSystem fileSystem;
  FileListState currentState;
  String groupValue = "file";

  FileList({Key key}) : super(key: key);

  ls() async {
    print("# ls");
    files.clear();
    List<umi.Entry> e = await fileSystem.ls("").toList();
    files.addAll(e);
    currentState.setState((){});//update();
  }
  mkdir(String v) async {
    try {
      await fileSystem.mkdir(v);
      files.clear();
      await ls();
    } catch(e){
    }
  }
  mkfile(String v) async {
    try {
      files.clear();
      umi.File f = await fileSystem.open(v);
      await f.writeAsBytes(conv.UTF8.encode("Hello, World!!"), 0);
      await f.close();
      await ls();
    } catch(e){
    }
  }
  delete(text) async {
    try {
      files.clear();
      await fileSystem.rm(text,recursive: true);
      await ls();
    } catch(e){


    }
  }
  read(String v) async {
    try {
      files.clear();
      umi.File f = await fileSystem.open(v);
      List<int> vv = await f.readAsBytes(0, await f.getLength());
      await f.close();
      try {
        return conv.UTF8.decode(vv);
      } catch(e) {
        return conv.BASE64.encode(vv);
      }
    } catch(e){
    }
    return  "";
  }
  cd(String name) async {
    print("# cd");
    await fileSystem.cd(name);
    currentDir = await fileSystem.wd();
    try {
      await ls();
    } catch(e) {
    }
  }

  State createState() {
    if(fileSystem == null) {
      fileSystem = new uni.FileSystem();
    }
    currentState =  new FileListState();
    new Future(()async {
      this.currentDir = await this.fileSystem.wd();
      await ls();
    });
    return currentState;
  }
}

class FileListState extends State<FileList> {

  String inputValue = "";
  void onPress(BuildContext context) {
    openCreateDialog();
  }

  void openCreateDialog() {
    showDialog(context: context, child: new Container(
        child: new AlertDialog(
          title: new Text('Create File/Dir'),
          content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  new TextField(onChanged:(v){inputValue = v;}),
                ],
              )),//child
          actions: <Widget>[
            new FlatButton(
              child: new Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text('Create'),
              onPressed: () async {
                if(inputValue.endsWith("/")) {
                  await this.widget.mkdir(inputValue);
                } else {
                  await this.widget.mkfile(inputValue);
                }
                setState((){});
                Navigator.of(context).pop();
                // this.setState((){});
              },
            ),
          ],//act
        )));
  }

  void openFileDialog(String text) {
    showDialog(context: context, child: new Container(
        child: new AlertDialog(
          title: new Text('Create File/Dir'),
          content: new SingleChildScrollView(
              child: new Text(text)
          ),//child
          actions: <Widget>[
            new FlatButton(
              child: new Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ],//act
        )));
  }

  void openDeleteDialog(String text) {
    showDialog(context: context, child: new Container(
        child: new AlertDialog(
          title: new Text('Create File/Dir'),
          content: new SingleChildScrollView(
              child: new Text(text)
          ),//child
          actions: <Widget>[
            new FlatButton(
              child: new Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text('Delete'),
              onPressed: () {
                this.widget.delete(text);
                setState((){});
                Navigator.of(context).pop();
              },
            ),
          ],//act
        )));
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> w = this.widget.files.map((umi.Entry v) =>buildItems(context, v.name)).toList();
    w.insert(0, buildItems(context,".."));
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          (this.widget.currentDir!=null?this.widget.currentDir.path:""),
          style: new TextStyle(fontSize: 8.0),),
      ),
      // body is the majority of the screen.
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: w,
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: new Icon(Icons.add),
        onPressed: (){onPress(context);},
      ),
    );
  }

  Widget buildItems(BuildContext context, String text) {
    return new ListTile(
      onTap: () async {
        if(await this.widget.fileSystem.isFile(text)) {
          String v = await this.widget.read(text);
          openFileDialog(v);
        } else {
          this.widget.cd(text);
          setState((){});
        }
      },
      onLongPress: (){
        openDeleteDialog(text);
      },
      leading: new CircleAvatar(
        child: new Text("Hello, World!!"),
      ),
      title: new Text(text),
    );
  }
  void update() {
    setState((){});
  }
}