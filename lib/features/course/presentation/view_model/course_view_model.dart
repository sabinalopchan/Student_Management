

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/core/common/snackbar/my_snackbar.dart';
import 'package:student_management_hive_api/features/course/domain/entity/course_entity.dart';
import 'package:student_management_hive_api/features/course/domain/use_case/add_course_usecase.dart';
import 'package:student_management_hive_api/features/course/domain/use_case/delete_course_use_case.dart';
import 'package:student_management_hive_api/features/course/domain/use_case/get_all_course_usecase.dart';
import 'package:student_management_hive_api/features/course/presentation/state/course_state.dart';

final courseViewModelProvider =
    StateNotifierProvider.autoDispose<CourseViewModel, CourseState>(
  (ref) => CourseViewModel(
    getAllCourseUsecase: ref.read(getAllCoursesUsecaseProvider),
    addCourseUsecase: ref.read(addCourseUsecaseProvider),
    deleteCourseUseCase: ref.read(deleteCoursesUsecaseProvider),
  ),
);

class CourseViewModel extends StateNotifier<CourseState> {
  final GetAllCourseUsecase getAllCourseUsecase;
  final AddCourseUsecase addCourseUsecase;
  final DeleteCourseUseCase deleteCourseUseCase;

  CourseViewModel(
      {required this.getAllCourseUsecase,
      required this.addCourseUsecase,
      required this.deleteCourseUseCase})
      : super(CourseState.initialState()) {
    getAllCourses();
  }

  void getAllCourses() {
    state = state.copyWith(isLoading: true);
    getAllCourseUsecase.getAllCourses().then((value) {
      value.fold(
        (failure) => state = state.copyWith(isLoading: false),
        (batches) {
          state = state.copyWith(isLoading: false, courses: batches);
        },
      );
    });
  }

  Future<void> addCourse(CourseEntity courseEntity) async {
    state = state.copyWith(isLoading: true);
    final result = await addCourseUsecase(courseEntity);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false),
      (isAdded) {
        state = state.copyWith(isLoading: false);
        getAllCourses();
      },
    );
  }

  Future<void> deleteCourse(BuildContext context, CourseEntity course) async {
    state.copyWith(isLoading: true);
    var data = await deleteCourseUseCase.deleteCourse(course.courseId!);
    data.fold(
      (l) {
        showSnackBar(message: l.error, context: context,color: Colors.red);
        state = state.copyWith(isLoading: false, error:l.error);
      },
      (r) {
        state.courses.remove(course);
        state = state.copyWith(isLoading: false,error: null);
        showSnackBar(
          context: context,
          message: 'Course Deleted Successfully',
        );
      },
    );
  }
}
