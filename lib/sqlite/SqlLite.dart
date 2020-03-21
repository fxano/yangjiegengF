import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqlLite{
  ///创建数据库db
  createDb() async {
    //获取数据库路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user.db');
    //打开数据库
    await openDatabase(
        path,
        version:1,
        onUpgrade: (Database db, int oldVersion, int newVersion) async{
          //数据库升级,只回调一次
          print("数据库需要升级！旧版：$oldVersion,新版：$newVersion");
        },
        onCreate: (Database db, int ver) async{
          //创建表，只回调一次
          await db.execute('CREATE TABLE userInfo (id INTEGER PRIMARY KEY, username TEXT,userId TEXT,url Text,Token TEXT)');
          await db.close();
        }
    );
  }

  //查询
  getQuery() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "user.db");
    Database db = await openDatabase(path);
    List<Map> list = await db.rawQuery('select * from userInfo where id=1');
    await db.close();
    return list;
  }

  ///增
  add(Map map) async {
    //获取数据库路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user.db');
    Database db = await openDatabase(path);
    await db.transaction((txn) async {
      int count = await txn.rawInsert("INSERT INTO userInfo(username,userId,url,Token) VALUES('"+map["name"]+"','"+map["userId"]+"','"+map["url"]+"','"+map["userId"]+"')");
    });
    await db.close();
  }

  //删
  delete() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user.db');
    Database db = await openDatabase(path);
    int count = await db.rawDelete("DELETE FROM userInfo");
    await db.close();
    if (count > 0) {
    } else {
    }
  }
}