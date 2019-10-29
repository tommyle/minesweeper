import 'package:minesweeper/models/grid_model.dart';
import 'package:test_api/test_api.dart';

void main() {
  group('GridModel', () {
    test('it should reveal the grid', () {
      List<List<String>> data = [
        ['E', 'E', 'E', 'E', 'E'],
        ['E', 'E', 'M', 'E', 'E'],
        ['E', 'E', 'E', 'E', 'E'],
        ['E', 'E', 'E', 'E', 'E'],
        ['E', 'E', 'E', 'E', 'E']
      ];

      GridModel gridModel = GridModel.decode(data);
      gridModel.reveal(3, 0);

      expect(gridModel.encode(), [
        ['0', '1', 'E', '1', '0'],
        ['0', '1', 'M', '1', '0'],
        ['0', '1', '1', '1', '0'],
        ['0', '0', '0', '0', '0'],
        ['0', '0', '0', '0', '0']
      ]);
    });

    test('it should reveal the grid', () {
      List<List<String>> data = [
        ['E', 'E', 'E', 'E', 'E'],
        ['E', 'E', 'M', 'E', 'E'],
        ['E', 'E', 'E', 'E', 'E'],
        ['E', 'E', 'E', 'E', 'E'],
        ['E', 'E', 'E', 'E', 'M']
      ];

      GridModel gridModel = GridModel.decode(data);
      gridModel.reveal(3, 0);

      expect(gridModel.encode(), [
        ['0', '1', 'E', 'E', 'E'],
        ['0', '1', 'M', 'E', 'E'],
        ['0', '1', '1', '1', 'E'],
        ['0', '0', '0', '1', 'E'],
        ['0', '0', '0', '1', 'M']
      ]);
    }, skip: false);

    test('it should reveal the grid', () {
      List<List<String>> data = [
        ['E', 'E', 'E', 'E', 'E'],
        ['E', 'E', 'M', 'E', 'E'],
        ['E', 'M', 'E', 'M', 'E'],
        ['E', 'E', 'E', 'E', 'E'],
        ['E', 'E', 'E', 'E', 'M']
      ];

      GridModel gridModel = GridModel.decode(data);
      gridModel.reveal(2, 2);

      expect(gridModel.encode(), [
        ['E', 'E', 'E', 'E', 'E'],
        ['E', 'E', 'M', 'E', 'E'],
        ['E', 'M', '3', 'M', 'E'],
        ['E', 'E', 'E', 'E', 'E'],
        ['E', 'E', 'E', 'E', 'M']
      ]);
    }, skip: false);

    test('it should reveal the grid', () {
      List<List<String>> data = [
        ['M', 'M', 'M', 'M', 'M'],
        ['E', 'E', 'M', 'E', 'M'],
        ['E', 'E', 'E', 'E', 'E'],
        ['E', 'E', 'E', 'E', 'E'],
        ['E', 'E', 'E', 'E', 'E']
      ];

      GridModel gridModel = GridModel.decode(data);
      gridModel.reveal(1, 3);

      expect(gridModel.encode(), [
        ['M', 'M', 'M', 'M', 'M'],
        ['E', 'E', 'M', '5', 'M'],
        ['E', 'E', 'E', 'E', 'E'],
        ['E', 'E', 'E', 'E', 'E'],
        ['E', 'E', 'E', 'E', 'E']
      ]);
    }, skip: false);
  });
}
