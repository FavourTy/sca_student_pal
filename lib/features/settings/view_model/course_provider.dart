import 'package:flutter/material.dart';
import 'package:student_pal/features/settings/model/course_model.dart';
import 'package:student_pal/repository/create_new_class_repo.dart';

class CourseProvider with ChangeNotifier {
  List<CourseModel> _courses = [];
  List<CourseModel> get courses => _courses;

  /// Adds a new course to the database and updates the list of courses.
  Future<int> addCourse({CourseModel? course}) async {
    try {
      if (course == null) {
        throw Exception("Course data is null");
      }
      final int id = await CreateNewClassRepo.insertCourse(course);
      await loadCourses(); // Refresh the list of courses
      return id;
    } catch (e) {
      print("Error adding course: $e");
      rethrow;
    }
  }

  /// Loads all courses from the database and updates the list of courses.
  Future<void> loadCourses() async {
    try {
      _courses = await CreateNewClassRepo.getAllCourses();
      notifyListeners(); // Notify listeners that the data has changed
    } catch (e) {
      print("Error loading courses: $e");
      rethrow;
    }
  }

  /// Updates an existing course in the database and refreshes the list of courses.
  Future<void> updateCourse(CourseModel course) async {
    try {
      await CreateNewClassRepo.updateCourse(course);
      await loadCourses(); // Refresh the list of courses
    } catch (e) {
      print("Error updating course: $e");
      rethrow;
    }
  }

  /// Deletes a course from the database and refreshes the list of courses.
  Future<void> deleteCourse(int id) async {
    try {
      await CreateNewClassRepo.deleteCourse(id);
      await loadCourses(); // Refresh the list of courses
    } catch (e) {
      print("Error deleting course: $e");
      rethrow;
    }
  }
}
