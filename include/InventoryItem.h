#ifndef ZSDX_INVENTORY_ITEM_H
#define ZSDX_INVENTORY_ITEM_H

#include "Common.h"
#include "Savegame.h"

/**
 * This class provides the description of each item of the inventory.
 * This does not include the dungeon items (map, compass, etc.)
 * nor the items of the quest status screen.
 */
class InventoryItem {

 public:

  /**
   * Constant identifying each item.
   * These constants permit to determine:
   * - the savegame slot of each item
   * - the place for each item in the inventory screen
   */
  enum ItemId {
    NONE                        = -1,

    FEATHER                     = 0,
    BOMBS                       = 1,
    BOW                         = 2, /**< 1: bow without arrows, 2: bow with arrows */
    BOOMERANG                   = 3,
    LAMP                        = 4,
    HOOK_SHOT                   = 5,
    BOTTLE_1                    = 6, /**< 1: empty, 2: water, 3: red potion, 4: green potion, 5: blue potion, 6: fairy */

    PEGASUS_SHOES               = 7,
    MYSTIC_MIRROR               = 8,
    CANE_OF_SOMARIA             = 9,
    APPLES                      = 10,
    PAINS_AU_CHOCOLAT           = 11,
    CROISSANTS                  = 12,
    BOTTLE_2                    = 13,

    ROCK_KEY                    = 14,
    RED_KEY                     = 15,
    CLAY_KEY                    = 16,
    L4_WAY_BONE_KEY             = 17, /**< 1: apple pie, 2: gold bars, 3: edelweiss, 4: bone key */
    FLIPPERS                    = 18,
    MAGIC_CAPE                  = 19,
    BOTTLE_3                    = 20,

    IRON_KEY                    = 21,
    STONE_KEY                   = 22,
    WOODEN_KEY                  = 23,
    ICE_KEY                     = 24,
    GLOVE                       = 25, /**< 1: iron glove, 2: golden glove */
    FIRE_STONES                 = 26,
    BOTTLE_4                    = 27,
  };

 private:

  bool attributable;   /**< true if this item can be assigned to icon X or V */
  int counter_index;   /**< for an item with a counter (bombs, arrows, etc.),
			* index of the savegame variable indicating the
			* counter's value (0 if there is no counter) */
  
  static InventoryItem items[28];

  InventoryItem(bool attributable, int counter_index);
  ~InventoryItem(void);

 public:

  static InventoryItem *get_item(ItemId id);

  bool is_attributable(void);
  bool has_counter(void);
  int get_counter_index(void);
};

#endif
