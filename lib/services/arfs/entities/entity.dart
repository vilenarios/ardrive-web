import 'package:ardrive/services/services.dart';
import 'package:arweave/arweave.dart';
import 'package:cryptography/cryptography.dart';
import 'package:json_annotation/json_annotation.dart';

import '../arfs.dart';

abstract class ArFsEntity {
  @JsonKey(ignore: true)
  String ownerAddress;
  @JsonKey(ignore: true)
  DateTime commitTime;

  /// Returns a transaction with the entity's data along with the appropriate tags.
  ///
  /// If a key is provided, the transaction data is encrypted.
  ///
  /// Throws an [EntityTransactionParseException] if the transaction represents an invalid entity.
  Future<Transaction> asTransaction([SecretKey key]);
}

class EntityTransactionParseException implements Exception {}

extension ArFsTransactionUtils on Transaction {
  void addArFsTags() {
    addTag(
        EntityTag.unixTime, DateTime.now().millisecondsSinceEpoch.toString());
    addTag(EntityTag.arFs, '0.10');
  }
}
