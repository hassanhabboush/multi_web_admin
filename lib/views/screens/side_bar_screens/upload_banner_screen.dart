import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_web_admin/views/screens/side_bar_screens/widgets/banner_widgets.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String routeName = '/UploadBannerScreen';

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final FirebaseStorage _storage =
      FirebaseStorage.instance; // نستخدمه للتخزين في ال FirebaseStorage
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  dynamic _image;
  String? fileName;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (result != null) {
      setState(() {
        _image = result
            .files.first.bytes; // يجلب الصورة و يحفظها في متغير اسمه image_
        fileName = result.files.first.name; // يخزن اسم الصورة
      });
    }
  }

  _uploadBannersToStorage(dynamic image) async {
    Reference ref = _storage.ref().child('Banners').child(fileName!);
    // Banners : هذا اسم  المجلد الذي يتم تخزين الصور به
    // طبعا يأخذ اسم ملف الصورة التي نجلبها من الجهاز لكي نحملها على ال FirebaseStorage

    UploadTask uploadTask =
        ref.putData(image); // لكي نرفع الصورة على FirebaseStorage

    TaskSnapshot snapshot =
        await uploadTask; // هنا نخزن الصورة في متغير اسمه snapshot
    String downloadUrl = await snapshot.ref
        .getDownloadURL(); // طبعا بعد الرفع على Firebase نحتاج التحميل فسوف نستخدم هذا السطر لنحول اسم الصورة الى url و حتى نقدر ننزله من Firebase
    return downloadUrl;
  }

  uploadToFirebaseStore() async {
    EasyLoading.show(); // هذه لظهور التحميل
    //نريد ان نفحص هل المستخدم اختار صورة
    if (_image != null) {
      String imageUrl = await _uploadBannersToStorage(_image);
      await _firestore.collection('banners').doc(fileName).set({
        'image': imageUrl,
      }).whenComplete(() {
        EasyLoading.dismiss(); // تعمل على انهاء و توقف التحميل
        setState(() {
          _image = null;
        }); // هنا بعد التحميل بنجاح يفرخ ال Container من الصورة
      }); // هنا ننشأ الملف و نخزن في ال FirebaseFirestore
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Banner',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        border: Border.all(color: Colors.grey.shade800),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _image != null
                          ? Image.memory(
                              _image,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Text('Banners'),
                            ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          pickImage();
                        },
                        child: Text('Upload Image'))
                  ],
                ),
              ),
              SizedBox(width: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow.shade900,
                ),
                onPressed: () {
                  uploadToFirebaseStore();
                },
                child: Text('Save'),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Banner',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          BannerWidget(),
        ],
      ),
    );
  }
}
