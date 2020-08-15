import 'package:arweave/arweave.dart';

extension TransactionUtils on Transaction {
  void addApplicationTags() {
    addTag('App-Name', 'drive');
    addTag('App-Version', '0.9.0');
  }

  void addJsonContentTypeTag() {
    addTag('Content-Type', 'application/json');
  }
}