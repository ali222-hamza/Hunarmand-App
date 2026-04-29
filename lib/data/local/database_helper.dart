import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';
import '../models/booking_model.dart';
import '../models/transaction_model.dart';
import '../models/message_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'hunarmand.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    // Users Table: uid ko UNIQUE rakha hai taake login/signup par data overwrite ho
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        uid TEXT NOT NULL UNIQUE,
        fullName TEXT NOT NULL,
        email TEXT NOT NULL,
        phone TEXT NOT NULL,
        role TEXT NOT NULL,
        profileImage TEXT,
        isVerified INTEGER DEFAULT 0,
        cnicNumber TEXT,
        location TEXT,
        rating REAL DEFAULT 0.0,
        jobsDone INTEGER DEFAULT 0,
        walletBalance REAL DEFAULT 0.0,
        createdAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE bookings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bookingId TEXT NOT NULL UNIQUE,
        customerId TEXT NOT NULL,
        workerId TEXT NOT NULL,
        workerName TEXT NOT NULL,
        serviceType TEXT NOT NULL,
        bookingDate TEXT NOT NULL,
        bookingTime TEXT NOT NULL,
        address TEXT NOT NULL,
        notes TEXT,
        status TEXT DEFAULT 'pending',
        amount REAL DEFAULT 0.0,
        createdAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        transactionId TEXT NOT NULL UNIQUE,
        userId TEXT NOT NULL,
        type TEXT NOT NULL,
        amount REAL NOT NULL,
        description TEXT NOT NULL,
        status TEXT DEFAULT 'pending',
        createdAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE messages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        messageId TEXT NOT NULL UNIQUE,
        chatId TEXT NOT NULL,
        senderId TEXT NOT NULL,
        receiverId TEXT NOT NULL,
        text TEXT NOT NULL,
        isRead INTEGER DEFAULT 0,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  // ---- USER OPERATIONS ----

  Future<int> insertUser(UserModel user) async {
    final db = await database;
    // ConflictAlgorithm.replace purane data ko naye data se update kar deta hai
    return await db.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<UserModel?> getUserByUid(String uid) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'uid = ?',
      whereArgs: [uid],
    );
    if (maps.isEmpty) return null;
    return UserModel.fromMap(maps.first);
  }

  Future<List<UserModel>> getAllUsers() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query('users');
    return maps.map((m) => UserModel.fromMap(m)).toList();
  }

  Future<void> updateWalletBalance(String uid, double newBalance) async {
    final db = await database;
    await db.update(
      'users',
      {'walletBalance': newBalance},
      where: 'uid = ?',
      whereArgs: [uid],
    );
  }

  Future<void> updateUserRole(String uid, String role) async {
    final db = await database;
    await db.update(
      'users',
      {'role': role},
      where: 'uid = ?',
      whereArgs: [uid],
    );
  }

  // ---- BOOKING OPERATIONS ----

  Future<int> insertBooking(BookingModel booking) async {
    final db = await database;
    return await db.insert(
        'bookings',
        booking.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<List<BookingModel>> getCustomerBookings(String customerId) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'bookings',
      where: 'customerId = ?',
      whereArgs: [customerId],
      orderBy: 'createdAt DESC',
    );
    return maps.map((m) => BookingModel.fromMap(m)).toList();
  }

  Future<List<BookingModel>> getWorkerBookings(String workerId) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'bookings',
      where: 'workerId = ?',
      whereArgs: [workerId],
      orderBy: 'createdAt DESC',
    );
    return maps.map((m) => BookingModel.fromMap(m)).toList();
  }

  Future<void> updateBookingStatus(String bookingId, String newStatus) async {
    final db = await database;
    await db.update(
      'bookings',
      {'status': newStatus},
      where: 'bookingId = ?',
      whereArgs: [bookingId],
    );
  }

  Future<List<BookingModel>> getAllBookings() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query('bookings', orderBy: 'createdAt DESC');
    return maps.map((m) => BookingModel.fromMap(m)).toList();
  }

  // ---- TRANSACTION OPERATIONS ----

  Future<int> insertTransaction(TransactionModel tx) async {
    final db = await database;
    return await db.insert(
        'transactions',
        tx.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<List<TransactionModel>> getUserTransactions(String userId) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'transactions',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'createdAt DESC',
    );
    return maps.map((m) => TransactionModel.fromMap(m)).toList();
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query('transactions', orderBy: 'createdAt DESC');
    return maps.map((m) => TransactionModel.fromMap(m)).toList();
  }

  // ---- MESSAGE OPERATIONS ----

  Future<int> insertMessage(MessageModel message) async {
    final db = await database;
    return await db.insert(
        'messages',
        message.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<List<MessageModel>> getChatMessages(String chatId) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'messages',
      where: 'chatId = ?',
      whereArgs: [chatId],
      orderBy: 'createdAt ASC',
    );
    return maps.map((m) => MessageModel.fromMap(m)).toList();
  }
}