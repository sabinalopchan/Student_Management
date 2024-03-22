import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/config/constants/api_endpoints.dart';
import 'package:student_management_hive_api/core/failure/failure.dart';
import 'package:student_management_hive_api/core/network/http_service.dart';
import 'package:student_management_hive_api/core/shared_prefs/user_shared_prefs.dart';
import 'package:student_management_hive_api/features/course/data/dto/get_all_course_dto.dart';
import 'package:student_management_hive_api/features/course/data/model/course_api_model.dart';
import 'package:student_management_hive_api/features/course/domain/entity/course_entity.dart';

final courseRemoteDataSourceProvider =
    Provider.autoDispose<CourseRemoteDataSource>(
  (ref) => CourseRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class CourseRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  CourseRemoteDataSource({required this.dio, required this.userSharedPrefs});

  Future<Either<Failure, List<CourseEntity>>> getAllCourses() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllCourse);
      if (response.statusCode == 200) {
        // Convert CourseAPIModel to CourseEntity
        GetAllCourseDTO courseAddDTO = GetAllCourseDTO.fromJson(response.data);
        List<CourseEntity> courseList = courseAddDTO.data
            .map((course) => CourseAPIModel.toEntity(course))
            .toList();

        return Right(courseList);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }
  Future<Either<Failure,bool>> deleteCourse(String courseId) async{
    try{
      String? token;
      var data= await userSharedPrefs.getUserToken();
      data.fold((l) => token=null, (r) => token = r!);

      Response response = await dio.delete(
        ApiEndpoints.deleteCourse + courseId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token'
          },
        ),
      );
      if (response.statusCode== 200){
        return const Right(true);
      } else{
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
