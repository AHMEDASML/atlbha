import 'package:atlobha/global/data/remote/dio_helper.dart';
import 'package:atlobha/global/endpoints/url_api.dart';
import 'package:atlobha/modules/home/models/home_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeModel? homeModel;
  bool loading = false;

  Future<void> getHomeData() async {
    setLoading(true);
    try {
      var response = await DioHelper.getData(url: homeUrl);

      if (response.statusCode == 200) {
        print(response.data);
        homeModel = HomeModel.fromJson(response.data);

        print(homeModel!.data.car);
        print(homeModel!.data.ads.length);
        setLoading(false);
      } else {
        print(response.statusMessage);
        setLoading(false);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      update();
    }
  }

  @override
  void onInit() {
    getHomeData();
    super.onInit();
  }

  void setLoading(bool status) {
    loading = status;
    update();
  }
}
