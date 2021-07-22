import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:keepboard/Notice.dart';
import 'package:keepboard/Pictuere.dart';

import 'Loading.dart';
import 'SnackBar.dart';

addForm(BuildContext context, Function addToList) {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController locationCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();

  bool finishLoad = false;
  String? _imagePath;
  String? picMissing;

  showAnimatedDialog(
    animationType: DialogTransitionType.slideFromLeftFade,
    curve: Curves.fastOutSlowIn,
    duration: Duration(milliseconds: 300),
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          TextFormField textFormField(ctrl, String hint,
              {TextInputType type = TextInputType.text}) {
            return TextFormField(
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              controller: ctrl,
              keyboardType: type,
              validator: (value) =>
                  value != null && value.isNotEmpty ? null : hint,
              decoration: InputDecoration(
                hintText: hint,
              ),
              autofocus: true,
            );
          }

          setPic(imagePath) {
            setState(
              () {
                _imagePath = imagePath;
                picMissing = null;
              },
            );
          }

          save() async {
            if (_imagePath == null) {
              setState(() => picMissing = 'חסר תמונה');
            }
            if (key.currentState!.validate()) {
              try {
                setState(() => finishLoad = true);

                // String pic = await Storage().addImage(File(_imagePath!),
                //     _imagePath!.substring(_imagePath!.lastIndexOf('/') + 1));

                addToList(Notice(
                    price: double.parse(priceCtrl.text),
                    name: nameCtrl.text,
                    picUrl: 'img/bg2.jpg',
                    title: titleCtrl.text,
                    location: locationCtrl.text,
                    phone: phoneCtrl.text));
              } catch (e) {
                snackBar(context, 'חלה שגיאה בעת הוספת המוצר');
              }

              setState(() => finishLoad = false);
              Navigator.of(context).pop();
            }
          }

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            actionsPadding: EdgeInsets.symmetric(horizontal: 88),
            content: SingleChildScrollView(
              child: Form(
                key: key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    textFormField(titleCtrl, "הכנס עיסוק"),
                    textFormField(nameCtrl, "הכנס שם"),
                    textFormField(locationCtrl, "הכנס מיקום"),
                    textFormField(
                      phoneCtrl,
                      "הכנס מספר טלפון",
                      type: TextInputType.number,
                    ),
                    textFormField(
                      priceCtrl,
                      "הכנס מחיר",
                      type: TextInputType.number,
                    ),
                    Pictuere(setImg: setPic),
                    if (picMissing != null)
                      Text(picMissing!, style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ),
            actions: [
              finishLoad
                  ? Loading()
                  : Center(
                      child: TextButton.icon(
                        icon: Icon(Icons.thumb_up),
                        label: Text(
                          "אישור",
                          style: TextStyle(fontSize: 25),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green.shade100,
                          textStyle: TextStyle(fontSize: 24),
                        ),
                        onPressed: save,
                      ),
                    ),
            ],
          );
        },
      );
    },
  );
}
