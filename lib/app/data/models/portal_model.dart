class PortalModel {
  String route;
  String tipe;
  dynamic source;
  bool visible;
  dynamic args;
  String name;

  PortalModel({required this.route, required this.name, required this.tipe, required this.source, required this.visible, this.args});
}
