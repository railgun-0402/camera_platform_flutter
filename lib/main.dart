import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  XFile? _image;
  final imagePicker = ImagePicker();

  // カメラから写真を取得するメソッド
  Future getImageFromCamera() async {
    try {
      final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        if (pickedFile != null) {
          _image = XFile(pickedFile.path);
        }
      });
    } catch (error) {
      print(error);
    }
  }

  // ギャラリーから写真を取得するメソッド
  Future getImageFromGarally() async {
    try {
      final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = XFile(pickedFile.path);
        }
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // 取得した写真を表示する(写真がない場合はメッセージ)
        child: _image == null
            ? Text("写真を選択してください",
        style: Theme.of(context).textTheme.headlineSmall)
            : Image.file(File(_image!.path))
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // カメラから取得するボタン
          FloatingActionButton(
              onPressed: getImageFromCamera,
            child: const Icon(Icons.photo_camera),
          ),
          // ギャラリーから取得するボタン
          FloatingActionButton(
              onPressed: getImageFromGarally,
            child: const Icon(Icons.photo_album),
          )
        ],
      )
    );
  }
}
