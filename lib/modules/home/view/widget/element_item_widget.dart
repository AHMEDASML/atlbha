import 'dart:io';

import 'package:atlobha/global/components/text_bolde_widget.dart';
import 'package:atlobha/global/components/text_nourmal_widget.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/modules/home/view/widget/spare_parts_requests_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ElementItemWidget extends StatefulWidget {
  final VoidCallback onRemove;
  final TextEditingController textController;
  final Function(int) onNumberChanged;
  final Function(File?) onImageChanged;
  final int id;

  const ElementItemWidget(
      {Key? key,
        required this.onRemove,
        required this.textController,
        required this.onNumberChanged,
        required this.onImageChanged,
        required this.id})
      : super(key: key);

  @override
  State<ElementItemWidget> createState() => _ElementItemWidgetState();
}

class _ElementItemWidgetState extends State<ElementItemWidget> {
  int number = 1;
  File? _image;

  void _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        File image = File(pickedFile.path);
        setState(() {
          _image = image;
        });
        widget.onImageChanged(image); // تأكد من استدعاء هذه الدالة
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.onNumberChanged(number);
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Choose Image Source".tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: Text("Camera".tr),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: Text("Gallery".tr),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void onNumberChange(bool increment) {
      setState(() {
        if (increment) {
          number++;
        } else {
          if (number > 0) number--;
        }
        widget.onNumberChanged(number); // Callback on number change
      });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextNourmalWidget(
                  text: 'Name or number of the part'.tr,
                  fontSize: 18,
                ),
                GestureDetector(
                    onTap: widget.onRemove,
                    child:
                    const Icon(Icons.close, color: Colors.black, size: 32)),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                  child:
                  textFieldSpareParts(controller: widget.textController)),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: _showImagePickerDialog,
                child: iconSparePartsRequests(
                  icon: _image == null
                      ? const Icon(Icons.image_search_outlined,
                      size: 30, color: Colors.grey)
                      : Image.file(_image!,
                      width: 30, height: 30, fit: BoxFit.cover),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    number++;
                  });
                  onNumberChange(true);
                },
                child: iconSparePartsRequests(
                    icon: Icon(
                      Icons.add,
                      size: 28,
                      color: ColorManager.yellow2,
                    )),
              ),
              Expanded(
                child: iconSparePartsRequests(
                  icon: Center(
                      child: TextBoldeWidget(
                          text: number.toString(), fontSize: 24)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    number--;
                  });
                  onNumberChange(false);
                },
                child: iconSparePartsRequests(
                    icon: Icon(Icons.remove,
                        size: 28, color: ColorManager.yellow2)),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
