import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'Loading.dart';
import 'SnackBar.dart';

class Pictuere extends StatefulWidget {
  final Function setImg;
  const Pictuere({Key? key, required this.setImg}) : super(key: key);

  @override
  _PictuereState createState() => _PictuereState();
}

class _PictuereState extends State<Pictuere> {
  bool loading = false;
  String? path;

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

    setImage(pickedFile) async {
      if (pickedFile != null) {
        try {
          setState(() => loading = true);

          widget.setImg(pickedFile.path);
          path = pickedFile.path;

          setState(() => loading = false);
        } catch (e) {
          snackBar(context, 'Fail to upload.');
          setState(() => loading = false);
        }
      } else {
        snackBar(context, 'No image selected.');
        setState(() => loading = false);
      }
    }

    Future getGalaryImage() async {
      final PickedFile? pickedFile =
          await picker.getImage(source: ImageSource.gallery);

      setImage(pickedFile);
    }

    Future getCameraImage() async {
      final PickedFile? pickedFile =
          await picker.getImage(source: ImageSource.camera);

      setImage(pickedFile);
    }

    return Center(
      child: path == null
          ? loading == true
              ? Loading()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('העלה תמונה'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: getGalaryImage,
                          icon: Icon(Icons.photo_album_outlined),
                        ),
                        IconButton(
                          onPressed: getCameraImage,
                          icon: Icon(Icons.camera_sharp),
                        ),
                      ],
                    ),
                  ],
                )
          : Image.asset(
              path!,
              height: 200,
              width: 500,
            ),
    );
  }
}
