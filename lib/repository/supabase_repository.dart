// repository/supabase_repository.dart
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRepository {
  final SupabaseClient client;
  const SupabaseRepository({required this.client});
  //TODO: LOGIN FUNCTIONALITY
  
  //Add the message to the database given tablename and the message
  addMessages(
      {required String tableName,
      required String message,
      required String createdAt}) async {
    try {
      await client.from(tableName).insert([
        {'message': message, 'created_at': createdAt}
      ]);
    } catch (e) {
      return e.toString();
    }
  }
}
