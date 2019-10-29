import 'package:minesweeper/models/grid_model.dart';
import 'package:test_api/test_api.dart';

void main() {
  group('GridModel', () {
    test(
        'it should convert a list of strings into a valid grid model then back',
        () {
      List<List<String>> data = [
        ['E', 'E', 'E', 'E', 'E'],
        ['E', 'E', 'M', 'E', 'E'],
        ['E', 'E', 'E', 'E', 'E'],
        ['E', 'E', 'E', 'E', 'E']
      ];

      GridModel gridModel = GridModel.decode(data);

      expect(gridModel.encode(), [
        ['E', 'E', 'E', 'E', 'E'],
        ['E', 'E', 'M', 'E', 'E'],
        ['E', 'E', 'E', 'E', 'E'],
        ['E', 'E', 'E', 'E', 'E']
      ]);
    });
  });
}
