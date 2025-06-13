class User {
  final String nombre;
  final String celular;

  User({required this.nombre, required this.celular});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nombre: json['nombre'],
      celular: json['celular'],
    );
  }
}