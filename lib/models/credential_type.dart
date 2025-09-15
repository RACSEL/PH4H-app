enum CredentialType {
  verifiableHealthLink,
  icvp;

  String get value {
    switch (this) {
      case CredentialType.verifiableHealthLink:
        return 'VerifiableHealthLink';
      case CredentialType.icvp:
        return 'ICVP';
    }
  }
}
