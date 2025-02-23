import 'package:sqflite/sqflite.dart';
import 'package:student_pal/features/assignments/model/assignment_model.dart';
import 'package:student_pal/features/settings/model/course_model.dart';
import 'package:student_pal/features/today/models/create_class_model.dart';

class CreateNewClassRepo {
  static Database? _database;
  static final int _version = 2;
  static final String _classTableName = "class";
  static final String _courseTableName = "courses";
  static final String _assignmentTableName = "assignment";

  static Future<void> deleteDataBase() async {
    String path = "${await getDatabasesPath()}classes.db";
    await deleteDatabase(path);
    print("Database deleted successfully");
  }

  static Future<void> initializeDb() async {
    if (_database != null) {
      return;
    }
    try {
      String path = "${await getDatabasesPath()}classes.db";
      _database = await openDatabase(path, version: _version,
          onCreate: (db, version) async {
        await db.execute('PRAGMA foreign_keys = ON');
        await _createCourseTable(db);
        await _createClassTable(db);
        await _createAssignmentTable(db);
      }, onUpgrade: (db, oldV, newV) async {
        await _onUpgrade(db, oldV, newV);
      });
    } catch (e) {
      print("Error initializing database: $e");
    }
  }

  static Future<void> _createCourseTable(Database db) async {
    await db.execute('''
      CREATE TABLE $_courseTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        code TEXT NOT NULL,
        color INTEGER NOT NULL
      )
    ''');
  }

  static Future<void> _createClassTable(Database db) async {
    await db.execute('''
      CREATE TABLE $_classTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        courseId INTEGER,
        isCompleted INTEGER,
        startDate TEXT,
        endDate TEXT,
        recurrence TEXT,
        startTime TEXT,
        endTime TEXT,
        remind INTEGER,
        repeat TEXT,
        title TEXT NOT NULL,
        note TEXT NOT NULL,
        color INTEGER NOT NULL,
        FOREIGN KEY (courseId) REFERENCES $_courseTableName (id) ON DELETE CASCADE
      )
    ''');
  }

  static Future<void> _createAssignmentTable(Database db) async {
    await db.execute('''
      CREATE TABLE $_assignmentTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        classId INTEGER,
        isCompleted INTEGER,
        dueDate TEXT,
        remind INTEGER,
        priority INTEGER,
        reminderTime TEXT,
        reminderDate TEXT,
        notificationId INTEGER,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        FOREIGN KEY (classId) REFERENCES $_classTableName(id) ON DELETE CASCADE
      )
    ''');
  }

  static Future<void> _onUpgrade(Database db, int oldV, int newV) async {
    if (oldV < newV) {
      print("Upgrading database from $oldV to $newV");
      await db.execute("DROP TABLE IF EXISTS $_classTableName");
      await _createClassTable(db);
    }
  }

  static Future<int> insertClass(CreateNewClass? createnewclass) async {
    if (_database == null) {
      await initializeDb();
    }
    if (createnewclass == null) {
      throw Exception("Class data is null");
    }
    return await _database?.insert(_classTableName, createnewclass.toJson()) ??
        0;
  }

  static Future<List<CreateNewClass>> getAllClass() async {
    if (_database == null) {
      await initializeDb();
    }
    final List<Map<String, dynamic>> maps =
        await _database!.query(_classTableName);
    return List.generate(maps.length, (i) {
      return CreateNewClass.fromJson(maps[i]);
    });
  }

  static Future<List<CreateNewClass>> getClassesByCourseId(int courseId) async {
    final db = _database;
    final maps = await db!
        .query(_classTableName, where: 'course_id = ?', whereArgs: [courseId]);
    return maps.map((map) => CreateNewClass.fromJson(map)).toList();
  }

  static Future<void> updateClass(CreateNewClass createnewclass) async {
    if (_database == null) {
      await initializeDb();
    }
    await _database!.update(
      _classTableName,
      createnewclass.toJson(),
      where: "id = ?",
      whereArgs: [createnewclass.id],
    );
  }

  static Future<void> deleteClass(int id) async {
    if (_database == null) {
      await initializeDb();
    }
    await _database?.delete(_classTableName, where: "id = ?", whereArgs: [id]);
  }

  static updateCompletedClass(int id) async {
    return await _database!.rawUpdate('''
     UPDATE class
     SET iscompleted = ?
     WHERE id =?
''', [1, id]);
  }

  static Future<int> insertCourse(CourseModel course) async {
    if (_database == null) {
      await initializeDb();
    }
    return await _database!.insert(_courseTableName, course.toJson());
  }

  static Future<List<CourseModel>> getAllCourses() async {
    if (_database == null) {
      await initializeDb();
    }
    final maps = await _database!.query(_courseTableName);
    return maps.map((map) => CourseModel.fromJson(map)).toList();
  }

  static Future<CourseModel?> getCourseById(int id) async {
    if (_database == null) {
      await initializeDb();
    }
    final maps = await _database!.query(
      _courseTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return CourseModel.fromJson(maps.first);
    }
    return null;
  }

  static Future<int?> updateCourse(CourseModel course) async {
    if (_database == null) {
      await initializeDb();
    }
    return await _database?.update(
      _courseTableName,
      course.toJson(),
      where: 'id = ?',
      whereArgs: [course.id],
    );
  }

  static Future<int> deleteCourse(int id) async {
    if (_database == null) {
      await initializeDb();
    }
    return await _database!.delete(
      _courseTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //assignment methods
  static Future<int> insertAssignment(AssignmentModel? assignmentModel) async {
    if (_database == null) {
      await initializeDb();
    }
    if (assignmentModel == null) {
      throw Exception("Assignment data is null");
    }
    return await _database?.insert(
            _assignmentTableName, assignmentModel.toJson()) ??
        0;
  }

  static Future<List<AssignmentModel>> getAllAssignment() async {
    if (_database == null) {
      await initializeDb();
    }
    final List<Map<String, dynamic>> maps =
        await _database!.query(_assignmentTableName);
    return List.generate(maps.length, (i) {
      return AssignmentModel.fromJson(maps[i]);
    });
  }

  static Future<List<AssignmentModel>> getAssignmentByClassId(
      int classId) async {
    final db = _database;
    final maps = await db!.query(_assignmentTableName,
        where: 'course_id = ?', whereArgs: [classId]);
    return maps.map((map) => AssignmentModel.fromJson(map)).toList();
  }

  static Future<void> updateAssignment(AssignmentModel assignmentModel) async {
    if (_database == null) {
      await initializeDb();
    }
    await _database!.update(
      _assignmentTableName,
      assignmentModel.toJson(),
      where: "id = ?",
      whereArgs: [assignmentModel.id],
    );
  }

  static Future<void> deleteAssignment(int id) async {
    if (_database == null) {
      await initializeDb();
    }
    await _database
        ?.delete(_assignmentTableName, where: "id = ?", whereArgs: [id]);
  }

  static updateCompletedAssignment(int id) async {
    return await _database!.rawUpdate('''
     UPDATE assignment
     SET iscompleted = ?
     WHERE id =?
''', [1, id]);
  }
}
