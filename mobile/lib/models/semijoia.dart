class SemiJoia {
  final int? id;
  final String nome;
  final String tipo;
  final String material;
  final double preco;
  final double pesoGramas;
  final String? descricao;
  final bool disponivel;

  SemiJoia({
    this.id,
    required this.nome,
    required this.tipo,
    required this.material,
    required this.preco,
    required this.pesoGramas,
    this.descricao,
    this.disponivel = true,
  });

  factory SemiJoia.fromJson(Map<String, dynamic> json) {
    return SemiJoia(
      id: json['id'] as int?,
      nome: json['nome'] as String,
      tipo: json['tipo'] as String,
      material: json['material'] as String,
      preco: (json['preco'] as num).toDouble(),
      pesoGramas: (json['pesoGramas'] as num).toDouble(),
      descricao: json['descricao'] as String?,
      disponivel: json['disponivel'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'tipo': tipo,
      'material': material,
      'preco': preco,
      'pesoGramas': pesoGramas,
      'descricao': descricao,
      'disponivel': disponivel,
    };
  }
}