import 'package:student_management_hive_api/features/course/domain/entity/course_entity.dart';

class CourseState {
  final bool isLoading;
  final List<CourseEntity> courses;
  final String? error;

  CourseState({
    required this.isLoading,
    required this.courses,
    this.error,
  });

  factory CourseState.initialState() {
    return CourseState(
      isLoading: false,
      courses: [],
      error: null
    );
  }

  CourseState copyWith({
    bool? isLoading,
    List<CourseEntity>? courses,
    String? error,
  }) {
    return CourseState(
      isLoading: isLoading ?? this.isLoading,
      courses: courses ?? this.courses,
      error: error ?? this.error, // Don't overwrite the current error if there is one
    );
  }
}
