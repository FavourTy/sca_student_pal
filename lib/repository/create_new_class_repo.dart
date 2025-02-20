import 'package:sqflite/sqflite.dart';
import 'package:student_pal/features/settings/model/course_model.dart';
import 'package:student_pal/features/today/models/create_class_model.dart';

class CreateNewClassRepo {
  static Database? _database;
  static final int _version = 1;
  static final String _classTableName = "classes";
  static final String _courseTableName = "courses";
  //static final String _assignmentTableName = "assignment";

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
      _database = await openDatabase(
        path,
        version: _version,
        onCreate: (db, version) async {
          await db.execute('PRAGMA foreign_keys = ON');
          await _createCourseTable(db);
          await _createClassTable(db);
        },
      );
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
        course_id INTEGER,
        isCompleted INTEGER,
        start_date TEXT,
        end_date TEXT,
        recurrence TEXT,
        startTime TEXT,
        endTime TEXT,
        remind INTEGER,
        repeat TEXT,
        FOREIGN KEY (course_id) REFERENCES $_courseTableName (id) ON DELETE CASCADE
      )
    ''');
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
}
