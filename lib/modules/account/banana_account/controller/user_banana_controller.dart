import 'dart:convert';
import 'dart:io';
import 'package:atlobha/global/Common/functions_app.dart';
import 'package:atlobha/global/components/show_toast_app.dart';
import 'package:atlobha/global/data/local/cache_helper.dart';
import 'package:atlobha/global/endpoints/url_api.dart';
import 'package:atlobha/global/utils/key_shared.dart';
import 'package:atlobha/modules/account/user_account/model/createusers_model.dart';
import 'package:atlobha/modules/layout/view/layout_screen.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserBananaController extends GetxController {
  bool loading = false;
  File? imageSelect;
  CreateUsersModel? createUsersModel;

  void setImage(File image) {
    imageSelect = image;
    update();
  }

  Future<void> pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageSelect = File(pickedFile.path);
      update();
    }
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController numberCarController = TextEditingController();

  Future<void> registrationBenana({required BuildContext context}) async {
    setLoading(true);

    dio.FormData formData = dio.FormData.fromMap({
      'files': [
        imageSelect != null
            ? await dio.MultipartFile.fromFile(imageSelect!.path,
                filename: imageSelect!.path.split('/').last)
            : null
      ],
      'username': usernameController.text.trim(),
      'password': passwordController.text.trim(),
      'profile_img': 'sda',
      'role_name': 'company',
      'phone': phoneController.text.trim(),
      'password_confirmation': passwordController.text.trim(),
      'number_car': numberCarController.text.trim()
    });

    try {
      var response = await dio.Dio().post(registerDistruedUrl, data: formData);

      if (response.statusCode == 200) {
        print(json.encode(response.data));

        createUsersModel = CreateUsersModel.fromJson(response.data);

        CacheHelper.saveData(key: TOKEN, value: createUsersModel!.token);
        await CacheHelper.saveData(
            key: NAMEUSER, value: createUsersModel!.data.username);
        await CacheHelper.saveData(
            key: NUMBERUSER, value: createUsersModel!.data.phone);

        navigateAndFinish(context, LayoutScreen());
      } else {
        showToastApp(
            text: response.statusMessage ?? 'Error', color: Colors.red);
      }
    } catch (e) {
      showToastApp(text: 'Try again', color: Colors.red);
      print(e.toString());
    } finally {
      setLoading(false);
    }
  }

  void setLoading(bool status) {
    loading = status;
    update();
  }
}
