import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/config/router/app_route.dart';
import 'package:student_management_hive_api/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_hive_api/features/course/domain/entity/course_entity.dart';
import 'package:student_management_hive_api/features/course/domain/use_case/get_all_course_usecase.dart';
import 'package:student_management_hive_api/features/home/presentation/state/home_state.dart';

import '../../../batch/domain/use_case/get_all_batch_usecase.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>(
  (ref) => HomeViewModel(
      getAllBatchUsecase: ref.read(getAllBatchUsecaseProvider),
      getAllCoursesUsecase: ref.read(getAllCoursesUsecaseProvider)),
);

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel({required this.getAllBatchUsecase, required this.getAllCoursesUsecase}) : super(HomeState.initialState()){
    getAllData();
  }

  final GetAllBatchUsecase getAllBatchUsecase;
  final GetAllCourseUsecase getAllCoursesUsecase;

  void changeIndex(int index) {
    state = state.copyWith(index: index);
  }

  void signOut(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoute.loginRoute);
  }

  void getAllData() {
    state = state.copyWith(isLoading: true);

    getAllBatchUsecase.getAllBatch().then((value) {
      value.fold(
            (failure) => state = state.copyWith(isLoading: false),
            (batches) {
          state = state.copyWith(batches: batches, isLoading: false);
        },
      );
    });
    getAllCoursesUsecase.getAllCourses().then((value) {
      value.fold(
            (failure) => state = state.copyWith(isLoading: false),
            (courses) {
          state = state.copyWith(courses: courses, isLoading: false);
        },
      );
    });
  }
}
