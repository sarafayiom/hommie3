import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hommie/models/signup_step3_model.dart';

class SignupStep3Service {
  Future<Map<String, dynamic>> submitStep3(SignupStep3Model model) async {
    final response = await http.post(
  Uri.parse('http://10.0.2.2:8000/api/auth/register/page3'),
  headers: {"Content-Type": "application/json"},
  body: jsonEncode(model.toJson()),
);

print(" Response Status: ${response.statusCode}");
print(" Response Body: ${response.body}");
    if (response.statusCode == 200) {
      return {"success": true, "data": jsonDecode(response.body)};
    } else {
      return {"success": false, "error": response.body};
    }
  }
}
