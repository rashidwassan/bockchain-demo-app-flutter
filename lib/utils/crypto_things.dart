import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../models/hash_with_nonce.dart';

// this method returns SHA256 of a string
class CryptoUtils {
  static String getSHA256(String data) {
    var bytes = utf8.encode(data);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  // this method returns SHA256 of a string with a givent difficulty,
  // the difficulty is the number of zeros that the hash should have
  static HashWithNonce getSHA256WithDifficulty(
      {required String data, required int difficulty}) {
    if (difficulty <= 0) throw Exception('Difficulty must be greater than 0');

    String regex = '^0{$difficulty}';
    int nonce = 0;
    List<int> bytes;
    Digest digest;
    for (nonce = 0;; nonce++) {
      bytes = utf8.encode(data + nonce.toString());
      digest = sha256.convert(bytes);
      if (RegExp(regex).hasMatch(digest.toString())) break;
    }
    return HashWithNonce(digest.toString(), nonce);
  }
}