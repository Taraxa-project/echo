import 'dart:async';

abstract class ExporterInterface {
  FutureOr<void> export();
}

class IpfsParams {
  String ipfsScheme;
  String ipfsHost;
  String ipfsPort;
  String? ipfsUsername;
  String? ipfsPassword;

  IpfsParams(
    this.ipfsScheme,
    this.ipfsHost,
    this.ipfsPort,
    this.ipfsUsername,
    this.ipfsPassword,
  );
}
