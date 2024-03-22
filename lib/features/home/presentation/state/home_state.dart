import 'package:flutter/widgets.dart';
import 'package:student_management_hive_api/features/batch/presentation/view/add_batch_view.dart';
import 'package:student_management_hive_api/features/course/domain/entity/course_entity.dart';
import 'package:student_management_hive_api/features/course/presentation/view/add_course_view.dart';
import 'package:student_management_hive_api/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:student_management_hive_api/features/home/presentation/view/bottom_view/profile_view.dart';

import '../../../batch/domain/entity/batch_entity.dart';

class HomeState {
  final int index;
  final bool isLoading;
  final List<BatchEntity> batches;
  final List<CourseEntity> courses;
  final List<Widget> lstWidgets;

  HomeState({required this.index, required this.lstWidgets, required this.isLoading, required this.batches, required this.courses});

  HomeState.initialState()
      : index = 0,
        isLoading = false,
        batches = [],
        courses = [],
        lstWidgets = [
          const DashboardView(),
          AddCourseView(),
          AddBatchView(),
          const ProfileView(),
        ];

  // CopyWith function to change the index no
  HomeState copyWith({
    int? index,
    bool? isLoading,
    List<BatchEntity>? batches,
    List<CourseEntity>? courses,
  }) {
    return HomeState(
      index: index ?? this.index,
      isLoading: isLoading ?? this.isLoading,
      batches: batches ?? this.batches,
      courses: courses ?? this.courses,
      lstWidgets: lstWidgets,
    );
  }
}
