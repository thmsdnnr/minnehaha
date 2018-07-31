enum CD {
  NORTH,
  SOUTH,
  EAST,
  WEST
}

const CD_fwd = {
  CD.NORTH: "north",
  CD.SOUTH: "south",
  CD.EAST: "east",
  CD.WEST: "west",
}

const CD_rev = {
  CD.NORTH: "south",
  CD.SOUTH: "north",
  CD.EAST: "west",
  CD.WEST: "east"
};

enum HD {
  LEFT,
  RIGHT
}

const HD_fwd = {
  HD.LEFT: "left",
  HD.RIGHT: "right",
}

const HD_rev = {
  HD.LEFT: "right",
  HD.RIGHT: "left",
}

enum WPT_TYPE {
  POI,
  WTR,
  CAR,
  TWN,
  OFF,
  HLP,
  TRL,
  THD,
  CMP,
}

class Waypoints {
  static bool nOBO = true;
  static String C (CD direction) => nOBO ? CD_fwd[direction] : CD_rev[direction];
  static String H (HD direction) => nOBO ? HD_fwd[direction] : HD_rev[direction];
 }
