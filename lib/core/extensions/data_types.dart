extension NullableString on String? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }

  bool get isNotNullOrEmpty {
    return !isNullOrEmpty;
  }

  int get fastHash {
    if (this == null) return 0;

    int hash = 0xcbf29ce484222325;
    for (int i = 0; i < this!.length; i++) {
      hash ^= this!.codeUnitAt(i);
      hash *= 0x100000001b3;
      hash &= 0xffffffffffffffff;
    }
    return hash;
  }
}
