enum Complexity {
  easy,
  medium,
  difficult,
}

class Exercises {
  final String id;
  final String name;
  final String subtitle;
  final List<String> steps;
  final String imageUrl;
  final List<String> categories;
  final Complexity complexity;

  const Exercises({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.steps,
    required this.imageUrl,
    required this.categories,
    required this.complexity,
  });

  String get getComplexity {
    switch (complexity) {
      case Complexity.easy:
        return "Fácil";
      case Complexity.medium:
        return "Médio";
      case Complexity.difficult:
        return "Dificíl";
    }
  }
}
