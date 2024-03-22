import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/core/failure/failure.dart';
import 'package:student_management_hive_api/features/course/domain/repository/course_repository.dart';
final deleteCoursesUsecaseProvider = Provider<DeleteCourseUseCase>(
  (ref) =>
      DeleteCourseUseCase(courseRepository: ref.read(courseRepositoryProvider)),
);
class DeleteCourseUseCase{
  final ICourseRepository courseRepository;

  DeleteCourseUseCase({required this.courseRepository});

   Future<Either<Failure, bool>> deleteCourse(String id){
    return courseRepository.deleteCourse(id);
   }


}