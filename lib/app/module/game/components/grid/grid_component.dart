import 'dart:collection';
import 'dart:math';
import 'package:color_puzzle/app/module/game/components/logical_size_component.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../hextile/hextile_component.dart';

class HexGridComponent extends PositionComponent {
  final List<int> rowStructure = [5, 6, 6, 6, 5];
  static double tileRadius = LogicalSize.logicalHight(120);
  static final double innerDiameter = tileRadius * sqrt(3);

  // Определяем отступы с учетом r и дополнительного отступа 12
  static final double horizontalSpacing =
      innerDiameter + LogicalSize.logicalWidth(20);
  static final double verticalSpacing =
      innerDiameter - LogicalSize.logicalHight(20);

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
      double offsetX =
          (rowStructure.reduce(max) - tileCount) * horizontalSpacing / 2;

      if (row == 2) {
        offsetX -= horizontalSpacing / 2;
      }

      List<HexTile> rowTiles = [];
      for (int col = 0; col < tileCount; col++) {
        final tilePosition = Vector2(
          col * horizontalSpacing + offsetX,
          row * verticalSpacing,
        );

        final hexTile = HexTile(tilePosition,
            () => findAndRemoveMatchingTiles(row, col), tileRadius);
        rowTiles.add(hexTile);
        add(hexTile);
      }
      hexTiles.add(rowTiles);
    }
  }

  void findAndRemoveMatchingTiles(int startRow, int startCol) {
    print('Starting match check at row: $startRow, col: $startCol');

    final HexTile startTile = hexTiles[startRow][startCol];
    if (startTile.isTileRemoved) {
      print('Tile is already removed');
      return;
    }

    final Color colorToMatch = startTile.colorCrystal.currentColor;
    if (colorToMatch == Colors.transparent) {
      print('Cannot match transparent color');
      return;
    }

    print('Matching color: $colorToMatch');

    final matchingTiles = <HexTile>[];
    final visited = HashSet<String>();

    void dfs(int row, int col) {
      // Check bounds
      if (row < 0 ||
          row >= hexTiles.length ||
          col < 0 ||
          col >= hexTiles[row].length) {
        return;
      }

      final String key = '$row,$col';
      if (visited.contains(key)) {
        return;
      }

      final HexTile tile = hexTiles[row][col];

      // Skip if tile is removed or color doesn't match
      if (tile.isTileRemoved ||
          tile.colorCrystal.currentColor != colorToMatch ||
          tile.colorCrystal.currentColor == Colors.transparent) {
        return;
      }

      print('Found matching tile at row: $row, col: $col');
      visited.add(key);
      matchingTiles.add(tile);

      // Get correct neighbors based on row parity (even/odd)
      final List<List<int>> neighbors = getNeighbors(row, col);

      for (final List<int> neighbor in neighbors) {
        final newRow = row + neighbor[0];
        final newCol = col + neighbor[1];
        dfs(newRow, newCol);
      }
    }

    // Start DFS from the initial tile
    dfs(startRow, startCol);

    print('Found ${matchingTiles.length} matching tiles');

    // Delete tiles if we found 4 or more matches
    if (matchingTiles.length >= 4) {
      print('Deleting ${matchingTiles.length} matching tiles');
      for (final tile in matchingTiles) {
        print('Deleting tile at position: ${tile.position}');
        tile.deleteTile();
      }
    }
  }

  List<List<int>> getNeighbors(int row, int col) {
    // Different neighbor patterns for even and odd rows
    if (row % 2 == 0) {
      return [
        [-1, -1], // top left
        [-1, 0], // top right
        [0, -1], // left
        [0, 1], // right
        [1, -1], // bottom left
        [1, 0] // bottom right
      ];
    } else {
      return [
        [-1, 0], // top left
        [-1, 1], // top right
        [0, -1], // left
        [0, 1], // right
        [1, 0], // bottom left
        [1, 1] // bottom right
      ];
    }
  }
}
