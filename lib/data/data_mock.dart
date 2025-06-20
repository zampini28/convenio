import 'package:physioapp/models/exercises.dart';
import 'package:physioapp/models/category.dart';

class DataMock {
  static const List<Category> categoryDataList = [
    Category(
      id: 'c1',
      title: 'Exercícios para Braço',
    ),
    Category(
      id: 'c2',
      title: 'Exercícios para Pernas',
    ),
    Category(
      id: 'c3',
      title: 'Exercícios para Abdominal',
    ),
    Category(
      id: 'c4',
      title: 'Exercícios para Costa',
    ),
  ];

  static const List<Exercises> exercisesDataList = [
    Exercises(
      id: 'e1',
      name: 'Exercício para Ombro',
      subtitle: 'Fortalecendo o ombro em diferentes ângulos',
      steps: [
        'Estique o braço esquerdo para frente',
        'Com o braço esticado mova-o para trás lentamente',
        'Volte com o braço na posição normal',
        'Estique o braço direito para frente',
        'Com o braço esticado mova-o para trás lentamente',
        'Volte com o braço na posição normal',
      ],
      imageUrl:
          'https://p2.trrsf.com/image/fget/cf/940/0/images.terra.com/2024/09/27/1656115878-istock-1224321104.jpg',
      complexity: Complexity.easy,
      categories: ['c1', 'c4'],
    ),
    Exercises(
      id: 'e2',
      name: 'Exercício para braços',
      subtitle: 'Fortalecimento do braço com foco no trapezio',
      steps: [
        'Fique de costas para uma cadeira ou banco para se apoiar',
        'Sustente-se com os braços na cadeira e fique com as pernas em 90 graus',
        'Com o peso sustentado nos braços desça e suba o corpo deixando seus braços na cadeira',
      ],
      imageUrl:
          'https://p2.trrsf.com/image/fget/cf/774/0/images.terra.com/2024/04/12/1790291834-istock-1248545807ffnxbkv.jpg',
      complexity: Complexity.medium,
      categories: ['c1', 'c2'],
    ),
    Exercises(
      id: 'e3',
      name: 'Exercício para Glúteo',
      subtitle: 'Fortalecendo o glúteo e membros inferiores',
      steps: [
        'Fique de costas para um banco',
        'Coloque a perna direita sobre o banco, mantendo-se de costas',
        'Abaixe o corpo mantendo a a perna sobre o banco e volte lentamente',
        'Volte a perna direita ao chão',
        'Coloque a perna esquerda sobre o banco, mantendo-se de costas',
        'Abaixe o corpo mantendo a a perna sobre o banco e volte lentamente',
      ],
      imageUrl:
          'https://p2.trrsf.com/image/fget/cf/774/0/images.terra.com/2023/10/13/620551488-istock-1248545816.jpg',
      complexity: Complexity.easy,
      categories: ['c2'],
    ),
    Exercises(
      id: 'e4',
      name: 'Exercício para panturrilhas',
      subtitle: 'Fostalecimento de panturrilha e membros inferiores',
      steps: [
        'Mantenha a postura ereta do corpo',
        'Erga o corpo na ponta dos pés',
        'Volte lentamente ao normal',
      ],
      imageUrl:
          'https://p2.trrsf.com/image/fget/cf/774/0/images.terra.com/2023/09/08/396374473-istock-1390409405.jpg',
      complexity: Complexity.medium,
      categories: ['c2'],
    ),
    Exercises(
      id: 'e5',
      name: 'Exercício para Pernas',
      subtitle: 'Fortalecimento de pernas e equilibrio do corpo',
      steps: [
        'Mantenha o corpo em posição ereta',
        'Flexione os joelhos e incline-se para frente',
        'Salte sobre um objeto baixo mantendo os joelho flexionados e corpo equilibrado',
        'Pule de volta ao chão',
      ],
      imageUrl:
          'https://p2.trrsf.com/image/fget/cf/774/0/images.terra.com/2024/01/12/648193685-istock-1147316215.jpg',
      complexity: Complexity.medium,
      categories: ['c2', 'c3', 'c4'],
    ),
    Exercises(
      id: 'e6',
      name: 'Exercício para Lombar',
      subtitle: 'Semi agachamento esticando uma das pernas para lateral',
      steps: [
        'Mantenha o corpo ereto',
        'Junte as mãos',
        'Mova-se para o lado esquerdo inclinando-se para frente',
        'estique a perna esquerda para a lateral direita',
        'Volte a postura ereta',
        'Mova-se para o lado direito inclinando-se para frente',
        'estique a perna esquerda para a lateral esquerda',
      ],
      imageUrl:
          'https://p2.trrsf.com/image/fget/cf/774/0/images.terra.com/2024/02/23/544828845-istock-969066472.jpg',
      complexity: Complexity.difficult,
      categories: ['c3', 'c2', 'c4'],
    ),
  ];
}
