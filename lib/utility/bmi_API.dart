import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> submitUserData(
  String tahunLahir,
  String berat,
  String tinggi,
  String gender,
  String token, // Tambahkan parameter token
) async {
  final url = Uri.parse('https://6cc5-210-210-144-170.ngrok-free.app/bmi');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token', // Tambahkan token di sini
  };

  final body = jsonEncode({
    "tanggal_lahir": tahunLahir,
    "berat_badan": int.tryParse(berat) ?? 0,
    "tinggi_badan": int.tryParse(tinggi) ?? 0,
    "jenis_kelamin": gender,
  });

  print("Sending data: $body");

  try {
    final response = await http.post(url, headers: headers, body: body);

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      print("Gagal mengirim data. Status: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("Error: $e");
    return null;
  }
}
