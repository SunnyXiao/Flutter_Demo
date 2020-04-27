import 'package:flutter_app/src/api/httpManager.dart';
import 'package:flutter_app/src/api/urls.dart';

class HomeApiService {
  static getBannerData() async {
    var result = await HttpManager().getAsync(url: ApiUrls.getBannerUrl, tag: 'getBanner');

    return result;
  }
}
