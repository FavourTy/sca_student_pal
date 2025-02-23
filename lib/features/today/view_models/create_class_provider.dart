import 'package:flutter/material.dart';
import 'package:student_pal/features/today/models/create_class_model.dart';
import 'package:student_pal/repository/create_new_class_repo.dart';

class CreateClassProvider with ChangeNotifier {
  List<CreateNewClass> _classes = [];

  List<CreateNewClass> get classes => _classes;
  //add class to db
  Future<int> addClass({CreateNewClass? createNewClass}) async {
    try {
      if (createNewClass == null) {
        throw Exception("Class data is null");
      }
      final int id = await CreateNewClassRepo.insertClass(createNewClass);
      await getAllClasses();
      return id;
    } catch (e) {
      print("Error adding c: $e");
      rethrow;
    }
  }

  //get all tasks
  // void getTasks() async {
  //   List<Map<String, dynamic>> classes = await CreateNewClassRepo.Query();
  //   _classes.addAll(
  //       classes.map((data) => new CreateNewClass.fromJson(data)).toList());
  //   notifyListeners();
  // }
  // fetch all classes
  Future<void> getAllClasses() async {
    _classes = await CreateNewClassRepo.getAllClass();
    notifyListeners();
  }
  //update a class

  Future<void> updateClass(CreateNewClass createnewclass) async {
    await CreateNewClassRepo.updateClass(createnewclass);
    await getAllClasses();
  }

//delete a class
  Future<void> deleteClass(int id) async {
    await CreateNewClassRepo.deleteClass(id);
    await getAllClasses();
  }

//mark class as completed
  void markClassCompleted(int id) async {
    await CreateNewClassRepo.updateCompletedClass(id);
    await getAllClasses();
  }
}
