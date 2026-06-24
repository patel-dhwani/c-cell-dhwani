import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://knwydxqjzwfqsrgjdqdn.supabase.co';
  static const String supabasePublishableKey =
      'sb_publishable_1rbEp0eNCRlwFTicMgLQ5A_36mX2XQQ';

  static Future<void> init() async {
    await Supabase.initialize(
      url: supabaseUrl,
      publishableKey: supabasePublishableKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
