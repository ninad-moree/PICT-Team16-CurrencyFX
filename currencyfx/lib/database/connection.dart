import 'package:mysql1/mysql1.dart';

Future<MySqlConnection?> openConnection() async {
  final settings = ConnectionSettings(
    host: 'localhost',
    port: 48034,
    user: 'root',
    db: 'currencyfx',
    password: 'root123',
  );

  try {
    final MySqlConnection connection = await MySqlConnection.connect(settings);

    // Execute a simple query to check the connection
    final results = await connection.query('SELECT 1');

    if (results.isNotEmpty) {
      print('Connected to the database.');
      return connection;
    } else {
      print('Failed to connect to the database.');
      await connection.close();
      return null;
    }
  } catch (e) {
    print('Error connecting to the database: $e');
    return null;
  }
}
