import 'dart:convert';
import 'dart:typed_data';

import 'package:arweave/arweave.dart';
import 'package:cryptography/cryptography.dart';
import 'package:uuid/uuid.dart';

const _keyByteLength = 256 ~/ 8;
final _uuid = Uuid();
final _hkdf = Hkdf(Hmac(sha256));

Future<SecretKey> deriveDriveKey(
  Wallet wallet,
  String driveId,
  String password,
) async {
  final walletSignature = await wallet
      .sign(Uint8List.fromList(utf8.encode('drive') + _uuid.parse(driveId)));

  return _hkdf.deriveKey(
    SecretKey(walletSignature),
    info: utf8.encode(password),
    outputLength: _keyByteLength,
  );
}

Future<SecretKey> deriveFileKey(SecretKey driveKey, String fileId) async {
  final fileIdBytes = Uint8List.fromList(_uuid.parse(fileId));

  return _hkdf.deriveKey(
    driveKey,
    info: fileIdBytes,
    outputLength: _keyByteLength,
  );
}
