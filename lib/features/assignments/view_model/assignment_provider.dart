import 'package:flutter/material.dart';
import 'package:student_pal/features/assignments/model/assignment_model.dart';
import 'package:student_pal/repository/create_new_class_repo.dart';

class AssignmentProvider with ChangeNotifier {
  List<AssignmentModel> assignments = [];
  List<AssignmentModel> get classes => assignments;

  //add assignment to db
  Future<int> addAssignment({AssignmentModel? assignmentModel}) async {
    try {
      if (assignmentModel == null) {
        throw Exception("assignment data is null");
      }
      final int id = await CreateNewClassRepo.insertAssignment(assignmentModel);
      await getAllAssignment();
      return id;
    } catch (e) {
      print("Error adding c: $e");
      rethrow;
    }
  }

  Future<void> getAllAssignment() async {
    assignments = await CreateNewClassRepo.getAllAssignment();
    notifyListeners();
  }

  Future<void> updateAssignment(AssignmentModel assignmentModel) async {
    await CreateNewClassRepo.updateAssignment(assignmentModel);
    await getAllAssignment();
  }

  Future<void> deleteAssignment(int id) async {
    await CreateNewClassRepo.deleteAssignment(id);
    await getAllAssignment();
  }

  //mark Assignment as Completed
  void markClassCompleted(int id) async {
    await CreateNewClassRepo.updateCompletedAssignment(id);
    await getAllAssignment();
  }
}
