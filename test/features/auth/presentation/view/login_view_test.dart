import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:student_management_hive_api/features/batch/domain/use_case/add_batch_usecase.dart';
import 'package:student_management_hive_api/features/batch/domain/use_case/get_all_batch_usecase.dart';
import 'package:student_management_hive_api/features/course/domain/use_case/get_all_course_usecase.dart';
// part 'login_view_test.g.dart';

@GenerateNiceMocks([
  MockSpec<GetAllBatchUsecase>(),
  MockSpec<GetAllCourseUsecase>(),
])
void main() {
  testWidgets('Login test with username and password and open dashboard', (WidgetTester tester) async {
  });
}