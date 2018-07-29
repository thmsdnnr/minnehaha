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
  
  static List<Map<String, Object>> getPOI() {
    return [
    {
      "name": "Northern Terminus",
      "type": WPT_TYPE.POI,
      "lat": 47.998733,
      "lon": -89.935233,
    },
    {
      "name": "BRT Trailhead, Otter Lake Rd",
      "type": WPT_TYPE.CAR,
      "lat": 47.987638,
      "lon": -89.9380277,
    },
    {
      "name": "Rengo Rd",
      "type": WPT_TYPE.CAR,
      "lat": 47.9870097,
      "lon": -89.9346213,
    },
    
    {
      "name": "",
      "lat":
      "lon": 
    },
    {
      "name": "",
      "lat":
      "lon":
    },
    {
      "name": "",
      "lat":
      "lon":
    },
    {
      "name": "",
      "lat":
      "lon":
    },
    {
      "name": "",
      "lat":
      "lon":
    },
  ];

  static List<Map<String, Object>> getCampsites() {
    return [
      {
        "name": "Silver Creek",
        "lat": 47.07608543375874,
        "lon": -91.64387838453455
      },
      {
        "name": "Crow Creek Valley",
        "lat": 47.12523019247822,
        "lon": -91.55801303840254
      },
      {
        "name": "West Gooseberry",
        "lat": 47.14883085079312,
        "lon": -91.51870542069358
      },
      {
        "name": "Gooseberry River",
        "lat": 47.15140063522978,
        "lon": -91.4982963572873
      },
      {
        "name": "East Gooseberry",
        "lat": 47.151714486196404,
        "lon": -91.50917194169277
      },
      {
        "name": "Blueberry Hill",
        "lat": 47.17376409644227,
        "lon": -91.44394112127713
      },
      {
        "name": "Northwest Split Rock Ri",
        "lat": 47.201557427468266,
        "lon": -91.42886100021224
      },
      {
        "name": "Southeast Split Rock Ri",
        "lat": 47.199373817408116,
        "lon": -91.42095883267683
      },
      {
        "name": "Southwest Split Rock Ri",
        "lat": 47.19885802304069,
        "lon": -91.4210481981983
      },
      {
        "name": "Northeast Split Rock Ri",
        "lat": 47.201147593421375,
        "lon": -91.42292344360638
      },
      {
        "name": "Chapins Ridge",
        "lat": 47.222254147148305,
        "lon": -91.38076657319645
      },
      {
        "name": "Beaver Pond",
        "lat": 47.23616005846799,
        "lon": -91.36650122004286
      },
      {
        "name": "Fault Line Creek",
        "lat": 47.24481968781436,
        "lon": -91.34788295344993
      },
      {
        "name": "North Beaver River",
        "lat": 47.267567871015196,
        "lon": -91.30588127581886
      },
      {
        "name": "South Beaver River",
        "lat": 47.26759543429931,
        "lon": -91.30072624668043
      },
      {
        "name": "Penn Creek",
        "lat": 47.30264997001084,
        "lon": -91.29608659759305
      },
      {
        "name": "Bear Lake",
        "lat": 47.31370782674863,
        "lon": -91.28862402470394
      },
      {
        "name": "Round Mountain Beaver P",
        "lat": 47.31918760425114,
        "lon": -91.27221435863162
      },
      {
        "name": "West Pailsade Creek",
        "lat": 47.32319559156107,
        "lon": -91.27089892005908
      },
      {
        "name": "East Palisade Creek",
        "lat": 47.325551137832896,
        "lon": -91.26685143010165
      },
      {
        "name": "West Kennedy Creek",
        "lat": 47.37622372015315,
        "lon": -91.18448496404928
      },
      {
        "name": "East Kennedy Creek",
        "lat": 47.37610722853412,
        "lon": -91.18262996436401
      },
      {
        "name": "Section 13",
        "lat": 47.424132020199146,
        "lon": -91.15242516185381
      },
      {
        "name": "Leskinen Creek",
        "lat": 47.42424836261484,
        "lon": -91.19249022046216
      },
      {
        "name": "South Egge Lake",
        "lat": 47.45528628275837,
        "lon": -91.21556558462778
      },
      {
        "name": "North Egge Lake",
        "lat": 47.45742627190046,
        "lon": -91.21597467640359
      },
      {
        "name": "South Sonju Lake",
        "lat": 47.48180110458844,
        "lon": -91.20561093580167
      },
      {
        "name": "North Sonju Lake",
        "lat": 47.4825058667926,
        "lon": -91.20195777582302
      },
      {
        "name": "East Branch Baptism Riv",
        "lat": 47.47822426504707,
        "lon": -91.16941203065515
      },
      {
        "name": "Blesner Creek",
        "lat": 47.473310442242536,
        "lon": -91.16030270339948
      },
      {
        "name": "Aspen Knob",
        "lat": 47.47911891555064,
        "lon": -91.12868677144607
      },
      {
        "name": "Horseshoe Ridge",
        "lat": 47.48381822070885,
        "lon": -91.07693496329262
      },
      {
        "name": "West Caribou River",
        "lat": 47.470345370101185,
        "lon": -91.03530846912014
      },
      {
        "name": "East Caribou River",
        "lat": 47.47112896807138,
        "lon": -91.0323103732908
      },
      {
        "name": "Crystal Creek",
        "lat": 47.48315125055598,
        "lon": -91.01368138412535
      },
      {
        "name": "Sugarloaf Pond",
        "lat": 47.506842700439506,
        "lon": -90.98827400366585
      },
      {
        "name": "Dyer's Creek",
        "lat": 47.53256584969011,
        "lon": -90.97041662381095
      },
      {
        "name": "Fredenberg Creek",
        "lat": 47.5511920356997,
        "lon": -90.9486856874439
      },
      {
        "name": "South Cross River",
        "lat": 47.557739504182265,
        "lon": -90.916115327225
      },
      {
        "name": "North Cross River",
        "lat": 47.55901957719186,
        "lon": -90.9166261630375
      },
      {"name": "Ledge", "lat": 47.5659264859902, "lon": -90.91348857084998},
      {"name": "Falls", "lat": 47.565177513704015, "lon": -90.9273251565227},
      {
        "name": "East Leveaux Pond",
        "lat": 47.61768910322249,
        "lon": -90.80510270651345
      },
      {
        "name": "Springdale Creek",
        "lat": 47.6033145285013,
        "lon": -90.83456218479145
      },
      {
        "name": "Onion River",
        "lat": 47.62533688230376,
        "lon": -90.78934696888041
      },
      {
        "name": "West Rollins Creek",
        "lat": 47.63136413125426,
        "lon": -90.7613628076513
      },
      {
        "name": "East Rollins Creek",
        "lat": 47.631538086902964,
        "lon": -90.76037522821575
      },
      {
        "name": "Mystery Mountain",
        "lat": 47.66933695168999,
        "lon": -90.72843300410962
      },
      {
        "name": "West Poplar River",
        "lat": 47.67878920055392,
        "lon": -90.70541784624929
      },
      {
        "name": "East Poplar River",
        "lat": 47.68218512236506,
        "lon": -90.70130357727167
      },
      {
        "name": "West Lake Agnes",
        "lat": 47.69958786394748,
        "lon": -90.6867574328568
      },
      {
        "name": "East Lake Agnes",
        "lat": 47.70021505895318,
        "lon": -90.68227230048983
      },
      {
        "name": "Jonvick Creek",
        "lat": 47.68904652773803,
        "lon": -90.64490824443916
      },
      {
        "name": "Spruce Creek",
        "lat": 47.695017655286414,
        "lon": -90.60796143028182
      },
      {
        "name": "Indian Creek",
        "lat": 47.70746971472601,
        "lon": -90.55827137038645
      },
      {
        "name": "Big White Pine",
        "lat": 47.72361634811203,
        "lon": -90.53725617440932
      },
      {"name": "Cut Log", "lat": 47.73049031369396, "lon": -90.53619829971537},
      {
        "name": "North Cascade River",
        "lat": 47.7545849793764,
        "lon": -90.51894789264401
      },
      {
        "name": "South Bally Creek Pond",
        "lat": 47.76799504531871,
        "lon": -90.43320212528666
      },
      {
        "name": "North Bally Creek Pond",
        "lat": 47.76914664275773,
        "lon": -90.43146794924735
      },
      {
        "name": "West Devil Track",
        "lat": 47.78139722551272,
        "lon": -90.2948859531549
      },
      {
        "name": "East Devil Track",
        "lat": 47.781014316373245,
        "lon": -90.29674157090298
      },
      {
        "name": "Wood's Creek",
        "lat": 47.783334923408766,
        "lon": -90.26633009358228
      },
      {
        "name": "Durfee Creek Camp",
        "lat": 47.79395345898166,
        "lon": -90.23997998407967
      },
      {
        "name": "Cliff Creek Camp",
        "lat": 47.79773103345661,
        "lon": -90.22140544199853
      },
      {
        "name": "Kimball Creek Camp",
        "lat": 47.793531827154766,
        "lon": -90.18370933255139
      },
      {
        "name": "Crow Creek Camp",
        "lat": 47.7997865906617,
        "lon": -90.16435240578642
      },
      {
        "name": "Northwest Little Brule Camp",
        "lat": 47.82158248744292,
        "lon": -90.09117986535058
      },
      {
        "name": "South Carlson Pond",
        "lat": 47.8917801404341,
        "lon": -89.98376550273909
      },
      {"name": "Hazel", "lat": 47.896194832799374, "lon": -90.02529378529754},
      {
        "name": "North Carlson Pond",
        "lat": 47.894581444904034,
        "lon": -89.95256683432548
      },
      {
        "name": "Woodland Caribou Pond",
        "lat": 47.89964294962605,
        "lon": -89.91486538648827
      },
      {
        "name": "Jackson Creek",
        "lat": 47.92357808274742,
        "lon": -89.91318677373073
      },
      {
        "name": "Andy Creek",
        "lat": 47.96854762643151,
        "lon": -89.91843073257095
      },
      {
        "name": "West Leveaux Pond",
        "lat": 47.61806619089805,
        "lon": -90.80624924949943
      },
      {
        "name": "Trout Creek",
        "lat": 47.71412647481302,
        "lon": -90.52837353078817
      },
      {"name": "Ferguson", "lat": 47.113959103377, "lon": -91.76504144357848},
      {
        "name": "McCarthy Creek",
        "lat": 47.11142391183158,
        "lon": -91.7842468381927
      },
      {
        "name": "Stewart River",
        "lat": 47.14066790968377,
        "lon": -91.70984871080593
      },
      {
        "name": "Big Bend",
        "lat": 47.073459316459264,
        "lon": -91.84764145093062
      },
      {
        "name": "Fox Farm Beaver Pond",
        "lat": 47.033050761923256,
        "lon": -91.9133782917541
      },
      {
        "name": "Sucker River",
        "lat": 47.01429469829501,
        "lon": -91.93755061382824
      },
      {
        "name": "Heron Pond",
        "lat": 46.98927515237095,
        "lon": -91.97219821074195
      },
      {
        "name": "Bald Eagle",
        "lat": 46.91702794387707,
        "lon": -92.07110686750546
      },
      {
        "name": "White Pine",
        "lat": 46.930896299514366,
        "lon": -92.06693720472573
      },
      {
        "name": "Lone Tree",
        "lat": 46.963941545595304,
        "lon": -92.01352454212147
      },
      {
        "name": "Reeves Falls",
        "lat": 47.11244322889479,
        "lon": -91.69076062841411
      },
      {
        "name": "Middle Gooseberry",
        "lat": 47.151792019559046,
        "lon": -91.49963433348395
      }
    ];
  }
}
