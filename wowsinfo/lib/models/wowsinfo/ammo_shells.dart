/// The abstraction of the ammo shells.
abstract class Shell {
  String get name;
}

class ShellHE extends Shell {
  @override
  String get name => 'HE';
}

class ShellAP extends Shell {
  @override
  String get name => 'AP';
}

class ShellSAP extends Shell {
  @override
  String get name => 'SAP';
}
