import 'package:flutter/material.dart';
import '../../data/models/stone_model.dart';

/// Stones constants - delegates to StoneModel.allStones
class StonesConstants {
  static List<StoneModel> getAllStones() {
    return StoneModel.allStones;
  }
  
  static StoneModel? getStoneById(String id) {
    return StoneModel.getById(id);
  }
  
  /// Get stones by rarity
  static List<StoneModel> getStonesByRarity(StoneRarity rarity) {
    return StoneModel.allStones.where((s) => s.rarity == rarity).toList();
  }
  
  /// Common stones
  static List<StoneModel> get commonStones => getStonesByRarity(StoneRarity.common);
  
  /// Rare stones
  static List<StoneModel> get rareStones => getStonesByRarity(StoneRarity.rare);
  
  /// Epic stones
  static List<StoneModel> get epicStones => getStonesByRarity(StoneRarity.epic);
  
  /// Legendary stones
  static List<StoneModel> get legendaryStones => getStonesByRarity(StoneRarity.legendary);
}
