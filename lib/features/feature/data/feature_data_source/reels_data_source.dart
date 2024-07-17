import 'package:dio/dio.dart';

import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';

class ReelsDataSource {
  final BaseDioHelper baseDioHelper;

  ReelsDataSource(this.baseDioHelper);

  Future getReals(int page, int perPage) async {
    final Response response = await baseDioHelper.get(
      endPoint: EndPoints.reels,
      query: {
        'page': page,
        'per_page': perPage,
      }
    );
    return response.data;
  }
}
