// repository/supabase_repository.dart
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRepository {
  final SupabaseClient client;
  const SupabaseRepository({required this.client});

  // Add message to the main table
 addMessages({
    required String tableName,
    required String message,
    required String createdAt,
  }) async {
    try {
      await client.from(tableName).insert([
        {'message': message, 'created_at': createdAt}
      ]);
    } catch (e) {
      return e.toString();
    }
  }

  // Add vulgar message to the student_vulgar table
   addVulgarMessage({
    required String message,
    required String createdAt,
  }) async {
    try {
      await client.from('student_vulgar').insert([
        {'message': message, 'created_at': createdAt}
      ]);
    } catch (e) {
      return e.toString();
    }
  }
}
