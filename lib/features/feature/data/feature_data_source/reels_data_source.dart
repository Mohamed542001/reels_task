import 'package:dio/dio.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';

class ReelsDataSource {
  final BaseDioHelper baseDioHelper;

  ReelsDataSource(this.baseDioHelper);

  Future getReals() async {
    final Response response = await baseDioHelper.get(
      endPoint: EndPoints.reels,
    );
    return response.data['data'];
  }
}
