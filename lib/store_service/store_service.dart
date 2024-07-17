import 'package:firebase_auth/firebase_auth.dart';

class StoreService {
  final user = FirebaseAuth.instance.currentUser!;
}
