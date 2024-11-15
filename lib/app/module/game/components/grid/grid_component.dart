import 'dart:collection';
import 'dart:math';
import 'package:color_puzzle/app/extensions/random_elements_from_list.dart';
import 'package:color_puzzle/app/module/game/components/logical_size_component.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../../game.dart';
import '../../pages/level_page.dart';
import '../hextile/color_crystal.dart';
import '../hextile/hextile_component.dart';

class HexGridComponent extends PositionComponent with HasGameRef<AppGame> {
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
    final double leftOffset = LogicalSize.logicalWidth(70);

    // Center the grid on the screen
    position = Vector2(
      (screenSize.x - gridWidth) / 2 - leftOffset,
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
            () => findAndRemoveMatchingTiles(row, col), tileRadius, Colors.red);
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
          tile.colorCrystal.currentColor == Colors.transparent ||
          tile.colorCrystal.currentColor == Colors.brown) {
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
    checkGameOver();
  }

  List<List<int>> getNeighbors(int row, int col) {
    if (row == 0) {
      return [
        [0, -1], // left
        [0, 1], // right
        [1, 0], // bottom left
        [1, 1], // bottom right
      ];
    } else if (row == 1) {
      return [
        [-1, -1],
        [-1, 0],
        [0, -1], // left
        [0, 1], // right
        [1, 0], // bottom left
        [1, 1], // bottom right
      ];
    } else if (row == 2) {
      return [
        [-1, -1],
        [-1, 0],
        [0, -1], // left
        [0, 1], // right
        [1, -1], // bottom left
        [1, 0], // bottom right
      ];
    } else if (row == 3) {
      return [
        [-1, 0],
        [-1, 1],
        [0, -1], // left
        [0, 1], // right
        [1, -1], // bottom left
        [1, 0], // bottom right
      ];
    } else {
      return [
        [-1, 1],
        [-1, 0],
        [-1, 1],
        [0, 1],
        [0, -1]
      ];
    }
  }

  addRandomCrystals() {
    final randomHexTiles =
        hexTiles.expand((e) => e).toList().getRandomElements(3);
    int i = 0;
    for (final hexTile in randomHexTiles) {
      hexTile.setColor(ColorCrystal.secondaryColors[i], withRefreshGrid: false);
      i++;
    }
  }

  void checkGameOver() {
    // Проверяем, все ли ячейки удалены или являются пустыми (Color.brown)
    bool allTilesRemovedOrEmpty = hexTiles.every(
      (row) => row.every(
        (tile) =>
            tile.isTileRemoved ||
            tile.colorCrystal.currentColor == Colors.brown,
      ),
    );

    if (allTilesRemovedOrEmpty) {
      print("All tiles removed or empty. Game Over!");
      onGameOver(); // Метод для обработки завершения игры
      return;
    }

    // Проверяем, есть ли хотя бы одна группа из 4 соседних ячеек
    bool hasAvailableMoves = false;

    for (int row = 0; row < hexTiles.length; row++) {
      for (int col = 0; col < hexTiles[row].length; col++) {
        final HexTile currentTile = hexTiles[row][col];
        if (currentTile.isTileRemoved ||
            currentTile.colorCrystal.currentColor == Colors.brown) {
          continue; // Пропускаем пустые ячейки
        }

        final List<List<int>> neighbors = getNeighbors(row, col);

        int neighborCount = 0;

        for (final List<int> neighbor in neighbors) {
          final int neighborRow = row + neighbor[0];
          final int neighborCol = col + neighbor[1];

          if (neighborRow >= 0 &&
              neighborRow < hexTiles.length &&
              neighborCol >= 0 &&
              neighborCol < hexTiles[neighborRow].length) {
            final HexTile neighborTile = hexTiles[neighborRow][neighborCol];

            if (!neighborTile.isTileRemoved &&
                neighborTile.colorCrystal.currentColor != Colors.brown) {
              neighborCount++;
              if (neighborCount >= 3) {
                // +1 текущая ячейка
                hasAvailableMoves = true;
                break;
              }
            }
          }
        }
        if (hasAvailableMoves) break;
      }
      if (hasAvailableMoves) break;
    }

    if (!hasAvailableMoves) {
      print("No more groups of 4 available. Game Over!");
      onGameOver(); // Метод для обработки завершения игры
    }
  }

  void onGameOver() {
    // to game_over_page
    (parent as GamePage).gameOver();
  }
}
