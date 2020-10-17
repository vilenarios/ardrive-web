import 'dart:convert';

import 'package:cryptography/cryptography.dart';

const keyByteLength = 256 ~/ 8;

final _pbkdf2 = Pbkdf2(
  macAlgorithm: Hmac(sha256),
  iterations: 100000,
  bits: 256,
);

Future<ProfileKeyDerivationResult> deriveProfileKey(String password,
    [Nonce salt]) async {
  salt ??= Nonce.randomBytes(128 ~/ 8);

  final keyBytes = await _pbkdf2.deriveBits(
    utf8.encode(password),
    nonce: salt,
  );

  return ProfileKeyDerivationResult(SecretKey(keyBytes), salt);
}

class ProfileKeyDerivationResult {
  final SecretKey key;
  final Nonce salt;

  ProfileKeyDerivationResult(this.key, this.salt);
}
