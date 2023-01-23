class PerusahaanTv {
  final int id;
  final String logo;
  final String name;
  final String country;

  PerusahaanTv(
    this.id,
    this.logo,
    this.name,
    this.country,
  );

  PerusahaanTv.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        logo = json["logo_path"],
        name = json["name"],
        country = json["origin_country"];
}
