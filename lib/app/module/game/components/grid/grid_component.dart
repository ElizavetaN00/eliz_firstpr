import 'dart:math';

import 'package:flame/components.dart';

import '../hextile/hextile_component.dart';

class HexGridComponent extends PositionComponent {
  final List<int> rowStructure = [5, 6, 6, 6, 5];
  static const double tileRadius = 40.0;
  static const double horizontalSpacing = tileRadius * 3;
  static final double verticalSpacing = tileRadius * sqrt(3) * 1.5;
  onTapTile() {
    checkForFourInARow();
  }

  List<List<HexTile>> hexTiles = [];

  HexGridComponent(Vector2 screenSize) {
    // Define grid width and height
    final gridWidth = rowStructure.reduce(max) * horizontalSpacing;
    final gridHeight = rowStructure.length * verticalSpacing;

    // Center the grid on the screen
    position = Vector2(
      (screenSize.x - gridWidth) / 2,
      (screenSize.y - gridHeight) / 2,
    );

    for (int row = 0; row < rowStructure.length; row++) {
      final tileCount = rowStructure[row];
      double offsetX = (rowStructure.reduce(max) - tileCount) * horizontalSpacing / 2;

      if (row == 2) {
        offsetX -= horizontalSpacing / 2;
      }

      List<HexTile> rowTiles = [];
      for (int col = 0; col < tileCount; col++) {
        final tilePosition = Vector2(
          col * horizontalSpacing + offsetX,
          row * verticalSpacing,
        );

        final hexTile = HexTile(tilePosition, () => onTapTile());
        rowTiles.add(hexTile);
        add(hexTile);
      }
      hexTiles.add(rowTiles);
    }
  }

  // Method to check for four identical adjacent tiles
  bool checkForFourInARow() {
    for (int row = 0; row < hexTiles.length; row++) {
      for (int col = 0; col < hexTiles[row].length; col++) {
        HexTile tile = hexTiles[row][col];
        if (_hasFourAdjacentTiles(row, col, tile)) {
          tile.deleteTile();
          return true;
        }
      }
    }
    return false;
  }

  bool _hasFourAdjacentTiles(int row, int col, HexTile tile) {
    int matchCount = 1;
    final adjacentOffsets = [
      [-1, 0], [1, 0], // above and below
      [0, -1], [0, 1], // left and right
      [-1, 1], [1, -1] // diagonals
    ];

    for (final offset in adjacentOffsets) {
      int newRow = row + offset[0];
      int newCol = col + offset[1];

      if (newRow >= 0 &&
          newRow < hexTiles.length &&
          newCol >= 0 &&
          newCol < hexTiles[newRow].length &&
          hexTiles[newRow][newCol].colorCrystal.currentColor == tile.colorCrystal.currentColor) {
        matchCount++;
      }

      if (matchCount >= 4) {
        return true;
      }
    }

    return false;
  }
}
