extension ObjectX on dynamic {
  bool get isNullOrEmpty {
    if (this is String) {
      return this == null || this == '';
    }
    if (this is List) {
      return this == null || this.isEmpty;
    }
    if (this is Map) {
      return this == null || this.isEmpty;
    }
    return this == null;
  }
}
