import 'package:encrypt/encrypt.dart' as encrypt;

class Encrypt {
  static final Encrypt instance = Encrypt._init();

  Encrypt._init();

  String encryptOrDecryptText(String value, isEncrypt) {

    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(8);
    final encrypter = encrypt.Encrypter(encrypt.Salsa20(key));

    if (isEncrypt == true) {
      final encrypted = encrypter.encrypt(value, iv: iv);
      return encrypted.base64;
    } else {
      final decrypted = encrypter.decrypt(encrypt.Encrypted.from64(value), iv: iv);
      return decrypted;
    }

  }
}
