
//  PWR Lattice Mesh Generator 

// set characteristic length
lc=0.1;

lcb=0.05;  // characteristic length on border

General.BackgroundGradient=0; 
General.Color.Background={63,255,50};

//  define outer box of lattice
  Point(1) = { 21.42000000,  0.00000000, 0, lc};
  Point(2) = { 21.42000000, 21.42000000, 0, lc};
  Point(3) = {  0.00000000, 21.42000000, 0, lc};
  Point(4) = {  0.00000000,  0.00000000, 0, lc};

Line(1) = {3, 2};
Line(2) = {2, 1};
Line(3) = {1, 4};
Line(4) = {4, 3};

Line Loop(5) = {1, 2, 3, 4};     // outer boundary

Physical Line("OutBC") = {1, 2, 3, 4};  // outer surface label


// ==============================
//    define rod 1,1

  Point(5) = {  0.63000000,  0.63000000, 0, lc};

  Point(6) = {  0.15500000,  0.63000000, 0, lc};
  Point(7) = {  1.10500000,  0.63000000, 0, lc};
  Point(8) = {  0.63000000,  0.15500000, 0, lc};
  Point(9) = {  0.63000000,  1.10500000, 0, lc};
  Circle(6) = {9,5,7};
  Circle(7) = {7,5,8};
  Circle(8) = {8,5,6};
  Circle(9) = {6,5,9};
  Line Loop(10) = {6,7,8,9};   // clad surface

  Point(10) = {  0.21200000,  0.63000000, 0, lc};
  Point(11) = {  1.04800000,  0.63000000, 0, lc};
  Point(12) = {  0.63000000,  0.21200000, 0, lc};
  Point(13) = {  0.63000000,  1.04800000, 0, lc};
  Circle(11) = {13,5,11};
  Circle(12) = {11,5,12};
  Circle(13) = {12,5,10};
  Circle(14) = {10,5,13};
  Line Loop(15) = {11,12,13,14};   // fuel surface

// define rod regions
  Plane Surface(16) = {10,15};   // clad region
  Plane Surface(17) = {15};      // fuel region
  Physical Surface("RegClad0101")={16};   // pin clad
  Physical Surface("RegFuel0101")={17};   // pin fuel

// ==============================
//    define rod 2,1

  Point(14) = {  1.89000000,  0.63000000, 0, lc};

  Point(15) = {  1.41500000,  0.63000000, 0, lc};
  Point(16) = {  2.36500000,  0.63000000, 0, lc};
  Point(17) = {  1.89000000,  0.15500000, 0, lc};
  Point(18) = {  1.89000000,  1.10500000, 0, lc};
  Circle(18) = {18,14,16};
  Circle(19) = {16,14,17};
  Circle(20) = {17,14,15};
  Circle(21) = {15,14,18};
  Line Loop(22) = {18,19,20,21};   // clad surface

  Point(19) = {  1.47200000,  0.63000000, 0, lc};
  Point(20) = {  2.30800000,  0.63000000, 0, lc};
  Point(21) = {  1.89000000,  0.21200000, 0, lc};
  Point(22) = {  1.89000000,  1.04800000, 0, lc};
  Circle(23) = {22,14,20};
  Circle(24) = {20,14,21};
  Circle(25) = {21,14,19};
  Circle(26) = {19,14,22};
  Line Loop(27) = {23,24,25,26};   // fuel surface

// define rod regions
  Plane Surface(28) = {22,27};   // clad region
  Plane Surface(29) = {27};      // fuel region
  Physical Surface("RegClad0201")={28};   // pin clad
  Physical Surface("RegFuel0201")={29};   // pin fuel

// ==============================
//    define rod 3,1

  Point(23) = {  3.15000000,  0.63000000, 0, lc};

  Point(24) = {  2.67500000,  0.63000000, 0, lc};
  Point(25) = {  3.62500000,  0.63000000, 0, lc};
  Point(26) = {  3.15000000,  0.15500000, 0, lc};
  Point(27) = {  3.15000000,  1.10500000, 0, lc};
  Circle(30) = {27,23,25};
  Circle(31) = {25,23,26};
  Circle(32) = {26,23,24};
  Circle(33) = {24,23,27};
  Line Loop(34) = {30,31,32,33};   // clad surface

  Point(28) = {  2.73200000,  0.63000000, 0, lc};
  Point(29) = {  3.56800000,  0.63000000, 0, lc};
  Point(30) = {  3.15000000,  0.21200000, 0, lc};
  Point(31) = {  3.15000000,  1.04800000, 0, lc};
  Circle(35) = {31,23,29};
  Circle(36) = {29,23,30};
  Circle(37) = {30,23,28};
  Circle(38) = {28,23,31};
  Line Loop(39) = {35,36,37,38};   // fuel surface

// define rod regions
  Plane Surface(40) = {34,39};   // clad region
  Plane Surface(41) = {39};      // fuel region
  Physical Surface("RegClad0301")={40};   // pin clad
  Physical Surface("RegFuel0301")={41};   // pin fuel

// ==============================
//    define rod 4,1

  Point(32) = {  4.41000000,  0.63000000, 0, lc};

  Point(33) = {  3.93500000,  0.63000000, 0, lc};
  Point(34) = {  4.88500000,  0.63000000, 0, lc};
  Point(35) = {  4.41000000,  0.15500000, 0, lc};
  Point(36) = {  4.41000000,  1.10500000, 0, lc};
  Circle(42) = {36,32,34};
  Circle(43) = {34,32,35};
  Circle(44) = {35,32,33};
  Circle(45) = {33,32,36};
  Line Loop(46) = {42,43,44,45};   // clad surface

  Point(37) = {  3.99200000,  0.63000000, 0, lc};
  Point(38) = {  4.82800000,  0.63000000, 0, lc};
  Point(39) = {  4.41000000,  0.21200000, 0, lc};
  Point(40) = {  4.41000000,  1.04800000, 0, lc};
  Circle(47) = {40,32,38};
  Circle(48) = {38,32,39};
  Circle(49) = {39,32,37};
  Circle(50) = {37,32,40};
  Line Loop(51) = {47,48,49,50};   // fuel surface

// define rod regions
  Plane Surface(52) = {46,51};   // clad region
  Plane Surface(53) = {51};      // fuel region
  Physical Surface("RegClad0401")={52};   // pin clad
  Physical Surface("RegFuel0401")={53};   // pin fuel

// ==============================
//    define rod 5,1

  Point(41) = {  5.67000000,  0.63000000, 0, lc};

  Point(42) = {  5.19500000,  0.63000000, 0, lc};
  Point(43) = {  6.14500000,  0.63000000, 0, lc};
  Point(44) = {  5.67000000,  0.15500000, 0, lc};
  Point(45) = {  5.67000000,  1.10500000, 0, lc};
  Circle(54) = {45,41,43};
  Circle(55) = {43,41,44};
  Circle(56) = {44,41,42};
  Circle(57) = {42,41,45};
  Line Loop(58) = {54,55,56,57};   // clad surface

  Point(46) = {  5.25200000,  0.63000000, 0, lc};
  Point(47) = {  6.08800000,  0.63000000, 0, lc};
  Point(48) = {  5.67000000,  0.21200000, 0, lc};
  Point(49) = {  5.67000000,  1.04800000, 0, lc};
  Circle(59) = {49,41,47};
  Circle(60) = {47,41,48};
  Circle(61) = {48,41,46};
  Circle(62) = {46,41,49};
  Line Loop(63) = {59,60,61,62};   // fuel surface

// define rod regions
  Plane Surface(64) = {58,63};   // clad region
  Plane Surface(65) = {63};      // fuel region
  Physical Surface("RegClad0501")={64};   // pin clad
  Physical Surface("RegFuel0501")={65};   // pin fuel

// ==============================
//    define rod 6,1

  Point(50) = {  6.93000000,  0.63000000, 0, lc};

  Point(51) = {  6.45500000,  0.63000000, 0, lc};
  Point(52) = {  7.40500000,  0.63000000, 0, lc};
  Point(53) = {  6.93000000,  0.15500000, 0, lc};
  Point(54) = {  6.93000000,  1.10500000, 0, lc};
  Circle(66) = {54,50,52};
  Circle(67) = {52,50,53};
  Circle(68) = {53,50,51};
  Circle(69) = {51,50,54};
  Line Loop(70) = {66,67,68,69};   // clad surface

  Point(55) = {  6.51200000,  0.63000000, 0, lc};
  Point(56) = {  7.34800000,  0.63000000, 0, lc};
  Point(57) = {  6.93000000,  0.21200000, 0, lc};
  Point(58) = {  6.93000000,  1.04800000, 0, lc};
  Circle(71) = {58,50,56};
  Circle(72) = {56,50,57};
  Circle(73) = {57,50,55};
  Circle(74) = {55,50,58};
  Line Loop(75) = {71,72,73,74};   // fuel surface

// define rod regions
  Plane Surface(76) = {70,75};   // clad region
  Plane Surface(77) = {75};      // fuel region
  Physical Surface("RegClad0601")={76};   // pin clad
  Physical Surface("RegFuel0601")={77};   // pin fuel

// ==============================
//    define rod 7,1

  Point(59) = {  8.19000000,  0.63000000, 0, lc};

  Point(60) = {  7.71500000,  0.63000000, 0, lc};
  Point(61) = {  8.66500000,  0.63000000, 0, lc};
  Point(62) = {  8.19000000,  0.15500000, 0, lc};
  Point(63) = {  8.19000000,  1.10500000, 0, lc};
  Circle(78) = {63,59,61};
  Circle(79) = {61,59,62};
  Circle(80) = {62,59,60};
  Circle(81) = {60,59,63};
  Line Loop(82) = {78,79,80,81};   // clad surface

  Point(64) = {  7.77200000,  0.63000000, 0, lc};
  Point(65) = {  8.60800000,  0.63000000, 0, lc};
  Point(66) = {  8.19000000,  0.21200000, 0, lc};
  Point(67) = {  8.19000000,  1.04800000, 0, lc};
  Circle(83) = {67,59,65};
  Circle(84) = {65,59,66};
  Circle(85) = {66,59,64};
  Circle(86) = {64,59,67};
  Line Loop(87) = {83,84,85,86};   // fuel surface

// define rod regions
  Plane Surface(88) = {82,87};   // clad region
  Plane Surface(89) = {87};      // fuel region
  Physical Surface("RegClad0701")={88};   // pin clad
  Physical Surface("RegFuel0701")={89};   // pin fuel

// ==============================
//    define rod 8,1

  Point(68) = {  9.45000000,  0.63000000, 0, lc};

  Point(69) = {  8.97500000,  0.63000000, 0, lc};
  Point(70) = {  9.92500000,  0.63000000, 0, lc};
  Point(71) = {  9.45000000,  0.15500000, 0, lc};
  Point(72) = {  9.45000000,  1.10500000, 0, lc};
  Circle(90) = {72,68,70};
  Circle(91) = {70,68,71};
  Circle(92) = {71,68,69};
  Circle(93) = {69,68,72};
  Line Loop(94) = {90,91,92,93};   // clad surface

  Point(73) = {  9.03200000,  0.63000000, 0, lc};
  Point(74) = {  9.86800000,  0.63000000, 0, lc};
  Point(75) = {  9.45000000,  0.21200000, 0, lc};
  Point(76) = {  9.45000000,  1.04800000, 0, lc};
  Circle(95) = {76,68,74};
  Circle(96) = {74,68,75};
  Circle(97) = {75,68,73};
  Circle(98) = {73,68,76};
  Line Loop(99) = {95,96,97,98};   // fuel surface

// define rod regions
  Plane Surface(100) = {94,99};   // clad region
  Plane Surface(101) = {99};      // fuel region
  Physical Surface("RegClad0801")={100};   // pin clad
  Physical Surface("RegFuel0801")={101};   // pin fuel

// ==============================
//    define rod 9,1

  Point(77) = { 10.71000000,  0.63000000, 0, lc};

  Point(78) = { 10.23500000,  0.63000000, 0, lc};
  Point(79) = { 11.18500000,  0.63000000, 0, lc};
  Point(80) = { 10.71000000,  0.15500000, 0, lc};
  Point(81) = { 10.71000000,  1.10500000, 0, lc};
  Circle(102) = {81,77,79};
  Circle(103) = {79,77,80};
  Circle(104) = {80,77,78};
  Circle(105) = {78,77,81};
  Line Loop(106) = {102,103,104,105};   // clad surface

  Point(82) = { 10.29200000,  0.63000000, 0, lc};
  Point(83) = { 11.12800000,  0.63000000, 0, lc};
  Point(84) = { 10.71000000,  0.21200000, 0, lc};
  Point(85) = { 10.71000000,  1.04800000, 0, lc};
  Circle(107) = {85,77,83};
  Circle(108) = {83,77,84};
  Circle(109) = {84,77,82};
  Circle(110) = {82,77,85};
  Line Loop(111) = {107,108,109,110};   // fuel surface

// define rod regions
  Plane Surface(112) = {106,111};   // clad region
  Plane Surface(113) = {111};      // fuel region
  Physical Surface("RegClad0901")={112};   // pin clad
  Physical Surface("RegFuel0901")={113};   // pin fuel

// ==============================
//    define rod 10,1

  Point(86) = { 11.97000000,  0.63000000, 0, lc};

  Point(87) = { 11.49500000,  0.63000000, 0, lc};
  Point(88) = { 12.44500000,  0.63000000, 0, lc};
  Point(89) = { 11.97000000,  0.15500000, 0, lc};
  Point(90) = { 11.97000000,  1.10500000, 0, lc};
  Circle(114) = {90,86,88};
  Circle(115) = {88,86,89};
  Circle(116) = {89,86,87};
  Circle(117) = {87,86,90};
  Line Loop(118) = {114,115,116,117};   // clad surface

  Point(91) = { 11.55200000,  0.63000000, 0, lc};
  Point(92) = { 12.38800000,  0.63000000, 0, lc};
  Point(93) = { 11.97000000,  0.21200000, 0, lc};
  Point(94) = { 11.97000000,  1.04800000, 0, lc};
  Circle(119) = {94,86,92};
  Circle(120) = {92,86,93};
  Circle(121) = {93,86,91};
  Circle(122) = {91,86,94};
  Line Loop(123) = {119,120,121,122};   // fuel surface

// define rod regions
  Plane Surface(124) = {118,123};   // clad region
  Plane Surface(125) = {123};      // fuel region
  Physical Surface("RegClad1001")={124};   // pin clad
  Physical Surface("RegFuel1001")={125};   // pin fuel

// ==============================
//    define rod 11,1

  Point(95) = { 13.23000000,  0.63000000, 0, lc};

  Point(96) = { 12.75500000,  0.63000000, 0, lc};
  Point(97) = { 13.70500000,  0.63000000, 0, lc};
  Point(98) = { 13.23000000,  0.15500000, 0, lc};
  Point(99) = { 13.23000000,  1.10500000, 0, lc};
  Circle(126) = {99,95,97};
  Circle(127) = {97,95,98};
  Circle(128) = {98,95,96};
  Circle(129) = {96,95,99};
  Line Loop(130) = {126,127,128,129};   // clad surface

  Point(100) = { 12.81200000,  0.63000000, 0, lc};
  Point(101) = { 13.64800000,  0.63000000, 0, lc};
  Point(102) = { 13.23000000,  0.21200000, 0, lc};
  Point(103) = { 13.23000000,  1.04800000, 0, lc};
  Circle(131) = {103,95,101};
  Circle(132) = {101,95,102};
  Circle(133) = {102,95,100};
  Circle(134) = {100,95,103};
  Line Loop(135) = {131,132,133,134};   // fuel surface

// define rod regions
  Plane Surface(136) = {130,135};   // clad region
  Plane Surface(137) = {135};      // fuel region
  Physical Surface("RegClad1101")={136};   // pin clad
  Physical Surface("RegFuel1101")={137};   // pin fuel

// ==============================
//    define rod 12,1

  Point(104) = { 14.49000000,  0.63000000, 0, lc};

  Point(105) = { 14.01500000,  0.63000000, 0, lc};
  Point(106) = { 14.96500000,  0.63000000, 0, lc};
  Point(107) = { 14.49000000,  0.15500000, 0, lc};
  Point(108) = { 14.49000000,  1.10500000, 0, lc};
  Circle(138) = {108,104,106};
  Circle(139) = {106,104,107};
  Circle(140) = {107,104,105};
  Circle(141) = {105,104,108};
  Line Loop(142) = {138,139,140,141};   // clad surface

  Point(109) = { 14.07200000,  0.63000000, 0, lc};
  Point(110) = { 14.90800000,  0.63000000, 0, lc};
  Point(111) = { 14.49000000,  0.21200000, 0, lc};
  Point(112) = { 14.49000000,  1.04800000, 0, lc};
  Circle(143) = {112,104,110};
  Circle(144) = {110,104,111};
  Circle(145) = {111,104,109};
  Circle(146) = {109,104,112};
  Line Loop(147) = {143,144,145,146};   // fuel surface

// define rod regions
  Plane Surface(148) = {142,147};   // clad region
  Plane Surface(149) = {147};      // fuel region
  Physical Surface("RegClad1201")={148};   // pin clad
  Physical Surface("RegFuel1201")={149};   // pin fuel

// ==============================
//    define rod 13,1

  Point(113) = { 15.75000000,  0.63000000, 0, lc};

  Point(114) = { 15.27500000,  0.63000000, 0, lc};
  Point(115) = { 16.22500000,  0.63000000, 0, lc};
  Point(116) = { 15.75000000,  0.15500000, 0, lc};
  Point(117) = { 15.75000000,  1.10500000, 0, lc};
  Circle(150) = {117,113,115};
  Circle(151) = {115,113,116};
  Circle(152) = {116,113,114};
  Circle(153) = {114,113,117};
  Line Loop(154) = {150,151,152,153};   // clad surface

  Point(118) = { 15.33200000,  0.63000000, 0, lc};
  Point(119) = { 16.16800000,  0.63000000, 0, lc};
  Point(120) = { 15.75000000,  0.21200000, 0, lc};
  Point(121) = { 15.75000000,  1.04800000, 0, lc};
  Circle(155) = {121,113,119};
  Circle(156) = {119,113,120};
  Circle(157) = {120,113,118};
  Circle(158) = {118,113,121};
  Line Loop(159) = {155,156,157,158};   // fuel surface

// define rod regions
  Plane Surface(160) = {154,159};   // clad region
  Plane Surface(161) = {159};      // fuel region
  Physical Surface("RegClad1301")={160};   // pin clad
  Physical Surface("RegFuel1301")={161};   // pin fuel

// ==============================
//    define rod 14,1

  Point(122) = { 17.01000000,  0.63000000, 0, lc};

  Point(123) = { 16.53500000,  0.63000000, 0, lc};
  Point(124) = { 17.48500000,  0.63000000, 0, lc};
  Point(125) = { 17.01000000,  0.15500000, 0, lc};
  Point(126) = { 17.01000000,  1.10500000, 0, lc};
  Circle(162) = {126,122,124};
  Circle(163) = {124,122,125};
  Circle(164) = {125,122,123};
  Circle(165) = {123,122,126};
  Line Loop(166) = {162,163,164,165};   // clad surface

  Point(127) = { 16.59200000,  0.63000000, 0, lc};
  Point(128) = { 17.42800000,  0.63000000, 0, lc};
  Point(129) = { 17.01000000,  0.21200000, 0, lc};
  Point(130) = { 17.01000000,  1.04800000, 0, lc};
  Circle(167) = {130,122,128};
  Circle(168) = {128,122,129};
  Circle(169) = {129,122,127};
  Circle(170) = {127,122,130};
  Line Loop(171) = {167,168,169,170};   // fuel surface

// define rod regions
  Plane Surface(172) = {166,171};   // clad region
  Plane Surface(173) = {171};      // fuel region
  Physical Surface("RegClad1401")={172};   // pin clad
  Physical Surface("RegFuel1401")={173};   // pin fuel

// ==============================
//    define rod 15,1

  Point(131) = { 18.27000000,  0.63000000, 0, lc};

  Point(132) = { 17.79500000,  0.63000000, 0, lc};
  Point(133) = { 18.74500000,  0.63000000, 0, lc};
  Point(134) = { 18.27000000,  0.15500000, 0, lc};
  Point(135) = { 18.27000000,  1.10500000, 0, lc};
  Circle(174) = {135,131,133};
  Circle(175) = {133,131,134};
  Circle(176) = {134,131,132};
  Circle(177) = {132,131,135};
  Line Loop(178) = {174,175,176,177};   // clad surface

  Point(136) = { 17.85200000,  0.63000000, 0, lc};
  Point(137) = { 18.68800000,  0.63000000, 0, lc};
  Point(138) = { 18.27000000,  0.21200000, 0, lc};
  Point(139) = { 18.27000000,  1.04800000, 0, lc};
  Circle(179) = {139,131,137};
  Circle(180) = {137,131,138};
  Circle(181) = {138,131,136};
  Circle(182) = {136,131,139};
  Line Loop(183) = {179,180,181,182};   // fuel surface

// define rod regions
  Plane Surface(184) = {178,183};   // clad region
  Plane Surface(185) = {183};      // fuel region
  Physical Surface("RegClad1501")={184};   // pin clad
  Physical Surface("RegFuel1501")={185};   // pin fuel

// ==============================
//    define rod 16,1

  Point(140) = { 19.53000000,  0.63000000, 0, lc};

  Point(141) = { 19.05500000,  0.63000000, 0, lc};
  Point(142) = { 20.00500000,  0.63000000, 0, lc};
  Point(143) = { 19.53000000,  0.15500000, 0, lc};
  Point(144) = { 19.53000000,  1.10500000, 0, lc};
  Circle(186) = {144,140,142};
  Circle(187) = {142,140,143};
  Circle(188) = {143,140,141};
  Circle(189) = {141,140,144};
  Line Loop(190) = {186,187,188,189};   // clad surface

  Point(145) = { 19.11200000,  0.63000000, 0, lc};
  Point(146) = { 19.94800000,  0.63000000, 0, lc};
  Point(147) = { 19.53000000,  0.21200000, 0, lc};
  Point(148) = { 19.53000000,  1.04800000, 0, lc};
  Circle(191) = {148,140,146};
  Circle(192) = {146,140,147};
  Circle(193) = {147,140,145};
  Circle(194) = {145,140,148};
  Line Loop(195) = {191,192,193,194};   // fuel surface

// define rod regions
  Plane Surface(196) = {190,195};   // clad region
  Plane Surface(197) = {195};      // fuel region
  Physical Surface("RegClad1601")={196};   // pin clad
  Physical Surface("RegFuel1601")={197};   // pin fuel

// ==============================
//    define rod 17,1

  Point(149) = { 20.79000000,  0.63000000, 0, lc};

  Point(150) = { 20.31500000,  0.63000000, 0, lc};
  Point(151) = { 21.26500000,  0.63000000, 0, lc};
  Point(152) = { 20.79000000,  0.15500000, 0, lc};
  Point(153) = { 20.79000000,  1.10500000, 0, lc};
  Circle(198) = {153,149,151};
  Circle(199) = {151,149,152};
  Circle(200) = {152,149,150};
  Circle(201) = {150,149,153};
  Line Loop(202) = {198,199,200,201};   // clad surface

  Point(154) = { 20.37200000,  0.63000000, 0, lc};
  Point(155) = { 21.20800000,  0.63000000, 0, lc};
  Point(156) = { 20.79000000,  0.21200000, 0, lc};
  Point(157) = { 20.79000000,  1.04800000, 0, lc};
  Circle(203) = {157,149,155};
  Circle(204) = {155,149,156};
  Circle(205) = {156,149,154};
  Circle(206) = {154,149,157};
  Line Loop(207) = {203,204,205,206};   // fuel surface

// define rod regions
  Plane Surface(208) = {202,207};   // clad region
  Plane Surface(209) = {207};      // fuel region
  Physical Surface("RegClad1701")={208};   // pin clad
  Physical Surface("RegFuel1701")={209};   // pin fuel

// ==============================
//    define rod 1,2

  Point(158) = {  0.63000000,  1.89000000, 0, lc};

  Point(159) = {  0.15500000,  1.89000000, 0, lc};
  Point(160) = {  1.10500000,  1.89000000, 0, lc};
  Point(161) = {  0.63000000,  1.41500000, 0, lc};
  Point(162) = {  0.63000000,  2.36500000, 0, lc};
  Circle(210) = {162,158,160};
  Circle(211) = {160,158,161};
  Circle(212) = {161,158,159};
  Circle(213) = {159,158,162};
  Line Loop(214) = {210,211,212,213};   // clad surface

  Point(163) = {  0.21200000,  1.89000000, 0, lc};
  Point(164) = {  1.04800000,  1.89000000, 0, lc};
  Point(165) = {  0.63000000,  1.47200000, 0, lc};
  Point(166) = {  0.63000000,  2.30800000, 0, lc};
  Circle(215) = {166,158,164};
  Circle(216) = {164,158,165};
  Circle(217) = {165,158,163};
  Circle(218) = {163,158,166};
  Line Loop(219) = {215,216,217,218};   // fuel surface

// define rod regions
  Plane Surface(220) = {214,219};   // clad region
  Plane Surface(221) = {219};      // fuel region
  Physical Surface("RegClad0102")={220};   // pin clad
  Physical Surface("RegFuel0102")={221};   // pin fuel

// ==============================
//    define rod 2,2

  Point(167) = {  1.89000000,  1.89000000, 0, lc};

  Point(168) = {  1.41500000,  1.89000000, 0, lc};
  Point(169) = {  2.36500000,  1.89000000, 0, lc};
  Point(170) = {  1.89000000,  1.41500000, 0, lc};
  Point(171) = {  1.89000000,  2.36500000, 0, lc};
  Circle(222) = {171,167,169};
  Circle(223) = {169,167,170};
  Circle(224) = {170,167,168};
  Circle(225) = {168,167,171};
  Line Loop(226) = {222,223,224,225};   // clad surface

  Point(172) = {  1.47200000,  1.89000000, 0, lc};
  Point(173) = {  2.30800000,  1.89000000, 0, lc};
  Point(174) = {  1.89000000,  1.47200000, 0, lc};
  Point(175) = {  1.89000000,  2.30800000, 0, lc};
  Circle(227) = {175,167,173};
  Circle(228) = {173,167,174};
  Circle(229) = {174,167,172};
  Circle(230) = {172,167,175};
  Line Loop(231) = {227,228,229,230};   // fuel surface

// define rod regions
  Plane Surface(232) = {226,231};   // clad region
  Plane Surface(233) = {231};      // fuel region
  Physical Surface("RegClad0202")={232};   // pin clad
  Physical Surface("RegFuel0202")={233};   // pin fuel

// ==============================
//    define rod 3,2

  Point(176) = {  3.15000000,  1.89000000, 0, lc};

  Point(177) = {  2.67500000,  1.89000000, 0, lc};
  Point(178) = {  3.62500000,  1.89000000, 0, lc};
  Point(179) = {  3.15000000,  1.41500000, 0, lc};
  Point(180) = {  3.15000000,  2.36500000, 0, lc};
  Circle(234) = {180,176,178};
  Circle(235) = {178,176,179};
  Circle(236) = {179,176,177};
  Circle(237) = {177,176,180};
  Line Loop(238) = {234,235,236,237};   // clad surface

  Point(181) = {  2.73200000,  1.89000000, 0, lc};
  Point(182) = {  3.56800000,  1.89000000, 0, lc};
  Point(183) = {  3.15000000,  1.47200000, 0, lc};
  Point(184) = {  3.15000000,  2.30800000, 0, lc};
  Circle(239) = {184,176,182};
  Circle(240) = {182,176,183};
  Circle(241) = {183,176,181};
  Circle(242) = {181,176,184};
  Line Loop(243) = {239,240,241,242};   // fuel surface

// define rod regions
  Plane Surface(244) = {238,243};   // clad region
  Plane Surface(245) = {243};      // fuel region
  Physical Surface("RegClad0302")={244};   // pin clad
  Physical Surface("RegFuel0302")={245};   // pin fuel

// ==============================
//    define rod 4,2

  Point(185) = {  4.41000000,  1.89000000, 0, lc};

  Point(186) = {  3.93500000,  1.89000000, 0, lc};
  Point(187) = {  4.88500000,  1.89000000, 0, lc};
  Point(188) = {  4.41000000,  1.41500000, 0, lc};
  Point(189) = {  4.41000000,  2.36500000, 0, lc};
  Circle(246) = {189,185,187};
  Circle(247) = {187,185,188};
  Circle(248) = {188,185,186};
  Circle(249) = {186,185,189};
  Line Loop(250) = {246,247,248,249};   // clad surface

  Point(190) = {  3.99200000,  1.89000000, 0, lc};
  Point(191) = {  4.82800000,  1.89000000, 0, lc};
  Point(192) = {  4.41000000,  1.47200000, 0, lc};
  Point(193) = {  4.41000000,  2.30800000, 0, lc};
  Circle(251) = {193,185,191};
  Circle(252) = {191,185,192};
  Circle(253) = {192,185,190};
  Circle(254) = {190,185,193};
  Line Loop(255) = {251,252,253,254};   // fuel surface

// define rod regions
  Plane Surface(256) = {250,255};   // clad region
  Plane Surface(257) = {255};      // fuel region
  Physical Surface("RegClad0402")={256};   // pin clad
  Physical Surface("RegFuel0402")={257};   // pin fuel

// ==============================
//    define rod 5,2

  Point(194) = {  5.67000000,  1.89000000, 0, lc};

  Point(195) = {  5.19500000,  1.89000000, 0, lc};
  Point(196) = {  6.14500000,  1.89000000, 0, lc};
  Point(197) = {  5.67000000,  1.41500000, 0, lc};
  Point(198) = {  5.67000000,  2.36500000, 0, lc};
  Circle(258) = {198,194,196};
  Circle(259) = {196,194,197};
  Circle(260) = {197,194,195};
  Circle(261) = {195,194,198};
  Line Loop(262) = {258,259,260,261};   // clad surface

  Point(199) = {  5.25200000,  1.89000000, 0, lc};
  Point(200) = {  6.08800000,  1.89000000, 0, lc};
  Point(201) = {  5.67000000,  1.47200000, 0, lc};
  Point(202) = {  5.67000000,  2.30800000, 0, lc};
  Circle(263) = {202,194,200};
  Circle(264) = {200,194,201};
  Circle(265) = {201,194,199};
  Circle(266) = {199,194,202};
  Line Loop(267) = {263,264,265,266};   // fuel surface

// define rod regions
  Plane Surface(268) = {262,267};   // clad region
  Plane Surface(269) = {267};      // fuel region
  Physical Surface("RegClad0502")={268};   // pin clad
  Physical Surface("RegFuel0502")={269};   // pin fuel

// ==============================
//    define rod 6,2

  Point(203) = {  6.93000000,  1.89000000, 0, lc};

  Point(204) = {  6.45500000,  1.89000000, 0, lc};
  Point(205) = {  7.40500000,  1.89000000, 0, lc};
  Point(206) = {  6.93000000,  1.41500000, 0, lc};
  Point(207) = {  6.93000000,  2.36500000, 0, lc};
  Circle(270) = {207,203,205};
  Circle(271) = {205,203,206};
  Circle(272) = {206,203,204};
  Circle(273) = {204,203,207};
  Line Loop(274) = {270,271,272,273};   // clad surface

  Point(208) = {  6.51200000,  1.89000000, 0, lc};
  Point(209) = {  7.34800000,  1.89000000, 0, lc};
  Point(210) = {  6.93000000,  1.47200000, 0, lc};
  Point(211) = {  6.93000000,  2.30800000, 0, lc};
  Circle(275) = {211,203,209};
  Circle(276) = {209,203,210};
  Circle(277) = {210,203,208};
  Circle(278) = {208,203,211};
  Line Loop(279) = {275,276,277,278};   // fuel surface

// define rod regions
  Plane Surface(280) = {274,279};   // clad region
  Plane Surface(281) = {279};      // fuel region
  Physical Surface("RegClad0602")={280};   // pin clad
  Physical Surface("RegFuel0602")={281};   // pin fuel

// ==============================
//    define rod 7,2

  Point(212) = {  8.19000000,  1.89000000, 0, lc};

  Point(213) = {  7.71500000,  1.89000000, 0, lc};
  Point(214) = {  8.66500000,  1.89000000, 0, lc};
  Point(215) = {  8.19000000,  1.41500000, 0, lc};
  Point(216) = {  8.19000000,  2.36500000, 0, lc};
  Circle(282) = {216,212,214};
  Circle(283) = {214,212,215};
  Circle(284) = {215,212,213};
  Circle(285) = {213,212,216};
  Line Loop(286) = {282,283,284,285};   // clad surface

  Point(217) = {  7.77200000,  1.89000000, 0, lc};
  Point(218) = {  8.60800000,  1.89000000, 0, lc};
  Point(219) = {  8.19000000,  1.47200000, 0, lc};
  Point(220) = {  8.19000000,  2.30800000, 0, lc};
  Circle(287) = {220,212,218};
  Circle(288) = {218,212,219};
  Circle(289) = {219,212,217};
  Circle(290) = {217,212,220};
  Line Loop(291) = {287,288,289,290};   // fuel surface

// define rod regions
  Plane Surface(292) = {286,291};   // clad region
  Plane Surface(293) = {291};      // fuel region
  Physical Surface("RegClad0702")={292};   // pin clad
  Physical Surface("RegFuel0702")={293};   // pin fuel

// ==============================
//    define rod 8,2

  Point(221) = {  9.45000000,  1.89000000, 0, lc};

  Point(222) = {  8.97500000,  1.89000000, 0, lc};
  Point(223) = {  9.92500000,  1.89000000, 0, lc};
  Point(224) = {  9.45000000,  1.41500000, 0, lc};
  Point(225) = {  9.45000000,  2.36500000, 0, lc};
  Circle(294) = {225,221,223};
  Circle(295) = {223,221,224};
  Circle(296) = {224,221,222};
  Circle(297) = {222,221,225};
  Line Loop(298) = {294,295,296,297};   // clad surface

  Point(226) = {  9.03200000,  1.89000000, 0, lc};
  Point(227) = {  9.86800000,  1.89000000, 0, lc};
  Point(228) = {  9.45000000,  1.47200000, 0, lc};
  Point(229) = {  9.45000000,  2.30800000, 0, lc};
  Circle(299) = {229,221,227};
  Circle(300) = {227,221,228};
  Circle(301) = {228,221,226};
  Circle(302) = {226,221,229};
  Line Loop(303) = {299,300,301,302};   // fuel surface

// define rod regions
  Plane Surface(304) = {298,303};   // clad region
  Plane Surface(305) = {303};      // fuel region
  Physical Surface("RegClad0802")={304};   // pin clad
  Physical Surface("RegFuel0802")={305};   // pin fuel

// ==============================
//    define rod 9,2

  Point(230) = { 10.71000000,  1.89000000, 0, lc};

  Point(231) = { 10.23500000,  1.89000000, 0, lc};
  Point(232) = { 11.18500000,  1.89000000, 0, lc};
  Point(233) = { 10.71000000,  1.41500000, 0, lc};
  Point(234) = { 10.71000000,  2.36500000, 0, lc};
  Circle(306) = {234,230,232};
  Circle(307) = {232,230,233};
  Circle(308) = {233,230,231};
  Circle(309) = {231,230,234};
  Line Loop(310) = {306,307,308,309};   // clad surface

  Point(235) = { 10.29200000,  1.89000000, 0, lc};
  Point(236) = { 11.12800000,  1.89000000, 0, lc};
  Point(237) = { 10.71000000,  1.47200000, 0, lc};
  Point(238) = { 10.71000000,  2.30800000, 0, lc};
  Circle(311) = {238,230,236};
  Circle(312) = {236,230,237};
  Circle(313) = {237,230,235};
  Circle(314) = {235,230,238};
  Line Loop(315) = {311,312,313,314};   // fuel surface

// define rod regions
  Plane Surface(316) = {310,315};   // clad region
  Plane Surface(317) = {315};      // fuel region
  Physical Surface("RegClad0902")={316};   // pin clad
  Physical Surface("RegFuel0902")={317};   // pin fuel

// ==============================
//    define rod 10,2

  Point(239) = { 11.97000000,  1.89000000, 0, lc};

  Point(240) = { 11.49500000,  1.89000000, 0, lc};
  Point(241) = { 12.44500000,  1.89000000, 0, lc};
  Point(242) = { 11.97000000,  1.41500000, 0, lc};
  Point(243) = { 11.97000000,  2.36500000, 0, lc};
  Circle(318) = {243,239,241};
  Circle(319) = {241,239,242};
  Circle(320) = {242,239,240};
  Circle(321) = {240,239,243};
  Line Loop(322) = {318,319,320,321};   // clad surface

  Point(244) = { 11.55200000,  1.89000000, 0, lc};
  Point(245) = { 12.38800000,  1.89000000, 0, lc};
  Point(246) = { 11.97000000,  1.47200000, 0, lc};
  Point(247) = { 11.97000000,  2.30800000, 0, lc};
  Circle(323) = {247,239,245};
  Circle(324) = {245,239,246};
  Circle(325) = {246,239,244};
  Circle(326) = {244,239,247};
  Line Loop(327) = {323,324,325,326};   // fuel surface

// define rod regions
  Plane Surface(328) = {322,327};   // clad region
  Plane Surface(329) = {327};      // fuel region
  Physical Surface("RegClad1002")={328};   // pin clad
  Physical Surface("RegFuel1002")={329};   // pin fuel

// ==============================
//    define rod 11,2

  Point(248) = { 13.23000000,  1.89000000, 0, lc};

  Point(249) = { 12.75500000,  1.89000000, 0, lc};
  Point(250) = { 13.70500000,  1.89000000, 0, lc};
  Point(251) = { 13.23000000,  1.41500000, 0, lc};
  Point(252) = { 13.23000000,  2.36500000, 0, lc};
  Circle(330) = {252,248,250};
  Circle(331) = {250,248,251};
  Circle(332) = {251,248,249};
  Circle(333) = {249,248,252};
  Line Loop(334) = {330,331,332,333};   // clad surface

  Point(253) = { 12.81200000,  1.89000000, 0, lc};
  Point(254) = { 13.64800000,  1.89000000, 0, lc};
  Point(255) = { 13.23000000,  1.47200000, 0, lc};
  Point(256) = { 13.23000000,  2.30800000, 0, lc};
  Circle(335) = {256,248,254};
  Circle(336) = {254,248,255};
  Circle(337) = {255,248,253};
  Circle(338) = {253,248,256};
  Line Loop(339) = {335,336,337,338};   // fuel surface

// define rod regions
  Plane Surface(340) = {334,339};   // clad region
  Plane Surface(341) = {339};      // fuel region
  Physical Surface("RegClad1102")={340};   // pin clad
  Physical Surface("RegFuel1102")={341};   // pin fuel

// ==============================
//    define rod 12,2

  Point(257) = { 14.49000000,  1.89000000, 0, lc};

  Point(258) = { 14.01500000,  1.89000000, 0, lc};
  Point(259) = { 14.96500000,  1.89000000, 0, lc};
  Point(260) = { 14.49000000,  1.41500000, 0, lc};
  Point(261) = { 14.49000000,  2.36500000, 0, lc};
  Circle(342) = {261,257,259};
  Circle(343) = {259,257,260};
  Circle(344) = {260,257,258};
  Circle(345) = {258,257,261};
  Line Loop(346) = {342,343,344,345};   // clad surface

  Point(262) = { 14.07200000,  1.89000000, 0, lc};
  Point(263) = { 14.90800000,  1.89000000, 0, lc};
  Point(264) = { 14.49000000,  1.47200000, 0, lc};
  Point(265) = { 14.49000000,  2.30800000, 0, lc};
  Circle(347) = {265,257,263};
  Circle(348) = {263,257,264};
  Circle(349) = {264,257,262};
  Circle(350) = {262,257,265};
  Line Loop(351) = {347,348,349,350};   // fuel surface

// define rod regions
  Plane Surface(352) = {346,351};   // clad region
  Plane Surface(353) = {351};      // fuel region
  Physical Surface("RegClad1202")={352};   // pin clad
  Physical Surface("RegFuel1202")={353};   // pin fuel

// ==============================
//    define rod 13,2

  Point(266) = { 15.75000000,  1.89000000, 0, lc};

  Point(267) = { 15.27500000,  1.89000000, 0, lc};
  Point(268) = { 16.22500000,  1.89000000, 0, lc};
  Point(269) = { 15.75000000,  1.41500000, 0, lc};
  Point(270) = { 15.75000000,  2.36500000, 0, lc};
  Circle(354) = {270,266,268};
  Circle(355) = {268,266,269};
  Circle(356) = {269,266,267};
  Circle(357) = {267,266,270};
  Line Loop(358) = {354,355,356,357};   // clad surface

  Point(271) = { 15.33200000,  1.89000000, 0, lc};
  Point(272) = { 16.16800000,  1.89000000, 0, lc};
  Point(273) = { 15.75000000,  1.47200000, 0, lc};
  Point(274) = { 15.75000000,  2.30800000, 0, lc};
  Circle(359) = {274,266,272};
  Circle(360) = {272,266,273};
  Circle(361) = {273,266,271};
  Circle(362) = {271,266,274};
  Line Loop(363) = {359,360,361,362};   // fuel surface

// define rod regions
  Plane Surface(364) = {358,363};   // clad region
  Plane Surface(365) = {363};      // fuel region
  Physical Surface("RegClad1302")={364};   // pin clad
  Physical Surface("RegFuel1302")={365};   // pin fuel

// ==============================
//    define rod 14,2

  Point(275) = { 17.01000000,  1.89000000, 0, lc};

  Point(276) = { 16.53500000,  1.89000000, 0, lc};
  Point(277) = { 17.48500000,  1.89000000, 0, lc};
  Point(278) = { 17.01000000,  1.41500000, 0, lc};
  Point(279) = { 17.01000000,  2.36500000, 0, lc};
  Circle(366) = {279,275,277};
  Circle(367) = {277,275,278};
  Circle(368) = {278,275,276};
  Circle(369) = {276,275,279};
  Line Loop(370) = {366,367,368,369};   // clad surface

  Point(280) = { 16.59200000,  1.89000000, 0, lc};
  Point(281) = { 17.42800000,  1.89000000, 0, lc};
  Point(282) = { 17.01000000,  1.47200000, 0, lc};
  Point(283) = { 17.01000000,  2.30800000, 0, lc};
  Circle(371) = {283,275,281};
  Circle(372) = {281,275,282};
  Circle(373) = {282,275,280};
  Circle(374) = {280,275,283};
  Line Loop(375) = {371,372,373,374};   // fuel surface

// define rod regions
  Plane Surface(376) = {370,375};   // clad region
  Plane Surface(377) = {375};      // fuel region
  Physical Surface("RegClad1402")={376};   // pin clad
  Physical Surface("RegFuel1402")={377};   // pin fuel

// ==============================
//    define rod 15,2

  Point(284) = { 18.27000000,  1.89000000, 0, lc};

  Point(285) = { 17.79500000,  1.89000000, 0, lc};
  Point(286) = { 18.74500000,  1.89000000, 0, lc};
  Point(287) = { 18.27000000,  1.41500000, 0, lc};
  Point(288) = { 18.27000000,  2.36500000, 0, lc};
  Circle(378) = {288,284,286};
  Circle(379) = {286,284,287};
  Circle(380) = {287,284,285};
  Circle(381) = {285,284,288};
  Line Loop(382) = {378,379,380,381};   // clad surface

  Point(289) = { 17.85200000,  1.89000000, 0, lc};
  Point(290) = { 18.68800000,  1.89000000, 0, lc};
  Point(291) = { 18.27000000,  1.47200000, 0, lc};
  Point(292) = { 18.27000000,  2.30800000, 0, lc};
  Circle(383) = {292,284,290};
  Circle(384) = {290,284,291};
  Circle(385) = {291,284,289};
  Circle(386) = {289,284,292};
  Line Loop(387) = {383,384,385,386};   // fuel surface

// define rod regions
  Plane Surface(388) = {382,387};   // clad region
  Plane Surface(389) = {387};      // fuel region
  Physical Surface("RegClad1502")={388};   // pin clad
  Physical Surface("RegFuel1502")={389};   // pin fuel

// ==============================
//    define rod 16,2

  Point(293) = { 19.53000000,  1.89000000, 0, lc};

  Point(294) = { 19.05500000,  1.89000000, 0, lc};
  Point(295) = { 20.00500000,  1.89000000, 0, lc};
  Point(296) = { 19.53000000,  1.41500000, 0, lc};
  Point(297) = { 19.53000000,  2.36500000, 0, lc};
  Circle(390) = {297,293,295};
  Circle(391) = {295,293,296};
  Circle(392) = {296,293,294};
  Circle(393) = {294,293,297};
  Line Loop(394) = {390,391,392,393};   // clad surface

  Point(298) = { 19.11200000,  1.89000000, 0, lc};
  Point(299) = { 19.94800000,  1.89000000, 0, lc};
  Point(300) = { 19.53000000,  1.47200000, 0, lc};
  Point(301) = { 19.53000000,  2.30800000, 0, lc};
  Circle(395) = {301,293,299};
  Circle(396) = {299,293,300};
  Circle(397) = {300,293,298};
  Circle(398) = {298,293,301};
  Line Loop(399) = {395,396,397,398};   // fuel surface

// define rod regions
  Plane Surface(400) = {394,399};   // clad region
  Plane Surface(401) = {399};      // fuel region
  Physical Surface("RegClad1602")={400};   // pin clad
  Physical Surface("RegFuel1602")={401};   // pin fuel

// ==============================
//    define rod 17,2

  Point(302) = { 20.79000000,  1.89000000, 0, lc};

  Point(303) = { 20.31500000,  1.89000000, 0, lc};
  Point(304) = { 21.26500000,  1.89000000, 0, lc};
  Point(305) = { 20.79000000,  1.41500000, 0, lc};
  Point(306) = { 20.79000000,  2.36500000, 0, lc};
  Circle(402) = {306,302,304};
  Circle(403) = {304,302,305};
  Circle(404) = {305,302,303};
  Circle(405) = {303,302,306};
  Line Loop(406) = {402,403,404,405};   // clad surface

  Point(307) = { 20.37200000,  1.89000000, 0, lc};
  Point(308) = { 21.20800000,  1.89000000, 0, lc};
  Point(309) = { 20.79000000,  1.47200000, 0, lc};
  Point(310) = { 20.79000000,  2.30800000, 0, lc};
  Circle(407) = {310,302,308};
  Circle(408) = {308,302,309};
  Circle(409) = {309,302,307};
  Circle(410) = {307,302,310};
  Line Loop(411) = {407,408,409,410};   // fuel surface

// define rod regions
  Plane Surface(412) = {406,411};   // clad region
  Plane Surface(413) = {411};      // fuel region
  Physical Surface("RegClad1702")={412};   // pin clad
  Physical Surface("RegFuel1702")={413};   // pin fuel

// ==============================
//    define rod 1,3

  Point(311) = {  0.63000000,  3.15000000, 0, lc};

  Point(312) = {  0.15500000,  3.15000000, 0, lc};
  Point(313) = {  1.10500000,  3.15000000, 0, lc};
  Point(314) = {  0.63000000,  2.67500000, 0, lc};
  Point(315) = {  0.63000000,  3.62500000, 0, lc};
  Circle(414) = {315,311,313};
  Circle(415) = {313,311,314};
  Circle(416) = {314,311,312};
  Circle(417) = {312,311,315};
  Line Loop(418) = {414,415,416,417};   // clad surface

  Point(316) = {  0.21200000,  3.15000000, 0, lc};
  Point(317) = {  1.04800000,  3.15000000, 0, lc};
  Point(318) = {  0.63000000,  2.73200000, 0, lc};
  Point(319) = {  0.63000000,  3.56800000, 0, lc};
  Circle(419) = {319,311,317};
  Circle(420) = {317,311,318};
  Circle(421) = {318,311,316};
  Circle(422) = {316,311,319};
  Line Loop(423) = {419,420,421,422};   // fuel surface

// define rod regions
  Plane Surface(424) = {418,423};   // clad region
  Plane Surface(425) = {423};      // fuel region
  Physical Surface("RegClad0103")={424};   // pin clad
  Physical Surface("RegFuel0103")={425};   // pin fuel

// ==============================
//    define rod 2,3

  Point(320) = {  1.89000000,  3.15000000, 0, lc};

  Point(321) = {  1.41500000,  3.15000000, 0, lc};
  Point(322) = {  2.36500000,  3.15000000, 0, lc};
  Point(323) = {  1.89000000,  2.67500000, 0, lc};
  Point(324) = {  1.89000000,  3.62500000, 0, lc};
  Circle(426) = {324,320,322};
  Circle(427) = {322,320,323};
  Circle(428) = {323,320,321};
  Circle(429) = {321,320,324};
  Line Loop(430) = {426,427,428,429};   // clad surface

  Point(325) = {  1.47200000,  3.15000000, 0, lc};
  Point(326) = {  2.30800000,  3.15000000, 0, lc};
  Point(327) = {  1.89000000,  2.73200000, 0, lc};
  Point(328) = {  1.89000000,  3.56800000, 0, lc};
  Circle(431) = {328,320,326};
  Circle(432) = {326,320,327};
  Circle(433) = {327,320,325};
  Circle(434) = {325,320,328};
  Line Loop(435) = {431,432,433,434};   // fuel surface

// define rod regions
  Plane Surface(436) = {430,435};   // clad region
  Plane Surface(437) = {435};      // fuel region
  Physical Surface("RegClad0203")={436};   // pin clad
  Physical Surface("RegFuel0203")={437};   // pin fuel

// ==============================
//    define rod 3,3

  Point(329) = {  3.15000000,  3.15000000, 0, lc};

  Point(330) = {  2.54800000,  3.15000000, 0, lc};
  Point(331) = {  3.75200000,  3.15000000, 0, lc};
  Point(332) = {  3.15000000,  2.54800000, 0, lc};
  Point(333) = {  3.15000000,  3.75200000, 0, lc};
  Circle(438) = {333,329,331};
  Circle(439) = {331,329,332};
  Circle(440) = {332,329,330};
  Circle(441) = {330,329,333};
  Line Loop(442) = {438,439,440,441};   // clad surface

  Point(334) = {  2.58900000,  3.15000000, 0, lc};
  Point(335) = {  3.71100000,  3.15000000, 0, lc};
  Point(336) = {  3.15000000,  2.58900000, 0, lc};
  Point(337) = {  3.15000000,  3.71100000, 0, lc};
  Circle(443) = {337,329,335};
  Circle(444) = {335,329,336};
  Circle(445) = {336,329,334};
  Circle(446) = {334,329,337};
  Line Loop(447) = {443,444,445,446};   // fuel surface

// define rod regions
  Plane Surface(448) = {442,447};   // clad region
  Plane Surface(449) = {447};      // fuel region
  Physical Surface("RegClad0303")={448};   // pin clad
  Physical Surface("RegFuel0303")={449};   // pin fuel

// ==============================
//    define rod 4,3

  Point(338) = {  4.41000000,  3.15000000, 0, lc};

  Point(339) = {  3.93500000,  3.15000000, 0, lc};
  Point(340) = {  4.88500000,  3.15000000, 0, lc};
  Point(341) = {  4.41000000,  2.67500000, 0, lc};
  Point(342) = {  4.41000000,  3.62500000, 0, lc};
  Circle(450) = {342,338,340};
  Circle(451) = {340,338,341};
  Circle(452) = {341,338,339};
  Circle(453) = {339,338,342};
  Line Loop(454) = {450,451,452,453};   // clad surface

  Point(343) = {  3.99200000,  3.15000000, 0, lc};
  Point(344) = {  4.82800000,  3.15000000, 0, lc};
  Point(345) = {  4.41000000,  2.73200000, 0, lc};
  Point(346) = {  4.41000000,  3.56800000, 0, lc};
  Circle(455) = {346,338,344};
  Circle(456) = {344,338,345};
  Circle(457) = {345,338,343};
  Circle(458) = {343,338,346};
  Line Loop(459) = {455,456,457,458};   // fuel surface

// define rod regions
  Plane Surface(460) = {454,459};   // clad region
  Plane Surface(461) = {459};      // fuel region
  Physical Surface("RegClad0403")={460};   // pin clad
  Physical Surface("RegFuel0403")={461};   // pin fuel

// ==============================
//    define rod 5,3

  Point(347) = {  5.67000000,  3.15000000, 0, lc};

  Point(348) = {  5.19500000,  3.15000000, 0, lc};
  Point(349) = {  6.14500000,  3.15000000, 0, lc};
  Point(350) = {  5.67000000,  2.67500000, 0, lc};
  Point(351) = {  5.67000000,  3.62500000, 0, lc};
  Circle(462) = {351,347,349};
  Circle(463) = {349,347,350};
  Circle(464) = {350,347,348};
  Circle(465) = {348,347,351};
  Line Loop(466) = {462,463,464,465};   // clad surface

  Point(352) = {  5.25200000,  3.15000000, 0, lc};
  Point(353) = {  6.08800000,  3.15000000, 0, lc};
  Point(354) = {  5.67000000,  2.73200000, 0, lc};
  Point(355) = {  5.67000000,  3.56800000, 0, lc};
  Circle(467) = {355,347,353};
  Circle(468) = {353,347,354};
  Circle(469) = {354,347,352};
  Circle(470) = {352,347,355};
  Line Loop(471) = {467,468,469,470};   // fuel surface

// define rod regions
  Plane Surface(472) = {466,471};   // clad region
  Plane Surface(473) = {471};      // fuel region
  Physical Surface("RegClad0503")={472};   // pin clad
  Physical Surface("RegFuel0503")={473};   // pin fuel

// ==============================
//    define rod 6,3

  Point(356) = {  6.93000000,  3.15000000, 0, lc};

  Point(357) = {  6.45500000,  3.15000000, 0, lc};
  Point(358) = {  7.40500000,  3.15000000, 0, lc};
  Point(359) = {  6.93000000,  2.67500000, 0, lc};
  Point(360) = {  6.93000000,  3.62500000, 0, lc};
  Circle(474) = {360,356,358};
  Circle(475) = {358,356,359};
  Circle(476) = {359,356,357};
  Circle(477) = {357,356,360};
  Line Loop(478) = {474,475,476,477};   // clad surface

  Point(361) = {  6.51200000,  3.15000000, 0, lc};
  Point(362) = {  7.34800000,  3.15000000, 0, lc};
  Point(363) = {  6.93000000,  2.73200000, 0, lc};
  Point(364) = {  6.93000000,  3.56800000, 0, lc};
  Circle(479) = {364,356,362};
  Circle(480) = {362,356,363};
  Circle(481) = {363,356,361};
  Circle(482) = {361,356,364};
  Line Loop(483) = {479,480,481,482};   // fuel surface

// define rod regions
  Plane Surface(484) = {478,483};   // clad region
  Plane Surface(485) = {483};      // fuel region
  Physical Surface("RegClad0603")={484};   // pin clad
  Physical Surface("RegFuel0603")={485};   // pin fuel

// ==============================
//    define rod 7,3

  Point(365) = {  8.19000000,  3.15000000, 0, lc};

  Point(366) = {  7.71500000,  3.15000000, 0, lc};
  Point(367) = {  8.66500000,  3.15000000, 0, lc};
  Point(368) = {  8.19000000,  2.67500000, 0, lc};
  Point(369) = {  8.19000000,  3.62500000, 0, lc};
  Circle(486) = {369,365,367};
  Circle(487) = {367,365,368};
  Circle(488) = {368,365,366};
  Circle(489) = {366,365,369};
  Line Loop(490) = {486,487,488,489};   // clad surface

  Point(370) = {  7.77200000,  3.15000000, 0, lc};
  Point(371) = {  8.60800000,  3.15000000, 0, lc};
  Point(372) = {  8.19000000,  2.73200000, 0, lc};
  Point(373) = {  8.19000000,  3.56800000, 0, lc};
  Circle(491) = {373,365,371};
  Circle(492) = {371,365,372};
  Circle(493) = {372,365,370};
  Circle(494) = {370,365,373};
  Line Loop(495) = {491,492,493,494};   // fuel surface

// define rod regions
  Plane Surface(496) = {490,495};   // clad region
  Plane Surface(497) = {495};      // fuel region
  Physical Surface("RegClad0703")={496};   // pin clad
  Physical Surface("RegFuel0703")={497};   // pin fuel

// ==============================
//    define rod 8,3

  Point(374) = {  9.45000000,  3.15000000, 0, lc};

  Point(375) = {  8.97500000,  3.15000000, 0, lc};
  Point(376) = {  9.92500000,  3.15000000, 0, lc};
  Point(377) = {  9.45000000,  2.67500000, 0, lc};
  Point(378) = {  9.45000000,  3.62500000, 0, lc};
  Circle(498) = {378,374,376};
  Circle(499) = {376,374,377};
  Circle(500) = {377,374,375};
  Circle(501) = {375,374,378};
  Line Loop(502) = {498,499,500,501};   // clad surface

  Point(379) = {  9.03200000,  3.15000000, 0, lc};
  Point(380) = {  9.86800000,  3.15000000, 0, lc};
  Point(381) = {  9.45000000,  2.73200000, 0, lc};
  Point(382) = {  9.45000000,  3.56800000, 0, lc};
  Circle(503) = {382,374,380};
  Circle(504) = {380,374,381};
  Circle(505) = {381,374,379};
  Circle(506) = {379,374,382};
  Line Loop(507) = {503,504,505,506};   // fuel surface

// define rod regions
  Plane Surface(508) = {502,507};   // clad region
  Plane Surface(509) = {507};      // fuel region
  Physical Surface("RegClad0803")={508};   // pin clad
  Physical Surface("RegFuel0803")={509};   // pin fuel

// ==============================
//    define rod 9,3

  Point(383) = { 10.71000000,  3.15000000, 0, lc};

  Point(384) = { 10.23500000,  3.15000000, 0, lc};
  Point(385) = { 11.18500000,  3.15000000, 0, lc};
  Point(386) = { 10.71000000,  2.67500000, 0, lc};
  Point(387) = { 10.71000000,  3.62500000, 0, lc};
  Circle(510) = {387,383,385};
  Circle(511) = {385,383,386};
  Circle(512) = {386,383,384};
  Circle(513) = {384,383,387};
  Line Loop(514) = {510,511,512,513};   // clad surface

  Point(388) = { 10.29200000,  3.15000000, 0, lc};
  Point(389) = { 11.12800000,  3.15000000, 0, lc};
  Point(390) = { 10.71000000,  2.73200000, 0, lc};
  Point(391) = { 10.71000000,  3.56800000, 0, lc};
  Circle(515) = {391,383,389};
  Circle(516) = {389,383,390};
  Circle(517) = {390,383,388};
  Circle(518) = {388,383,391};
  Line Loop(519) = {515,516,517,518};   // fuel surface

// define rod regions
  Plane Surface(520) = {514,519};   // clad region
  Plane Surface(521) = {519};      // fuel region
  Physical Surface("RegClad0903")={520};   // pin clad
  Physical Surface("RegFuel0903")={521};   // pin fuel

// ==============================
//    define rod 10,3

  Point(392) = { 11.97000000,  3.15000000, 0, lc};

  Point(393) = { 11.49500000,  3.15000000, 0, lc};
  Point(394) = { 12.44500000,  3.15000000, 0, lc};
  Point(395) = { 11.97000000,  2.67500000, 0, lc};
  Point(396) = { 11.97000000,  3.62500000, 0, lc};
  Circle(522) = {396,392,394};
  Circle(523) = {394,392,395};
  Circle(524) = {395,392,393};
  Circle(525) = {393,392,396};
  Line Loop(526) = {522,523,524,525};   // clad surface

  Point(397) = { 11.55200000,  3.15000000, 0, lc};
  Point(398) = { 12.38800000,  3.15000000, 0, lc};
  Point(399) = { 11.97000000,  2.73200000, 0, lc};
  Point(400) = { 11.97000000,  3.56800000, 0, lc};
  Circle(527) = {400,392,398};
  Circle(528) = {398,392,399};
  Circle(529) = {399,392,397};
  Circle(530) = {397,392,400};
  Line Loop(531) = {527,528,529,530};   // fuel surface

// define rod regions
  Plane Surface(532) = {526,531};   // clad region
  Plane Surface(533) = {531};      // fuel region
  Physical Surface("RegClad1003")={532};   // pin clad
  Physical Surface("RegFuel1003")={533};   // pin fuel

// ==============================
//    define rod 11,3

  Point(401) = { 13.23000000,  3.15000000, 0, lc};

  Point(402) = { 12.75500000,  3.15000000, 0, lc};
  Point(403) = { 13.70500000,  3.15000000, 0, lc};
  Point(404) = { 13.23000000,  2.67500000, 0, lc};
  Point(405) = { 13.23000000,  3.62500000, 0, lc};
  Circle(534) = {405,401,403};
  Circle(535) = {403,401,404};
  Circle(536) = {404,401,402};
  Circle(537) = {402,401,405};
  Line Loop(538) = {534,535,536,537};   // clad surface

  Point(406) = { 12.81200000,  3.15000000, 0, lc};
  Point(407) = { 13.64800000,  3.15000000, 0, lc};
  Point(408) = { 13.23000000,  2.73200000, 0, lc};
  Point(409) = { 13.23000000,  3.56800000, 0, lc};
  Circle(539) = {409,401,407};
  Circle(540) = {407,401,408};
  Circle(541) = {408,401,406};
  Circle(542) = {406,401,409};
  Line Loop(543) = {539,540,541,542};   // fuel surface

// define rod regions
  Plane Surface(544) = {538,543};   // clad region
  Plane Surface(545) = {543};      // fuel region
  Physical Surface("RegClad1103")={544};   // pin clad
  Physical Surface("RegFuel1103")={545};   // pin fuel

// ==============================
//    define rod 12,3

  Point(410) = { 14.49000000,  3.15000000, 0, lc};

  Point(411) = { 14.01500000,  3.15000000, 0, lc};
  Point(412) = { 14.96500000,  3.15000000, 0, lc};
  Point(413) = { 14.49000000,  2.67500000, 0, lc};
  Point(414) = { 14.49000000,  3.62500000, 0, lc};
  Circle(546) = {414,410,412};
  Circle(547) = {412,410,413};
  Circle(548) = {413,410,411};
  Circle(549) = {411,410,414};
  Line Loop(550) = {546,547,548,549};   // clad surface

  Point(415) = { 14.07200000,  3.15000000, 0, lc};
  Point(416) = { 14.90800000,  3.15000000, 0, lc};
  Point(417) = { 14.49000000,  2.73200000, 0, lc};
  Point(418) = { 14.49000000,  3.56800000, 0, lc};
  Circle(551) = {418,410,416};
  Circle(552) = {416,410,417};
  Circle(553) = {417,410,415};
  Circle(554) = {415,410,418};
  Line Loop(555) = {551,552,553,554};   // fuel surface

// define rod regions
  Plane Surface(556) = {550,555};   // clad region
  Plane Surface(557) = {555};      // fuel region
  Physical Surface("RegClad1203")={556};   // pin clad
  Physical Surface("RegFuel1203")={557};   // pin fuel

// ==============================
//    define rod 13,3

  Point(419) = { 15.75000000,  3.15000000, 0, lc};

  Point(420) = { 15.27500000,  3.15000000, 0, lc};
  Point(421) = { 16.22500000,  3.15000000, 0, lc};
  Point(422) = { 15.75000000,  2.67500000, 0, lc};
  Point(423) = { 15.75000000,  3.62500000, 0, lc};
  Circle(558) = {423,419,421};
  Circle(559) = {421,419,422};
  Circle(560) = {422,419,420};
  Circle(561) = {420,419,423};
  Line Loop(562) = {558,559,560,561};   // clad surface

  Point(424) = { 15.33200000,  3.15000000, 0, lc};
  Point(425) = { 16.16800000,  3.15000000, 0, lc};
  Point(426) = { 15.75000000,  2.73200000, 0, lc};
  Point(427) = { 15.75000000,  3.56800000, 0, lc};
  Circle(563) = {427,419,425};
  Circle(564) = {425,419,426};
  Circle(565) = {426,419,424};
  Circle(566) = {424,419,427};
  Line Loop(567) = {563,564,565,566};   // fuel surface

// define rod regions
  Plane Surface(568) = {562,567};   // clad region
  Plane Surface(569) = {567};      // fuel region
  Physical Surface("RegClad1303")={568};   // pin clad
  Physical Surface("RegFuel1303")={569};   // pin fuel

// ==============================
//    define rod 14,3

  Point(428) = { 17.01000000,  3.15000000, 0, lc};

  Point(429) = { 16.53500000,  3.15000000, 0, lc};
  Point(430) = { 17.48500000,  3.15000000, 0, lc};
  Point(431) = { 17.01000000,  2.67500000, 0, lc};
  Point(432) = { 17.01000000,  3.62500000, 0, lc};
  Circle(570) = {432,428,430};
  Circle(571) = {430,428,431};
  Circle(572) = {431,428,429};
  Circle(573) = {429,428,432};
  Line Loop(574) = {570,571,572,573};   // clad surface

  Point(433) = { 16.59200000,  3.15000000, 0, lc};
  Point(434) = { 17.42800000,  3.15000000, 0, lc};
  Point(435) = { 17.01000000,  2.73200000, 0, lc};
  Point(436) = { 17.01000000,  3.56800000, 0, lc};
  Circle(575) = {436,428,434};
  Circle(576) = {434,428,435};
  Circle(577) = {435,428,433};
  Circle(578) = {433,428,436};
  Line Loop(579) = {575,576,577,578};   // fuel surface

// define rod regions
  Plane Surface(580) = {574,579};   // clad region
  Plane Surface(581) = {579};      // fuel region
  Physical Surface("RegClad1403")={580};   // pin clad
  Physical Surface("RegFuel1403")={581};   // pin fuel

// ==============================
//    define rod 15,3

  Point(437) = { 18.27000000,  3.15000000, 0, lc};

  Point(438) = { 17.79500000,  3.15000000, 0, lc};
  Point(439) = { 18.74500000,  3.15000000, 0, lc};
  Point(440) = { 18.27000000,  2.67500000, 0, lc};
  Point(441) = { 18.27000000,  3.62500000, 0, lc};
  Circle(582) = {441,437,439};
  Circle(583) = {439,437,440};
  Circle(584) = {440,437,438};
  Circle(585) = {438,437,441};
  Line Loop(586) = {582,583,584,585};   // clad surface

  Point(442) = { 17.85200000,  3.15000000, 0, lc};
  Point(443) = { 18.68800000,  3.15000000, 0, lc};
  Point(444) = { 18.27000000,  2.73200000, 0, lc};
  Point(445) = { 18.27000000,  3.56800000, 0, lc};
  Circle(587) = {445,437,443};
  Circle(588) = {443,437,444};
  Circle(589) = {444,437,442};
  Circle(590) = {442,437,445};
  Line Loop(591) = {587,588,589,590};   // fuel surface

// define rod regions
  Plane Surface(592) = {586,591};   // clad region
  Plane Surface(593) = {591};      // fuel region
  Physical Surface("RegClad1503")={592};   // pin clad
  Physical Surface("RegFuel1503")={593};   // pin fuel

// ==============================
//    define rod 16,3

  Point(446) = { 19.53000000,  3.15000000, 0, lc};

  Point(447) = { 19.05500000,  3.15000000, 0, lc};
  Point(448) = { 20.00500000,  3.15000000, 0, lc};
  Point(449) = { 19.53000000,  2.67500000, 0, lc};
  Point(450) = { 19.53000000,  3.62500000, 0, lc};
  Circle(594) = {450,446,448};
  Circle(595) = {448,446,449};
  Circle(596) = {449,446,447};
  Circle(597) = {447,446,450};
  Line Loop(598) = {594,595,596,597};   // clad surface

  Point(451) = { 19.11200000,  3.15000000, 0, lc};
  Point(452) = { 19.94800000,  3.15000000, 0, lc};
  Point(453) = { 19.53000000,  2.73200000, 0, lc};
  Point(454) = { 19.53000000,  3.56800000, 0, lc};
  Circle(599) = {454,446,452};
  Circle(600) = {452,446,453};
  Circle(601) = {453,446,451};
  Circle(602) = {451,446,454};
  Line Loop(603) = {599,600,601,602};   // fuel surface

// define rod regions
  Plane Surface(604) = {598,603};   // clad region
  Plane Surface(605) = {603};      // fuel region
  Physical Surface("RegClad1603")={604};   // pin clad
  Physical Surface("RegFuel1603")={605};   // pin fuel

// ==============================
//    define rod 17,3

  Point(455) = { 20.79000000,  3.15000000, 0, lc};

  Point(456) = { 20.31500000,  3.15000000, 0, lc};
  Point(457) = { 21.26500000,  3.15000000, 0, lc};
  Point(458) = { 20.79000000,  2.67500000, 0, lc};
  Point(459) = { 20.79000000,  3.62500000, 0, lc};
  Circle(606) = {459,455,457};
  Circle(607) = {457,455,458};
  Circle(608) = {458,455,456};
  Circle(609) = {456,455,459};
  Line Loop(610) = {606,607,608,609};   // clad surface

  Point(460) = { 20.37200000,  3.15000000, 0, lc};
  Point(461) = { 21.20800000,  3.15000000, 0, lc};
  Point(462) = { 20.79000000,  2.73200000, 0, lc};
  Point(463) = { 20.79000000,  3.56800000, 0, lc};
  Circle(611) = {463,455,461};
  Circle(612) = {461,455,462};
  Circle(613) = {462,455,460};
  Circle(614) = {460,455,463};
  Line Loop(615) = {611,612,613,614};   // fuel surface

// define rod regions
  Plane Surface(616) = {610,615};   // clad region
  Plane Surface(617) = {615};      // fuel region
  Physical Surface("RegClad1703")={616};   // pin clad
  Physical Surface("RegFuel1703")={617};   // pin fuel

// ==============================
//    define rod 1,4

  Point(464) = {  0.63000000,  4.41000000, 0, lc};

  Point(465) = {  0.15500000,  4.41000000, 0, lc};
  Point(466) = {  1.10500000,  4.41000000, 0, lc};
  Point(467) = {  0.63000000,  3.93500000, 0, lc};
  Point(468) = {  0.63000000,  4.88500000, 0, lc};
  Circle(618) = {468,464,466};
  Circle(619) = {466,464,467};
  Circle(620) = {467,464,465};
  Circle(621) = {465,464,468};
  Line Loop(622) = {618,619,620,621};   // clad surface

  Point(469) = {  0.21200000,  4.41000000, 0, lc};
  Point(470) = {  1.04800000,  4.41000000, 0, lc};
  Point(471) = {  0.63000000,  3.99200000, 0, lc};
  Point(472) = {  0.63000000,  4.82800000, 0, lc};
  Circle(623) = {472,464,470};
  Circle(624) = {470,464,471};
  Circle(625) = {471,464,469};
  Circle(626) = {469,464,472};
  Line Loop(627) = {623,624,625,626};   // fuel surface

// define rod regions
  Plane Surface(628) = {622,627};   // clad region
  Plane Surface(629) = {627};      // fuel region
  Physical Surface("RegClad0104")={628};   // pin clad
  Physical Surface("RegFuel0104")={629};   // pin fuel

// ==============================
//    define rod 2,4

  Point(473) = {  1.89000000,  4.41000000, 0, lc};

  Point(474) = {  1.41500000,  4.41000000, 0, lc};
  Point(475) = {  2.36500000,  4.41000000, 0, lc};
  Point(476) = {  1.89000000,  3.93500000, 0, lc};
  Point(477) = {  1.89000000,  4.88500000, 0, lc};
  Circle(630) = {477,473,475};
  Circle(631) = {475,473,476};
  Circle(632) = {476,473,474};
  Circle(633) = {474,473,477};
  Line Loop(634) = {630,631,632,633};   // clad surface

  Point(478) = {  1.47200000,  4.41000000, 0, lc};
  Point(479) = {  2.30800000,  4.41000000, 0, lc};
  Point(480) = {  1.89000000,  3.99200000, 0, lc};
  Point(481) = {  1.89000000,  4.82800000, 0, lc};
  Circle(635) = {481,473,479};
  Circle(636) = {479,473,480};
  Circle(637) = {480,473,478};
  Circle(638) = {478,473,481};
  Line Loop(639) = {635,636,637,638};   // fuel surface

// define rod regions
  Plane Surface(640) = {634,639};   // clad region
  Plane Surface(641) = {639};      // fuel region
  Physical Surface("RegClad0204")={640};   // pin clad
  Physical Surface("RegFuel0204")={641};   // pin fuel

// ==============================
//    define rod 3,4

  Point(482) = {  3.15000000,  4.41000000, 0, lc};

  Point(483) = {  2.67500000,  4.41000000, 0, lc};
  Point(484) = {  3.62500000,  4.41000000, 0, lc};
  Point(485) = {  3.15000000,  3.93500000, 0, lc};
  Point(486) = {  3.15000000,  4.88500000, 0, lc};
  Circle(642) = {486,482,484};
  Circle(643) = {484,482,485};
  Circle(644) = {485,482,483};
  Circle(645) = {483,482,486};
  Line Loop(646) = {642,643,644,645};   // clad surface

  Point(487) = {  2.73200000,  4.41000000, 0, lc};
  Point(488) = {  3.56800000,  4.41000000, 0, lc};
  Point(489) = {  3.15000000,  3.99200000, 0, lc};
  Point(490) = {  3.15000000,  4.82800000, 0, lc};
  Circle(647) = {490,482,488};
  Circle(648) = {488,482,489};
  Circle(649) = {489,482,487};
  Circle(650) = {487,482,490};
  Line Loop(651) = {647,648,649,650};   // fuel surface

// define rod regions
  Plane Surface(652) = {646,651};   // clad region
  Plane Surface(653) = {651};      // fuel region
  Physical Surface("RegClad0304")={652};   // pin clad
  Physical Surface("RegFuel0304")={653};   // pin fuel

// ==============================
//    define rod 4,4

  Point(491) = {  4.41000000,  4.41000000, 0, lc};

  Point(492) = {  3.93500000,  4.41000000, 0, lc};
  Point(493) = {  4.88500000,  4.41000000, 0, lc};
  Point(494) = {  4.41000000,  3.93500000, 0, lc};
  Point(495) = {  4.41000000,  4.88500000, 0, lc};
  Circle(654) = {495,491,493};
  Circle(655) = {493,491,494};
  Circle(656) = {494,491,492};
  Circle(657) = {492,491,495};
  Line Loop(658) = {654,655,656,657};   // clad surface

  Point(496) = {  3.99200000,  4.41000000, 0, lc};
  Point(497) = {  4.82800000,  4.41000000, 0, lc};
  Point(498) = {  4.41000000,  3.99200000, 0, lc};
  Point(499) = {  4.41000000,  4.82800000, 0, lc};
  Circle(659) = {499,491,497};
  Circle(660) = {497,491,498};
  Circle(661) = {498,491,496};
  Circle(662) = {496,491,499};
  Line Loop(663) = {659,660,661,662};   // fuel surface

// define rod regions
  Plane Surface(664) = {658,663};   // clad region
  Plane Surface(665) = {663};      // fuel region
  Physical Surface("RegClad0404")={664};   // pin clad
  Physical Surface("RegFuel0404")={665};   // pin fuel

// ==============================
//    define rod 5,4

  Point(500) = {  5.67000000,  4.41000000, 0, lc};

  Point(501) = {  5.19500000,  4.41000000, 0, lc};
  Point(502) = {  6.14500000,  4.41000000, 0, lc};
  Point(503) = {  5.67000000,  3.93500000, 0, lc};
  Point(504) = {  5.67000000,  4.88500000, 0, lc};
  Circle(666) = {504,500,502};
  Circle(667) = {502,500,503};
  Circle(668) = {503,500,501};
  Circle(669) = {501,500,504};
  Line Loop(670) = {666,667,668,669};   // clad surface

  Point(505) = {  5.25200000,  4.41000000, 0, lc};
  Point(506) = {  6.08800000,  4.41000000, 0, lc};
  Point(507) = {  5.67000000,  3.99200000, 0, lc};
  Point(508) = {  5.67000000,  4.82800000, 0, lc};
  Circle(671) = {508,500,506};
  Circle(672) = {506,500,507};
  Circle(673) = {507,500,505};
  Circle(674) = {505,500,508};
  Line Loop(675) = {671,672,673,674};   // fuel surface

// define rod regions
  Plane Surface(676) = {670,675};   // clad region
  Plane Surface(677) = {675};      // fuel region
  Physical Surface("RegClad0504")={676};   // pin clad
  Physical Surface("RegFuel0504")={677};   // pin fuel

// ==============================
//    define rod 6,4

  Point(509) = {  6.93000000,  4.41000000, 0, lc};

  Point(510) = {  6.45500000,  4.41000000, 0, lc};
  Point(511) = {  7.40500000,  4.41000000, 0, lc};
  Point(512) = {  6.93000000,  3.93500000, 0, lc};
  Point(513) = {  6.93000000,  4.88500000, 0, lc};
  Circle(678) = {513,509,511};
  Circle(679) = {511,509,512};
  Circle(680) = {512,509,510};
  Circle(681) = {510,509,513};
  Line Loop(682) = {678,679,680,681};   // clad surface

  Point(514) = {  6.51200000,  4.41000000, 0, lc};
  Point(515) = {  7.34800000,  4.41000000, 0, lc};
  Point(516) = {  6.93000000,  3.99200000, 0, lc};
  Point(517) = {  6.93000000,  4.82800000, 0, lc};
  Circle(683) = {517,509,515};
  Circle(684) = {515,509,516};
  Circle(685) = {516,509,514};
  Circle(686) = {514,509,517};
  Line Loop(687) = {683,684,685,686};   // fuel surface

// define rod regions
  Plane Surface(688) = {682,687};   // clad region
  Plane Surface(689) = {687};      // fuel region
  Physical Surface("RegClad0604")={688};   // pin clad
  Physical Surface("RegFuel0604")={689};   // pin fuel

// ==============================
//    define rod 7,4

  Point(518) = {  8.19000000,  4.41000000, 0, lc};

  Point(519) = {  7.71500000,  4.41000000, 0, lc};
  Point(520) = {  8.66500000,  4.41000000, 0, lc};
  Point(521) = {  8.19000000,  3.93500000, 0, lc};
  Point(522) = {  8.19000000,  4.88500000, 0, lc};
  Circle(690) = {522,518,520};
  Circle(691) = {520,518,521};
  Circle(692) = {521,518,519};
  Circle(693) = {519,518,522};
  Line Loop(694) = {690,691,692,693};   // clad surface

  Point(523) = {  7.77200000,  4.41000000, 0, lc};
  Point(524) = {  8.60800000,  4.41000000, 0, lc};
  Point(525) = {  8.19000000,  3.99200000, 0, lc};
  Point(526) = {  8.19000000,  4.82800000, 0, lc};
  Circle(695) = {526,518,524};
  Circle(696) = {524,518,525};
  Circle(697) = {525,518,523};
  Circle(698) = {523,518,526};
  Line Loop(699) = {695,696,697,698};   // fuel surface

// define rod regions
  Plane Surface(700) = {694,699};   // clad region
  Plane Surface(701) = {699};      // fuel region
  Physical Surface("RegClad0704")={700};   // pin clad
  Physical Surface("RegFuel0704")={701};   // pin fuel

// ==============================
//    define rod 8,4

  Point(527) = {  9.45000000,  4.41000000, 0, lc};

  Point(528) = {  8.97500000,  4.41000000, 0, lc};
  Point(529) = {  9.92500000,  4.41000000, 0, lc};
  Point(530) = {  9.45000000,  3.93500000, 0, lc};
  Point(531) = {  9.45000000,  4.88500000, 0, lc};
  Circle(702) = {531,527,529};
  Circle(703) = {529,527,530};
  Circle(704) = {530,527,528};
  Circle(705) = {528,527,531};
  Line Loop(706) = {702,703,704,705};   // clad surface

  Point(532) = {  9.03200000,  4.41000000, 0, lc};
  Point(533) = {  9.86800000,  4.41000000, 0, lc};
  Point(534) = {  9.45000000,  3.99200000, 0, lc};
  Point(535) = {  9.45000000,  4.82800000, 0, lc};
  Circle(707) = {535,527,533};
  Circle(708) = {533,527,534};
  Circle(709) = {534,527,532};
  Circle(710) = {532,527,535};
  Line Loop(711) = {707,708,709,710};   // fuel surface

// define rod regions
  Plane Surface(712) = {706,711};   // clad region
  Plane Surface(713) = {711};      // fuel region
  Physical Surface("RegClad0804")={712};   // pin clad
  Physical Surface("RegFuel0804")={713};   // pin fuel

// ==============================
//    define rod 9,4

  Point(536) = { 10.71000000,  4.41000000, 0, lc};

  Point(537) = { 10.23500000,  4.41000000, 0, lc};
  Point(538) = { 11.18500000,  4.41000000, 0, lc};
  Point(539) = { 10.71000000,  3.93500000, 0, lc};
  Point(540) = { 10.71000000,  4.88500000, 0, lc};
  Circle(714) = {540,536,538};
  Circle(715) = {538,536,539};
  Circle(716) = {539,536,537};
  Circle(717) = {537,536,540};
  Line Loop(718) = {714,715,716,717};   // clad surface

  Point(541) = { 10.29200000,  4.41000000, 0, lc};
  Point(542) = { 11.12800000,  4.41000000, 0, lc};
  Point(543) = { 10.71000000,  3.99200000, 0, lc};
  Point(544) = { 10.71000000,  4.82800000, 0, lc};
  Circle(719) = {544,536,542};
  Circle(720) = {542,536,543};
  Circle(721) = {543,536,541};
  Circle(722) = {541,536,544};
  Line Loop(723) = {719,720,721,722};   // fuel surface

// define rod regions
  Plane Surface(724) = {718,723};   // clad region
  Plane Surface(725) = {723};      // fuel region
  Physical Surface("RegClad0904")={724};   // pin clad
  Physical Surface("RegFuel0904")={725};   // pin fuel

// ==============================
//    define rod 10,4

  Point(545) = { 11.97000000,  4.41000000, 0, lc};

  Point(546) = { 11.49500000,  4.41000000, 0, lc};
  Point(547) = { 12.44500000,  4.41000000, 0, lc};
  Point(548) = { 11.97000000,  3.93500000, 0, lc};
  Point(549) = { 11.97000000,  4.88500000, 0, lc};
  Circle(726) = {549,545,547};
  Circle(727) = {547,545,548};
  Circle(728) = {548,545,546};
  Circle(729) = {546,545,549};
  Line Loop(730) = {726,727,728,729};   // clad surface

  Point(550) = { 11.55200000,  4.41000000, 0, lc};
  Point(551) = { 12.38800000,  4.41000000, 0, lc};
  Point(552) = { 11.97000000,  3.99200000, 0, lc};
  Point(553) = { 11.97000000,  4.82800000, 0, lc};
  Circle(731) = {553,545,551};
  Circle(732) = {551,545,552};
  Circle(733) = {552,545,550};
  Circle(734) = {550,545,553};
  Line Loop(735) = {731,732,733,734};   // fuel surface

// define rod regions
  Plane Surface(736) = {730,735};   // clad region
  Plane Surface(737) = {735};      // fuel region
  Physical Surface("RegClad1004")={736};   // pin clad
  Physical Surface("RegFuel1004")={737};   // pin fuel

// ==============================
//    define rod 11,4

  Point(554) = { 13.23000000,  4.41000000, 0, lc};

  Point(555) = { 12.75500000,  4.41000000, 0, lc};
  Point(556) = { 13.70500000,  4.41000000, 0, lc};
  Point(557) = { 13.23000000,  3.93500000, 0, lc};
  Point(558) = { 13.23000000,  4.88500000, 0, lc};
  Circle(738) = {558,554,556};
  Circle(739) = {556,554,557};
  Circle(740) = {557,554,555};
  Circle(741) = {555,554,558};
  Line Loop(742) = {738,739,740,741};   // clad surface

  Point(559) = { 12.81200000,  4.41000000, 0, lc};
  Point(560) = { 13.64800000,  4.41000000, 0, lc};
  Point(561) = { 13.23000000,  3.99200000, 0, lc};
  Point(562) = { 13.23000000,  4.82800000, 0, lc};
  Circle(743) = {562,554,560};
  Circle(744) = {560,554,561};
  Circle(745) = {561,554,559};
  Circle(746) = {559,554,562};
  Line Loop(747) = {743,744,745,746};   // fuel surface

// define rod regions
  Plane Surface(748) = {742,747};   // clad region
  Plane Surface(749) = {747};      // fuel region
  Physical Surface("RegClad1104")={748};   // pin clad
  Physical Surface("RegFuel1104")={749};   // pin fuel

// ==============================
//    define rod 12,4

  Point(563) = { 14.49000000,  4.41000000, 0, lc};

  Point(564) = { 14.01500000,  4.41000000, 0, lc};
  Point(565) = { 14.96500000,  4.41000000, 0, lc};
  Point(566) = { 14.49000000,  3.93500000, 0, lc};
  Point(567) = { 14.49000000,  4.88500000, 0, lc};
  Circle(750) = {567,563,565};
  Circle(751) = {565,563,566};
  Circle(752) = {566,563,564};
  Circle(753) = {564,563,567};
  Line Loop(754) = {750,751,752,753};   // clad surface

  Point(568) = { 14.07200000,  4.41000000, 0, lc};
  Point(569) = { 14.90800000,  4.41000000, 0, lc};
  Point(570) = { 14.49000000,  3.99200000, 0, lc};
  Point(571) = { 14.49000000,  4.82800000, 0, lc};
  Circle(755) = {571,563,569};
  Circle(756) = {569,563,570};
  Circle(757) = {570,563,568};
  Circle(758) = {568,563,571};
  Line Loop(759) = {755,756,757,758};   // fuel surface

// define rod regions
  Plane Surface(760) = {754,759};   // clad region
  Plane Surface(761) = {759};      // fuel region
  Physical Surface("RegClad1204")={760};   // pin clad
  Physical Surface("RegFuel1204")={761};   // pin fuel

// ==============================
//    define rod 13,4

  Point(572) = { 15.75000000,  4.41000000, 0, lc};

  Point(573) = { 15.27500000,  4.41000000, 0, lc};
  Point(574) = { 16.22500000,  4.41000000, 0, lc};
  Point(575) = { 15.75000000,  3.93500000, 0, lc};
  Point(576) = { 15.75000000,  4.88500000, 0, lc};
  Circle(762) = {576,572,574};
  Circle(763) = {574,572,575};
  Circle(764) = {575,572,573};
  Circle(765) = {573,572,576};
  Line Loop(766) = {762,763,764,765};   // clad surface

  Point(577) = { 15.33200000,  4.41000000, 0, lc};
  Point(578) = { 16.16800000,  4.41000000, 0, lc};
  Point(579) = { 15.75000000,  3.99200000, 0, lc};
  Point(580) = { 15.75000000,  4.82800000, 0, lc};
  Circle(767) = {580,572,578};
  Circle(768) = {578,572,579};
  Circle(769) = {579,572,577};
  Circle(770) = {577,572,580};
  Line Loop(771) = {767,768,769,770};   // fuel surface

// define rod regions
  Plane Surface(772) = {766,771};   // clad region
  Plane Surface(773) = {771};      // fuel region
  Physical Surface("RegClad1304")={772};   // pin clad
  Physical Surface("RegFuel1304")={773};   // pin fuel

// ==============================
//    define rod 14,4

  Point(581) = { 17.01000000,  4.41000000, 0, lc};

  Point(582) = { 16.53500000,  4.41000000, 0, lc};
  Point(583) = { 17.48500000,  4.41000000, 0, lc};
  Point(584) = { 17.01000000,  3.93500000, 0, lc};
  Point(585) = { 17.01000000,  4.88500000, 0, lc};
  Circle(774) = {585,581,583};
  Circle(775) = {583,581,584};
  Circle(776) = {584,581,582};
  Circle(777) = {582,581,585};
  Line Loop(778) = {774,775,776,777};   // clad surface

  Point(586) = { 16.59200000,  4.41000000, 0, lc};
  Point(587) = { 17.42800000,  4.41000000, 0, lc};
  Point(588) = { 17.01000000,  3.99200000, 0, lc};
  Point(589) = { 17.01000000,  4.82800000, 0, lc};
  Circle(779) = {589,581,587};
  Circle(780) = {587,581,588};
  Circle(781) = {588,581,586};
  Circle(782) = {586,581,589};
  Line Loop(783) = {779,780,781,782};   // fuel surface

// define rod regions
  Plane Surface(784) = {778,783};   // clad region
  Plane Surface(785) = {783};      // fuel region
  Physical Surface("RegClad1404")={784};   // pin clad
  Physical Surface("RegFuel1404")={785};   // pin fuel

// ==============================
//    define rod 15,4

  Point(590) = { 18.27000000,  4.41000000, 0, lc};

  Point(591) = { 17.79500000,  4.41000000, 0, lc};
  Point(592) = { 18.74500000,  4.41000000, 0, lc};
  Point(593) = { 18.27000000,  3.93500000, 0, lc};
  Point(594) = { 18.27000000,  4.88500000, 0, lc};
  Circle(786) = {594,590,592};
  Circle(787) = {592,590,593};
  Circle(788) = {593,590,591};
  Circle(789) = {591,590,594};
  Line Loop(790) = {786,787,788,789};   // clad surface

  Point(595) = { 17.85200000,  4.41000000, 0, lc};
  Point(596) = { 18.68800000,  4.41000000, 0, lc};
  Point(597) = { 18.27000000,  3.99200000, 0, lc};
  Point(598) = { 18.27000000,  4.82800000, 0, lc};
  Circle(791) = {598,590,596};
  Circle(792) = {596,590,597};
  Circle(793) = {597,590,595};
  Circle(794) = {595,590,598};
  Line Loop(795) = {791,792,793,794};   // fuel surface

// define rod regions
  Plane Surface(796) = {790,795};   // clad region
  Plane Surface(797) = {795};      // fuel region
  Physical Surface("RegClad1504")={796};   // pin clad
  Physical Surface("RegFuel1504")={797};   // pin fuel

// ==============================
//    define rod 16,4

  Point(599) = { 19.53000000,  4.41000000, 0, lc};

  Point(600) = { 19.05500000,  4.41000000, 0, lc};
  Point(601) = { 20.00500000,  4.41000000, 0, lc};
  Point(602) = { 19.53000000,  3.93500000, 0, lc};
  Point(603) = { 19.53000000,  4.88500000, 0, lc};
  Circle(798) = {603,599,601};
  Circle(799) = {601,599,602};
  Circle(800) = {602,599,600};
  Circle(801) = {600,599,603};
  Line Loop(802) = {798,799,800,801};   // clad surface

  Point(604) = { 19.11200000,  4.41000000, 0, lc};
  Point(605) = { 19.94800000,  4.41000000, 0, lc};
  Point(606) = { 19.53000000,  3.99200000, 0, lc};
  Point(607) = { 19.53000000,  4.82800000, 0, lc};
  Circle(803) = {607,599,605};
  Circle(804) = {605,599,606};
  Circle(805) = {606,599,604};
  Circle(806) = {604,599,607};
  Line Loop(807) = {803,804,805,806};   // fuel surface

// define rod regions
  Plane Surface(808) = {802,807};   // clad region
  Plane Surface(809) = {807};      // fuel region
  Physical Surface("RegClad1604")={808};   // pin clad
  Physical Surface("RegFuel1604")={809};   // pin fuel

// ==============================
//    define rod 17,4

  Point(608) = { 20.79000000,  4.41000000, 0, lc};

  Point(609) = { 20.31500000,  4.41000000, 0, lc};
  Point(610) = { 21.26500000,  4.41000000, 0, lc};
  Point(611) = { 20.79000000,  3.93500000, 0, lc};
  Point(612) = { 20.79000000,  4.88500000, 0, lc};
  Circle(810) = {612,608,610};
  Circle(811) = {610,608,611};
  Circle(812) = {611,608,609};
  Circle(813) = {609,608,612};
  Line Loop(814) = {810,811,812,813};   // clad surface

  Point(613) = { 20.37200000,  4.41000000, 0, lc};
  Point(614) = { 21.20800000,  4.41000000, 0, lc};
  Point(615) = { 20.79000000,  3.99200000, 0, lc};
  Point(616) = { 20.79000000,  4.82800000, 0, lc};
  Circle(815) = {616,608,614};
  Circle(816) = {614,608,615};
  Circle(817) = {615,608,613};
  Circle(818) = {613,608,616};
  Line Loop(819) = {815,816,817,818};   // fuel surface

// define rod regions
  Plane Surface(820) = {814,819};   // clad region
  Plane Surface(821) = {819};      // fuel region
  Physical Surface("RegClad1704")={820};   // pin clad
  Physical Surface("RegFuel1704")={821};   // pin fuel

// ==============================
//    define rod 1,5

  Point(617) = {  0.63000000,  5.67000000, 0, lc};

  Point(618) = {  0.15500000,  5.67000000, 0, lc};
  Point(619) = {  1.10500000,  5.67000000, 0, lc};
  Point(620) = {  0.63000000,  5.19500000, 0, lc};
  Point(621) = {  0.63000000,  6.14500000, 0, lc};
  Circle(822) = {621,617,619};
  Circle(823) = {619,617,620};
  Circle(824) = {620,617,618};
  Circle(825) = {618,617,621};
  Line Loop(826) = {822,823,824,825};   // clad surface

  Point(622) = {  0.21200000,  5.67000000, 0, lc};
  Point(623) = {  1.04800000,  5.67000000, 0, lc};
  Point(624) = {  0.63000000,  5.25200000, 0, lc};
  Point(625) = {  0.63000000,  6.08800000, 0, lc};
  Circle(827) = {625,617,623};
  Circle(828) = {623,617,624};
  Circle(829) = {624,617,622};
  Circle(830) = {622,617,625};
  Line Loop(831) = {827,828,829,830};   // fuel surface

// define rod regions
  Plane Surface(832) = {826,831};   // clad region
  Plane Surface(833) = {831};      // fuel region
  Physical Surface("RegClad0105")={832};   // pin clad
  Physical Surface("RegFuel0105")={833};   // pin fuel

// ==============================
//    define rod 2,5

  Point(626) = {  1.89000000,  5.67000000, 0, lc};

  Point(627) = {  1.41500000,  5.67000000, 0, lc};
  Point(628) = {  2.36500000,  5.67000000, 0, lc};
  Point(629) = {  1.89000000,  5.19500000, 0, lc};
  Point(630) = {  1.89000000,  6.14500000, 0, lc};
  Circle(834) = {630,626,628};
  Circle(835) = {628,626,629};
  Circle(836) = {629,626,627};
  Circle(837) = {627,626,630};
  Line Loop(838) = {834,835,836,837};   // clad surface

  Point(631) = {  1.47200000,  5.67000000, 0, lc};
  Point(632) = {  2.30800000,  5.67000000, 0, lc};
  Point(633) = {  1.89000000,  5.25200000, 0, lc};
  Point(634) = {  1.89000000,  6.08800000, 0, lc};
  Circle(839) = {634,626,632};
  Circle(840) = {632,626,633};
  Circle(841) = {633,626,631};
  Circle(842) = {631,626,634};
  Line Loop(843) = {839,840,841,842};   // fuel surface

// define rod regions
  Plane Surface(844) = {838,843};   // clad region
  Plane Surface(845) = {843};      // fuel region
  Physical Surface("RegClad0205")={844};   // pin clad
  Physical Surface("RegFuel0205")={845};   // pin fuel

// ==============================
//    define rod 3,5

  Point(635) = {  3.15000000,  5.67000000, 0, lc};

  Point(636) = {  2.67500000,  5.67000000, 0, lc};
  Point(637) = {  3.62500000,  5.67000000, 0, lc};
  Point(638) = {  3.15000000,  5.19500000, 0, lc};
  Point(639) = {  3.15000000,  6.14500000, 0, lc};
  Circle(846) = {639,635,637};
  Circle(847) = {637,635,638};
  Circle(848) = {638,635,636};
  Circle(849) = {636,635,639};
  Line Loop(850) = {846,847,848,849};   // clad surface

  Point(640) = {  2.73200000,  5.67000000, 0, lc};
  Point(641) = {  3.56800000,  5.67000000, 0, lc};
  Point(642) = {  3.15000000,  5.25200000, 0, lc};
  Point(643) = {  3.15000000,  6.08800000, 0, lc};
  Circle(851) = {643,635,641};
  Circle(852) = {641,635,642};
  Circle(853) = {642,635,640};
  Circle(854) = {640,635,643};
  Line Loop(855) = {851,852,853,854};   // fuel surface

// define rod regions
  Plane Surface(856) = {850,855};   // clad region
  Plane Surface(857) = {855};      // fuel region
  Physical Surface("RegClad0305")={856};   // pin clad
  Physical Surface("RegFuel0305")={857};   // pin fuel

// ==============================
//    define rod 4,5

  Point(644) = {  4.41000000,  5.67000000, 0, lc};

  Point(645) = {  3.93500000,  5.67000000, 0, lc};
  Point(646) = {  4.88500000,  5.67000000, 0, lc};
  Point(647) = {  4.41000000,  5.19500000, 0, lc};
  Point(648) = {  4.41000000,  6.14500000, 0, lc};
  Circle(858) = {648,644,646};
  Circle(859) = {646,644,647};
  Circle(860) = {647,644,645};
  Circle(861) = {645,644,648};
  Line Loop(862) = {858,859,860,861};   // clad surface

  Point(649) = {  3.99200000,  5.67000000, 0, lc};
  Point(650) = {  4.82800000,  5.67000000, 0, lc};
  Point(651) = {  4.41000000,  5.25200000, 0, lc};
  Point(652) = {  4.41000000,  6.08800000, 0, lc};
  Circle(863) = {652,644,650};
  Circle(864) = {650,644,651};
  Circle(865) = {651,644,649};
  Circle(866) = {649,644,652};
  Line Loop(867) = {863,864,865,866};   // fuel surface

// define rod regions
  Plane Surface(868) = {862,867};   // clad region
  Plane Surface(869) = {867};      // fuel region
  Physical Surface("RegClad0405")={868};   // pin clad
  Physical Surface("RegFuel0405")={869};   // pin fuel

// ==============================
//    define rod 5,5

  Point(653) = {  5.67000000,  5.67000000, 0, lc};

  Point(654) = {  5.19500000,  5.67000000, 0, lc};
  Point(655) = {  6.14500000,  5.67000000, 0, lc};
  Point(656) = {  5.67000000,  5.19500000, 0, lc};
  Point(657) = {  5.67000000,  6.14500000, 0, lc};
  Circle(870) = {657,653,655};
  Circle(871) = {655,653,656};
  Circle(872) = {656,653,654};
  Circle(873) = {654,653,657};
  Line Loop(874) = {870,871,872,873};   // clad surface

  Point(658) = {  5.25200000,  5.67000000, 0, lc};
  Point(659) = {  6.08800000,  5.67000000, 0, lc};
  Point(660) = {  5.67000000,  5.25200000, 0, lc};
  Point(661) = {  5.67000000,  6.08800000, 0, lc};
  Circle(875) = {661,653,659};
  Circle(876) = {659,653,660};
  Circle(877) = {660,653,658};
  Circle(878) = {658,653,661};
  Line Loop(879) = {875,876,877,878};   // fuel surface

// define rod regions
  Plane Surface(880) = {874,879};   // clad region
  Plane Surface(881) = {879};      // fuel region
  Physical Surface("RegClad0505")={880};   // pin clad
  Physical Surface("RegFuel0505")={881};   // pin fuel

// ==============================
//    define rod 6,5

  Point(662) = {  6.93000000,  5.67000000, 0, lc};

  Point(663) = {  6.45500000,  5.67000000, 0, lc};
  Point(664) = {  7.40500000,  5.67000000, 0, lc};
  Point(665) = {  6.93000000,  5.19500000, 0, lc};
  Point(666) = {  6.93000000,  6.14500000, 0, lc};
  Circle(882) = {666,662,664};
  Circle(883) = {664,662,665};
  Circle(884) = {665,662,663};
  Circle(885) = {663,662,666};
  Line Loop(886) = {882,883,884,885};   // clad surface

  Point(667) = {  6.51200000,  5.67000000, 0, lc};
  Point(668) = {  7.34800000,  5.67000000, 0, lc};
  Point(669) = {  6.93000000,  5.25200000, 0, lc};
  Point(670) = {  6.93000000,  6.08800000, 0, lc};
  Circle(887) = {670,662,668};
  Circle(888) = {668,662,669};
  Circle(889) = {669,662,667};
  Circle(890) = {667,662,670};
  Line Loop(891) = {887,888,889,890};   // fuel surface

// define rod regions
  Plane Surface(892) = {886,891};   // clad region
  Plane Surface(893) = {891};      // fuel region
  Physical Surface("RegClad0605")={892};   // pin clad
  Physical Surface("RegFuel0605")={893};   // pin fuel

// ==============================
//    define rod 7,5

  Point(671) = {  8.19000000,  5.67000000, 0, lc};

  Point(672) = {  7.71500000,  5.67000000, 0, lc};
  Point(673) = {  8.66500000,  5.67000000, 0, lc};
  Point(674) = {  8.19000000,  5.19500000, 0, lc};
  Point(675) = {  8.19000000,  6.14500000, 0, lc};
  Circle(894) = {675,671,673};
  Circle(895) = {673,671,674};
  Circle(896) = {674,671,672};
  Circle(897) = {672,671,675};
  Line Loop(898) = {894,895,896,897};   // clad surface

  Point(676) = {  7.77200000,  5.67000000, 0, lc};
  Point(677) = {  8.60800000,  5.67000000, 0, lc};
  Point(678) = {  8.19000000,  5.25200000, 0, lc};
  Point(679) = {  8.19000000,  6.08800000, 0, lc};
  Circle(899) = {679,671,677};
  Circle(900) = {677,671,678};
  Circle(901) = {678,671,676};
  Circle(902) = {676,671,679};
  Line Loop(903) = {899,900,901,902};   // fuel surface

// define rod regions
  Plane Surface(904) = {898,903};   // clad region
  Plane Surface(905) = {903};      // fuel region
  Physical Surface("RegClad0705")={904};   // pin clad
  Physical Surface("RegFuel0705")={905};   // pin fuel

// ==============================
//    define rod 8,5

  Point(680) = {  9.45000000,  5.67000000, 0, lc};

  Point(681) = {  8.97500000,  5.67000000, 0, lc};
  Point(682) = {  9.92500000,  5.67000000, 0, lc};
  Point(683) = {  9.45000000,  5.19500000, 0, lc};
  Point(684) = {  9.45000000,  6.14500000, 0, lc};
  Circle(906) = {684,680,682};
  Circle(907) = {682,680,683};
  Circle(908) = {683,680,681};
  Circle(909) = {681,680,684};
  Line Loop(910) = {906,907,908,909};   // clad surface

  Point(685) = {  9.03200000,  5.67000000, 0, lc};
  Point(686) = {  9.86800000,  5.67000000, 0, lc};
  Point(687) = {  9.45000000,  5.25200000, 0, lc};
  Point(688) = {  9.45000000,  6.08800000, 0, lc};
  Circle(911) = {688,680,686};
  Circle(912) = {686,680,687};
  Circle(913) = {687,680,685};
  Circle(914) = {685,680,688};
  Line Loop(915) = {911,912,913,914};   // fuel surface

// define rod regions
  Plane Surface(916) = {910,915};   // clad region
  Plane Surface(917) = {915};      // fuel region
  Physical Surface("RegClad0805")={916};   // pin clad
  Physical Surface("RegFuel0805")={917};   // pin fuel

// ==============================
//    define rod 9,5

  Point(689) = { 10.71000000,  5.67000000, 0, lc};

  Point(690) = { 10.23500000,  5.67000000, 0, lc};
  Point(691) = { 11.18500000,  5.67000000, 0, lc};
  Point(692) = { 10.71000000,  5.19500000, 0, lc};
  Point(693) = { 10.71000000,  6.14500000, 0, lc};
  Circle(918) = {693,689,691};
  Circle(919) = {691,689,692};
  Circle(920) = {692,689,690};
  Circle(921) = {690,689,693};
  Line Loop(922) = {918,919,920,921};   // clad surface

  Point(694) = { 10.29200000,  5.67000000, 0, lc};
  Point(695) = { 11.12800000,  5.67000000, 0, lc};
  Point(696) = { 10.71000000,  5.25200000, 0, lc};
  Point(697) = { 10.71000000,  6.08800000, 0, lc};
  Circle(923) = {697,689,695};
  Circle(924) = {695,689,696};
  Circle(925) = {696,689,694};
  Circle(926) = {694,689,697};
  Line Loop(927) = {923,924,925,926};   // fuel surface

// define rod regions
  Plane Surface(928) = {922,927};   // clad region
  Plane Surface(929) = {927};      // fuel region
  Physical Surface("RegClad0905")={928};   // pin clad
  Physical Surface("RegFuel0905")={929};   // pin fuel

// ==============================
//    define rod 10,5

  Point(698) = { 11.97000000,  5.67000000, 0, lc};

  Point(699) = { 11.49500000,  5.67000000, 0, lc};
  Point(700) = { 12.44500000,  5.67000000, 0, lc};
  Point(701) = { 11.97000000,  5.19500000, 0, lc};
  Point(702) = { 11.97000000,  6.14500000, 0, lc};
  Circle(930) = {702,698,700};
  Circle(931) = {700,698,701};
  Circle(932) = {701,698,699};
  Circle(933) = {699,698,702};
  Line Loop(934) = {930,931,932,933};   // clad surface

  Point(703) = { 11.55200000,  5.67000000, 0, lc};
  Point(704) = { 12.38800000,  5.67000000, 0, lc};
  Point(705) = { 11.97000000,  5.25200000, 0, lc};
  Point(706) = { 11.97000000,  6.08800000, 0, lc};
  Circle(935) = {706,698,704};
  Circle(936) = {704,698,705};
  Circle(937) = {705,698,703};
  Circle(938) = {703,698,706};
  Line Loop(939) = {935,936,937,938};   // fuel surface

// define rod regions
  Plane Surface(940) = {934,939};   // clad region
  Plane Surface(941) = {939};      // fuel region
  Physical Surface("RegClad1005")={940};   // pin clad
  Physical Surface("RegFuel1005")={941};   // pin fuel

// ==============================
//    define rod 11,5

  Point(707) = { 13.23000000,  5.67000000, 0, lc};

  Point(708) = { 12.75500000,  5.67000000, 0, lc};
  Point(709) = { 13.70500000,  5.67000000, 0, lc};
  Point(710) = { 13.23000000,  5.19500000, 0, lc};
  Point(711) = { 13.23000000,  6.14500000, 0, lc};
  Circle(942) = {711,707,709};
  Circle(943) = {709,707,710};
  Circle(944) = {710,707,708};
  Circle(945) = {708,707,711};
  Line Loop(946) = {942,943,944,945};   // clad surface

  Point(712) = { 12.81200000,  5.67000000, 0, lc};
  Point(713) = { 13.64800000,  5.67000000, 0, lc};
  Point(714) = { 13.23000000,  5.25200000, 0, lc};
  Point(715) = { 13.23000000,  6.08800000, 0, lc};
  Circle(947) = {715,707,713};
  Circle(948) = {713,707,714};
  Circle(949) = {714,707,712};
  Circle(950) = {712,707,715};
  Line Loop(951) = {947,948,949,950};   // fuel surface

// define rod regions
  Plane Surface(952) = {946,951};   // clad region
  Plane Surface(953) = {951};      // fuel region
  Physical Surface("RegClad1105")={952};   // pin clad
  Physical Surface("RegFuel1105")={953};   // pin fuel

// ==============================
//    define rod 12,5

  Point(716) = { 14.49000000,  5.67000000, 0, lc};

  Point(717) = { 14.01500000,  5.67000000, 0, lc};
  Point(718) = { 14.96500000,  5.67000000, 0, lc};
  Point(719) = { 14.49000000,  5.19500000, 0, lc};
  Point(720) = { 14.49000000,  6.14500000, 0, lc};
  Circle(954) = {720,716,718};
  Circle(955) = {718,716,719};
  Circle(956) = {719,716,717};
  Circle(957) = {717,716,720};
  Line Loop(958) = {954,955,956,957};   // clad surface

  Point(721) = { 14.07200000,  5.67000000, 0, lc};
  Point(722) = { 14.90800000,  5.67000000, 0, lc};
  Point(723) = { 14.49000000,  5.25200000, 0, lc};
  Point(724) = { 14.49000000,  6.08800000, 0, lc};
  Circle(959) = {724,716,722};
  Circle(960) = {722,716,723};
  Circle(961) = {723,716,721};
  Circle(962) = {721,716,724};
  Line Loop(963) = {959,960,961,962};   // fuel surface

// define rod regions
  Plane Surface(964) = {958,963};   // clad region
  Plane Surface(965) = {963};      // fuel region
  Physical Surface("RegClad1205")={964};   // pin clad
  Physical Surface("RegFuel1205")={965};   // pin fuel

// ==============================
//    define rod 13,5

  Point(725) = { 15.75000000,  5.67000000, 0, lc};

  Point(726) = { 15.27500000,  5.67000000, 0, lc};
  Point(727) = { 16.22500000,  5.67000000, 0, lc};
  Point(728) = { 15.75000000,  5.19500000, 0, lc};
  Point(729) = { 15.75000000,  6.14500000, 0, lc};
  Circle(966) = {729,725,727};
  Circle(967) = {727,725,728};
  Circle(968) = {728,725,726};
  Circle(969) = {726,725,729};
  Line Loop(970) = {966,967,968,969};   // clad surface

  Point(730) = { 15.33200000,  5.67000000, 0, lc};
  Point(731) = { 16.16800000,  5.67000000, 0, lc};
  Point(732) = { 15.75000000,  5.25200000, 0, lc};
  Point(733) = { 15.75000000,  6.08800000, 0, lc};
  Circle(971) = {733,725,731};
  Circle(972) = {731,725,732};
  Circle(973) = {732,725,730};
  Circle(974) = {730,725,733};
  Line Loop(975) = {971,972,973,974};   // fuel surface

// define rod regions
  Plane Surface(976) = {970,975};   // clad region
  Plane Surface(977) = {975};      // fuel region
  Physical Surface("RegClad1305")={976};   // pin clad
  Physical Surface("RegFuel1305")={977};   // pin fuel

// ==============================
//    define rod 14,5

  Point(734) = { 17.01000000,  5.67000000, 0, lc};

  Point(735) = { 16.53500000,  5.67000000, 0, lc};
  Point(736) = { 17.48500000,  5.67000000, 0, lc};
  Point(737) = { 17.01000000,  5.19500000, 0, lc};
  Point(738) = { 17.01000000,  6.14500000, 0, lc};
  Circle(978) = {738,734,736};
  Circle(979) = {736,734,737};
  Circle(980) = {737,734,735};
  Circle(981) = {735,734,738};
  Line Loop(982) = {978,979,980,981};   // clad surface

  Point(739) = { 16.59200000,  5.67000000, 0, lc};
  Point(740) = { 17.42800000,  5.67000000, 0, lc};
  Point(741) = { 17.01000000,  5.25200000, 0, lc};
  Point(742) = { 17.01000000,  6.08800000, 0, lc};
  Circle(983) = {742,734,740};
  Circle(984) = {740,734,741};
  Circle(985) = {741,734,739};
  Circle(986) = {739,734,742};
  Line Loop(987) = {983,984,985,986};   // fuel surface

// define rod regions
  Plane Surface(988) = {982,987};   // clad region
  Plane Surface(989) = {987};      // fuel region
  Physical Surface("RegClad1405")={988};   // pin clad
  Physical Surface("RegFuel1405")={989};   // pin fuel

// ==============================
//    define rod 15,5

  Point(743) = { 18.27000000,  5.67000000, 0, lc};

  Point(744) = { 17.79500000,  5.67000000, 0, lc};
  Point(745) = { 18.74500000,  5.67000000, 0, lc};
  Point(746) = { 18.27000000,  5.19500000, 0, lc};
  Point(747) = { 18.27000000,  6.14500000, 0, lc};
  Circle(990) = {747,743,745};
  Circle(991) = {745,743,746};
  Circle(992) = {746,743,744};
  Circle(993) = {744,743,747};
  Line Loop(994) = {990,991,992,993};   // clad surface

  Point(748) = { 17.85200000,  5.67000000, 0, lc};
  Point(749) = { 18.68800000,  5.67000000, 0, lc};
  Point(750) = { 18.27000000,  5.25200000, 0, lc};
  Point(751) = { 18.27000000,  6.08800000, 0, lc};
  Circle(995) = {751,743,749};
  Circle(996) = {749,743,750};
  Circle(997) = {750,743,748};
  Circle(998) = {748,743,751};
  Line Loop(999) = {995,996,997,998};   // fuel surface

// define rod regions
  Plane Surface(1000) = {994,999};   // clad region
  Plane Surface(1001) = {999};      // fuel region
  Physical Surface("RegClad1505")={1000};   // pin clad
  Physical Surface("RegFuel1505")={1001};   // pin fuel

// ==============================
//    define rod 16,5

  Point(752) = { 19.53000000,  5.67000000, 0, lc};

  Point(753) = { 19.05500000,  5.67000000, 0, lc};
  Point(754) = { 20.00500000,  5.67000000, 0, lc};
  Point(755) = { 19.53000000,  5.19500000, 0, lc};
  Point(756) = { 19.53000000,  6.14500000, 0, lc};
  Circle(1002) = {756,752,754};
  Circle(1003) = {754,752,755};
  Circle(1004) = {755,752,753};
  Circle(1005) = {753,752,756};
  Line Loop(1006) = {1002,1003,1004,1005};   // clad surface

  Point(757) = { 19.11200000,  5.67000000, 0, lc};
  Point(758) = { 19.94800000,  5.67000000, 0, lc};
  Point(759) = { 19.53000000,  5.25200000, 0, lc};
  Point(760) = { 19.53000000,  6.08800000, 0, lc};
  Circle(1007) = {760,752,758};
  Circle(1008) = {758,752,759};
  Circle(1009) = {759,752,757};
  Circle(1010) = {757,752,760};
  Line Loop(1011) = {1007,1008,1009,1010};   // fuel surface

// define rod regions
  Plane Surface(1012) = {1006,1011};   // clad region
  Plane Surface(1013) = {1011};      // fuel region
  Physical Surface("RegClad1605")={1012};   // pin clad
  Physical Surface("RegFuel1605")={1013};   // pin fuel

// ==============================
//    define rod 17,5

  Point(761) = { 20.79000000,  5.67000000, 0, lc};

  Point(762) = { 20.31500000,  5.67000000, 0, lc};
  Point(763) = { 21.26500000,  5.67000000, 0, lc};
  Point(764) = { 20.79000000,  5.19500000, 0, lc};
  Point(765) = { 20.79000000,  6.14500000, 0, lc};
  Circle(1014) = {765,761,763};
  Circle(1015) = {763,761,764};
  Circle(1016) = {764,761,762};
  Circle(1017) = {762,761,765};
  Line Loop(1018) = {1014,1015,1016,1017};   // clad surface

  Point(766) = { 20.37200000,  5.67000000, 0, lc};
  Point(767) = { 21.20800000,  5.67000000, 0, lc};
  Point(768) = { 20.79000000,  5.25200000, 0, lc};
  Point(769) = { 20.79000000,  6.08800000, 0, lc};
  Circle(1019) = {769,761,767};
  Circle(1020) = {767,761,768};
  Circle(1021) = {768,761,766};
  Circle(1022) = {766,761,769};
  Line Loop(1023) = {1019,1020,1021,1022};   // fuel surface

// define rod regions
  Plane Surface(1024) = {1018,1023};   // clad region
  Plane Surface(1025) = {1023};      // fuel region
  Physical Surface("RegClad1705")={1024};   // pin clad
  Physical Surface("RegFuel1705")={1025};   // pin fuel

// ==============================
//    define rod 1,6

  Point(770) = {  0.63000000,  6.93000000, 0, lc};

  Point(771) = {  0.15500000,  6.93000000, 0, lc};
  Point(772) = {  1.10500000,  6.93000000, 0, lc};
  Point(773) = {  0.63000000,  6.45500000, 0, lc};
  Point(774) = {  0.63000000,  7.40500000, 0, lc};
  Circle(1026) = {774,770,772};
  Circle(1027) = {772,770,773};
  Circle(1028) = {773,770,771};
  Circle(1029) = {771,770,774};
  Line Loop(1030) = {1026,1027,1028,1029};   // clad surface

  Point(775) = {  0.21200000,  6.93000000, 0, lc};
  Point(776) = {  1.04800000,  6.93000000, 0, lc};
  Point(777) = {  0.63000000,  6.51200000, 0, lc};
  Point(778) = {  0.63000000,  7.34800000, 0, lc};
  Circle(1031) = {778,770,776};
  Circle(1032) = {776,770,777};
  Circle(1033) = {777,770,775};
  Circle(1034) = {775,770,778};
  Line Loop(1035) = {1031,1032,1033,1034};   // fuel surface

// define rod regions
  Plane Surface(1036) = {1030,1035};   // clad region
  Plane Surface(1037) = {1035};      // fuel region
  Physical Surface("RegClad0106")={1036};   // pin clad
  Physical Surface("RegFuel0106")={1037};   // pin fuel

// ==============================
//    define rod 2,6

  Point(779) = {  1.89000000,  6.93000000, 0, lc};

  Point(780) = {  1.41500000,  6.93000000, 0, lc};
  Point(781) = {  2.36500000,  6.93000000, 0, lc};
  Point(782) = {  1.89000000,  6.45500000, 0, lc};
  Point(783) = {  1.89000000,  7.40500000, 0, lc};
  Circle(1038) = {783,779,781};
  Circle(1039) = {781,779,782};
  Circle(1040) = {782,779,780};
  Circle(1041) = {780,779,783};
  Line Loop(1042) = {1038,1039,1040,1041};   // clad surface

  Point(784) = {  1.47200000,  6.93000000, 0, lc};
  Point(785) = {  2.30800000,  6.93000000, 0, lc};
  Point(786) = {  1.89000000,  6.51200000, 0, lc};
  Point(787) = {  1.89000000,  7.34800000, 0, lc};
  Circle(1043) = {787,779,785};
  Circle(1044) = {785,779,786};
  Circle(1045) = {786,779,784};
  Circle(1046) = {784,779,787};
  Line Loop(1047) = {1043,1044,1045,1046};   // fuel surface

// define rod regions
  Plane Surface(1048) = {1042,1047};   // clad region
  Plane Surface(1049) = {1047};      // fuel region
  Physical Surface("RegClad0206")={1048};   // pin clad
  Physical Surface("RegFuel0206")={1049};   // pin fuel

// ==============================
//    define rod 3,6

  Point(788) = {  3.15000000,  6.93000000, 0, lc};

  Point(789) = {  2.67500000,  6.93000000, 0, lc};
  Point(790) = {  3.62500000,  6.93000000, 0, lc};
  Point(791) = {  3.15000000,  6.45500000, 0, lc};
  Point(792) = {  3.15000000,  7.40500000, 0, lc};
  Circle(1050) = {792,788,790};
  Circle(1051) = {790,788,791};
  Circle(1052) = {791,788,789};
  Circle(1053) = {789,788,792};
  Line Loop(1054) = {1050,1051,1052,1053};   // clad surface

  Point(793) = {  2.73200000,  6.93000000, 0, lc};
  Point(794) = {  3.56800000,  6.93000000, 0, lc};
  Point(795) = {  3.15000000,  6.51200000, 0, lc};
  Point(796) = {  3.15000000,  7.34800000, 0, lc};
  Circle(1055) = {796,788,794};
  Circle(1056) = {794,788,795};
  Circle(1057) = {795,788,793};
  Circle(1058) = {793,788,796};
  Line Loop(1059) = {1055,1056,1057,1058};   // fuel surface

// define rod regions
  Plane Surface(1060) = {1054,1059};   // clad region
  Plane Surface(1061) = {1059};      // fuel region
  Physical Surface("RegClad0306")={1060};   // pin clad
  Physical Surface("RegFuel0306")={1061};   // pin fuel

// ==============================
//    define rod 4,6

  Point(797) = {  4.41000000,  6.93000000, 0, lc};

  Point(798) = {  3.93500000,  6.93000000, 0, lc};
  Point(799) = {  4.88500000,  6.93000000, 0, lc};
  Point(800) = {  4.41000000,  6.45500000, 0, lc};
  Point(801) = {  4.41000000,  7.40500000, 0, lc};
  Circle(1062) = {801,797,799};
  Circle(1063) = {799,797,800};
  Circle(1064) = {800,797,798};
  Circle(1065) = {798,797,801};
  Line Loop(1066) = {1062,1063,1064,1065};   // clad surface

  Point(802) = {  3.99200000,  6.93000000, 0, lc};
  Point(803) = {  4.82800000,  6.93000000, 0, lc};
  Point(804) = {  4.41000000,  6.51200000, 0, lc};
  Point(805) = {  4.41000000,  7.34800000, 0, lc};
  Circle(1067) = {805,797,803};
  Circle(1068) = {803,797,804};
  Circle(1069) = {804,797,802};
  Circle(1070) = {802,797,805};
  Line Loop(1071) = {1067,1068,1069,1070};   // fuel surface

// define rod regions
  Plane Surface(1072) = {1066,1071};   // clad region
  Plane Surface(1073) = {1071};      // fuel region
  Physical Surface("RegClad0406")={1072};   // pin clad
  Physical Surface("RegFuel0406")={1073};   // pin fuel

// ==============================
//    define rod 5,6

  Point(806) = {  5.67000000,  6.93000000, 0, lc};

  Point(807) = {  5.19500000,  6.93000000, 0, lc};
  Point(808) = {  6.14500000,  6.93000000, 0, lc};
  Point(809) = {  5.67000000,  6.45500000, 0, lc};
  Point(810) = {  5.67000000,  7.40500000, 0, lc};
  Circle(1074) = {810,806,808};
  Circle(1075) = {808,806,809};
  Circle(1076) = {809,806,807};
  Circle(1077) = {807,806,810};
  Line Loop(1078) = {1074,1075,1076,1077};   // clad surface

  Point(811) = {  5.25200000,  6.93000000, 0, lc};
  Point(812) = {  6.08800000,  6.93000000, 0, lc};
  Point(813) = {  5.67000000,  6.51200000, 0, lc};
  Point(814) = {  5.67000000,  7.34800000, 0, lc};
  Circle(1079) = {814,806,812};
  Circle(1080) = {812,806,813};
  Circle(1081) = {813,806,811};
  Circle(1082) = {811,806,814};
  Line Loop(1083) = {1079,1080,1081,1082};   // fuel surface

// define rod regions
  Plane Surface(1084) = {1078,1083};   // clad region
  Plane Surface(1085) = {1083};      // fuel region
  Physical Surface("RegClad0506")={1084};   // pin clad
  Physical Surface("RegFuel0506")={1085};   // pin fuel

// ==============================
//    define rod 6,6

  Point(815) = {  6.93000000,  6.93000000, 0, lc};

  Point(816) = {  6.45500000,  6.93000000, 0, lc};
  Point(817) = {  7.40500000,  6.93000000, 0, lc};
  Point(818) = {  6.93000000,  6.45500000, 0, lc};
  Point(819) = {  6.93000000,  7.40500000, 0, lc};
  Circle(1086) = {819,815,817};
  Circle(1087) = {817,815,818};
  Circle(1088) = {818,815,816};
  Circle(1089) = {816,815,819};
  Line Loop(1090) = {1086,1087,1088,1089};   // clad surface

  Point(820) = {  6.51200000,  6.93000000, 0, lc};
  Point(821) = {  7.34800000,  6.93000000, 0, lc};
  Point(822) = {  6.93000000,  6.51200000, 0, lc};
  Point(823) = {  6.93000000,  7.34800000, 0, lc};
  Circle(1091) = {823,815,821};
  Circle(1092) = {821,815,822};
  Circle(1093) = {822,815,820};
  Circle(1094) = {820,815,823};
  Line Loop(1095) = {1091,1092,1093,1094};   // fuel surface

// define rod regions
  Plane Surface(1096) = {1090,1095};   // clad region
  Plane Surface(1097) = {1095};      // fuel region
  Physical Surface("RegClad0606")={1096};   // pin clad
  Physical Surface("RegFuel0606")={1097};   // pin fuel

// ==============================
//    define rod 7,6

  Point(824) = {  8.19000000,  6.93000000, 0, lc};

  Point(825) = {  7.71500000,  6.93000000, 0, lc};
  Point(826) = {  8.66500000,  6.93000000, 0, lc};
  Point(827) = {  8.19000000,  6.45500000, 0, lc};
  Point(828) = {  8.19000000,  7.40500000, 0, lc};
  Circle(1098) = {828,824,826};
  Circle(1099) = {826,824,827};
  Circle(1100) = {827,824,825};
  Circle(1101) = {825,824,828};
  Line Loop(1102) = {1098,1099,1100,1101};   // clad surface

  Point(829) = {  7.77200000,  6.93000000, 0, lc};
  Point(830) = {  8.60800000,  6.93000000, 0, lc};
  Point(831) = {  8.19000000,  6.51200000, 0, lc};
  Point(832) = {  8.19000000,  7.34800000, 0, lc};
  Circle(1103) = {832,824,830};
  Circle(1104) = {830,824,831};
  Circle(1105) = {831,824,829};
  Circle(1106) = {829,824,832};
  Line Loop(1107) = {1103,1104,1105,1106};   // fuel surface

// define rod regions
  Plane Surface(1108) = {1102,1107};   // clad region
  Plane Surface(1109) = {1107};      // fuel region
  Physical Surface("RegClad0706")={1108};   // pin clad
  Physical Surface("RegFuel0706")={1109};   // pin fuel

// ==============================
//    define rod 8,6

  Point(833) = {  9.45000000,  6.93000000, 0, lc};

  Point(834) = {  8.97500000,  6.93000000, 0, lc};
  Point(835) = {  9.92500000,  6.93000000, 0, lc};
  Point(836) = {  9.45000000,  6.45500000, 0, lc};
  Point(837) = {  9.45000000,  7.40500000, 0, lc};
  Circle(1110) = {837,833,835};
  Circle(1111) = {835,833,836};
  Circle(1112) = {836,833,834};
  Circle(1113) = {834,833,837};
  Line Loop(1114) = {1110,1111,1112,1113};   // clad surface

  Point(838) = {  9.03200000,  6.93000000, 0, lc};
  Point(839) = {  9.86800000,  6.93000000, 0, lc};
  Point(840) = {  9.45000000,  6.51200000, 0, lc};
  Point(841) = {  9.45000000,  7.34800000, 0, lc};
  Circle(1115) = {841,833,839};
  Circle(1116) = {839,833,840};
  Circle(1117) = {840,833,838};
  Circle(1118) = {838,833,841};
  Line Loop(1119) = {1115,1116,1117,1118};   // fuel surface

// define rod regions
  Plane Surface(1120) = {1114,1119};   // clad region
  Plane Surface(1121) = {1119};      // fuel region
  Physical Surface("RegClad0806")={1120};   // pin clad
  Physical Surface("RegFuel0806")={1121};   // pin fuel

// ==============================
//    define rod 9,6

  Point(842) = { 10.71000000,  6.93000000, 0, lc};

  Point(843) = { 10.23500000,  6.93000000, 0, lc};
  Point(844) = { 11.18500000,  6.93000000, 0, lc};
  Point(845) = { 10.71000000,  6.45500000, 0, lc};
  Point(846) = { 10.71000000,  7.40500000, 0, lc};
  Circle(1122) = {846,842,844};
  Circle(1123) = {844,842,845};
  Circle(1124) = {845,842,843};
  Circle(1125) = {843,842,846};
  Line Loop(1126) = {1122,1123,1124,1125};   // clad surface

  Point(847) = { 10.29200000,  6.93000000, 0, lc};
  Point(848) = { 11.12800000,  6.93000000, 0, lc};
  Point(849) = { 10.71000000,  6.51200000, 0, lc};
  Point(850) = { 10.71000000,  7.34800000, 0, lc};
  Circle(1127) = {850,842,848};
  Circle(1128) = {848,842,849};
  Circle(1129) = {849,842,847};
  Circle(1130) = {847,842,850};
  Line Loop(1131) = {1127,1128,1129,1130};   // fuel surface

// define rod regions
  Plane Surface(1132) = {1126,1131};   // clad region
  Plane Surface(1133) = {1131};      // fuel region
  Physical Surface("RegClad0906")={1132};   // pin clad
  Physical Surface("RegFuel0906")={1133};   // pin fuel

// ==============================
//    define rod 10,6

  Point(851) = { 11.97000000,  6.93000000, 0, lc};

  Point(852) = { 11.49500000,  6.93000000, 0, lc};
  Point(853) = { 12.44500000,  6.93000000, 0, lc};
  Point(854) = { 11.97000000,  6.45500000, 0, lc};
  Point(855) = { 11.97000000,  7.40500000, 0, lc};
  Circle(1134) = {855,851,853};
  Circle(1135) = {853,851,854};
  Circle(1136) = {854,851,852};
  Circle(1137) = {852,851,855};
  Line Loop(1138) = {1134,1135,1136,1137};   // clad surface

  Point(856) = { 11.55200000,  6.93000000, 0, lc};
  Point(857) = { 12.38800000,  6.93000000, 0, lc};
  Point(858) = { 11.97000000,  6.51200000, 0, lc};
  Point(859) = { 11.97000000,  7.34800000, 0, lc};
  Circle(1139) = {859,851,857};
  Circle(1140) = {857,851,858};
  Circle(1141) = {858,851,856};
  Circle(1142) = {856,851,859};
  Line Loop(1143) = {1139,1140,1141,1142};   // fuel surface

// define rod regions
  Plane Surface(1144) = {1138,1143};   // clad region
  Plane Surface(1145) = {1143};      // fuel region
  Physical Surface("RegClad1006")={1144};   // pin clad
  Physical Surface("RegFuel1006")={1145};   // pin fuel

// ==============================
//    define rod 11,6

  Point(860) = { 13.23000000,  6.93000000, 0, lc};

  Point(861) = { 12.75500000,  6.93000000, 0, lc};
  Point(862) = { 13.70500000,  6.93000000, 0, lc};
  Point(863) = { 13.23000000,  6.45500000, 0, lc};
  Point(864) = { 13.23000000,  7.40500000, 0, lc};
  Circle(1146) = {864,860,862};
  Circle(1147) = {862,860,863};
  Circle(1148) = {863,860,861};
  Circle(1149) = {861,860,864};
  Line Loop(1150) = {1146,1147,1148,1149};   // clad surface

  Point(865) = { 12.81200000,  6.93000000, 0, lc};
  Point(866) = { 13.64800000,  6.93000000, 0, lc};
  Point(867) = { 13.23000000,  6.51200000, 0, lc};
  Point(868) = { 13.23000000,  7.34800000, 0, lc};
  Circle(1151) = {868,860,866};
  Circle(1152) = {866,860,867};
  Circle(1153) = {867,860,865};
  Circle(1154) = {865,860,868};
  Line Loop(1155) = {1151,1152,1153,1154};   // fuel surface

// define rod regions
  Plane Surface(1156) = {1150,1155};   // clad region
  Plane Surface(1157) = {1155};      // fuel region
  Physical Surface("RegClad1106")={1156};   // pin clad
  Physical Surface("RegFuel1106")={1157};   // pin fuel

// ==============================
//    define rod 12,6

  Point(869) = { 14.49000000,  6.93000000, 0, lc};

  Point(870) = { 14.01500000,  6.93000000, 0, lc};
  Point(871) = { 14.96500000,  6.93000000, 0, lc};
  Point(872) = { 14.49000000,  6.45500000, 0, lc};
  Point(873) = { 14.49000000,  7.40500000, 0, lc};
  Circle(1158) = {873,869,871};
  Circle(1159) = {871,869,872};
  Circle(1160) = {872,869,870};
  Circle(1161) = {870,869,873};
  Line Loop(1162) = {1158,1159,1160,1161};   // clad surface

  Point(874) = { 14.07200000,  6.93000000, 0, lc};
  Point(875) = { 14.90800000,  6.93000000, 0, lc};
  Point(876) = { 14.49000000,  6.51200000, 0, lc};
  Point(877) = { 14.49000000,  7.34800000, 0, lc};
  Circle(1163) = {877,869,875};
  Circle(1164) = {875,869,876};
  Circle(1165) = {876,869,874};
  Circle(1166) = {874,869,877};
  Line Loop(1167) = {1163,1164,1165,1166};   // fuel surface

// define rod regions
  Plane Surface(1168) = {1162,1167};   // clad region
  Plane Surface(1169) = {1167};      // fuel region
  Physical Surface("RegClad1206")={1168};   // pin clad
  Physical Surface("RegFuel1206")={1169};   // pin fuel

// ==============================
//    define rod 13,6

  Point(878) = { 15.75000000,  6.93000000, 0, lc};

  Point(879) = { 15.27500000,  6.93000000, 0, lc};
  Point(880) = { 16.22500000,  6.93000000, 0, lc};
  Point(881) = { 15.75000000,  6.45500000, 0, lc};
  Point(882) = { 15.75000000,  7.40500000, 0, lc};
  Circle(1170) = {882,878,880};
  Circle(1171) = {880,878,881};
  Circle(1172) = {881,878,879};
  Circle(1173) = {879,878,882};
  Line Loop(1174) = {1170,1171,1172,1173};   // clad surface

  Point(883) = { 15.33200000,  6.93000000, 0, lc};
  Point(884) = { 16.16800000,  6.93000000, 0, lc};
  Point(885) = { 15.75000000,  6.51200000, 0, lc};
  Point(886) = { 15.75000000,  7.34800000, 0, lc};
  Circle(1175) = {886,878,884};
  Circle(1176) = {884,878,885};
  Circle(1177) = {885,878,883};
  Circle(1178) = {883,878,886};
  Line Loop(1179) = {1175,1176,1177,1178};   // fuel surface

// define rod regions
  Plane Surface(1180) = {1174,1179};   // clad region
  Plane Surface(1181) = {1179};      // fuel region
  Physical Surface("RegClad1306")={1180};   // pin clad
  Physical Surface("RegFuel1306")={1181};   // pin fuel

// ==============================
//    define rod 14,6

  Point(887) = { 17.01000000,  6.93000000, 0, lc};

  Point(888) = { 16.53500000,  6.93000000, 0, lc};
  Point(889) = { 17.48500000,  6.93000000, 0, lc};
  Point(890) = { 17.01000000,  6.45500000, 0, lc};
  Point(891) = { 17.01000000,  7.40500000, 0, lc};
  Circle(1182) = {891,887,889};
  Circle(1183) = {889,887,890};
  Circle(1184) = {890,887,888};
  Circle(1185) = {888,887,891};
  Line Loop(1186) = {1182,1183,1184,1185};   // clad surface

  Point(892) = { 16.59200000,  6.93000000, 0, lc};
  Point(893) = { 17.42800000,  6.93000000, 0, lc};
  Point(894) = { 17.01000000,  6.51200000, 0, lc};
  Point(895) = { 17.01000000,  7.34800000, 0, lc};
  Circle(1187) = {895,887,893};
  Circle(1188) = {893,887,894};
  Circle(1189) = {894,887,892};
  Circle(1190) = {892,887,895};
  Line Loop(1191) = {1187,1188,1189,1190};   // fuel surface

// define rod regions
  Plane Surface(1192) = {1186,1191};   // clad region
  Plane Surface(1193) = {1191};      // fuel region
  Physical Surface("RegClad1406")={1192};   // pin clad
  Physical Surface("RegFuel1406")={1193};   // pin fuel

// ==============================
//    define rod 15,6

  Point(896) = { 18.27000000,  6.93000000, 0, lc};

  Point(897) = { 17.79500000,  6.93000000, 0, lc};
  Point(898) = { 18.74500000,  6.93000000, 0, lc};
  Point(899) = { 18.27000000,  6.45500000, 0, lc};
  Point(900) = { 18.27000000,  7.40500000, 0, lc};
  Circle(1194) = {900,896,898};
  Circle(1195) = {898,896,899};
  Circle(1196) = {899,896,897};
  Circle(1197) = {897,896,900};
  Line Loop(1198) = {1194,1195,1196,1197};   // clad surface

  Point(901) = { 17.85200000,  6.93000000, 0, lc};
  Point(902) = { 18.68800000,  6.93000000, 0, lc};
  Point(903) = { 18.27000000,  6.51200000, 0, lc};
  Point(904) = { 18.27000000,  7.34800000, 0, lc};
  Circle(1199) = {904,896,902};
  Circle(1200) = {902,896,903};
  Circle(1201) = {903,896,901};
  Circle(1202) = {901,896,904};
  Line Loop(1203) = {1199,1200,1201,1202};   // fuel surface

// define rod regions
  Plane Surface(1204) = {1198,1203};   // clad region
  Plane Surface(1205) = {1203};      // fuel region
  Physical Surface("RegClad1506")={1204};   // pin clad
  Physical Surface("RegFuel1506")={1205};   // pin fuel

// ==============================
//    define rod 16,6

  Point(905) = { 19.53000000,  6.93000000, 0, lc};

  Point(906) = { 19.05500000,  6.93000000, 0, lc};
  Point(907) = { 20.00500000,  6.93000000, 0, lc};
  Point(908) = { 19.53000000,  6.45500000, 0, lc};
  Point(909) = { 19.53000000,  7.40500000, 0, lc};
  Circle(1206) = {909,905,907};
  Circle(1207) = {907,905,908};
  Circle(1208) = {908,905,906};
  Circle(1209) = {906,905,909};
  Line Loop(1210) = {1206,1207,1208,1209};   // clad surface

  Point(910) = { 19.11200000,  6.93000000, 0, lc};
  Point(911) = { 19.94800000,  6.93000000, 0, lc};
  Point(912) = { 19.53000000,  6.51200000, 0, lc};
  Point(913) = { 19.53000000,  7.34800000, 0, lc};
  Circle(1211) = {913,905,911};
  Circle(1212) = {911,905,912};
  Circle(1213) = {912,905,910};
  Circle(1214) = {910,905,913};
  Line Loop(1215) = {1211,1212,1213,1214};   // fuel surface

// define rod regions
  Plane Surface(1216) = {1210,1215};   // clad region
  Plane Surface(1217) = {1215};      // fuel region
  Physical Surface("RegClad1606")={1216};   // pin clad
  Physical Surface("RegFuel1606")={1217};   // pin fuel

// ==============================
//    define rod 17,6

  Point(914) = { 20.79000000,  6.93000000, 0, lc};

  Point(915) = { 20.31500000,  6.93000000, 0, lc};
  Point(916) = { 21.26500000,  6.93000000, 0, lc};
  Point(917) = { 20.79000000,  6.45500000, 0, lc};
  Point(918) = { 20.79000000,  7.40500000, 0, lc};
  Circle(1218) = {918,914,916};
  Circle(1219) = {916,914,917};
  Circle(1220) = {917,914,915};
  Circle(1221) = {915,914,918};
  Line Loop(1222) = {1218,1219,1220,1221};   // clad surface

  Point(919) = { 20.37200000,  6.93000000, 0, lc};
  Point(920) = { 21.20800000,  6.93000000, 0, lc};
  Point(921) = { 20.79000000,  6.51200000, 0, lc};
  Point(922) = { 20.79000000,  7.34800000, 0, lc};
  Circle(1223) = {922,914,920};
  Circle(1224) = {920,914,921};
  Circle(1225) = {921,914,919};
  Circle(1226) = {919,914,922};
  Line Loop(1227) = {1223,1224,1225,1226};   // fuel surface

// define rod regions
  Plane Surface(1228) = {1222,1227};   // clad region
  Plane Surface(1229) = {1227};      // fuel region
  Physical Surface("RegClad1706")={1228};   // pin clad
  Physical Surface("RegFuel1706")={1229};   // pin fuel

// ==============================
//    define rod 1,7

  Point(923) = {  0.63000000,  8.19000000, 0, lc};

  Point(924) = {  0.15500000,  8.19000000, 0, lc};
  Point(925) = {  1.10500000,  8.19000000, 0, lc};
  Point(926) = {  0.63000000,  7.71500000, 0, lc};
  Point(927) = {  0.63000000,  8.66500000, 0, lc};
  Circle(1230) = {927,923,925};
  Circle(1231) = {925,923,926};
  Circle(1232) = {926,923,924};
  Circle(1233) = {924,923,927};
  Line Loop(1234) = {1230,1231,1232,1233};   // clad surface

  Point(928) = {  0.21200000,  8.19000000, 0, lc};
  Point(929) = {  1.04800000,  8.19000000, 0, lc};
  Point(930) = {  0.63000000,  7.77200000, 0, lc};
  Point(931) = {  0.63000000,  8.60800000, 0, lc};
  Circle(1235) = {931,923,929};
  Circle(1236) = {929,923,930};
  Circle(1237) = {930,923,928};
  Circle(1238) = {928,923,931};
  Line Loop(1239) = {1235,1236,1237,1238};   // fuel surface

// define rod regions
  Plane Surface(1240) = {1234,1239};   // clad region
  Plane Surface(1241) = {1239};      // fuel region
  Physical Surface("RegClad0107")={1240};   // pin clad
  Physical Surface("RegFuel0107")={1241};   // pin fuel

// ==============================
//    define rod 2,7

  Point(932) = {  1.89000000,  8.19000000, 0, lc};

  Point(933) = {  1.41500000,  8.19000000, 0, lc};
  Point(934) = {  2.36500000,  8.19000000, 0, lc};
  Point(935) = {  1.89000000,  7.71500000, 0, lc};
  Point(936) = {  1.89000000,  8.66500000, 0, lc};
  Circle(1242) = {936,932,934};
  Circle(1243) = {934,932,935};
  Circle(1244) = {935,932,933};
  Circle(1245) = {933,932,936};
  Line Loop(1246) = {1242,1243,1244,1245};   // clad surface

  Point(937) = {  1.47200000,  8.19000000, 0, lc};
  Point(938) = {  2.30800000,  8.19000000, 0, lc};
  Point(939) = {  1.89000000,  7.77200000, 0, lc};
  Point(940) = {  1.89000000,  8.60800000, 0, lc};
  Circle(1247) = {940,932,938};
  Circle(1248) = {938,932,939};
  Circle(1249) = {939,932,937};
  Circle(1250) = {937,932,940};
  Line Loop(1251) = {1247,1248,1249,1250};   // fuel surface

// define rod regions
  Plane Surface(1252) = {1246,1251};   // clad region
  Plane Surface(1253) = {1251};      // fuel region
  Physical Surface("RegClad0207")={1252};   // pin clad
  Physical Surface("RegFuel0207")={1253};   // pin fuel

// ==============================
//    define rod 3,7

  Point(941) = {  3.15000000,  8.19000000, 0, lc};

  Point(942) = {  2.67500000,  8.19000000, 0, lc};
  Point(943) = {  3.62500000,  8.19000000, 0, lc};
  Point(944) = {  3.15000000,  7.71500000, 0, lc};
  Point(945) = {  3.15000000,  8.66500000, 0, lc};
  Circle(1254) = {945,941,943};
  Circle(1255) = {943,941,944};
  Circle(1256) = {944,941,942};
  Circle(1257) = {942,941,945};
  Line Loop(1258) = {1254,1255,1256,1257};   // clad surface

  Point(946) = {  2.73200000,  8.19000000, 0, lc};
  Point(947) = {  3.56800000,  8.19000000, 0, lc};
  Point(948) = {  3.15000000,  7.77200000, 0, lc};
  Point(949) = {  3.15000000,  8.60800000, 0, lc};
  Circle(1259) = {949,941,947};
  Circle(1260) = {947,941,948};
  Circle(1261) = {948,941,946};
  Circle(1262) = {946,941,949};
  Line Loop(1263) = {1259,1260,1261,1262};   // fuel surface

// define rod regions
  Plane Surface(1264) = {1258,1263};   // clad region
  Plane Surface(1265) = {1263};      // fuel region
  Physical Surface("RegClad0307")={1264};   // pin clad
  Physical Surface("RegFuel0307")={1265};   // pin fuel

// ==============================
//    define rod 4,7

  Point(950) = {  4.41000000,  8.19000000, 0, lc};

  Point(951) = {  3.93500000,  8.19000000, 0, lc};
  Point(952) = {  4.88500000,  8.19000000, 0, lc};
  Point(953) = {  4.41000000,  7.71500000, 0, lc};
  Point(954) = {  4.41000000,  8.66500000, 0, lc};
  Circle(1266) = {954,950,952};
  Circle(1267) = {952,950,953};
  Circle(1268) = {953,950,951};
  Circle(1269) = {951,950,954};
  Line Loop(1270) = {1266,1267,1268,1269};   // clad surface

  Point(955) = {  3.99200000,  8.19000000, 0, lc};
  Point(956) = {  4.82800000,  8.19000000, 0, lc};
  Point(957) = {  4.41000000,  7.77200000, 0, lc};
  Point(958) = {  4.41000000,  8.60800000, 0, lc};
  Circle(1271) = {958,950,956};
  Circle(1272) = {956,950,957};
  Circle(1273) = {957,950,955};
  Circle(1274) = {955,950,958};
  Line Loop(1275) = {1271,1272,1273,1274};   // fuel surface

// define rod regions
  Plane Surface(1276) = {1270,1275};   // clad region
  Plane Surface(1277) = {1275};      // fuel region
  Physical Surface("RegClad0407")={1276};   // pin clad
  Physical Surface("RegFuel0407")={1277};   // pin fuel

// ==============================
//    define rod 5,7

  Point(959) = {  5.67000000,  8.19000000, 0, lc};

  Point(960) = {  5.19500000,  8.19000000, 0, lc};
  Point(961) = {  6.14500000,  8.19000000, 0, lc};
  Point(962) = {  5.67000000,  7.71500000, 0, lc};
  Point(963) = {  5.67000000,  8.66500000, 0, lc};
  Circle(1278) = {963,959,961};
  Circle(1279) = {961,959,962};
  Circle(1280) = {962,959,960};
  Circle(1281) = {960,959,963};
  Line Loop(1282) = {1278,1279,1280,1281};   // clad surface

  Point(964) = {  5.25200000,  8.19000000, 0, lc};
  Point(965) = {  6.08800000,  8.19000000, 0, lc};
  Point(966) = {  5.67000000,  7.77200000, 0, lc};
  Point(967) = {  5.67000000,  8.60800000, 0, lc};
  Circle(1283) = {967,959,965};
  Circle(1284) = {965,959,966};
  Circle(1285) = {966,959,964};
  Circle(1286) = {964,959,967};
  Line Loop(1287) = {1283,1284,1285,1286};   // fuel surface

// define rod regions
  Plane Surface(1288) = {1282,1287};   // clad region
  Plane Surface(1289) = {1287};      // fuel region
  Physical Surface("RegClad0507")={1288};   // pin clad
  Physical Surface("RegFuel0507")={1289};   // pin fuel

// ==============================
//    define rod 6,7

  Point(968) = {  6.93000000,  8.19000000, 0, lc};

  Point(969) = {  6.45500000,  8.19000000, 0, lc};
  Point(970) = {  7.40500000,  8.19000000, 0, lc};
  Point(971) = {  6.93000000,  7.71500000, 0, lc};
  Point(972) = {  6.93000000,  8.66500000, 0, lc};
  Circle(1290) = {972,968,970};
  Circle(1291) = {970,968,971};
  Circle(1292) = {971,968,969};
  Circle(1293) = {969,968,972};
  Line Loop(1294) = {1290,1291,1292,1293};   // clad surface

  Point(973) = {  6.51200000,  8.19000000, 0, lc};
  Point(974) = {  7.34800000,  8.19000000, 0, lc};
  Point(975) = {  6.93000000,  7.77200000, 0, lc};
  Point(976) = {  6.93000000,  8.60800000, 0, lc};
  Circle(1295) = {976,968,974};
  Circle(1296) = {974,968,975};
  Circle(1297) = {975,968,973};
  Circle(1298) = {973,968,976};
  Line Loop(1299) = {1295,1296,1297,1298};   // fuel surface

// define rod regions
  Plane Surface(1300) = {1294,1299};   // clad region
  Plane Surface(1301) = {1299};      // fuel region
  Physical Surface("RegClad0607")={1300};   // pin clad
  Physical Surface("RegFuel0607")={1301};   // pin fuel

// ==============================
//    define rod 7,7

  Point(977) = {  8.19000000,  8.19000000, 0, lc};

  Point(978) = {  7.71500000,  8.19000000, 0, lc};
  Point(979) = {  8.66500000,  8.19000000, 0, lc};
  Point(980) = {  8.19000000,  7.71500000, 0, lc};
  Point(981) = {  8.19000000,  8.66500000, 0, lc};
  Circle(1302) = {981,977,979};
  Circle(1303) = {979,977,980};
  Circle(1304) = {980,977,978};
  Circle(1305) = {978,977,981};
  Line Loop(1306) = {1302,1303,1304,1305};   // clad surface

  Point(982) = {  7.77200000,  8.19000000, 0, lc};
  Point(983) = {  8.60800000,  8.19000000, 0, lc};
  Point(984) = {  8.19000000,  7.77200000, 0, lc};
  Point(985) = {  8.19000000,  8.60800000, 0, lc};
  Circle(1307) = {985,977,983};
  Circle(1308) = {983,977,984};
  Circle(1309) = {984,977,982};
  Circle(1310) = {982,977,985};
  Line Loop(1311) = {1307,1308,1309,1310};   // fuel surface

// define rod regions
  Plane Surface(1312) = {1306,1311};   // clad region
  Plane Surface(1313) = {1311};      // fuel region
  Physical Surface("RegClad0707")={1312};   // pin clad
  Physical Surface("RegFuel0707")={1313};   // pin fuel

// ==============================
//    define rod 8,7

  Point(986) = {  9.45000000,  8.19000000, 0, lc};

  Point(987) = {  8.97500000,  8.19000000, 0, lc};
  Point(988) = {  9.92500000,  8.19000000, 0, lc};
  Point(989) = {  9.45000000,  7.71500000, 0, lc};
  Point(990) = {  9.45000000,  8.66500000, 0, lc};
  Circle(1314) = {990,986,988};
  Circle(1315) = {988,986,989};
  Circle(1316) = {989,986,987};
  Circle(1317) = {987,986,990};
  Line Loop(1318) = {1314,1315,1316,1317};   // clad surface

  Point(991) = {  9.03200000,  8.19000000, 0, lc};
  Point(992) = {  9.86800000,  8.19000000, 0, lc};
  Point(993) = {  9.45000000,  7.77200000, 0, lc};
  Point(994) = {  9.45000000,  8.60800000, 0, lc};
  Circle(1319) = {994,986,992};
  Circle(1320) = {992,986,993};
  Circle(1321) = {993,986,991};
  Circle(1322) = {991,986,994};
  Line Loop(1323) = {1319,1320,1321,1322};   // fuel surface

// define rod regions
  Plane Surface(1324) = {1318,1323};   // clad region
  Plane Surface(1325) = {1323};      // fuel region
  Physical Surface("RegClad0807")={1324};   // pin clad
  Physical Surface("RegFuel0807")={1325};   // pin fuel

// ==============================
//    define rod 9,7

  Point(995) = { 10.71000000,  8.19000000, 0, lc};

  Point(996) = { 10.23500000,  8.19000000, 0, lc};
  Point(997) = { 11.18500000,  8.19000000, 0, lc};
  Point(998) = { 10.71000000,  7.71500000, 0, lc};
  Point(999) = { 10.71000000,  8.66500000, 0, lc};
  Circle(1326) = {999,995,997};
  Circle(1327) = {997,995,998};
  Circle(1328) = {998,995,996};
  Circle(1329) = {996,995,999};
  Line Loop(1330) = {1326,1327,1328,1329};   // clad surface

  Point(1000) = { 10.29200000,  8.19000000, 0, lc};
  Point(1001) = { 11.12800000,  8.19000000, 0, lc};
  Point(1002) = { 10.71000000,  7.77200000, 0, lc};
  Point(1003) = { 10.71000000,  8.60800000, 0, lc};
  Circle(1331) = {1003,995,1001};
  Circle(1332) = {1001,995,1002};
  Circle(1333) = {1002,995,1000};
  Circle(1334) = {1000,995,1003};
  Line Loop(1335) = {1331,1332,1333,1334};   // fuel surface

// define rod regions
  Plane Surface(1336) = {1330,1335};   // clad region
  Plane Surface(1337) = {1335};      // fuel region
  Physical Surface("RegClad0907")={1336};   // pin clad
  Physical Surface("RegFuel0907")={1337};   // pin fuel

// ==============================
//    define rod 10,7

  Point(1004) = { 11.97000000,  8.19000000, 0, lc};

  Point(1005) = { 11.49500000,  8.19000000, 0, lc};
  Point(1006) = { 12.44500000,  8.19000000, 0, lc};
  Point(1007) = { 11.97000000,  7.71500000, 0, lc};
  Point(1008) = { 11.97000000,  8.66500000, 0, lc};
  Circle(1338) = {1008,1004,1006};
  Circle(1339) = {1006,1004,1007};
  Circle(1340) = {1007,1004,1005};
  Circle(1341) = {1005,1004,1008};
  Line Loop(1342) = {1338,1339,1340,1341};   // clad surface

  Point(1009) = { 11.55200000,  8.19000000, 0, lc};
  Point(1010) = { 12.38800000,  8.19000000, 0, lc};
  Point(1011) = { 11.97000000,  7.77200000, 0, lc};
  Point(1012) = { 11.97000000,  8.60800000, 0, lc};
  Circle(1343) = {1012,1004,1010};
  Circle(1344) = {1010,1004,1011};
  Circle(1345) = {1011,1004,1009};
  Circle(1346) = {1009,1004,1012};
  Line Loop(1347) = {1343,1344,1345,1346};   // fuel surface

// define rod regions
  Plane Surface(1348) = {1342,1347};   // clad region
  Plane Surface(1349) = {1347};      // fuel region
  Physical Surface("RegClad1007")={1348};   // pin clad
  Physical Surface("RegFuel1007")={1349};   // pin fuel

// ==============================
//    define rod 11,7

  Point(1013) = { 13.23000000,  8.19000000, 0, lc};

  Point(1014) = { 12.75500000,  8.19000000, 0, lc};
  Point(1015) = { 13.70500000,  8.19000000, 0, lc};
  Point(1016) = { 13.23000000,  7.71500000, 0, lc};
  Point(1017) = { 13.23000000,  8.66500000, 0, lc};
  Circle(1350) = {1017,1013,1015};
  Circle(1351) = {1015,1013,1016};
  Circle(1352) = {1016,1013,1014};
  Circle(1353) = {1014,1013,1017};
  Line Loop(1354) = {1350,1351,1352,1353};   // clad surface

  Point(1018) = { 12.81200000,  8.19000000, 0, lc};
  Point(1019) = { 13.64800000,  8.19000000, 0, lc};
  Point(1020) = { 13.23000000,  7.77200000, 0, lc};
  Point(1021) = { 13.23000000,  8.60800000, 0, lc};
  Circle(1355) = {1021,1013,1019};
  Circle(1356) = {1019,1013,1020};
  Circle(1357) = {1020,1013,1018};
  Circle(1358) = {1018,1013,1021};
  Line Loop(1359) = {1355,1356,1357,1358};   // fuel surface

// define rod regions
  Plane Surface(1360) = {1354,1359};   // clad region
  Plane Surface(1361) = {1359};      // fuel region
  Physical Surface("RegClad1107")={1360};   // pin clad
  Physical Surface("RegFuel1107")={1361};   // pin fuel

// ==============================
//    define rod 12,7

  Point(1022) = { 14.49000000,  8.19000000, 0, lc};

  Point(1023) = { 14.01500000,  8.19000000, 0, lc};
  Point(1024) = { 14.96500000,  8.19000000, 0, lc};
  Point(1025) = { 14.49000000,  7.71500000, 0, lc};
  Point(1026) = { 14.49000000,  8.66500000, 0, lc};
  Circle(1362) = {1026,1022,1024};
  Circle(1363) = {1024,1022,1025};
  Circle(1364) = {1025,1022,1023};
  Circle(1365) = {1023,1022,1026};
  Line Loop(1366) = {1362,1363,1364,1365};   // clad surface

  Point(1027) = { 14.07200000,  8.19000000, 0, lc};
  Point(1028) = { 14.90800000,  8.19000000, 0, lc};
  Point(1029) = { 14.49000000,  7.77200000, 0, lc};
  Point(1030) = { 14.49000000,  8.60800000, 0, lc};
  Circle(1367) = {1030,1022,1028};
  Circle(1368) = {1028,1022,1029};
  Circle(1369) = {1029,1022,1027};
  Circle(1370) = {1027,1022,1030};
  Line Loop(1371) = {1367,1368,1369,1370};   // fuel surface

// define rod regions
  Plane Surface(1372) = {1366,1371};   // clad region
  Plane Surface(1373) = {1371};      // fuel region
  Physical Surface("RegClad1207")={1372};   // pin clad
  Physical Surface("RegFuel1207")={1373};   // pin fuel

// ==============================
//    define rod 13,7

  Point(1031) = { 15.75000000,  8.19000000, 0, lc};

  Point(1032) = { 15.27500000,  8.19000000, 0, lc};
  Point(1033) = { 16.22500000,  8.19000000, 0, lc};
  Point(1034) = { 15.75000000,  7.71500000, 0, lc};
  Point(1035) = { 15.75000000,  8.66500000, 0, lc};
  Circle(1374) = {1035,1031,1033};
  Circle(1375) = {1033,1031,1034};
  Circle(1376) = {1034,1031,1032};
  Circle(1377) = {1032,1031,1035};
  Line Loop(1378) = {1374,1375,1376,1377};   // clad surface

  Point(1036) = { 15.33200000,  8.19000000, 0, lc};
  Point(1037) = { 16.16800000,  8.19000000, 0, lc};
  Point(1038) = { 15.75000000,  7.77200000, 0, lc};
  Point(1039) = { 15.75000000,  8.60800000, 0, lc};
  Circle(1379) = {1039,1031,1037};
  Circle(1380) = {1037,1031,1038};
  Circle(1381) = {1038,1031,1036};
  Circle(1382) = {1036,1031,1039};
  Line Loop(1383) = {1379,1380,1381,1382};   // fuel surface

// define rod regions
  Plane Surface(1384) = {1378,1383};   // clad region
  Plane Surface(1385) = {1383};      // fuel region
  Physical Surface("RegClad1307")={1384};   // pin clad
  Physical Surface("RegFuel1307")={1385};   // pin fuel

// ==============================
//    define rod 14,7

  Point(1040) = { 17.01000000,  8.19000000, 0, lc};

  Point(1041) = { 16.53500000,  8.19000000, 0, lc};
  Point(1042) = { 17.48500000,  8.19000000, 0, lc};
  Point(1043) = { 17.01000000,  7.71500000, 0, lc};
  Point(1044) = { 17.01000000,  8.66500000, 0, lc};
  Circle(1386) = {1044,1040,1042};
  Circle(1387) = {1042,1040,1043};
  Circle(1388) = {1043,1040,1041};
  Circle(1389) = {1041,1040,1044};
  Line Loop(1390) = {1386,1387,1388,1389};   // clad surface

  Point(1045) = { 16.59200000,  8.19000000, 0, lc};
  Point(1046) = { 17.42800000,  8.19000000, 0, lc};
  Point(1047) = { 17.01000000,  7.77200000, 0, lc};
  Point(1048) = { 17.01000000,  8.60800000, 0, lc};
  Circle(1391) = {1048,1040,1046};
  Circle(1392) = {1046,1040,1047};
  Circle(1393) = {1047,1040,1045};
  Circle(1394) = {1045,1040,1048};
  Line Loop(1395) = {1391,1392,1393,1394};   // fuel surface

// define rod regions
  Plane Surface(1396) = {1390,1395};   // clad region
  Plane Surface(1397) = {1395};      // fuel region
  Physical Surface("RegClad1407")={1396};   // pin clad
  Physical Surface("RegFuel1407")={1397};   // pin fuel

// ==============================
//    define rod 15,7

  Point(1049) = { 18.27000000,  8.19000000, 0, lc};

  Point(1050) = { 17.79500000,  8.19000000, 0, lc};
  Point(1051) = { 18.74500000,  8.19000000, 0, lc};
  Point(1052) = { 18.27000000,  7.71500000, 0, lc};
  Point(1053) = { 18.27000000,  8.66500000, 0, lc};
  Circle(1398) = {1053,1049,1051};
  Circle(1399) = {1051,1049,1052};
  Circle(1400) = {1052,1049,1050};
  Circle(1401) = {1050,1049,1053};
  Line Loop(1402) = {1398,1399,1400,1401};   // clad surface

  Point(1054) = { 17.85200000,  8.19000000, 0, lc};
  Point(1055) = { 18.68800000,  8.19000000, 0, lc};
  Point(1056) = { 18.27000000,  7.77200000, 0, lc};
  Point(1057) = { 18.27000000,  8.60800000, 0, lc};
  Circle(1403) = {1057,1049,1055};
  Circle(1404) = {1055,1049,1056};
  Circle(1405) = {1056,1049,1054};
  Circle(1406) = {1054,1049,1057};
  Line Loop(1407) = {1403,1404,1405,1406};   // fuel surface

// define rod regions
  Plane Surface(1408) = {1402,1407};   // clad region
  Plane Surface(1409) = {1407};      // fuel region
  Physical Surface("RegClad1507")={1408};   // pin clad
  Physical Surface("RegFuel1507")={1409};   // pin fuel

// ==============================
//    define rod 16,7

  Point(1058) = { 19.53000000,  8.19000000, 0, lc};

  Point(1059) = { 19.05500000,  8.19000000, 0, lc};
  Point(1060) = { 20.00500000,  8.19000000, 0, lc};
  Point(1061) = { 19.53000000,  7.71500000, 0, lc};
  Point(1062) = { 19.53000000,  8.66500000, 0, lc};
  Circle(1410) = {1062,1058,1060};
  Circle(1411) = {1060,1058,1061};
  Circle(1412) = {1061,1058,1059};
  Circle(1413) = {1059,1058,1062};
  Line Loop(1414) = {1410,1411,1412,1413};   // clad surface

  Point(1063) = { 19.11200000,  8.19000000, 0, lc};
  Point(1064) = { 19.94800000,  8.19000000, 0, lc};
  Point(1065) = { 19.53000000,  7.77200000, 0, lc};
  Point(1066) = { 19.53000000,  8.60800000, 0, lc};
  Circle(1415) = {1066,1058,1064};
  Circle(1416) = {1064,1058,1065};
  Circle(1417) = {1065,1058,1063};
  Circle(1418) = {1063,1058,1066};
  Line Loop(1419) = {1415,1416,1417,1418};   // fuel surface

// define rod regions
  Plane Surface(1420) = {1414,1419};   // clad region
  Plane Surface(1421) = {1419};      // fuel region
  Physical Surface("RegClad1607")={1420};   // pin clad
  Physical Surface("RegFuel1607")={1421};   // pin fuel

// ==============================
//    define rod 17,7

  Point(1067) = { 20.79000000,  8.19000000, 0, lc};

  Point(1068) = { 20.31500000,  8.19000000, 0, lc};
  Point(1069) = { 21.26500000,  8.19000000, 0, lc};
  Point(1070) = { 20.79000000,  7.71500000, 0, lc};
  Point(1071) = { 20.79000000,  8.66500000, 0, lc};
  Circle(1422) = {1071,1067,1069};
  Circle(1423) = {1069,1067,1070};
  Circle(1424) = {1070,1067,1068};
  Circle(1425) = {1068,1067,1071};
  Line Loop(1426) = {1422,1423,1424,1425};   // clad surface

  Point(1072) = { 20.37200000,  8.19000000, 0, lc};
  Point(1073) = { 21.20800000,  8.19000000, 0, lc};
  Point(1074) = { 20.79000000,  7.77200000, 0, lc};
  Point(1075) = { 20.79000000,  8.60800000, 0, lc};
  Circle(1427) = {1075,1067,1073};
  Circle(1428) = {1073,1067,1074};
  Circle(1429) = {1074,1067,1072};
  Circle(1430) = {1072,1067,1075};
  Line Loop(1431) = {1427,1428,1429,1430};   // fuel surface

// define rod regions
  Plane Surface(1432) = {1426,1431};   // clad region
  Plane Surface(1433) = {1431};      // fuel region
  Physical Surface("RegClad1707")={1432};   // pin clad
  Physical Surface("RegFuel1707")={1433};   // pin fuel

// ==============================
//    define rod 1,8

  Point(1076) = {  0.63000000,  9.45000000, 0, lc};

  Point(1077) = {  0.15500000,  9.45000000, 0, lc};
  Point(1078) = {  1.10500000,  9.45000000, 0, lc};
  Point(1079) = {  0.63000000,  8.97500000, 0, lc};
  Point(1080) = {  0.63000000,  9.92500000, 0, lc};
  Circle(1434) = {1080,1076,1078};
  Circle(1435) = {1078,1076,1079};
  Circle(1436) = {1079,1076,1077};
  Circle(1437) = {1077,1076,1080};
  Line Loop(1438) = {1434,1435,1436,1437};   // clad surface

  Point(1081) = {  0.21200000,  9.45000000, 0, lc};
  Point(1082) = {  1.04800000,  9.45000000, 0, lc};
  Point(1083) = {  0.63000000,  9.03200000, 0, lc};
  Point(1084) = {  0.63000000,  9.86800000, 0, lc};
  Circle(1439) = {1084,1076,1082};
  Circle(1440) = {1082,1076,1083};
  Circle(1441) = {1083,1076,1081};
  Circle(1442) = {1081,1076,1084};
  Line Loop(1443) = {1439,1440,1441,1442};   // fuel surface

// define rod regions
  Plane Surface(1444) = {1438,1443};   // clad region
  Plane Surface(1445) = {1443};      // fuel region
  Physical Surface("RegClad0108")={1444};   // pin clad
  Physical Surface("RegFuel0108")={1445};   // pin fuel

// ==============================
//    define rod 2,8

  Point(1085) = {  1.89000000,  9.45000000, 0, lc};

  Point(1086) = {  1.41500000,  9.45000000, 0, lc};
  Point(1087) = {  2.36500000,  9.45000000, 0, lc};
  Point(1088) = {  1.89000000,  8.97500000, 0, lc};
  Point(1089) = {  1.89000000,  9.92500000, 0, lc};
  Circle(1446) = {1089,1085,1087};
  Circle(1447) = {1087,1085,1088};
  Circle(1448) = {1088,1085,1086};
  Circle(1449) = {1086,1085,1089};
  Line Loop(1450) = {1446,1447,1448,1449};   // clad surface

  Point(1090) = {  1.47200000,  9.45000000, 0, lc};
  Point(1091) = {  2.30800000,  9.45000000, 0, lc};
  Point(1092) = {  1.89000000,  9.03200000, 0, lc};
  Point(1093) = {  1.89000000,  9.86800000, 0, lc};
  Circle(1451) = {1093,1085,1091};
  Circle(1452) = {1091,1085,1092};
  Circle(1453) = {1092,1085,1090};
  Circle(1454) = {1090,1085,1093};
  Line Loop(1455) = {1451,1452,1453,1454};   // fuel surface

// define rod regions
  Plane Surface(1456) = {1450,1455};   // clad region
  Plane Surface(1457) = {1455};      // fuel region
  Physical Surface("RegClad0208")={1456};   // pin clad
  Physical Surface("RegFuel0208")={1457};   // pin fuel

// ==============================
//    define rod 3,8

  Point(1094) = {  3.15000000,  9.45000000, 0, lc};

  Point(1095) = {  2.67500000,  9.45000000, 0, lc};
  Point(1096) = {  3.62500000,  9.45000000, 0, lc};
  Point(1097) = {  3.15000000,  8.97500000, 0, lc};
  Point(1098) = {  3.15000000,  9.92500000, 0, lc};
  Circle(1458) = {1098,1094,1096};
  Circle(1459) = {1096,1094,1097};
  Circle(1460) = {1097,1094,1095};
  Circle(1461) = {1095,1094,1098};
  Line Loop(1462) = {1458,1459,1460,1461};   // clad surface

  Point(1099) = {  2.73200000,  9.45000000, 0, lc};
  Point(1100) = {  3.56800000,  9.45000000, 0, lc};
  Point(1101) = {  3.15000000,  9.03200000, 0, lc};
  Point(1102) = {  3.15000000,  9.86800000, 0, lc};
  Circle(1463) = {1102,1094,1100};
  Circle(1464) = {1100,1094,1101};
  Circle(1465) = {1101,1094,1099};
  Circle(1466) = {1099,1094,1102};
  Line Loop(1467) = {1463,1464,1465,1466};   // fuel surface

// define rod regions
  Plane Surface(1468) = {1462,1467};   // clad region
  Plane Surface(1469) = {1467};      // fuel region
  Physical Surface("RegClad0308")={1468};   // pin clad
  Physical Surface("RegFuel0308")={1469};   // pin fuel

// ==============================
//    define rod 4,8

  Point(1103) = {  4.41000000,  9.45000000, 0, lc};

  Point(1104) = {  3.93500000,  9.45000000, 0, lc};
  Point(1105) = {  4.88500000,  9.45000000, 0, lc};
  Point(1106) = {  4.41000000,  8.97500000, 0, lc};
  Point(1107) = {  4.41000000,  9.92500000, 0, lc};
  Circle(1470) = {1107,1103,1105};
  Circle(1471) = {1105,1103,1106};
  Circle(1472) = {1106,1103,1104};
  Circle(1473) = {1104,1103,1107};
  Line Loop(1474) = {1470,1471,1472,1473};   // clad surface

  Point(1108) = {  3.99200000,  9.45000000, 0, lc};
  Point(1109) = {  4.82800000,  9.45000000, 0, lc};
  Point(1110) = {  4.41000000,  9.03200000, 0, lc};
  Point(1111) = {  4.41000000,  9.86800000, 0, lc};
  Circle(1475) = {1111,1103,1109};
  Circle(1476) = {1109,1103,1110};
  Circle(1477) = {1110,1103,1108};
  Circle(1478) = {1108,1103,1111};
  Line Loop(1479) = {1475,1476,1477,1478};   // fuel surface

// define rod regions
  Plane Surface(1480) = {1474,1479};   // clad region
  Plane Surface(1481) = {1479};      // fuel region
  Physical Surface("RegClad0408")={1480};   // pin clad
  Physical Surface("RegFuel0408")={1481};   // pin fuel

// ==============================
//    define rod 5,8

  Point(1112) = {  5.67000000,  9.45000000, 0, lc};

  Point(1113) = {  5.19500000,  9.45000000, 0, lc};
  Point(1114) = {  6.14500000,  9.45000000, 0, lc};
  Point(1115) = {  5.67000000,  8.97500000, 0, lc};
  Point(1116) = {  5.67000000,  9.92500000, 0, lc};
  Circle(1482) = {1116,1112,1114};
  Circle(1483) = {1114,1112,1115};
  Circle(1484) = {1115,1112,1113};
  Circle(1485) = {1113,1112,1116};
  Line Loop(1486) = {1482,1483,1484,1485};   // clad surface

  Point(1117) = {  5.25200000,  9.45000000, 0, lc};
  Point(1118) = {  6.08800000,  9.45000000, 0, lc};
  Point(1119) = {  5.67000000,  9.03200000, 0, lc};
  Point(1120) = {  5.67000000,  9.86800000, 0, lc};
  Circle(1487) = {1120,1112,1118};
  Circle(1488) = {1118,1112,1119};
  Circle(1489) = {1119,1112,1117};
  Circle(1490) = {1117,1112,1120};
  Line Loop(1491) = {1487,1488,1489,1490};   // fuel surface

// define rod regions
  Plane Surface(1492) = {1486,1491};   // clad region
  Plane Surface(1493) = {1491};      // fuel region
  Physical Surface("RegClad0508")={1492};   // pin clad
  Physical Surface("RegFuel0508")={1493};   // pin fuel

// ==============================
//    define rod 6,8

  Point(1121) = {  6.93000000,  9.45000000, 0, lc};

  Point(1122) = {  6.45500000,  9.45000000, 0, lc};
  Point(1123) = {  7.40500000,  9.45000000, 0, lc};
  Point(1124) = {  6.93000000,  8.97500000, 0, lc};
  Point(1125) = {  6.93000000,  9.92500000, 0, lc};
  Circle(1494) = {1125,1121,1123};
  Circle(1495) = {1123,1121,1124};
  Circle(1496) = {1124,1121,1122};
  Circle(1497) = {1122,1121,1125};
  Line Loop(1498) = {1494,1495,1496,1497};   // clad surface

  Point(1126) = {  6.51200000,  9.45000000, 0, lc};
  Point(1127) = {  7.34800000,  9.45000000, 0, lc};
  Point(1128) = {  6.93000000,  9.03200000, 0, lc};
  Point(1129) = {  6.93000000,  9.86800000, 0, lc};
  Circle(1499) = {1129,1121,1127};
  Circle(1500) = {1127,1121,1128};
  Circle(1501) = {1128,1121,1126};
  Circle(1502) = {1126,1121,1129};
  Line Loop(1503) = {1499,1500,1501,1502};   // fuel surface

// define rod regions
  Plane Surface(1504) = {1498,1503};   // clad region
  Plane Surface(1505) = {1503};      // fuel region
  Physical Surface("RegClad0608")={1504};   // pin clad
  Physical Surface("RegFuel0608")={1505};   // pin fuel

// ==============================
//    define rod 7,8

  Point(1130) = {  8.19000000,  9.45000000, 0, lc};

  Point(1131) = {  7.71500000,  9.45000000, 0, lc};
  Point(1132) = {  8.66500000,  9.45000000, 0, lc};
  Point(1133) = {  8.19000000,  8.97500000, 0, lc};
  Point(1134) = {  8.19000000,  9.92500000, 0, lc};
  Circle(1506) = {1134,1130,1132};
  Circle(1507) = {1132,1130,1133};
  Circle(1508) = {1133,1130,1131};
  Circle(1509) = {1131,1130,1134};
  Line Loop(1510) = {1506,1507,1508,1509};   // clad surface

  Point(1135) = {  7.77200000,  9.45000000, 0, lc};
  Point(1136) = {  8.60800000,  9.45000000, 0, lc};
  Point(1137) = {  8.19000000,  9.03200000, 0, lc};
  Point(1138) = {  8.19000000,  9.86800000, 0, lc};
  Circle(1511) = {1138,1130,1136};
  Circle(1512) = {1136,1130,1137};
  Circle(1513) = {1137,1130,1135};
  Circle(1514) = {1135,1130,1138};
  Line Loop(1515) = {1511,1512,1513,1514};   // fuel surface

// define rod regions
  Plane Surface(1516) = {1510,1515};   // clad region
  Plane Surface(1517) = {1515};      // fuel region
  Physical Surface("RegClad0708")={1516};   // pin clad
  Physical Surface("RegFuel0708")={1517};   // pin fuel

// ==============================
//    define rod 8,8

  Point(1139) = {  9.45000000,  9.45000000, 0, lc};

  Point(1140) = {  8.97500000,  9.45000000, 0, lc};
  Point(1141) = {  9.92500000,  9.45000000, 0, lc};
  Point(1142) = {  9.45000000,  8.97500000, 0, lc};
  Point(1143) = {  9.45000000,  9.92500000, 0, lc};
  Circle(1518) = {1143,1139,1141};
  Circle(1519) = {1141,1139,1142};
  Circle(1520) = {1142,1139,1140};
  Circle(1521) = {1140,1139,1143};
  Line Loop(1522) = {1518,1519,1520,1521};   // clad surface

  Point(1144) = {  9.03200000,  9.45000000, 0, lc};
  Point(1145) = {  9.86800000,  9.45000000, 0, lc};
  Point(1146) = {  9.45000000,  9.03200000, 0, lc};
  Point(1147) = {  9.45000000,  9.86800000, 0, lc};
  Circle(1523) = {1147,1139,1145};
  Circle(1524) = {1145,1139,1146};
  Circle(1525) = {1146,1139,1144};
  Circle(1526) = {1144,1139,1147};
  Line Loop(1527) = {1523,1524,1525,1526};   // fuel surface

// define rod regions
  Plane Surface(1528) = {1522,1527};   // clad region
  Plane Surface(1529) = {1527};      // fuel region
  Physical Surface("RegClad0808")={1528};   // pin clad
  Physical Surface("RegFuel0808")={1529};   // pin fuel

// ==============================
//    define rod 9,8

  Point(1148) = { 10.71000000,  9.45000000, 0, lc};

  Point(1149) = { 10.23500000,  9.45000000, 0, lc};
  Point(1150) = { 11.18500000,  9.45000000, 0, lc};
  Point(1151) = { 10.71000000,  8.97500000, 0, lc};
  Point(1152) = { 10.71000000,  9.92500000, 0, lc};
  Circle(1530) = {1152,1148,1150};
  Circle(1531) = {1150,1148,1151};
  Circle(1532) = {1151,1148,1149};
  Circle(1533) = {1149,1148,1152};
  Line Loop(1534) = {1530,1531,1532,1533};   // clad surface

  Point(1153) = { 10.29200000,  9.45000000, 0, lc};
  Point(1154) = { 11.12800000,  9.45000000, 0, lc};
  Point(1155) = { 10.71000000,  9.03200000, 0, lc};
  Point(1156) = { 10.71000000,  9.86800000, 0, lc};
  Circle(1535) = {1156,1148,1154};
  Circle(1536) = {1154,1148,1155};
  Circle(1537) = {1155,1148,1153};
  Circle(1538) = {1153,1148,1156};
  Line Loop(1539) = {1535,1536,1537,1538};   // fuel surface

// define rod regions
  Plane Surface(1540) = {1534,1539};   // clad region
  Plane Surface(1541) = {1539};      // fuel region
  Physical Surface("RegClad0908")={1540};   // pin clad
  Physical Surface("RegFuel0908")={1541};   // pin fuel

// ==============================
//    define rod 10,8

  Point(1157) = { 11.97000000,  9.45000000, 0, lc};

  Point(1158) = { 11.49500000,  9.45000000, 0, lc};
  Point(1159) = { 12.44500000,  9.45000000, 0, lc};
  Point(1160) = { 11.97000000,  8.97500000, 0, lc};
  Point(1161) = { 11.97000000,  9.92500000, 0, lc};
  Circle(1542) = {1161,1157,1159};
  Circle(1543) = {1159,1157,1160};
  Circle(1544) = {1160,1157,1158};
  Circle(1545) = {1158,1157,1161};
  Line Loop(1546) = {1542,1543,1544,1545};   // clad surface

  Point(1162) = { 11.55200000,  9.45000000, 0, lc};
  Point(1163) = { 12.38800000,  9.45000000, 0, lc};
  Point(1164) = { 11.97000000,  9.03200000, 0, lc};
  Point(1165) = { 11.97000000,  9.86800000, 0, lc};
  Circle(1547) = {1165,1157,1163};
  Circle(1548) = {1163,1157,1164};
  Circle(1549) = {1164,1157,1162};
  Circle(1550) = {1162,1157,1165};
  Line Loop(1551) = {1547,1548,1549,1550};   // fuel surface

// define rod regions
  Plane Surface(1552) = {1546,1551};   // clad region
  Plane Surface(1553) = {1551};      // fuel region
  Physical Surface("RegClad1008")={1552};   // pin clad
  Physical Surface("RegFuel1008")={1553};   // pin fuel

// ==============================
//    define rod 11,8

  Point(1166) = { 13.23000000,  9.45000000, 0, lc};

  Point(1167) = { 12.75500000,  9.45000000, 0, lc};
  Point(1168) = { 13.70500000,  9.45000000, 0, lc};
  Point(1169) = { 13.23000000,  8.97500000, 0, lc};
  Point(1170) = { 13.23000000,  9.92500000, 0, lc};
  Circle(1554) = {1170,1166,1168};
  Circle(1555) = {1168,1166,1169};
  Circle(1556) = {1169,1166,1167};
  Circle(1557) = {1167,1166,1170};
  Line Loop(1558) = {1554,1555,1556,1557};   // clad surface

  Point(1171) = { 12.81200000,  9.45000000, 0, lc};
  Point(1172) = { 13.64800000,  9.45000000, 0, lc};
  Point(1173) = { 13.23000000,  9.03200000, 0, lc};
  Point(1174) = { 13.23000000,  9.86800000, 0, lc};
  Circle(1559) = {1174,1166,1172};
  Circle(1560) = {1172,1166,1173};
  Circle(1561) = {1173,1166,1171};
  Circle(1562) = {1171,1166,1174};
  Line Loop(1563) = {1559,1560,1561,1562};   // fuel surface

// define rod regions
  Plane Surface(1564) = {1558,1563};   // clad region
  Plane Surface(1565) = {1563};      // fuel region
  Physical Surface("RegClad1108")={1564};   // pin clad
  Physical Surface("RegFuel1108")={1565};   // pin fuel

// ==============================
//    define rod 12,8

  Point(1175) = { 14.49000000,  9.45000000, 0, lc};

  Point(1176) = { 14.01500000,  9.45000000, 0, lc};
  Point(1177) = { 14.96500000,  9.45000000, 0, lc};
  Point(1178) = { 14.49000000,  8.97500000, 0, lc};
  Point(1179) = { 14.49000000,  9.92500000, 0, lc};
  Circle(1566) = {1179,1175,1177};
  Circle(1567) = {1177,1175,1178};
  Circle(1568) = {1178,1175,1176};
  Circle(1569) = {1176,1175,1179};
  Line Loop(1570) = {1566,1567,1568,1569};   // clad surface

  Point(1180) = { 14.07200000,  9.45000000, 0, lc};
  Point(1181) = { 14.90800000,  9.45000000, 0, lc};
  Point(1182) = { 14.49000000,  9.03200000, 0, lc};
  Point(1183) = { 14.49000000,  9.86800000, 0, lc};
  Circle(1571) = {1183,1175,1181};
  Circle(1572) = {1181,1175,1182};
  Circle(1573) = {1182,1175,1180};
  Circle(1574) = {1180,1175,1183};
  Line Loop(1575) = {1571,1572,1573,1574};   // fuel surface

// define rod regions
  Plane Surface(1576) = {1570,1575};   // clad region
  Plane Surface(1577) = {1575};      // fuel region
  Physical Surface("RegClad1208")={1576};   // pin clad
  Physical Surface("RegFuel1208")={1577};   // pin fuel

// ==============================
//    define rod 13,8

  Point(1184) = { 15.75000000,  9.45000000, 0, lc};

  Point(1185) = { 15.27500000,  9.45000000, 0, lc};
  Point(1186) = { 16.22500000,  9.45000000, 0, lc};
  Point(1187) = { 15.75000000,  8.97500000, 0, lc};
  Point(1188) = { 15.75000000,  9.92500000, 0, lc};
  Circle(1578) = {1188,1184,1186};
  Circle(1579) = {1186,1184,1187};
  Circle(1580) = {1187,1184,1185};
  Circle(1581) = {1185,1184,1188};
  Line Loop(1582) = {1578,1579,1580,1581};   // clad surface

  Point(1189) = { 15.33200000,  9.45000000, 0, lc};
  Point(1190) = { 16.16800000,  9.45000000, 0, lc};
  Point(1191) = { 15.75000000,  9.03200000, 0, lc};
  Point(1192) = { 15.75000000,  9.86800000, 0, lc};
  Circle(1583) = {1192,1184,1190};
  Circle(1584) = {1190,1184,1191};
  Circle(1585) = {1191,1184,1189};
  Circle(1586) = {1189,1184,1192};
  Line Loop(1587) = {1583,1584,1585,1586};   // fuel surface

// define rod regions
  Plane Surface(1588) = {1582,1587};   // clad region
  Plane Surface(1589) = {1587};      // fuel region
  Physical Surface("RegClad1308")={1588};   // pin clad
  Physical Surface("RegFuel1308")={1589};   // pin fuel

// ==============================
//    define rod 14,8

  Point(1193) = { 17.01000000,  9.45000000, 0, lc};

  Point(1194) = { 16.53500000,  9.45000000, 0, lc};
  Point(1195) = { 17.48500000,  9.45000000, 0, lc};
  Point(1196) = { 17.01000000,  8.97500000, 0, lc};
  Point(1197) = { 17.01000000,  9.92500000, 0, lc};
  Circle(1590) = {1197,1193,1195};
  Circle(1591) = {1195,1193,1196};
  Circle(1592) = {1196,1193,1194};
  Circle(1593) = {1194,1193,1197};
  Line Loop(1594) = {1590,1591,1592,1593};   // clad surface

  Point(1198) = { 16.59200000,  9.45000000, 0, lc};
  Point(1199) = { 17.42800000,  9.45000000, 0, lc};
  Point(1200) = { 17.01000000,  9.03200000, 0, lc};
  Point(1201) = { 17.01000000,  9.86800000, 0, lc};
  Circle(1595) = {1201,1193,1199};
  Circle(1596) = {1199,1193,1200};
  Circle(1597) = {1200,1193,1198};
  Circle(1598) = {1198,1193,1201};
  Line Loop(1599) = {1595,1596,1597,1598};   // fuel surface

// define rod regions
  Plane Surface(1600) = {1594,1599};   // clad region
  Plane Surface(1601) = {1599};      // fuel region
  Physical Surface("RegClad1408")={1600};   // pin clad
  Physical Surface("RegFuel1408")={1601};   // pin fuel

// ==============================
//    define rod 15,8

  Point(1202) = { 18.27000000,  9.45000000, 0, lc};

  Point(1203) = { 17.79500000,  9.45000000, 0, lc};
  Point(1204) = { 18.74500000,  9.45000000, 0, lc};
  Point(1205) = { 18.27000000,  8.97500000, 0, lc};
  Point(1206) = { 18.27000000,  9.92500000, 0, lc};
  Circle(1602) = {1206,1202,1204};
  Circle(1603) = {1204,1202,1205};
  Circle(1604) = {1205,1202,1203};
  Circle(1605) = {1203,1202,1206};
  Line Loop(1606) = {1602,1603,1604,1605};   // clad surface

  Point(1207) = { 17.85200000,  9.45000000, 0, lc};
  Point(1208) = { 18.68800000,  9.45000000, 0, lc};
  Point(1209) = { 18.27000000,  9.03200000, 0, lc};
  Point(1210) = { 18.27000000,  9.86800000, 0, lc};
  Circle(1607) = {1210,1202,1208};
  Circle(1608) = {1208,1202,1209};
  Circle(1609) = {1209,1202,1207};
  Circle(1610) = {1207,1202,1210};
  Line Loop(1611) = {1607,1608,1609,1610};   // fuel surface

// define rod regions
  Plane Surface(1612) = {1606,1611};   // clad region
  Plane Surface(1613) = {1611};      // fuel region
  Physical Surface("RegClad1508")={1612};   // pin clad
  Physical Surface("RegFuel1508")={1613};   // pin fuel

// ==============================
//    define rod 16,8

  Point(1211) = { 19.53000000,  9.45000000, 0, lc};

  Point(1212) = { 19.05500000,  9.45000000, 0, lc};
  Point(1213) = { 20.00500000,  9.45000000, 0, lc};
  Point(1214) = { 19.53000000,  8.97500000, 0, lc};
  Point(1215) = { 19.53000000,  9.92500000, 0, lc};
  Circle(1614) = {1215,1211,1213};
  Circle(1615) = {1213,1211,1214};
  Circle(1616) = {1214,1211,1212};
  Circle(1617) = {1212,1211,1215};
  Line Loop(1618) = {1614,1615,1616,1617};   // clad surface

  Point(1216) = { 19.11200000,  9.45000000, 0, lc};
  Point(1217) = { 19.94800000,  9.45000000, 0, lc};
  Point(1218) = { 19.53000000,  9.03200000, 0, lc};
  Point(1219) = { 19.53000000,  9.86800000, 0, lc};
  Circle(1619) = {1219,1211,1217};
  Circle(1620) = {1217,1211,1218};
  Circle(1621) = {1218,1211,1216};
  Circle(1622) = {1216,1211,1219};
  Line Loop(1623) = {1619,1620,1621,1622};   // fuel surface

// define rod regions
  Plane Surface(1624) = {1618,1623};   // clad region
  Plane Surface(1625) = {1623};      // fuel region
  Physical Surface("RegClad1608")={1624};   // pin clad
  Physical Surface("RegFuel1608")={1625};   // pin fuel

// ==============================
//    define rod 17,8

  Point(1220) = { 20.79000000,  9.45000000, 0, lc};

  Point(1221) = { 20.31500000,  9.45000000, 0, lc};
  Point(1222) = { 21.26500000,  9.45000000, 0, lc};
  Point(1223) = { 20.79000000,  8.97500000, 0, lc};
  Point(1224) = { 20.79000000,  9.92500000, 0, lc};
  Circle(1626) = {1224,1220,1222};
  Circle(1627) = {1222,1220,1223};
  Circle(1628) = {1223,1220,1221};
  Circle(1629) = {1221,1220,1224};
  Line Loop(1630) = {1626,1627,1628,1629};   // clad surface

  Point(1225) = { 20.37200000,  9.45000000, 0, lc};
  Point(1226) = { 21.20800000,  9.45000000, 0, lc};
  Point(1227) = { 20.79000000,  9.03200000, 0, lc};
  Point(1228) = { 20.79000000,  9.86800000, 0, lc};
  Circle(1631) = {1228,1220,1226};
  Circle(1632) = {1226,1220,1227};
  Circle(1633) = {1227,1220,1225};
  Circle(1634) = {1225,1220,1228};
  Line Loop(1635) = {1631,1632,1633,1634};   // fuel surface

// define rod regions
  Plane Surface(1636) = {1630,1635};   // clad region
  Plane Surface(1637) = {1635};      // fuel region
  Physical Surface("RegClad1708")={1636};   // pin clad
  Physical Surface("RegFuel1708")={1637};   // pin fuel

// ==============================
//    define rod 1,9

  Point(1229) = {  0.63000000, 10.71000000, 0, lc};

  Point(1230) = {  0.15500000, 10.71000000, 0, lc};
  Point(1231) = {  1.10500000, 10.71000000, 0, lc};
  Point(1232) = {  0.63000000, 10.23500000, 0, lc};
  Point(1233) = {  0.63000000, 11.18500000, 0, lc};
  Circle(1638) = {1233,1229,1231};
  Circle(1639) = {1231,1229,1232};
  Circle(1640) = {1232,1229,1230};
  Circle(1641) = {1230,1229,1233};
  Line Loop(1642) = {1638,1639,1640,1641};   // clad surface

  Point(1234) = {  0.21200000, 10.71000000, 0, lc};
  Point(1235) = {  1.04800000, 10.71000000, 0, lc};
  Point(1236) = {  0.63000000, 10.29200000, 0, lc};
  Point(1237) = {  0.63000000, 11.12800000, 0, lc};
  Circle(1643) = {1237,1229,1235};
  Circle(1644) = {1235,1229,1236};
  Circle(1645) = {1236,1229,1234};
  Circle(1646) = {1234,1229,1237};
  Line Loop(1647) = {1643,1644,1645,1646};   // fuel surface

// define rod regions
  Plane Surface(1648) = {1642,1647};   // clad region
  Plane Surface(1649) = {1647};      // fuel region
  Physical Surface("RegClad0109")={1648};   // pin clad
  Physical Surface("RegFuel0109")={1649};   // pin fuel

// ==============================
//    define rod 2,9

  Point(1238) = {  1.89000000, 10.71000000, 0, lc};

  Point(1239) = {  1.41500000, 10.71000000, 0, lc};
  Point(1240) = {  2.36500000, 10.71000000, 0, lc};
  Point(1241) = {  1.89000000, 10.23500000, 0, lc};
  Point(1242) = {  1.89000000, 11.18500000, 0, lc};
  Circle(1650) = {1242,1238,1240};
  Circle(1651) = {1240,1238,1241};
  Circle(1652) = {1241,1238,1239};
  Circle(1653) = {1239,1238,1242};
  Line Loop(1654) = {1650,1651,1652,1653};   // clad surface

  Point(1243) = {  1.47200000, 10.71000000, 0, lc};
  Point(1244) = {  2.30800000, 10.71000000, 0, lc};
  Point(1245) = {  1.89000000, 10.29200000, 0, lc};
  Point(1246) = {  1.89000000, 11.12800000, 0, lc};
  Circle(1655) = {1246,1238,1244};
  Circle(1656) = {1244,1238,1245};
  Circle(1657) = {1245,1238,1243};
  Circle(1658) = {1243,1238,1246};
  Line Loop(1659) = {1655,1656,1657,1658};   // fuel surface

// define rod regions
  Plane Surface(1660) = {1654,1659};   // clad region
  Plane Surface(1661) = {1659};      // fuel region
  Physical Surface("RegClad0209")={1660};   // pin clad
  Physical Surface("RegFuel0209")={1661};   // pin fuel

// ==============================
//    define rod 3,9

  Point(1247) = {  3.15000000, 10.71000000, 0, lc};

  Point(1248) = {  2.67500000, 10.71000000, 0, lc};
  Point(1249) = {  3.62500000, 10.71000000, 0, lc};
  Point(1250) = {  3.15000000, 10.23500000, 0, lc};
  Point(1251) = {  3.15000000, 11.18500000, 0, lc};
  Circle(1662) = {1251,1247,1249};
  Circle(1663) = {1249,1247,1250};
  Circle(1664) = {1250,1247,1248};
  Circle(1665) = {1248,1247,1251};
  Line Loop(1666) = {1662,1663,1664,1665};   // clad surface

  Point(1252) = {  2.73200000, 10.71000000, 0, lc};
  Point(1253) = {  3.56800000, 10.71000000, 0, lc};
  Point(1254) = {  3.15000000, 10.29200000, 0, lc};
  Point(1255) = {  3.15000000, 11.12800000, 0, lc};
  Circle(1667) = {1255,1247,1253};
  Circle(1668) = {1253,1247,1254};
  Circle(1669) = {1254,1247,1252};
  Circle(1670) = {1252,1247,1255};
  Line Loop(1671) = {1667,1668,1669,1670};   // fuel surface

// define rod regions
  Plane Surface(1672) = {1666,1671};   // clad region
  Plane Surface(1673) = {1671};      // fuel region
  Physical Surface("RegClad0309")={1672};   // pin clad
  Physical Surface("RegFuel0309")={1673};   // pin fuel

// ==============================
//    define rod 4,9

  Point(1256) = {  4.41000000, 10.71000000, 0, lc};

  Point(1257) = {  3.93500000, 10.71000000, 0, lc};
  Point(1258) = {  4.88500000, 10.71000000, 0, lc};
  Point(1259) = {  4.41000000, 10.23500000, 0, lc};
  Point(1260) = {  4.41000000, 11.18500000, 0, lc};
  Circle(1674) = {1260,1256,1258};
  Circle(1675) = {1258,1256,1259};
  Circle(1676) = {1259,1256,1257};
  Circle(1677) = {1257,1256,1260};
  Line Loop(1678) = {1674,1675,1676,1677};   // clad surface

  Point(1261) = {  3.99200000, 10.71000000, 0, lc};
  Point(1262) = {  4.82800000, 10.71000000, 0, lc};
  Point(1263) = {  4.41000000, 10.29200000, 0, lc};
  Point(1264) = {  4.41000000, 11.12800000, 0, lc};
  Circle(1679) = {1264,1256,1262};
  Circle(1680) = {1262,1256,1263};
  Circle(1681) = {1263,1256,1261};
  Circle(1682) = {1261,1256,1264};
  Line Loop(1683) = {1679,1680,1681,1682};   // fuel surface

// define rod regions
  Plane Surface(1684) = {1678,1683};   // clad region
  Plane Surface(1685) = {1683};      // fuel region
  Physical Surface("RegClad0409")={1684};   // pin clad
  Physical Surface("RegFuel0409")={1685};   // pin fuel

// ==============================
//    define rod 5,9

  Point(1265) = {  5.67000000, 10.71000000, 0, lc};

  Point(1266) = {  5.19500000, 10.71000000, 0, lc};
  Point(1267) = {  6.14500000, 10.71000000, 0, lc};
  Point(1268) = {  5.67000000, 10.23500000, 0, lc};
  Point(1269) = {  5.67000000, 11.18500000, 0, lc};
  Circle(1686) = {1269,1265,1267};
  Circle(1687) = {1267,1265,1268};
  Circle(1688) = {1268,1265,1266};
  Circle(1689) = {1266,1265,1269};
  Line Loop(1690) = {1686,1687,1688,1689};   // clad surface

  Point(1270) = {  5.25200000, 10.71000000, 0, lc};
  Point(1271) = {  6.08800000, 10.71000000, 0, lc};
  Point(1272) = {  5.67000000, 10.29200000, 0, lc};
  Point(1273) = {  5.67000000, 11.12800000, 0, lc};
  Circle(1691) = {1273,1265,1271};
  Circle(1692) = {1271,1265,1272};
  Circle(1693) = {1272,1265,1270};
  Circle(1694) = {1270,1265,1273};
  Line Loop(1695) = {1691,1692,1693,1694};   // fuel surface

// define rod regions
  Plane Surface(1696) = {1690,1695};   // clad region
  Plane Surface(1697) = {1695};      // fuel region
  Physical Surface("RegClad0509")={1696};   // pin clad
  Physical Surface("RegFuel0509")={1697};   // pin fuel

// ==============================
//    define rod 6,9

  Point(1274) = {  6.93000000, 10.71000000, 0, lc};

  Point(1275) = {  6.45500000, 10.71000000, 0, lc};
  Point(1276) = {  7.40500000, 10.71000000, 0, lc};
  Point(1277) = {  6.93000000, 10.23500000, 0, lc};
  Point(1278) = {  6.93000000, 11.18500000, 0, lc};
  Circle(1698) = {1278,1274,1276};
  Circle(1699) = {1276,1274,1277};
  Circle(1700) = {1277,1274,1275};
  Circle(1701) = {1275,1274,1278};
  Line Loop(1702) = {1698,1699,1700,1701};   // clad surface

  Point(1279) = {  6.51200000, 10.71000000, 0, lc};
  Point(1280) = {  7.34800000, 10.71000000, 0, lc};
  Point(1281) = {  6.93000000, 10.29200000, 0, lc};
  Point(1282) = {  6.93000000, 11.12800000, 0, lc};
  Circle(1703) = {1282,1274,1280};
  Circle(1704) = {1280,1274,1281};
  Circle(1705) = {1281,1274,1279};
  Circle(1706) = {1279,1274,1282};
  Line Loop(1707) = {1703,1704,1705,1706};   // fuel surface

// define rod regions
  Plane Surface(1708) = {1702,1707};   // clad region
  Plane Surface(1709) = {1707};      // fuel region
  Physical Surface("RegClad0609")={1708};   // pin clad
  Physical Surface("RegFuel0609")={1709};   // pin fuel

// ==============================
//    define rod 7,9

  Point(1283) = {  8.19000000, 10.71000000, 0, lc};

  Point(1284) = {  7.71500000, 10.71000000, 0, lc};
  Point(1285) = {  8.66500000, 10.71000000, 0, lc};
  Point(1286) = {  8.19000000, 10.23500000, 0, lc};
  Point(1287) = {  8.19000000, 11.18500000, 0, lc};
  Circle(1710) = {1287,1283,1285};
  Circle(1711) = {1285,1283,1286};
  Circle(1712) = {1286,1283,1284};
  Circle(1713) = {1284,1283,1287};
  Line Loop(1714) = {1710,1711,1712,1713};   // clad surface

  Point(1288) = {  7.77200000, 10.71000000, 0, lc};
  Point(1289) = {  8.60800000, 10.71000000, 0, lc};
  Point(1290) = {  8.19000000, 10.29200000, 0, lc};
  Point(1291) = {  8.19000000, 11.12800000, 0, lc};
  Circle(1715) = {1291,1283,1289};
  Circle(1716) = {1289,1283,1290};
  Circle(1717) = {1290,1283,1288};
  Circle(1718) = {1288,1283,1291};
  Line Loop(1719) = {1715,1716,1717,1718};   // fuel surface

// define rod regions
  Plane Surface(1720) = {1714,1719};   // clad region
  Plane Surface(1721) = {1719};      // fuel region
  Physical Surface("RegClad0709")={1720};   // pin clad
  Physical Surface("RegFuel0709")={1721};   // pin fuel

// ==============================
//    define rod 8,9

  Point(1292) = {  9.45000000, 10.71000000, 0, lc};

  Point(1293) = {  8.97500000, 10.71000000, 0, lc};
  Point(1294) = {  9.92500000, 10.71000000, 0, lc};
  Point(1295) = {  9.45000000, 10.23500000, 0, lc};
  Point(1296) = {  9.45000000, 11.18500000, 0, lc};
  Circle(1722) = {1296,1292,1294};
  Circle(1723) = {1294,1292,1295};
  Circle(1724) = {1295,1292,1293};
  Circle(1725) = {1293,1292,1296};
  Line Loop(1726) = {1722,1723,1724,1725};   // clad surface

  Point(1297) = {  9.03200000, 10.71000000, 0, lc};
  Point(1298) = {  9.86800000, 10.71000000, 0, lc};
  Point(1299) = {  9.45000000, 10.29200000, 0, lc};
  Point(1300) = {  9.45000000, 11.12800000, 0, lc};
  Circle(1727) = {1300,1292,1298};
  Circle(1728) = {1298,1292,1299};
  Circle(1729) = {1299,1292,1297};
  Circle(1730) = {1297,1292,1300};
  Line Loop(1731) = {1727,1728,1729,1730};   // fuel surface

// define rod regions
  Plane Surface(1732) = {1726,1731};   // clad region
  Plane Surface(1733) = {1731};      // fuel region
  Physical Surface("RegClad0809")={1732};   // pin clad
  Physical Surface("RegFuel0809")={1733};   // pin fuel

// ==============================
//    define rod 9,9

  Point(1301) = { 10.71000000, 10.71000000, 0, lc};

  Point(1302) = { 10.23500000, 10.71000000, 0, lc};
  Point(1303) = { 11.18500000, 10.71000000, 0, lc};
  Point(1304) = { 10.71000000, 10.23500000, 0, lc};
  Point(1305) = { 10.71000000, 11.18500000, 0, lc};
  Circle(1734) = {1305,1301,1303};
  Circle(1735) = {1303,1301,1304};
  Circle(1736) = {1304,1301,1302};
  Circle(1737) = {1302,1301,1305};
  Line Loop(1738) = {1734,1735,1736,1737};   // clad surface

  Point(1306) = { 10.29200000, 10.71000000, 0, lc};
  Point(1307) = { 11.12800000, 10.71000000, 0, lc};
  Point(1308) = { 10.71000000, 10.29200000, 0, lc};
  Point(1309) = { 10.71000000, 11.12800000, 0, lc};
  Circle(1739) = {1309,1301,1307};
  Circle(1740) = {1307,1301,1308};
  Circle(1741) = {1308,1301,1306};
  Circle(1742) = {1306,1301,1309};
  Line Loop(1743) = {1739,1740,1741,1742};   // fuel surface

// define rod regions
  Plane Surface(1744) = {1738,1743};   // clad region
  Plane Surface(1745) = {1743};      // fuel region
  Physical Surface("RegClad0909")={1744};   // pin clad
  Physical Surface("RegFuel0909")={1745};   // pin fuel

// ==============================
//    define rod 10,9

  Point(1310) = { 11.97000000, 10.71000000, 0, lc};

  Point(1311) = { 11.49500000, 10.71000000, 0, lc};
  Point(1312) = { 12.44500000, 10.71000000, 0, lc};
  Point(1313) = { 11.97000000, 10.23500000, 0, lc};
  Point(1314) = { 11.97000000, 11.18500000, 0, lc};
  Circle(1746) = {1314,1310,1312};
  Circle(1747) = {1312,1310,1313};
  Circle(1748) = {1313,1310,1311};
  Circle(1749) = {1311,1310,1314};
  Line Loop(1750) = {1746,1747,1748,1749};   // clad surface

  Point(1315) = { 11.55200000, 10.71000000, 0, lc};
  Point(1316) = { 12.38800000, 10.71000000, 0, lc};
  Point(1317) = { 11.97000000, 10.29200000, 0, lc};
  Point(1318) = { 11.97000000, 11.12800000, 0, lc};
  Circle(1751) = {1318,1310,1316};
  Circle(1752) = {1316,1310,1317};
  Circle(1753) = {1317,1310,1315};
  Circle(1754) = {1315,1310,1318};
  Line Loop(1755) = {1751,1752,1753,1754};   // fuel surface

// define rod regions
  Plane Surface(1756) = {1750,1755};   // clad region
  Plane Surface(1757) = {1755};      // fuel region
  Physical Surface("RegClad1009")={1756};   // pin clad
  Physical Surface("RegFuel1009")={1757};   // pin fuel

// ==============================
//    define rod 11,9

  Point(1319) = { 13.23000000, 10.71000000, 0, lc};

  Point(1320) = { 12.75500000, 10.71000000, 0, lc};
  Point(1321) = { 13.70500000, 10.71000000, 0, lc};
  Point(1322) = { 13.23000000, 10.23500000, 0, lc};
  Point(1323) = { 13.23000000, 11.18500000, 0, lc};
  Circle(1758) = {1323,1319,1321};
  Circle(1759) = {1321,1319,1322};
  Circle(1760) = {1322,1319,1320};
  Circle(1761) = {1320,1319,1323};
  Line Loop(1762) = {1758,1759,1760,1761};   // clad surface

  Point(1324) = { 12.81200000, 10.71000000, 0, lc};
  Point(1325) = { 13.64800000, 10.71000000, 0, lc};
  Point(1326) = { 13.23000000, 10.29200000, 0, lc};
  Point(1327) = { 13.23000000, 11.12800000, 0, lc};
  Circle(1763) = {1327,1319,1325};
  Circle(1764) = {1325,1319,1326};
  Circle(1765) = {1326,1319,1324};
  Circle(1766) = {1324,1319,1327};
  Line Loop(1767) = {1763,1764,1765,1766};   // fuel surface

// define rod regions
  Plane Surface(1768) = {1762,1767};   // clad region
  Plane Surface(1769) = {1767};      // fuel region
  Physical Surface("RegClad1109")={1768};   // pin clad
  Physical Surface("RegFuel1109")={1769};   // pin fuel

// ==============================
//    define rod 12,9

  Point(1328) = { 14.49000000, 10.71000000, 0, lc};

  Point(1329) = { 14.01500000, 10.71000000, 0, lc};
  Point(1330) = { 14.96500000, 10.71000000, 0, lc};
  Point(1331) = { 14.49000000, 10.23500000, 0, lc};
  Point(1332) = { 14.49000000, 11.18500000, 0, lc};
  Circle(1770) = {1332,1328,1330};
  Circle(1771) = {1330,1328,1331};
  Circle(1772) = {1331,1328,1329};
  Circle(1773) = {1329,1328,1332};
  Line Loop(1774) = {1770,1771,1772,1773};   // clad surface

  Point(1333) = { 14.07200000, 10.71000000, 0, lc};
  Point(1334) = { 14.90800000, 10.71000000, 0, lc};
  Point(1335) = { 14.49000000, 10.29200000, 0, lc};
  Point(1336) = { 14.49000000, 11.12800000, 0, lc};
  Circle(1775) = {1336,1328,1334};
  Circle(1776) = {1334,1328,1335};
  Circle(1777) = {1335,1328,1333};
  Circle(1778) = {1333,1328,1336};
  Line Loop(1779) = {1775,1776,1777,1778};   // fuel surface

// define rod regions
  Plane Surface(1780) = {1774,1779};   // clad region
  Plane Surface(1781) = {1779};      // fuel region
  Physical Surface("RegClad1209")={1780};   // pin clad
  Physical Surface("RegFuel1209")={1781};   // pin fuel

// ==============================
//    define rod 13,9

  Point(1337) = { 15.75000000, 10.71000000, 0, lc};

  Point(1338) = { 15.27500000, 10.71000000, 0, lc};
  Point(1339) = { 16.22500000, 10.71000000, 0, lc};
  Point(1340) = { 15.75000000, 10.23500000, 0, lc};
  Point(1341) = { 15.75000000, 11.18500000, 0, lc};
  Circle(1782) = {1341,1337,1339};
  Circle(1783) = {1339,1337,1340};
  Circle(1784) = {1340,1337,1338};
  Circle(1785) = {1338,1337,1341};
  Line Loop(1786) = {1782,1783,1784,1785};   // clad surface

  Point(1342) = { 15.33200000, 10.71000000, 0, lc};
  Point(1343) = { 16.16800000, 10.71000000, 0, lc};
  Point(1344) = { 15.75000000, 10.29200000, 0, lc};
  Point(1345) = { 15.75000000, 11.12800000, 0, lc};
  Circle(1787) = {1345,1337,1343};
  Circle(1788) = {1343,1337,1344};
  Circle(1789) = {1344,1337,1342};
  Circle(1790) = {1342,1337,1345};
  Line Loop(1791) = {1787,1788,1789,1790};   // fuel surface

// define rod regions
  Plane Surface(1792) = {1786,1791};   // clad region
  Plane Surface(1793) = {1791};      // fuel region
  Physical Surface("RegClad1309")={1792};   // pin clad
  Physical Surface("RegFuel1309")={1793};   // pin fuel

// ==============================
//    define rod 14,9

  Point(1346) = { 17.01000000, 10.71000000, 0, lc};

  Point(1347) = { 16.53500000, 10.71000000, 0, lc};
  Point(1348) = { 17.48500000, 10.71000000, 0, lc};
  Point(1349) = { 17.01000000, 10.23500000, 0, lc};
  Point(1350) = { 17.01000000, 11.18500000, 0, lc};
  Circle(1794) = {1350,1346,1348};
  Circle(1795) = {1348,1346,1349};
  Circle(1796) = {1349,1346,1347};
  Circle(1797) = {1347,1346,1350};
  Line Loop(1798) = {1794,1795,1796,1797};   // clad surface

  Point(1351) = { 16.59200000, 10.71000000, 0, lc};
  Point(1352) = { 17.42800000, 10.71000000, 0, lc};
  Point(1353) = { 17.01000000, 10.29200000, 0, lc};
  Point(1354) = { 17.01000000, 11.12800000, 0, lc};
  Circle(1799) = {1354,1346,1352};
  Circle(1800) = {1352,1346,1353};
  Circle(1801) = {1353,1346,1351};
  Circle(1802) = {1351,1346,1354};
  Line Loop(1803) = {1799,1800,1801,1802};   // fuel surface

// define rod regions
  Plane Surface(1804) = {1798,1803};   // clad region
  Plane Surface(1805) = {1803};      // fuel region
  Physical Surface("RegClad1409")={1804};   // pin clad
  Physical Surface("RegFuel1409")={1805};   // pin fuel

// ==============================
//    define rod 15,9

  Point(1355) = { 18.27000000, 10.71000000, 0, lc};

  Point(1356) = { 17.79500000, 10.71000000, 0, lc};
  Point(1357) = { 18.74500000, 10.71000000, 0, lc};
  Point(1358) = { 18.27000000, 10.23500000, 0, lc};
  Point(1359) = { 18.27000000, 11.18500000, 0, lc};
  Circle(1806) = {1359,1355,1357};
  Circle(1807) = {1357,1355,1358};
  Circle(1808) = {1358,1355,1356};
  Circle(1809) = {1356,1355,1359};
  Line Loop(1810) = {1806,1807,1808,1809};   // clad surface

  Point(1360) = { 17.85200000, 10.71000000, 0, lc};
  Point(1361) = { 18.68800000, 10.71000000, 0, lc};
  Point(1362) = { 18.27000000, 10.29200000, 0, lc};
  Point(1363) = { 18.27000000, 11.12800000, 0, lc};
  Circle(1811) = {1363,1355,1361};
  Circle(1812) = {1361,1355,1362};
  Circle(1813) = {1362,1355,1360};
  Circle(1814) = {1360,1355,1363};
  Line Loop(1815) = {1811,1812,1813,1814};   // fuel surface

// define rod regions
  Plane Surface(1816) = {1810,1815};   // clad region
  Plane Surface(1817) = {1815};      // fuel region
  Physical Surface("RegClad1509")={1816};   // pin clad
  Physical Surface("RegFuel1509")={1817};   // pin fuel

// ==============================
//    define rod 16,9

  Point(1364) = { 19.53000000, 10.71000000, 0, lc};

  Point(1365) = { 19.05500000, 10.71000000, 0, lc};
  Point(1366) = { 20.00500000, 10.71000000, 0, lc};
  Point(1367) = { 19.53000000, 10.23500000, 0, lc};
  Point(1368) = { 19.53000000, 11.18500000, 0, lc};
  Circle(1818) = {1368,1364,1366};
  Circle(1819) = {1366,1364,1367};
  Circle(1820) = {1367,1364,1365};
  Circle(1821) = {1365,1364,1368};
  Line Loop(1822) = {1818,1819,1820,1821};   // clad surface

  Point(1369) = { 19.11200000, 10.71000000, 0, lc};
  Point(1370) = { 19.94800000, 10.71000000, 0, lc};
  Point(1371) = { 19.53000000, 10.29200000, 0, lc};
  Point(1372) = { 19.53000000, 11.12800000, 0, lc};
  Circle(1823) = {1372,1364,1370};
  Circle(1824) = {1370,1364,1371};
  Circle(1825) = {1371,1364,1369};
  Circle(1826) = {1369,1364,1372};
  Line Loop(1827) = {1823,1824,1825,1826};   // fuel surface

// define rod regions
  Plane Surface(1828) = {1822,1827};   // clad region
  Plane Surface(1829) = {1827};      // fuel region
  Physical Surface("RegClad1609")={1828};   // pin clad
  Physical Surface("RegFuel1609")={1829};   // pin fuel

// ==============================
//    define rod 17,9

  Point(1373) = { 20.79000000, 10.71000000, 0, lc};

  Point(1374) = { 20.31500000, 10.71000000, 0, lc};
  Point(1375) = { 21.26500000, 10.71000000, 0, lc};
  Point(1376) = { 20.79000000, 10.23500000, 0, lc};
  Point(1377) = { 20.79000000, 11.18500000, 0, lc};
  Circle(1830) = {1377,1373,1375};
  Circle(1831) = {1375,1373,1376};
  Circle(1832) = {1376,1373,1374};
  Circle(1833) = {1374,1373,1377};
  Line Loop(1834) = {1830,1831,1832,1833};   // clad surface

  Point(1378) = { 20.37200000, 10.71000000, 0, lc};
  Point(1379) = { 21.20800000, 10.71000000, 0, lc};
  Point(1380) = { 20.79000000, 10.29200000, 0, lc};
  Point(1381) = { 20.79000000, 11.12800000, 0, lc};
  Circle(1835) = {1381,1373,1379};
  Circle(1836) = {1379,1373,1380};
  Circle(1837) = {1380,1373,1378};
  Circle(1838) = {1378,1373,1381};
  Line Loop(1839) = {1835,1836,1837,1838};   // fuel surface

// define rod regions
  Plane Surface(1840) = {1834,1839};   // clad region
  Plane Surface(1841) = {1839};      // fuel region
  Physical Surface("RegClad1709")={1840};   // pin clad
  Physical Surface("RegFuel1709")={1841};   // pin fuel

// ==============================
//    define rod 1,10

  Point(1382) = {  0.63000000, 11.97000000, 0, lc};

  Point(1383) = {  0.15500000, 11.97000000, 0, lc};
  Point(1384) = {  1.10500000, 11.97000000, 0, lc};
  Point(1385) = {  0.63000000, 11.49500000, 0, lc};
  Point(1386) = {  0.63000000, 12.44500000, 0, lc};
  Circle(1842) = {1386,1382,1384};
  Circle(1843) = {1384,1382,1385};
  Circle(1844) = {1385,1382,1383};
  Circle(1845) = {1383,1382,1386};
  Line Loop(1846) = {1842,1843,1844,1845};   // clad surface

  Point(1387) = {  0.21200000, 11.97000000, 0, lc};
  Point(1388) = {  1.04800000, 11.97000000, 0, lc};
  Point(1389) = {  0.63000000, 11.55200000, 0, lc};
  Point(1390) = {  0.63000000, 12.38800000, 0, lc};
  Circle(1847) = {1390,1382,1388};
  Circle(1848) = {1388,1382,1389};
  Circle(1849) = {1389,1382,1387};
  Circle(1850) = {1387,1382,1390};
  Line Loop(1851) = {1847,1848,1849,1850};   // fuel surface

// define rod regions
  Plane Surface(1852) = {1846,1851};   // clad region
  Plane Surface(1853) = {1851};      // fuel region
  Physical Surface("RegClad0110")={1852};   // pin clad
  Physical Surface("RegFuel0110")={1853};   // pin fuel

// ==============================
//    define rod 2,10

  Point(1391) = {  1.89000000, 11.97000000, 0, lc};

  Point(1392) = {  1.41500000, 11.97000000, 0, lc};
  Point(1393) = {  2.36500000, 11.97000000, 0, lc};
  Point(1394) = {  1.89000000, 11.49500000, 0, lc};
  Point(1395) = {  1.89000000, 12.44500000, 0, lc};
  Circle(1854) = {1395,1391,1393};
  Circle(1855) = {1393,1391,1394};
  Circle(1856) = {1394,1391,1392};
  Circle(1857) = {1392,1391,1395};
  Line Loop(1858) = {1854,1855,1856,1857};   // clad surface

  Point(1396) = {  1.47200000, 11.97000000, 0, lc};
  Point(1397) = {  2.30800000, 11.97000000, 0, lc};
  Point(1398) = {  1.89000000, 11.55200000, 0, lc};
  Point(1399) = {  1.89000000, 12.38800000, 0, lc};
  Circle(1859) = {1399,1391,1397};
  Circle(1860) = {1397,1391,1398};
  Circle(1861) = {1398,1391,1396};
  Circle(1862) = {1396,1391,1399};
  Line Loop(1863) = {1859,1860,1861,1862};   // fuel surface

// define rod regions
  Plane Surface(1864) = {1858,1863};   // clad region
  Plane Surface(1865) = {1863};      // fuel region
  Physical Surface("RegClad0210")={1864};   // pin clad
  Physical Surface("RegFuel0210")={1865};   // pin fuel

// ==============================
//    define rod 3,10

  Point(1400) = {  3.15000000, 11.97000000, 0, lc};

  Point(1401) = {  2.67500000, 11.97000000, 0, lc};
  Point(1402) = {  3.62500000, 11.97000000, 0, lc};
  Point(1403) = {  3.15000000, 11.49500000, 0, lc};
  Point(1404) = {  3.15000000, 12.44500000, 0, lc};
  Circle(1866) = {1404,1400,1402};
  Circle(1867) = {1402,1400,1403};
  Circle(1868) = {1403,1400,1401};
  Circle(1869) = {1401,1400,1404};
  Line Loop(1870) = {1866,1867,1868,1869};   // clad surface

  Point(1405) = {  2.73200000, 11.97000000, 0, lc};
  Point(1406) = {  3.56800000, 11.97000000, 0, lc};
  Point(1407) = {  3.15000000, 11.55200000, 0, lc};
  Point(1408) = {  3.15000000, 12.38800000, 0, lc};
  Circle(1871) = {1408,1400,1406};
  Circle(1872) = {1406,1400,1407};
  Circle(1873) = {1407,1400,1405};
  Circle(1874) = {1405,1400,1408};
  Line Loop(1875) = {1871,1872,1873,1874};   // fuel surface

// define rod regions
  Plane Surface(1876) = {1870,1875};   // clad region
  Plane Surface(1877) = {1875};      // fuel region
  Physical Surface("RegClad0310")={1876};   // pin clad
  Physical Surface("RegFuel0310")={1877};   // pin fuel

// ==============================
//    define rod 4,10

  Point(1409) = {  4.41000000, 11.97000000, 0, lc};

  Point(1410) = {  3.93500000, 11.97000000, 0, lc};
  Point(1411) = {  4.88500000, 11.97000000, 0, lc};
  Point(1412) = {  4.41000000, 11.49500000, 0, lc};
  Point(1413) = {  4.41000000, 12.44500000, 0, lc};
  Circle(1878) = {1413,1409,1411};
  Circle(1879) = {1411,1409,1412};
  Circle(1880) = {1412,1409,1410};
  Circle(1881) = {1410,1409,1413};
  Line Loop(1882) = {1878,1879,1880,1881};   // clad surface

  Point(1414) = {  3.99200000, 11.97000000, 0, lc};
  Point(1415) = {  4.82800000, 11.97000000, 0, lc};
  Point(1416) = {  4.41000000, 11.55200000, 0, lc};
  Point(1417) = {  4.41000000, 12.38800000, 0, lc};
  Circle(1883) = {1417,1409,1415};
  Circle(1884) = {1415,1409,1416};
  Circle(1885) = {1416,1409,1414};
  Circle(1886) = {1414,1409,1417};
  Line Loop(1887) = {1883,1884,1885,1886};   // fuel surface

// define rod regions
  Plane Surface(1888) = {1882,1887};   // clad region
  Plane Surface(1889) = {1887};      // fuel region
  Physical Surface("RegClad0410")={1888};   // pin clad
  Physical Surface("RegFuel0410")={1889};   // pin fuel

// ==============================
//    define rod 5,10

  Point(1418) = {  5.67000000, 11.97000000, 0, lc};

  Point(1419) = {  5.19500000, 11.97000000, 0, lc};
  Point(1420) = {  6.14500000, 11.97000000, 0, lc};
  Point(1421) = {  5.67000000, 11.49500000, 0, lc};
  Point(1422) = {  5.67000000, 12.44500000, 0, lc};
  Circle(1890) = {1422,1418,1420};
  Circle(1891) = {1420,1418,1421};
  Circle(1892) = {1421,1418,1419};
  Circle(1893) = {1419,1418,1422};
  Line Loop(1894) = {1890,1891,1892,1893};   // clad surface

  Point(1423) = {  5.25200000, 11.97000000, 0, lc};
  Point(1424) = {  6.08800000, 11.97000000, 0, lc};
  Point(1425) = {  5.67000000, 11.55200000, 0, lc};
  Point(1426) = {  5.67000000, 12.38800000, 0, lc};
  Circle(1895) = {1426,1418,1424};
  Circle(1896) = {1424,1418,1425};
  Circle(1897) = {1425,1418,1423};
  Circle(1898) = {1423,1418,1426};
  Line Loop(1899) = {1895,1896,1897,1898};   // fuel surface

// define rod regions
  Plane Surface(1900) = {1894,1899};   // clad region
  Plane Surface(1901) = {1899};      // fuel region
  Physical Surface("RegClad0510")={1900};   // pin clad
  Physical Surface("RegFuel0510")={1901};   // pin fuel

// ==============================
//    define rod 6,10

  Point(1427) = {  6.93000000, 11.97000000, 0, lc};

  Point(1428) = {  6.45500000, 11.97000000, 0, lc};
  Point(1429) = {  7.40500000, 11.97000000, 0, lc};
  Point(1430) = {  6.93000000, 11.49500000, 0, lc};
  Point(1431) = {  6.93000000, 12.44500000, 0, lc};
  Circle(1902) = {1431,1427,1429};
  Circle(1903) = {1429,1427,1430};
  Circle(1904) = {1430,1427,1428};
  Circle(1905) = {1428,1427,1431};
  Line Loop(1906) = {1902,1903,1904,1905};   // clad surface

  Point(1432) = {  6.51200000, 11.97000000, 0, lc};
  Point(1433) = {  7.34800000, 11.97000000, 0, lc};
  Point(1434) = {  6.93000000, 11.55200000, 0, lc};
  Point(1435) = {  6.93000000, 12.38800000, 0, lc};
  Circle(1907) = {1435,1427,1433};
  Circle(1908) = {1433,1427,1434};
  Circle(1909) = {1434,1427,1432};
  Circle(1910) = {1432,1427,1435};
  Line Loop(1911) = {1907,1908,1909,1910};   // fuel surface

// define rod regions
  Plane Surface(1912) = {1906,1911};   // clad region
  Plane Surface(1913) = {1911};      // fuel region
  Physical Surface("RegClad0610")={1912};   // pin clad
  Physical Surface("RegFuel0610")={1913};   // pin fuel

// ==============================
//    define rod 7,10

  Point(1436) = {  8.19000000, 11.97000000, 0, lc};

  Point(1437) = {  7.71500000, 11.97000000, 0, lc};
  Point(1438) = {  8.66500000, 11.97000000, 0, lc};
  Point(1439) = {  8.19000000, 11.49500000, 0, lc};
  Point(1440) = {  8.19000000, 12.44500000, 0, lc};
  Circle(1914) = {1440,1436,1438};
  Circle(1915) = {1438,1436,1439};
  Circle(1916) = {1439,1436,1437};
  Circle(1917) = {1437,1436,1440};
  Line Loop(1918) = {1914,1915,1916,1917};   // clad surface

  Point(1441) = {  7.77200000, 11.97000000, 0, lc};
  Point(1442) = {  8.60800000, 11.97000000, 0, lc};
  Point(1443) = {  8.19000000, 11.55200000, 0, lc};
  Point(1444) = {  8.19000000, 12.38800000, 0, lc};
  Circle(1919) = {1444,1436,1442};
  Circle(1920) = {1442,1436,1443};
  Circle(1921) = {1443,1436,1441};
  Circle(1922) = {1441,1436,1444};
  Line Loop(1923) = {1919,1920,1921,1922};   // fuel surface

// define rod regions
  Plane Surface(1924) = {1918,1923};   // clad region
  Plane Surface(1925) = {1923};      // fuel region
  Physical Surface("RegClad0710")={1924};   // pin clad
  Physical Surface("RegFuel0710")={1925};   // pin fuel

// ==============================
//    define rod 8,10

  Point(1445) = {  9.45000000, 11.97000000, 0, lc};

  Point(1446) = {  8.97500000, 11.97000000, 0, lc};
  Point(1447) = {  9.92500000, 11.97000000, 0, lc};
  Point(1448) = {  9.45000000, 11.49500000, 0, lc};
  Point(1449) = {  9.45000000, 12.44500000, 0, lc};
  Circle(1926) = {1449,1445,1447};
  Circle(1927) = {1447,1445,1448};
  Circle(1928) = {1448,1445,1446};
  Circle(1929) = {1446,1445,1449};
  Line Loop(1930) = {1926,1927,1928,1929};   // clad surface

  Point(1450) = {  9.03200000, 11.97000000, 0, lc};
  Point(1451) = {  9.86800000, 11.97000000, 0, lc};
  Point(1452) = {  9.45000000, 11.55200000, 0, lc};
  Point(1453) = {  9.45000000, 12.38800000, 0, lc};
  Circle(1931) = {1453,1445,1451};
  Circle(1932) = {1451,1445,1452};
  Circle(1933) = {1452,1445,1450};
  Circle(1934) = {1450,1445,1453};
  Line Loop(1935) = {1931,1932,1933,1934};   // fuel surface

// define rod regions
  Plane Surface(1936) = {1930,1935};   // clad region
  Plane Surface(1937) = {1935};      // fuel region
  Physical Surface("RegClad0810")={1936};   // pin clad
  Physical Surface("RegFuel0810")={1937};   // pin fuel

// ==============================
//    define rod 9,10

  Point(1454) = { 10.71000000, 11.97000000, 0, lc};

  Point(1455) = { 10.23500000, 11.97000000, 0, lc};
  Point(1456) = { 11.18500000, 11.97000000, 0, lc};
  Point(1457) = { 10.71000000, 11.49500000, 0, lc};
  Point(1458) = { 10.71000000, 12.44500000, 0, lc};
  Circle(1938) = {1458,1454,1456};
  Circle(1939) = {1456,1454,1457};
  Circle(1940) = {1457,1454,1455};
  Circle(1941) = {1455,1454,1458};
  Line Loop(1942) = {1938,1939,1940,1941};   // clad surface

  Point(1459) = { 10.29200000, 11.97000000, 0, lc};
  Point(1460) = { 11.12800000, 11.97000000, 0, lc};
  Point(1461) = { 10.71000000, 11.55200000, 0, lc};
  Point(1462) = { 10.71000000, 12.38800000, 0, lc};
  Circle(1943) = {1462,1454,1460};
  Circle(1944) = {1460,1454,1461};
  Circle(1945) = {1461,1454,1459};
  Circle(1946) = {1459,1454,1462};
  Line Loop(1947) = {1943,1944,1945,1946};   // fuel surface

// define rod regions
  Plane Surface(1948) = {1942,1947};   // clad region
  Plane Surface(1949) = {1947};      // fuel region
  Physical Surface("RegClad0910")={1948};   // pin clad
  Physical Surface("RegFuel0910")={1949};   // pin fuel

// ==============================
//    define rod 10,10

  Point(1463) = { 11.97000000, 11.97000000, 0, lc};

  Point(1464) = { 11.49500000, 11.97000000, 0, lc};
  Point(1465) = { 12.44500000, 11.97000000, 0, lc};
  Point(1466) = { 11.97000000, 11.49500000, 0, lc};
  Point(1467) = { 11.97000000, 12.44500000, 0, lc};
  Circle(1950) = {1467,1463,1465};
  Circle(1951) = {1465,1463,1466};
  Circle(1952) = {1466,1463,1464};
  Circle(1953) = {1464,1463,1467};
  Line Loop(1954) = {1950,1951,1952,1953};   // clad surface

  Point(1468) = { 11.55200000, 11.97000000, 0, lc};
  Point(1469) = { 12.38800000, 11.97000000, 0, lc};
  Point(1470) = { 11.97000000, 11.55200000, 0, lc};
  Point(1471) = { 11.97000000, 12.38800000, 0, lc};
  Circle(1955) = {1471,1463,1469};
  Circle(1956) = {1469,1463,1470};
  Circle(1957) = {1470,1463,1468};
  Circle(1958) = {1468,1463,1471};
  Line Loop(1959) = {1955,1956,1957,1958};   // fuel surface

// define rod regions
  Plane Surface(1960) = {1954,1959};   // clad region
  Plane Surface(1961) = {1959};      // fuel region
  Physical Surface("RegClad1010")={1960};   // pin clad
  Physical Surface("RegFuel1010")={1961};   // pin fuel

// ==============================
//    define rod 11,10

  Point(1472) = { 13.23000000, 11.97000000, 0, lc};

  Point(1473) = { 12.75500000, 11.97000000, 0, lc};
  Point(1474) = { 13.70500000, 11.97000000, 0, lc};
  Point(1475) = { 13.23000000, 11.49500000, 0, lc};
  Point(1476) = { 13.23000000, 12.44500000, 0, lc};
  Circle(1962) = {1476,1472,1474};
  Circle(1963) = {1474,1472,1475};
  Circle(1964) = {1475,1472,1473};
  Circle(1965) = {1473,1472,1476};
  Line Loop(1966) = {1962,1963,1964,1965};   // clad surface

  Point(1477) = { 12.81200000, 11.97000000, 0, lc};
  Point(1478) = { 13.64800000, 11.97000000, 0, lc};
  Point(1479) = { 13.23000000, 11.55200000, 0, lc};
  Point(1480) = { 13.23000000, 12.38800000, 0, lc};
  Circle(1967) = {1480,1472,1478};
  Circle(1968) = {1478,1472,1479};
  Circle(1969) = {1479,1472,1477};
  Circle(1970) = {1477,1472,1480};
  Line Loop(1971) = {1967,1968,1969,1970};   // fuel surface

// define rod regions
  Plane Surface(1972) = {1966,1971};   // clad region
  Plane Surface(1973) = {1971};      // fuel region
  Physical Surface("RegClad1110")={1972};   // pin clad
  Physical Surface("RegFuel1110")={1973};   // pin fuel

// ==============================
//    define rod 12,10

  Point(1481) = { 14.49000000, 11.97000000, 0, lc};

  Point(1482) = { 14.01500000, 11.97000000, 0, lc};
  Point(1483) = { 14.96500000, 11.97000000, 0, lc};
  Point(1484) = { 14.49000000, 11.49500000, 0, lc};
  Point(1485) = { 14.49000000, 12.44500000, 0, lc};
  Circle(1974) = {1485,1481,1483};
  Circle(1975) = {1483,1481,1484};
  Circle(1976) = {1484,1481,1482};
  Circle(1977) = {1482,1481,1485};
  Line Loop(1978) = {1974,1975,1976,1977};   // clad surface

  Point(1486) = { 14.07200000, 11.97000000, 0, lc};
  Point(1487) = { 14.90800000, 11.97000000, 0, lc};
  Point(1488) = { 14.49000000, 11.55200000, 0, lc};
  Point(1489) = { 14.49000000, 12.38800000, 0, lc};
  Circle(1979) = {1489,1481,1487};
  Circle(1980) = {1487,1481,1488};
  Circle(1981) = {1488,1481,1486};
  Circle(1982) = {1486,1481,1489};
  Line Loop(1983) = {1979,1980,1981,1982};   // fuel surface

// define rod regions
  Plane Surface(1984) = {1978,1983};   // clad region
  Plane Surface(1985) = {1983};      // fuel region
  Physical Surface("RegClad1210")={1984};   // pin clad
  Physical Surface("RegFuel1210")={1985};   // pin fuel

// ==============================
//    define rod 13,10

  Point(1490) = { 15.75000000, 11.97000000, 0, lc};

  Point(1491) = { 15.27500000, 11.97000000, 0, lc};
  Point(1492) = { 16.22500000, 11.97000000, 0, lc};
  Point(1493) = { 15.75000000, 11.49500000, 0, lc};
  Point(1494) = { 15.75000000, 12.44500000, 0, lc};
  Circle(1986) = {1494,1490,1492};
  Circle(1987) = {1492,1490,1493};
  Circle(1988) = {1493,1490,1491};
  Circle(1989) = {1491,1490,1494};
  Line Loop(1990) = {1986,1987,1988,1989};   // clad surface

  Point(1495) = { 15.33200000, 11.97000000, 0, lc};
  Point(1496) = { 16.16800000, 11.97000000, 0, lc};
  Point(1497) = { 15.75000000, 11.55200000, 0, lc};
  Point(1498) = { 15.75000000, 12.38800000, 0, lc};
  Circle(1991) = {1498,1490,1496};
  Circle(1992) = {1496,1490,1497};
  Circle(1993) = {1497,1490,1495};
  Circle(1994) = {1495,1490,1498};
  Line Loop(1995) = {1991,1992,1993,1994};   // fuel surface

// define rod regions
  Plane Surface(1996) = {1990,1995};   // clad region
  Plane Surface(1997) = {1995};      // fuel region
  Physical Surface("RegClad1310")={1996};   // pin clad
  Physical Surface("RegFuel1310")={1997};   // pin fuel

// ==============================
//    define rod 14,10

  Point(1499) = { 17.01000000, 11.97000000, 0, lc};

  Point(1500) = { 16.53500000, 11.97000000, 0, lc};
  Point(1501) = { 17.48500000, 11.97000000, 0, lc};
  Point(1502) = { 17.01000000, 11.49500000, 0, lc};
  Point(1503) = { 17.01000000, 12.44500000, 0, lc};
  Circle(1998) = {1503,1499,1501};
  Circle(1999) = {1501,1499,1502};
  Circle(2000) = {1502,1499,1500};
  Circle(2001) = {1500,1499,1503};
  Line Loop(2002) = {1998,1999,2000,2001};   // clad surface

  Point(1504) = { 16.59200000, 11.97000000, 0, lc};
  Point(1505) = { 17.42800000, 11.97000000, 0, lc};
  Point(1506) = { 17.01000000, 11.55200000, 0, lc};
  Point(1507) = { 17.01000000, 12.38800000, 0, lc};
  Circle(2003) = {1507,1499,1505};
  Circle(2004) = {1505,1499,1506};
  Circle(2005) = {1506,1499,1504};
  Circle(2006) = {1504,1499,1507};
  Line Loop(2007) = {2003,2004,2005,2006};   // fuel surface

// define rod regions
  Plane Surface(2008) = {2002,2007};   // clad region
  Plane Surface(2009) = {2007};      // fuel region
  Physical Surface("RegClad1410")={2008};   // pin clad
  Physical Surface("RegFuel1410")={2009};   // pin fuel

// ==============================
//    define rod 15,10

  Point(1508) = { 18.27000000, 11.97000000, 0, lc};

  Point(1509) = { 17.79500000, 11.97000000, 0, lc};
  Point(1510) = { 18.74500000, 11.97000000, 0, lc};
  Point(1511) = { 18.27000000, 11.49500000, 0, lc};
  Point(1512) = { 18.27000000, 12.44500000, 0, lc};
  Circle(2010) = {1512,1508,1510};
  Circle(2011) = {1510,1508,1511};
  Circle(2012) = {1511,1508,1509};
  Circle(2013) = {1509,1508,1512};
  Line Loop(2014) = {2010,2011,2012,2013};   // clad surface

  Point(1513) = { 17.85200000, 11.97000000, 0, lc};
  Point(1514) = { 18.68800000, 11.97000000, 0, lc};
  Point(1515) = { 18.27000000, 11.55200000, 0, lc};
  Point(1516) = { 18.27000000, 12.38800000, 0, lc};
  Circle(2015) = {1516,1508,1514};
  Circle(2016) = {1514,1508,1515};
  Circle(2017) = {1515,1508,1513};
  Circle(2018) = {1513,1508,1516};
  Line Loop(2019) = {2015,2016,2017,2018};   // fuel surface

// define rod regions
  Plane Surface(2020) = {2014,2019};   // clad region
  Plane Surface(2021) = {2019};      // fuel region
  Physical Surface("RegClad1510")={2020};   // pin clad
  Physical Surface("RegFuel1510")={2021};   // pin fuel

// ==============================
//    define rod 16,10

  Point(1517) = { 19.53000000, 11.97000000, 0, lc};

  Point(1518) = { 19.05500000, 11.97000000, 0, lc};
  Point(1519) = { 20.00500000, 11.97000000, 0, lc};
  Point(1520) = { 19.53000000, 11.49500000, 0, lc};
  Point(1521) = { 19.53000000, 12.44500000, 0, lc};
  Circle(2022) = {1521,1517,1519};
  Circle(2023) = {1519,1517,1520};
  Circle(2024) = {1520,1517,1518};
  Circle(2025) = {1518,1517,1521};
  Line Loop(2026) = {2022,2023,2024,2025};   // clad surface

  Point(1522) = { 19.11200000, 11.97000000, 0, lc};
  Point(1523) = { 19.94800000, 11.97000000, 0, lc};
  Point(1524) = { 19.53000000, 11.55200000, 0, lc};
  Point(1525) = { 19.53000000, 12.38800000, 0, lc};
  Circle(2027) = {1525,1517,1523};
  Circle(2028) = {1523,1517,1524};
  Circle(2029) = {1524,1517,1522};
  Circle(2030) = {1522,1517,1525};
  Line Loop(2031) = {2027,2028,2029,2030};   // fuel surface

// define rod regions
  Plane Surface(2032) = {2026,2031};   // clad region
  Plane Surface(2033) = {2031};      // fuel region
  Physical Surface("RegClad1610")={2032};   // pin clad
  Physical Surface("RegFuel1610")={2033};   // pin fuel

// ==============================
//    define rod 17,10

  Point(1526) = { 20.79000000, 11.97000000, 0, lc};

  Point(1527) = { 20.31500000, 11.97000000, 0, lc};
  Point(1528) = { 21.26500000, 11.97000000, 0, lc};
  Point(1529) = { 20.79000000, 11.49500000, 0, lc};
  Point(1530) = { 20.79000000, 12.44500000, 0, lc};
  Circle(2034) = {1530,1526,1528};
  Circle(2035) = {1528,1526,1529};
  Circle(2036) = {1529,1526,1527};
  Circle(2037) = {1527,1526,1530};
  Line Loop(2038) = {2034,2035,2036,2037};   // clad surface

  Point(1531) = { 20.37200000, 11.97000000, 0, lc};
  Point(1532) = { 21.20800000, 11.97000000, 0, lc};
  Point(1533) = { 20.79000000, 11.55200000, 0, lc};
  Point(1534) = { 20.79000000, 12.38800000, 0, lc};
  Circle(2039) = {1534,1526,1532};
  Circle(2040) = {1532,1526,1533};
  Circle(2041) = {1533,1526,1531};
  Circle(2042) = {1531,1526,1534};
  Line Loop(2043) = {2039,2040,2041,2042};   // fuel surface

// define rod regions
  Plane Surface(2044) = {2038,2043};   // clad region
  Plane Surface(2045) = {2043};      // fuel region
  Physical Surface("RegClad1710")={2044};   // pin clad
  Physical Surface("RegFuel1710")={2045};   // pin fuel

// ==============================
//    define rod 1,11

  Point(1535) = {  0.63000000, 13.23000000, 0, lc};

  Point(1536) = {  0.15500000, 13.23000000, 0, lc};
  Point(1537) = {  1.10500000, 13.23000000, 0, lc};
  Point(1538) = {  0.63000000, 12.75500000, 0, lc};
  Point(1539) = {  0.63000000, 13.70500000, 0, lc};
  Circle(2046) = {1539,1535,1537};
  Circle(2047) = {1537,1535,1538};
  Circle(2048) = {1538,1535,1536};
  Circle(2049) = {1536,1535,1539};
  Line Loop(2050) = {2046,2047,2048,2049};   // clad surface

  Point(1540) = {  0.21200000, 13.23000000, 0, lc};
  Point(1541) = {  1.04800000, 13.23000000, 0, lc};
  Point(1542) = {  0.63000000, 12.81200000, 0, lc};
  Point(1543) = {  0.63000000, 13.64800000, 0, lc};
  Circle(2051) = {1543,1535,1541};
  Circle(2052) = {1541,1535,1542};
  Circle(2053) = {1542,1535,1540};
  Circle(2054) = {1540,1535,1543};
  Line Loop(2055) = {2051,2052,2053,2054};   // fuel surface

// define rod regions
  Plane Surface(2056) = {2050,2055};   // clad region
  Plane Surface(2057) = {2055};      // fuel region
  Physical Surface("RegClad0111")={2056};   // pin clad
  Physical Surface("RegFuel0111")={2057};   // pin fuel

// ==============================
//    define rod 2,11

  Point(1544) = {  1.89000000, 13.23000000, 0, lc};

  Point(1545) = {  1.41500000, 13.23000000, 0, lc};
  Point(1546) = {  2.36500000, 13.23000000, 0, lc};
  Point(1547) = {  1.89000000, 12.75500000, 0, lc};
  Point(1548) = {  1.89000000, 13.70500000, 0, lc};
  Circle(2058) = {1548,1544,1546};
  Circle(2059) = {1546,1544,1547};
  Circle(2060) = {1547,1544,1545};
  Circle(2061) = {1545,1544,1548};
  Line Loop(2062) = {2058,2059,2060,2061};   // clad surface

  Point(1549) = {  1.47200000, 13.23000000, 0, lc};
  Point(1550) = {  2.30800000, 13.23000000, 0, lc};
  Point(1551) = {  1.89000000, 12.81200000, 0, lc};
  Point(1552) = {  1.89000000, 13.64800000, 0, lc};
  Circle(2063) = {1552,1544,1550};
  Circle(2064) = {1550,1544,1551};
  Circle(2065) = {1551,1544,1549};
  Circle(2066) = {1549,1544,1552};
  Line Loop(2067) = {2063,2064,2065,2066};   // fuel surface

// define rod regions
  Plane Surface(2068) = {2062,2067};   // clad region
  Plane Surface(2069) = {2067};      // fuel region
  Physical Surface("RegClad0211")={2068};   // pin clad
  Physical Surface("RegFuel0211")={2069};   // pin fuel

// ==============================
//    define rod 3,11

  Point(1553) = {  3.15000000, 13.23000000, 0, lc};

  Point(1554) = {  2.67500000, 13.23000000, 0, lc};
  Point(1555) = {  3.62500000, 13.23000000, 0, lc};
  Point(1556) = {  3.15000000, 12.75500000, 0, lc};
  Point(1557) = {  3.15000000, 13.70500000, 0, lc};
  Circle(2070) = {1557,1553,1555};
  Circle(2071) = {1555,1553,1556};
  Circle(2072) = {1556,1553,1554};
  Circle(2073) = {1554,1553,1557};
  Line Loop(2074) = {2070,2071,2072,2073};   // clad surface

  Point(1558) = {  2.73200000, 13.23000000, 0, lc};
  Point(1559) = {  3.56800000, 13.23000000, 0, lc};
  Point(1560) = {  3.15000000, 12.81200000, 0, lc};
  Point(1561) = {  3.15000000, 13.64800000, 0, lc};
  Circle(2075) = {1561,1553,1559};
  Circle(2076) = {1559,1553,1560};
  Circle(2077) = {1560,1553,1558};
  Circle(2078) = {1558,1553,1561};
  Line Loop(2079) = {2075,2076,2077,2078};   // fuel surface

// define rod regions
  Plane Surface(2080) = {2074,2079};   // clad region
  Plane Surface(2081) = {2079};      // fuel region
  Physical Surface("RegClad0311")={2080};   // pin clad
  Physical Surface("RegFuel0311")={2081};   // pin fuel

// ==============================
//    define rod 4,11

  Point(1562) = {  4.41000000, 13.23000000, 0, lc};

  Point(1563) = {  3.93500000, 13.23000000, 0, lc};
  Point(1564) = {  4.88500000, 13.23000000, 0, lc};
  Point(1565) = {  4.41000000, 12.75500000, 0, lc};
  Point(1566) = {  4.41000000, 13.70500000, 0, lc};
  Circle(2082) = {1566,1562,1564};
  Circle(2083) = {1564,1562,1565};
  Circle(2084) = {1565,1562,1563};
  Circle(2085) = {1563,1562,1566};
  Line Loop(2086) = {2082,2083,2084,2085};   // clad surface

  Point(1567) = {  3.99200000, 13.23000000, 0, lc};
  Point(1568) = {  4.82800000, 13.23000000, 0, lc};
  Point(1569) = {  4.41000000, 12.81200000, 0, lc};
  Point(1570) = {  4.41000000, 13.64800000, 0, lc};
  Circle(2087) = {1570,1562,1568};
  Circle(2088) = {1568,1562,1569};
  Circle(2089) = {1569,1562,1567};
  Circle(2090) = {1567,1562,1570};
  Line Loop(2091) = {2087,2088,2089,2090};   // fuel surface

// define rod regions
  Plane Surface(2092) = {2086,2091};   // clad region
  Plane Surface(2093) = {2091};      // fuel region
  Physical Surface("RegClad0411")={2092};   // pin clad
  Physical Surface("RegFuel0411")={2093};   // pin fuel

// ==============================
//    define rod 5,11

  Point(1571) = {  5.67000000, 13.23000000, 0, lc};

  Point(1572) = {  5.19500000, 13.23000000, 0, lc};
  Point(1573) = {  6.14500000, 13.23000000, 0, lc};
  Point(1574) = {  5.67000000, 12.75500000, 0, lc};
  Point(1575) = {  5.67000000, 13.70500000, 0, lc};
  Circle(2094) = {1575,1571,1573};
  Circle(2095) = {1573,1571,1574};
  Circle(2096) = {1574,1571,1572};
  Circle(2097) = {1572,1571,1575};
  Line Loop(2098) = {2094,2095,2096,2097};   // clad surface

  Point(1576) = {  5.25200000, 13.23000000, 0, lc};
  Point(1577) = {  6.08800000, 13.23000000, 0, lc};
  Point(1578) = {  5.67000000, 12.81200000, 0, lc};
  Point(1579) = {  5.67000000, 13.64800000, 0, lc};
  Circle(2099) = {1579,1571,1577};
  Circle(2100) = {1577,1571,1578};
  Circle(2101) = {1578,1571,1576};
  Circle(2102) = {1576,1571,1579};
  Line Loop(2103) = {2099,2100,2101,2102};   // fuel surface

// define rod regions
  Plane Surface(2104) = {2098,2103};   // clad region
  Plane Surface(2105) = {2103};      // fuel region
  Physical Surface("RegClad0511")={2104};   // pin clad
  Physical Surface("RegFuel0511")={2105};   // pin fuel

// ==============================
//    define rod 6,11

  Point(1580) = {  6.93000000, 13.23000000, 0, lc};

  Point(1581) = {  6.45500000, 13.23000000, 0, lc};
  Point(1582) = {  7.40500000, 13.23000000, 0, lc};
  Point(1583) = {  6.93000000, 12.75500000, 0, lc};
  Point(1584) = {  6.93000000, 13.70500000, 0, lc};
  Circle(2106) = {1584,1580,1582};
  Circle(2107) = {1582,1580,1583};
  Circle(2108) = {1583,1580,1581};
  Circle(2109) = {1581,1580,1584};
  Line Loop(2110) = {2106,2107,2108,2109};   // clad surface

  Point(1585) = {  6.51200000, 13.23000000, 0, lc};
  Point(1586) = {  7.34800000, 13.23000000, 0, lc};
  Point(1587) = {  6.93000000, 12.81200000, 0, lc};
  Point(1588) = {  6.93000000, 13.64800000, 0, lc};
  Circle(2111) = {1588,1580,1586};
  Circle(2112) = {1586,1580,1587};
  Circle(2113) = {1587,1580,1585};
  Circle(2114) = {1585,1580,1588};
  Line Loop(2115) = {2111,2112,2113,2114};   // fuel surface

// define rod regions
  Plane Surface(2116) = {2110,2115};   // clad region
  Plane Surface(2117) = {2115};      // fuel region
  Physical Surface("RegClad0611")={2116};   // pin clad
  Physical Surface("RegFuel0611")={2117};   // pin fuel

// ==============================
//    define rod 7,11

  Point(1589) = {  8.19000000, 13.23000000, 0, lc};

  Point(1590) = {  7.71500000, 13.23000000, 0, lc};
  Point(1591) = {  8.66500000, 13.23000000, 0, lc};
  Point(1592) = {  8.19000000, 12.75500000, 0, lc};
  Point(1593) = {  8.19000000, 13.70500000, 0, lc};
  Circle(2118) = {1593,1589,1591};
  Circle(2119) = {1591,1589,1592};
  Circle(2120) = {1592,1589,1590};
  Circle(2121) = {1590,1589,1593};
  Line Loop(2122) = {2118,2119,2120,2121};   // clad surface

  Point(1594) = {  7.77200000, 13.23000000, 0, lc};
  Point(1595) = {  8.60800000, 13.23000000, 0, lc};
  Point(1596) = {  8.19000000, 12.81200000, 0, lc};
  Point(1597) = {  8.19000000, 13.64800000, 0, lc};
  Circle(2123) = {1597,1589,1595};
  Circle(2124) = {1595,1589,1596};
  Circle(2125) = {1596,1589,1594};
  Circle(2126) = {1594,1589,1597};
  Line Loop(2127) = {2123,2124,2125,2126};   // fuel surface

// define rod regions
  Plane Surface(2128) = {2122,2127};   // clad region
  Plane Surface(2129) = {2127};      // fuel region
  Physical Surface("RegClad0711")={2128};   // pin clad
  Physical Surface("RegFuel0711")={2129};   // pin fuel

// ==============================
//    define rod 8,11

  Point(1598) = {  9.45000000, 13.23000000, 0, lc};

  Point(1599) = {  8.97500000, 13.23000000, 0, lc};
  Point(1600) = {  9.92500000, 13.23000000, 0, lc};
  Point(1601) = {  9.45000000, 12.75500000, 0, lc};
  Point(1602) = {  9.45000000, 13.70500000, 0, lc};
  Circle(2130) = {1602,1598,1600};
  Circle(2131) = {1600,1598,1601};
  Circle(2132) = {1601,1598,1599};
  Circle(2133) = {1599,1598,1602};
  Line Loop(2134) = {2130,2131,2132,2133};   // clad surface

  Point(1603) = {  9.03200000, 13.23000000, 0, lc};
  Point(1604) = {  9.86800000, 13.23000000, 0, lc};
  Point(1605) = {  9.45000000, 12.81200000, 0, lc};
  Point(1606) = {  9.45000000, 13.64800000, 0, lc};
  Circle(2135) = {1606,1598,1604};
  Circle(2136) = {1604,1598,1605};
  Circle(2137) = {1605,1598,1603};
  Circle(2138) = {1603,1598,1606};
  Line Loop(2139) = {2135,2136,2137,2138};   // fuel surface

// define rod regions
  Plane Surface(2140) = {2134,2139};   // clad region
  Plane Surface(2141) = {2139};      // fuel region
  Physical Surface("RegClad0811")={2140};   // pin clad
  Physical Surface("RegFuel0811")={2141};   // pin fuel

// ==============================
//    define rod 9,11

  Point(1607) = { 10.71000000, 13.23000000, 0, lc};

  Point(1608) = { 10.23500000, 13.23000000, 0, lc};
  Point(1609) = { 11.18500000, 13.23000000, 0, lc};
  Point(1610) = { 10.71000000, 12.75500000, 0, lc};
  Point(1611) = { 10.71000000, 13.70500000, 0, lc};
  Circle(2142) = {1611,1607,1609};
  Circle(2143) = {1609,1607,1610};
  Circle(2144) = {1610,1607,1608};
  Circle(2145) = {1608,1607,1611};
  Line Loop(2146) = {2142,2143,2144,2145};   // clad surface

  Point(1612) = { 10.29200000, 13.23000000, 0, lc};
  Point(1613) = { 11.12800000, 13.23000000, 0, lc};
  Point(1614) = { 10.71000000, 12.81200000, 0, lc};
  Point(1615) = { 10.71000000, 13.64800000, 0, lc};
  Circle(2147) = {1615,1607,1613};
  Circle(2148) = {1613,1607,1614};
  Circle(2149) = {1614,1607,1612};
  Circle(2150) = {1612,1607,1615};
  Line Loop(2151) = {2147,2148,2149,2150};   // fuel surface

// define rod regions
  Plane Surface(2152) = {2146,2151};   // clad region
  Plane Surface(2153) = {2151};      // fuel region
  Physical Surface("RegClad0911")={2152};   // pin clad
  Physical Surface("RegFuel0911")={2153};   // pin fuel

// ==============================
//    define rod 10,11

  Point(1616) = { 11.97000000, 13.23000000, 0, lc};

  Point(1617) = { 11.49500000, 13.23000000, 0, lc};
  Point(1618) = { 12.44500000, 13.23000000, 0, lc};
  Point(1619) = { 11.97000000, 12.75500000, 0, lc};
  Point(1620) = { 11.97000000, 13.70500000, 0, lc};
  Circle(2154) = {1620,1616,1618};
  Circle(2155) = {1618,1616,1619};
  Circle(2156) = {1619,1616,1617};
  Circle(2157) = {1617,1616,1620};
  Line Loop(2158) = {2154,2155,2156,2157};   // clad surface

  Point(1621) = { 11.55200000, 13.23000000, 0, lc};
  Point(1622) = { 12.38800000, 13.23000000, 0, lc};
  Point(1623) = { 11.97000000, 12.81200000, 0, lc};
  Point(1624) = { 11.97000000, 13.64800000, 0, lc};
  Circle(2159) = {1624,1616,1622};
  Circle(2160) = {1622,1616,1623};
  Circle(2161) = {1623,1616,1621};
  Circle(2162) = {1621,1616,1624};
  Line Loop(2163) = {2159,2160,2161,2162};   // fuel surface

// define rod regions
  Plane Surface(2164) = {2158,2163};   // clad region
  Plane Surface(2165) = {2163};      // fuel region
  Physical Surface("RegClad1011")={2164};   // pin clad
  Physical Surface("RegFuel1011")={2165};   // pin fuel

// ==============================
//    define rod 11,11

  Point(1625) = { 13.23000000, 13.23000000, 0, lc};

  Point(1626) = { 12.75500000, 13.23000000, 0, lc};
  Point(1627) = { 13.70500000, 13.23000000, 0, lc};
  Point(1628) = { 13.23000000, 12.75500000, 0, lc};
  Point(1629) = { 13.23000000, 13.70500000, 0, lc};
  Circle(2166) = {1629,1625,1627};
  Circle(2167) = {1627,1625,1628};
  Circle(2168) = {1628,1625,1626};
  Circle(2169) = {1626,1625,1629};
  Line Loop(2170) = {2166,2167,2168,2169};   // clad surface

  Point(1630) = { 12.81200000, 13.23000000, 0, lc};
  Point(1631) = { 13.64800000, 13.23000000, 0, lc};
  Point(1632) = { 13.23000000, 12.81200000, 0, lc};
  Point(1633) = { 13.23000000, 13.64800000, 0, lc};
  Circle(2171) = {1633,1625,1631};
  Circle(2172) = {1631,1625,1632};
  Circle(2173) = {1632,1625,1630};
  Circle(2174) = {1630,1625,1633};
  Line Loop(2175) = {2171,2172,2173,2174};   // fuel surface

// define rod regions
  Plane Surface(2176) = {2170,2175};   // clad region
  Plane Surface(2177) = {2175};      // fuel region
  Physical Surface("RegClad1111")={2176};   // pin clad
  Physical Surface("RegFuel1111")={2177};   // pin fuel

// ==============================
//    define rod 12,11

  Point(1634) = { 14.49000000, 13.23000000, 0, lc};

  Point(1635) = { 14.01500000, 13.23000000, 0, lc};
  Point(1636) = { 14.96500000, 13.23000000, 0, lc};
  Point(1637) = { 14.49000000, 12.75500000, 0, lc};
  Point(1638) = { 14.49000000, 13.70500000, 0, lc};
  Circle(2178) = {1638,1634,1636};
  Circle(2179) = {1636,1634,1637};
  Circle(2180) = {1637,1634,1635};
  Circle(2181) = {1635,1634,1638};
  Line Loop(2182) = {2178,2179,2180,2181};   // clad surface

  Point(1639) = { 14.07200000, 13.23000000, 0, lc};
  Point(1640) = { 14.90800000, 13.23000000, 0, lc};
  Point(1641) = { 14.49000000, 12.81200000, 0, lc};
  Point(1642) = { 14.49000000, 13.64800000, 0, lc};
  Circle(2183) = {1642,1634,1640};
  Circle(2184) = {1640,1634,1641};
  Circle(2185) = {1641,1634,1639};
  Circle(2186) = {1639,1634,1642};
  Line Loop(2187) = {2183,2184,2185,2186};   // fuel surface

// define rod regions
  Plane Surface(2188) = {2182,2187};   // clad region
  Plane Surface(2189) = {2187};      // fuel region
  Physical Surface("RegClad1211")={2188};   // pin clad
  Physical Surface("RegFuel1211")={2189};   // pin fuel

// ==============================
//    define rod 13,11

  Point(1643) = { 15.75000000, 13.23000000, 0, lc};

  Point(1644) = { 15.27500000, 13.23000000, 0, lc};
  Point(1645) = { 16.22500000, 13.23000000, 0, lc};
  Point(1646) = { 15.75000000, 12.75500000, 0, lc};
  Point(1647) = { 15.75000000, 13.70500000, 0, lc};
  Circle(2190) = {1647,1643,1645};
  Circle(2191) = {1645,1643,1646};
  Circle(2192) = {1646,1643,1644};
  Circle(2193) = {1644,1643,1647};
  Line Loop(2194) = {2190,2191,2192,2193};   // clad surface

  Point(1648) = { 15.33200000, 13.23000000, 0, lc};
  Point(1649) = { 16.16800000, 13.23000000, 0, lc};
  Point(1650) = { 15.75000000, 12.81200000, 0, lc};
  Point(1651) = { 15.75000000, 13.64800000, 0, lc};
  Circle(2195) = {1651,1643,1649};
  Circle(2196) = {1649,1643,1650};
  Circle(2197) = {1650,1643,1648};
  Circle(2198) = {1648,1643,1651};
  Line Loop(2199) = {2195,2196,2197,2198};   // fuel surface

// define rod regions
  Plane Surface(2200) = {2194,2199};   // clad region
  Plane Surface(2201) = {2199};      // fuel region
  Physical Surface("RegClad1311")={2200};   // pin clad
  Physical Surface("RegFuel1311")={2201};   // pin fuel

// ==============================
//    define rod 14,11

  Point(1652) = { 17.01000000, 13.23000000, 0, lc};

  Point(1653) = { 16.53500000, 13.23000000, 0, lc};
  Point(1654) = { 17.48500000, 13.23000000, 0, lc};
  Point(1655) = { 17.01000000, 12.75500000, 0, lc};
  Point(1656) = { 17.01000000, 13.70500000, 0, lc};
  Circle(2202) = {1656,1652,1654};
  Circle(2203) = {1654,1652,1655};
  Circle(2204) = {1655,1652,1653};
  Circle(2205) = {1653,1652,1656};
  Line Loop(2206) = {2202,2203,2204,2205};   // clad surface

  Point(1657) = { 16.59200000, 13.23000000, 0, lc};
  Point(1658) = { 17.42800000, 13.23000000, 0, lc};
  Point(1659) = { 17.01000000, 12.81200000, 0, lc};
  Point(1660) = { 17.01000000, 13.64800000, 0, lc};
  Circle(2207) = {1660,1652,1658};
  Circle(2208) = {1658,1652,1659};
  Circle(2209) = {1659,1652,1657};
  Circle(2210) = {1657,1652,1660};
  Line Loop(2211) = {2207,2208,2209,2210};   // fuel surface

// define rod regions
  Plane Surface(2212) = {2206,2211};   // clad region
  Plane Surface(2213) = {2211};      // fuel region
  Physical Surface("RegClad1411")={2212};   // pin clad
  Physical Surface("RegFuel1411")={2213};   // pin fuel

// ==============================
//    define rod 15,11

  Point(1661) = { 18.27000000, 13.23000000, 0, lc};

  Point(1662) = { 17.79500000, 13.23000000, 0, lc};
  Point(1663) = { 18.74500000, 13.23000000, 0, lc};
  Point(1664) = { 18.27000000, 12.75500000, 0, lc};
  Point(1665) = { 18.27000000, 13.70500000, 0, lc};
  Circle(2214) = {1665,1661,1663};
  Circle(2215) = {1663,1661,1664};
  Circle(2216) = {1664,1661,1662};
  Circle(2217) = {1662,1661,1665};
  Line Loop(2218) = {2214,2215,2216,2217};   // clad surface

  Point(1666) = { 17.85200000, 13.23000000, 0, lc};
  Point(1667) = { 18.68800000, 13.23000000, 0, lc};
  Point(1668) = { 18.27000000, 12.81200000, 0, lc};
  Point(1669) = { 18.27000000, 13.64800000, 0, lc};
  Circle(2219) = {1669,1661,1667};
  Circle(2220) = {1667,1661,1668};
  Circle(2221) = {1668,1661,1666};
  Circle(2222) = {1666,1661,1669};
  Line Loop(2223) = {2219,2220,2221,2222};   // fuel surface

// define rod regions
  Plane Surface(2224) = {2218,2223};   // clad region
  Plane Surface(2225) = {2223};      // fuel region
  Physical Surface("RegClad1511")={2224};   // pin clad
  Physical Surface("RegFuel1511")={2225};   // pin fuel

// ==============================
//    define rod 16,11

  Point(1670) = { 19.53000000, 13.23000000, 0, lc};

  Point(1671) = { 19.05500000, 13.23000000, 0, lc};
  Point(1672) = { 20.00500000, 13.23000000, 0, lc};
  Point(1673) = { 19.53000000, 12.75500000, 0, lc};
  Point(1674) = { 19.53000000, 13.70500000, 0, lc};
  Circle(2226) = {1674,1670,1672};
  Circle(2227) = {1672,1670,1673};
  Circle(2228) = {1673,1670,1671};
  Circle(2229) = {1671,1670,1674};
  Line Loop(2230) = {2226,2227,2228,2229};   // clad surface

  Point(1675) = { 19.11200000, 13.23000000, 0, lc};
  Point(1676) = { 19.94800000, 13.23000000, 0, lc};
  Point(1677) = { 19.53000000, 12.81200000, 0, lc};
  Point(1678) = { 19.53000000, 13.64800000, 0, lc};
  Circle(2231) = {1678,1670,1676};
  Circle(2232) = {1676,1670,1677};
  Circle(2233) = {1677,1670,1675};
  Circle(2234) = {1675,1670,1678};
  Line Loop(2235) = {2231,2232,2233,2234};   // fuel surface

// define rod regions
  Plane Surface(2236) = {2230,2235};   // clad region
  Plane Surface(2237) = {2235};      // fuel region
  Physical Surface("RegClad1611")={2236};   // pin clad
  Physical Surface("RegFuel1611")={2237};   // pin fuel

// ==============================
//    define rod 17,11

  Point(1679) = { 20.79000000, 13.23000000, 0, lc};

  Point(1680) = { 20.31500000, 13.23000000, 0, lc};
  Point(1681) = { 21.26500000, 13.23000000, 0, lc};
  Point(1682) = { 20.79000000, 12.75500000, 0, lc};
  Point(1683) = { 20.79000000, 13.70500000, 0, lc};
  Circle(2238) = {1683,1679,1681};
  Circle(2239) = {1681,1679,1682};
  Circle(2240) = {1682,1679,1680};
  Circle(2241) = {1680,1679,1683};
  Line Loop(2242) = {2238,2239,2240,2241};   // clad surface

  Point(1684) = { 20.37200000, 13.23000000, 0, lc};
  Point(1685) = { 21.20800000, 13.23000000, 0, lc};
  Point(1686) = { 20.79000000, 12.81200000, 0, lc};
  Point(1687) = { 20.79000000, 13.64800000, 0, lc};
  Circle(2243) = {1687,1679,1685};
  Circle(2244) = {1685,1679,1686};
  Circle(2245) = {1686,1679,1684};
  Circle(2246) = {1684,1679,1687};
  Line Loop(2247) = {2243,2244,2245,2246};   // fuel surface

// define rod regions
  Plane Surface(2248) = {2242,2247};   // clad region
  Plane Surface(2249) = {2247};      // fuel region
  Physical Surface("RegClad1711")={2248};   // pin clad
  Physical Surface("RegFuel1711")={2249};   // pin fuel

// ==============================
//    define rod 1,12

  Point(1688) = {  0.63000000, 14.49000000, 0, lc};

  Point(1689) = {  0.15500000, 14.49000000, 0, lc};
  Point(1690) = {  1.10500000, 14.49000000, 0, lc};
  Point(1691) = {  0.63000000, 14.01500000, 0, lc};
  Point(1692) = {  0.63000000, 14.96500000, 0, lc};
  Circle(2250) = {1692,1688,1690};
  Circle(2251) = {1690,1688,1691};
  Circle(2252) = {1691,1688,1689};
  Circle(2253) = {1689,1688,1692};
  Line Loop(2254) = {2250,2251,2252,2253};   // clad surface

  Point(1693) = {  0.21200000, 14.49000000, 0, lc};
  Point(1694) = {  1.04800000, 14.49000000, 0, lc};
  Point(1695) = {  0.63000000, 14.07200000, 0, lc};
  Point(1696) = {  0.63000000, 14.90800000, 0, lc};
  Circle(2255) = {1696,1688,1694};
  Circle(2256) = {1694,1688,1695};
  Circle(2257) = {1695,1688,1693};
  Circle(2258) = {1693,1688,1696};
  Line Loop(2259) = {2255,2256,2257,2258};   // fuel surface

// define rod regions
  Plane Surface(2260) = {2254,2259};   // clad region
  Plane Surface(2261) = {2259};      // fuel region
  Physical Surface("RegClad0112")={2260};   // pin clad
  Physical Surface("RegFuel0112")={2261};   // pin fuel

// ==============================
//    define rod 2,12

  Point(1697) = {  1.89000000, 14.49000000, 0, lc};

  Point(1698) = {  1.41500000, 14.49000000, 0, lc};
  Point(1699) = {  2.36500000, 14.49000000, 0, lc};
  Point(1700) = {  1.89000000, 14.01500000, 0, lc};
  Point(1701) = {  1.89000000, 14.96500000, 0, lc};
  Circle(2262) = {1701,1697,1699};
  Circle(2263) = {1699,1697,1700};
  Circle(2264) = {1700,1697,1698};
  Circle(2265) = {1698,1697,1701};
  Line Loop(2266) = {2262,2263,2264,2265};   // clad surface

  Point(1702) = {  1.47200000, 14.49000000, 0, lc};
  Point(1703) = {  2.30800000, 14.49000000, 0, lc};
  Point(1704) = {  1.89000000, 14.07200000, 0, lc};
  Point(1705) = {  1.89000000, 14.90800000, 0, lc};
  Circle(2267) = {1705,1697,1703};
  Circle(2268) = {1703,1697,1704};
  Circle(2269) = {1704,1697,1702};
  Circle(2270) = {1702,1697,1705};
  Line Loop(2271) = {2267,2268,2269,2270};   // fuel surface

// define rod regions
  Plane Surface(2272) = {2266,2271};   // clad region
  Plane Surface(2273) = {2271};      // fuel region
  Physical Surface("RegClad0212")={2272};   // pin clad
  Physical Surface("RegFuel0212")={2273};   // pin fuel

// ==============================
//    define rod 3,12

  Point(1706) = {  3.15000000, 14.49000000, 0, lc};

  Point(1707) = {  2.67500000, 14.49000000, 0, lc};
  Point(1708) = {  3.62500000, 14.49000000, 0, lc};
  Point(1709) = {  3.15000000, 14.01500000, 0, lc};
  Point(1710) = {  3.15000000, 14.96500000, 0, lc};
  Circle(2274) = {1710,1706,1708};
  Circle(2275) = {1708,1706,1709};
  Circle(2276) = {1709,1706,1707};
  Circle(2277) = {1707,1706,1710};
  Line Loop(2278) = {2274,2275,2276,2277};   // clad surface

  Point(1711) = {  2.73200000, 14.49000000, 0, lc};
  Point(1712) = {  3.56800000, 14.49000000, 0, lc};
  Point(1713) = {  3.15000000, 14.07200000, 0, lc};
  Point(1714) = {  3.15000000, 14.90800000, 0, lc};
  Circle(2279) = {1714,1706,1712};
  Circle(2280) = {1712,1706,1713};
  Circle(2281) = {1713,1706,1711};
  Circle(2282) = {1711,1706,1714};
  Line Loop(2283) = {2279,2280,2281,2282};   // fuel surface

// define rod regions
  Plane Surface(2284) = {2278,2283};   // clad region
  Plane Surface(2285) = {2283};      // fuel region
  Physical Surface("RegClad0312")={2284};   // pin clad
  Physical Surface("RegFuel0312")={2285};   // pin fuel

// ==============================
//    define rod 4,12

  Point(1715) = {  4.41000000, 14.49000000, 0, lc};

  Point(1716) = {  3.93500000, 14.49000000, 0, lc};
  Point(1717) = {  4.88500000, 14.49000000, 0, lc};
  Point(1718) = {  4.41000000, 14.01500000, 0, lc};
  Point(1719) = {  4.41000000, 14.96500000, 0, lc};
  Circle(2286) = {1719,1715,1717};
  Circle(2287) = {1717,1715,1718};
  Circle(2288) = {1718,1715,1716};
  Circle(2289) = {1716,1715,1719};
  Line Loop(2290) = {2286,2287,2288,2289};   // clad surface

  Point(1720) = {  3.99200000, 14.49000000, 0, lc};
  Point(1721) = {  4.82800000, 14.49000000, 0, lc};
  Point(1722) = {  4.41000000, 14.07200000, 0, lc};
  Point(1723) = {  4.41000000, 14.90800000, 0, lc};
  Circle(2291) = {1723,1715,1721};
  Circle(2292) = {1721,1715,1722};
  Circle(2293) = {1722,1715,1720};
  Circle(2294) = {1720,1715,1723};
  Line Loop(2295) = {2291,2292,2293,2294};   // fuel surface

// define rod regions
  Plane Surface(2296) = {2290,2295};   // clad region
  Plane Surface(2297) = {2295};      // fuel region
  Physical Surface("RegClad0412")={2296};   // pin clad
  Physical Surface("RegFuel0412")={2297};   // pin fuel

// ==============================
//    define rod 5,12

  Point(1724) = {  5.67000000, 14.49000000, 0, lc};

  Point(1725) = {  5.19500000, 14.49000000, 0, lc};
  Point(1726) = {  6.14500000, 14.49000000, 0, lc};
  Point(1727) = {  5.67000000, 14.01500000, 0, lc};
  Point(1728) = {  5.67000000, 14.96500000, 0, lc};
  Circle(2298) = {1728,1724,1726};
  Circle(2299) = {1726,1724,1727};
  Circle(2300) = {1727,1724,1725};
  Circle(2301) = {1725,1724,1728};
  Line Loop(2302) = {2298,2299,2300,2301};   // clad surface

  Point(1729) = {  5.25200000, 14.49000000, 0, lc};
  Point(1730) = {  6.08800000, 14.49000000, 0, lc};
  Point(1731) = {  5.67000000, 14.07200000, 0, lc};
  Point(1732) = {  5.67000000, 14.90800000, 0, lc};
  Circle(2303) = {1732,1724,1730};
  Circle(2304) = {1730,1724,1731};
  Circle(2305) = {1731,1724,1729};
  Circle(2306) = {1729,1724,1732};
  Line Loop(2307) = {2303,2304,2305,2306};   // fuel surface

// define rod regions
  Plane Surface(2308) = {2302,2307};   // clad region
  Plane Surface(2309) = {2307};      // fuel region
  Physical Surface("RegClad0512")={2308};   // pin clad
  Physical Surface("RegFuel0512")={2309};   // pin fuel

// ==============================
//    define rod 6,12

  Point(1733) = {  6.93000000, 14.49000000, 0, lc};

  Point(1734) = {  6.45500000, 14.49000000, 0, lc};
  Point(1735) = {  7.40500000, 14.49000000, 0, lc};
  Point(1736) = {  6.93000000, 14.01500000, 0, lc};
  Point(1737) = {  6.93000000, 14.96500000, 0, lc};
  Circle(2310) = {1737,1733,1735};
  Circle(2311) = {1735,1733,1736};
  Circle(2312) = {1736,1733,1734};
  Circle(2313) = {1734,1733,1737};
  Line Loop(2314) = {2310,2311,2312,2313};   // clad surface

  Point(1738) = {  6.51200000, 14.49000000, 0, lc};
  Point(1739) = {  7.34800000, 14.49000000, 0, lc};
  Point(1740) = {  6.93000000, 14.07200000, 0, lc};
  Point(1741) = {  6.93000000, 14.90800000, 0, lc};
  Circle(2315) = {1741,1733,1739};
  Circle(2316) = {1739,1733,1740};
  Circle(2317) = {1740,1733,1738};
  Circle(2318) = {1738,1733,1741};
  Line Loop(2319) = {2315,2316,2317,2318};   // fuel surface

// define rod regions
  Plane Surface(2320) = {2314,2319};   // clad region
  Plane Surface(2321) = {2319};      // fuel region
  Physical Surface("RegClad0612")={2320};   // pin clad
  Physical Surface("RegFuel0612")={2321};   // pin fuel

// ==============================
//    define rod 7,12

  Point(1742) = {  8.19000000, 14.49000000, 0, lc};

  Point(1743) = {  7.71500000, 14.49000000, 0, lc};
  Point(1744) = {  8.66500000, 14.49000000, 0, lc};
  Point(1745) = {  8.19000000, 14.01500000, 0, lc};
  Point(1746) = {  8.19000000, 14.96500000, 0, lc};
  Circle(2322) = {1746,1742,1744};
  Circle(2323) = {1744,1742,1745};
  Circle(2324) = {1745,1742,1743};
  Circle(2325) = {1743,1742,1746};
  Line Loop(2326) = {2322,2323,2324,2325};   // clad surface

  Point(1747) = {  7.77200000, 14.49000000, 0, lc};
  Point(1748) = {  8.60800000, 14.49000000, 0, lc};
  Point(1749) = {  8.19000000, 14.07200000, 0, lc};
  Point(1750) = {  8.19000000, 14.90800000, 0, lc};
  Circle(2327) = {1750,1742,1748};
  Circle(2328) = {1748,1742,1749};
  Circle(2329) = {1749,1742,1747};
  Circle(2330) = {1747,1742,1750};
  Line Loop(2331) = {2327,2328,2329,2330};   // fuel surface

// define rod regions
  Plane Surface(2332) = {2326,2331};   // clad region
  Plane Surface(2333) = {2331};      // fuel region
  Physical Surface("RegClad0712")={2332};   // pin clad
  Physical Surface("RegFuel0712")={2333};   // pin fuel

// ==============================
//    define rod 8,12

  Point(1751) = {  9.45000000, 14.49000000, 0, lc};

  Point(1752) = {  8.97500000, 14.49000000, 0, lc};
  Point(1753) = {  9.92500000, 14.49000000, 0, lc};
  Point(1754) = {  9.45000000, 14.01500000, 0, lc};
  Point(1755) = {  9.45000000, 14.96500000, 0, lc};
  Circle(2334) = {1755,1751,1753};
  Circle(2335) = {1753,1751,1754};
  Circle(2336) = {1754,1751,1752};
  Circle(2337) = {1752,1751,1755};
  Line Loop(2338) = {2334,2335,2336,2337};   // clad surface

  Point(1756) = {  9.03200000, 14.49000000, 0, lc};
  Point(1757) = {  9.86800000, 14.49000000, 0, lc};
  Point(1758) = {  9.45000000, 14.07200000, 0, lc};
  Point(1759) = {  9.45000000, 14.90800000, 0, lc};
  Circle(2339) = {1759,1751,1757};
  Circle(2340) = {1757,1751,1758};
  Circle(2341) = {1758,1751,1756};
  Circle(2342) = {1756,1751,1759};
  Line Loop(2343) = {2339,2340,2341,2342};   // fuel surface

// define rod regions
  Plane Surface(2344) = {2338,2343};   // clad region
  Plane Surface(2345) = {2343};      // fuel region
  Physical Surface("RegClad0812")={2344};   // pin clad
  Physical Surface("RegFuel0812")={2345};   // pin fuel

// ==============================
//    define rod 9,12

  Point(1760) = { 10.71000000, 14.49000000, 0, lc};

  Point(1761) = { 10.23500000, 14.49000000, 0, lc};
  Point(1762) = { 11.18500000, 14.49000000, 0, lc};
  Point(1763) = { 10.71000000, 14.01500000, 0, lc};
  Point(1764) = { 10.71000000, 14.96500000, 0, lc};
  Circle(2346) = {1764,1760,1762};
  Circle(2347) = {1762,1760,1763};
  Circle(2348) = {1763,1760,1761};
  Circle(2349) = {1761,1760,1764};
  Line Loop(2350) = {2346,2347,2348,2349};   // clad surface

  Point(1765) = { 10.29200000, 14.49000000, 0, lc};
  Point(1766) = { 11.12800000, 14.49000000, 0, lc};
  Point(1767) = { 10.71000000, 14.07200000, 0, lc};
  Point(1768) = { 10.71000000, 14.90800000, 0, lc};
  Circle(2351) = {1768,1760,1766};
  Circle(2352) = {1766,1760,1767};
  Circle(2353) = {1767,1760,1765};
  Circle(2354) = {1765,1760,1768};
  Line Loop(2355) = {2351,2352,2353,2354};   // fuel surface

// define rod regions
  Plane Surface(2356) = {2350,2355};   // clad region
  Plane Surface(2357) = {2355};      // fuel region
  Physical Surface("RegClad0912")={2356};   // pin clad
  Physical Surface("RegFuel0912")={2357};   // pin fuel

// ==============================
//    define rod 10,12

  Point(1769) = { 11.97000000, 14.49000000, 0, lc};

  Point(1770) = { 11.49500000, 14.49000000, 0, lc};
  Point(1771) = { 12.44500000, 14.49000000, 0, lc};
  Point(1772) = { 11.97000000, 14.01500000, 0, lc};
  Point(1773) = { 11.97000000, 14.96500000, 0, lc};
  Circle(2358) = {1773,1769,1771};
  Circle(2359) = {1771,1769,1772};
  Circle(2360) = {1772,1769,1770};
  Circle(2361) = {1770,1769,1773};
  Line Loop(2362) = {2358,2359,2360,2361};   // clad surface

  Point(1774) = { 11.55200000, 14.49000000, 0, lc};
  Point(1775) = { 12.38800000, 14.49000000, 0, lc};
  Point(1776) = { 11.97000000, 14.07200000, 0, lc};
  Point(1777) = { 11.97000000, 14.90800000, 0, lc};
  Circle(2363) = {1777,1769,1775};
  Circle(2364) = {1775,1769,1776};
  Circle(2365) = {1776,1769,1774};
  Circle(2366) = {1774,1769,1777};
  Line Loop(2367) = {2363,2364,2365,2366};   // fuel surface

// define rod regions
  Plane Surface(2368) = {2362,2367};   // clad region
  Plane Surface(2369) = {2367};      // fuel region
  Physical Surface("RegClad1012")={2368};   // pin clad
  Physical Surface("RegFuel1012")={2369};   // pin fuel

// ==============================
//    define rod 11,12

  Point(1778) = { 13.23000000, 14.49000000, 0, lc};

  Point(1779) = { 12.75500000, 14.49000000, 0, lc};
  Point(1780) = { 13.70500000, 14.49000000, 0, lc};
  Point(1781) = { 13.23000000, 14.01500000, 0, lc};
  Point(1782) = { 13.23000000, 14.96500000, 0, lc};
  Circle(2370) = {1782,1778,1780};
  Circle(2371) = {1780,1778,1781};
  Circle(2372) = {1781,1778,1779};
  Circle(2373) = {1779,1778,1782};
  Line Loop(2374) = {2370,2371,2372,2373};   // clad surface

  Point(1783) = { 12.81200000, 14.49000000, 0, lc};
  Point(1784) = { 13.64800000, 14.49000000, 0, lc};
  Point(1785) = { 13.23000000, 14.07200000, 0, lc};
  Point(1786) = { 13.23000000, 14.90800000, 0, lc};
  Circle(2375) = {1786,1778,1784};
  Circle(2376) = {1784,1778,1785};
  Circle(2377) = {1785,1778,1783};
  Circle(2378) = {1783,1778,1786};
  Line Loop(2379) = {2375,2376,2377,2378};   // fuel surface

// define rod regions
  Plane Surface(2380) = {2374,2379};   // clad region
  Plane Surface(2381) = {2379};      // fuel region
  Physical Surface("RegClad1112")={2380};   // pin clad
  Physical Surface("RegFuel1112")={2381};   // pin fuel

// ==============================
//    define rod 12,12

  Point(1787) = { 14.49000000, 14.49000000, 0, lc};

  Point(1788) = { 14.01500000, 14.49000000, 0, lc};
  Point(1789) = { 14.96500000, 14.49000000, 0, lc};
  Point(1790) = { 14.49000000, 14.01500000, 0, lc};
  Point(1791) = { 14.49000000, 14.96500000, 0, lc};
  Circle(2382) = {1791,1787,1789};
  Circle(2383) = {1789,1787,1790};
  Circle(2384) = {1790,1787,1788};
  Circle(2385) = {1788,1787,1791};
  Line Loop(2386) = {2382,2383,2384,2385};   // clad surface

  Point(1792) = { 14.07200000, 14.49000000, 0, lc};
  Point(1793) = { 14.90800000, 14.49000000, 0, lc};
  Point(1794) = { 14.49000000, 14.07200000, 0, lc};
  Point(1795) = { 14.49000000, 14.90800000, 0, lc};
  Circle(2387) = {1795,1787,1793};
  Circle(2388) = {1793,1787,1794};
  Circle(2389) = {1794,1787,1792};
  Circle(2390) = {1792,1787,1795};
  Line Loop(2391) = {2387,2388,2389,2390};   // fuel surface

// define rod regions
  Plane Surface(2392) = {2386,2391};   // clad region
  Plane Surface(2393) = {2391};      // fuel region
  Physical Surface("RegClad1212")={2392};   // pin clad
  Physical Surface("RegFuel1212")={2393};   // pin fuel

// ==============================
//    define rod 13,12

  Point(1796) = { 15.75000000, 14.49000000, 0, lc};

  Point(1797) = { 15.27500000, 14.49000000, 0, lc};
  Point(1798) = { 16.22500000, 14.49000000, 0, lc};
  Point(1799) = { 15.75000000, 14.01500000, 0, lc};
  Point(1800) = { 15.75000000, 14.96500000, 0, lc};
  Circle(2394) = {1800,1796,1798};
  Circle(2395) = {1798,1796,1799};
  Circle(2396) = {1799,1796,1797};
  Circle(2397) = {1797,1796,1800};
  Line Loop(2398) = {2394,2395,2396,2397};   // clad surface

  Point(1801) = { 15.33200000, 14.49000000, 0, lc};
  Point(1802) = { 16.16800000, 14.49000000, 0, lc};
  Point(1803) = { 15.75000000, 14.07200000, 0, lc};
  Point(1804) = { 15.75000000, 14.90800000, 0, lc};
  Circle(2399) = {1804,1796,1802};
  Circle(2400) = {1802,1796,1803};
  Circle(2401) = {1803,1796,1801};
  Circle(2402) = {1801,1796,1804};
  Line Loop(2403) = {2399,2400,2401,2402};   // fuel surface

// define rod regions
  Plane Surface(2404) = {2398,2403};   // clad region
  Plane Surface(2405) = {2403};      // fuel region
  Physical Surface("RegClad1312")={2404};   // pin clad
  Physical Surface("RegFuel1312")={2405};   // pin fuel

// ==============================
//    define rod 14,12

  Point(1805) = { 17.01000000, 14.49000000, 0, lc};

  Point(1806) = { 16.53500000, 14.49000000, 0, lc};
  Point(1807) = { 17.48500000, 14.49000000, 0, lc};
  Point(1808) = { 17.01000000, 14.01500000, 0, lc};
  Point(1809) = { 17.01000000, 14.96500000, 0, lc};
  Circle(2406) = {1809,1805,1807};
  Circle(2407) = {1807,1805,1808};
  Circle(2408) = {1808,1805,1806};
  Circle(2409) = {1806,1805,1809};
  Line Loop(2410) = {2406,2407,2408,2409};   // clad surface

  Point(1810) = { 16.59200000, 14.49000000, 0, lc};
  Point(1811) = { 17.42800000, 14.49000000, 0, lc};
  Point(1812) = { 17.01000000, 14.07200000, 0, lc};
  Point(1813) = { 17.01000000, 14.90800000, 0, lc};
  Circle(2411) = {1813,1805,1811};
  Circle(2412) = {1811,1805,1812};
  Circle(2413) = {1812,1805,1810};
  Circle(2414) = {1810,1805,1813};
  Line Loop(2415) = {2411,2412,2413,2414};   // fuel surface

// define rod regions
  Plane Surface(2416) = {2410,2415};   // clad region
  Plane Surface(2417) = {2415};      // fuel region
  Physical Surface("RegClad1412")={2416};   // pin clad
  Physical Surface("RegFuel1412")={2417};   // pin fuel

// ==============================
//    define rod 15,12

  Point(1814) = { 18.27000000, 14.49000000, 0, lc};

  Point(1815) = { 17.79500000, 14.49000000, 0, lc};
  Point(1816) = { 18.74500000, 14.49000000, 0, lc};
  Point(1817) = { 18.27000000, 14.01500000, 0, lc};
  Point(1818) = { 18.27000000, 14.96500000, 0, lc};
  Circle(2418) = {1818,1814,1816};
  Circle(2419) = {1816,1814,1817};
  Circle(2420) = {1817,1814,1815};
  Circle(2421) = {1815,1814,1818};
  Line Loop(2422) = {2418,2419,2420,2421};   // clad surface

  Point(1819) = { 17.85200000, 14.49000000, 0, lc};
  Point(1820) = { 18.68800000, 14.49000000, 0, lc};
  Point(1821) = { 18.27000000, 14.07200000, 0, lc};
  Point(1822) = { 18.27000000, 14.90800000, 0, lc};
  Circle(2423) = {1822,1814,1820};
  Circle(2424) = {1820,1814,1821};
  Circle(2425) = {1821,1814,1819};
  Circle(2426) = {1819,1814,1822};
  Line Loop(2427) = {2423,2424,2425,2426};   // fuel surface

// define rod regions
  Plane Surface(2428) = {2422,2427};   // clad region
  Plane Surface(2429) = {2427};      // fuel region
  Physical Surface("RegClad1512")={2428};   // pin clad
  Physical Surface("RegFuel1512")={2429};   // pin fuel

// ==============================
//    define rod 16,12

  Point(1823) = { 19.53000000, 14.49000000, 0, lc};

  Point(1824) = { 19.05500000, 14.49000000, 0, lc};
  Point(1825) = { 20.00500000, 14.49000000, 0, lc};
  Point(1826) = { 19.53000000, 14.01500000, 0, lc};
  Point(1827) = { 19.53000000, 14.96500000, 0, lc};
  Circle(2430) = {1827,1823,1825};
  Circle(2431) = {1825,1823,1826};
  Circle(2432) = {1826,1823,1824};
  Circle(2433) = {1824,1823,1827};
  Line Loop(2434) = {2430,2431,2432,2433};   // clad surface

  Point(1828) = { 19.11200000, 14.49000000, 0, lc};
  Point(1829) = { 19.94800000, 14.49000000, 0, lc};
  Point(1830) = { 19.53000000, 14.07200000, 0, lc};
  Point(1831) = { 19.53000000, 14.90800000, 0, lc};
  Circle(2435) = {1831,1823,1829};
  Circle(2436) = {1829,1823,1830};
  Circle(2437) = {1830,1823,1828};
  Circle(2438) = {1828,1823,1831};
  Line Loop(2439) = {2435,2436,2437,2438};   // fuel surface

// define rod regions
  Plane Surface(2440) = {2434,2439};   // clad region
  Plane Surface(2441) = {2439};      // fuel region
  Physical Surface("RegClad1612")={2440};   // pin clad
  Physical Surface("RegFuel1612")={2441};   // pin fuel

// ==============================
//    define rod 17,12

  Point(1832) = { 20.79000000, 14.49000000, 0, lc};

  Point(1833) = { 20.31500000, 14.49000000, 0, lc};
  Point(1834) = { 21.26500000, 14.49000000, 0, lc};
  Point(1835) = { 20.79000000, 14.01500000, 0, lc};
  Point(1836) = { 20.79000000, 14.96500000, 0, lc};
  Circle(2442) = {1836,1832,1834};
  Circle(2443) = {1834,1832,1835};
  Circle(2444) = {1835,1832,1833};
  Circle(2445) = {1833,1832,1836};
  Line Loop(2446) = {2442,2443,2444,2445};   // clad surface

  Point(1837) = { 20.37200000, 14.49000000, 0, lc};
  Point(1838) = { 21.20800000, 14.49000000, 0, lc};
  Point(1839) = { 20.79000000, 14.07200000, 0, lc};
  Point(1840) = { 20.79000000, 14.90800000, 0, lc};
  Circle(2447) = {1840,1832,1838};
  Circle(2448) = {1838,1832,1839};
  Circle(2449) = {1839,1832,1837};
  Circle(2450) = {1837,1832,1840};
  Line Loop(2451) = {2447,2448,2449,2450};   // fuel surface

// define rod regions
  Plane Surface(2452) = {2446,2451};   // clad region
  Plane Surface(2453) = {2451};      // fuel region
  Physical Surface("RegClad1712")={2452};   // pin clad
  Physical Surface("RegFuel1712")={2453};   // pin fuel

// ==============================
//    define rod 1,13

  Point(1841) = {  0.63000000, 15.75000000, 0, lc};

  Point(1842) = {  0.15500000, 15.75000000, 0, lc};
  Point(1843) = {  1.10500000, 15.75000000, 0, lc};
  Point(1844) = {  0.63000000, 15.27500000, 0, lc};
  Point(1845) = {  0.63000000, 16.22500000, 0, lc};
  Circle(2454) = {1845,1841,1843};
  Circle(2455) = {1843,1841,1844};
  Circle(2456) = {1844,1841,1842};
  Circle(2457) = {1842,1841,1845};
  Line Loop(2458) = {2454,2455,2456,2457};   // clad surface

  Point(1846) = {  0.21200000, 15.75000000, 0, lc};
  Point(1847) = {  1.04800000, 15.75000000, 0, lc};
  Point(1848) = {  0.63000000, 15.33200000, 0, lc};
  Point(1849) = {  0.63000000, 16.16800000, 0, lc};
  Circle(2459) = {1849,1841,1847};
  Circle(2460) = {1847,1841,1848};
  Circle(2461) = {1848,1841,1846};
  Circle(2462) = {1846,1841,1849};
  Line Loop(2463) = {2459,2460,2461,2462};   // fuel surface

// define rod regions
  Plane Surface(2464) = {2458,2463};   // clad region
  Plane Surface(2465) = {2463};      // fuel region
  Physical Surface("RegClad0113")={2464};   // pin clad
  Physical Surface("RegFuel0113")={2465};   // pin fuel

// ==============================
//    define rod 2,13

  Point(1850) = {  1.89000000, 15.75000000, 0, lc};

  Point(1851) = {  1.41500000, 15.75000000, 0, lc};
  Point(1852) = {  2.36500000, 15.75000000, 0, lc};
  Point(1853) = {  1.89000000, 15.27500000, 0, lc};
  Point(1854) = {  1.89000000, 16.22500000, 0, lc};
  Circle(2466) = {1854,1850,1852};
  Circle(2467) = {1852,1850,1853};
  Circle(2468) = {1853,1850,1851};
  Circle(2469) = {1851,1850,1854};
  Line Loop(2470) = {2466,2467,2468,2469};   // clad surface

  Point(1855) = {  1.47200000, 15.75000000, 0, lc};
  Point(1856) = {  2.30800000, 15.75000000, 0, lc};
  Point(1857) = {  1.89000000, 15.33200000, 0, lc};
  Point(1858) = {  1.89000000, 16.16800000, 0, lc};
  Circle(2471) = {1858,1850,1856};
  Circle(2472) = {1856,1850,1857};
  Circle(2473) = {1857,1850,1855};
  Circle(2474) = {1855,1850,1858};
  Line Loop(2475) = {2471,2472,2473,2474};   // fuel surface

// define rod regions
  Plane Surface(2476) = {2470,2475};   // clad region
  Plane Surface(2477) = {2475};      // fuel region
  Physical Surface("RegClad0213")={2476};   // pin clad
  Physical Surface("RegFuel0213")={2477};   // pin fuel

// ==============================
//    define rod 3,13

  Point(1859) = {  3.15000000, 15.75000000, 0, lc};

  Point(1860) = {  2.67500000, 15.75000000, 0, lc};
  Point(1861) = {  3.62500000, 15.75000000, 0, lc};
  Point(1862) = {  3.15000000, 15.27500000, 0, lc};
  Point(1863) = {  3.15000000, 16.22500000, 0, lc};
  Circle(2478) = {1863,1859,1861};
  Circle(2479) = {1861,1859,1862};
  Circle(2480) = {1862,1859,1860};
  Circle(2481) = {1860,1859,1863};
  Line Loop(2482) = {2478,2479,2480,2481};   // clad surface

  Point(1864) = {  2.73200000, 15.75000000, 0, lc};
  Point(1865) = {  3.56800000, 15.75000000, 0, lc};
  Point(1866) = {  3.15000000, 15.33200000, 0, lc};
  Point(1867) = {  3.15000000, 16.16800000, 0, lc};
  Circle(2483) = {1867,1859,1865};
  Circle(2484) = {1865,1859,1866};
  Circle(2485) = {1866,1859,1864};
  Circle(2486) = {1864,1859,1867};
  Line Loop(2487) = {2483,2484,2485,2486};   // fuel surface

// define rod regions
  Plane Surface(2488) = {2482,2487};   // clad region
  Plane Surface(2489) = {2487};      // fuel region
  Physical Surface("RegClad0313")={2488};   // pin clad
  Physical Surface("RegFuel0313")={2489};   // pin fuel

// ==============================
//    define rod 4,13

  Point(1868) = {  4.41000000, 15.75000000, 0, lc};

  Point(1869) = {  3.93500000, 15.75000000, 0, lc};
  Point(1870) = {  4.88500000, 15.75000000, 0, lc};
  Point(1871) = {  4.41000000, 15.27500000, 0, lc};
  Point(1872) = {  4.41000000, 16.22500000, 0, lc};
  Circle(2490) = {1872,1868,1870};
  Circle(2491) = {1870,1868,1871};
  Circle(2492) = {1871,1868,1869};
  Circle(2493) = {1869,1868,1872};
  Line Loop(2494) = {2490,2491,2492,2493};   // clad surface

  Point(1873) = {  3.99200000, 15.75000000, 0, lc};
  Point(1874) = {  4.82800000, 15.75000000, 0, lc};
  Point(1875) = {  4.41000000, 15.33200000, 0, lc};
  Point(1876) = {  4.41000000, 16.16800000, 0, lc};
  Circle(2495) = {1876,1868,1874};
  Circle(2496) = {1874,1868,1875};
  Circle(2497) = {1875,1868,1873};
  Circle(2498) = {1873,1868,1876};
  Line Loop(2499) = {2495,2496,2497,2498};   // fuel surface

// define rod regions
  Plane Surface(2500) = {2494,2499};   // clad region
  Plane Surface(2501) = {2499};      // fuel region
  Physical Surface("RegClad0413")={2500};   // pin clad
  Physical Surface("RegFuel0413")={2501};   // pin fuel

// ==============================
//    define rod 5,13

  Point(1877) = {  5.67000000, 15.75000000, 0, lc};

  Point(1878) = {  5.19500000, 15.75000000, 0, lc};
  Point(1879) = {  6.14500000, 15.75000000, 0, lc};
  Point(1880) = {  5.67000000, 15.27500000, 0, lc};
  Point(1881) = {  5.67000000, 16.22500000, 0, lc};
  Circle(2502) = {1881,1877,1879};
  Circle(2503) = {1879,1877,1880};
  Circle(2504) = {1880,1877,1878};
  Circle(2505) = {1878,1877,1881};
  Line Loop(2506) = {2502,2503,2504,2505};   // clad surface

  Point(1882) = {  5.25200000, 15.75000000, 0, lc};
  Point(1883) = {  6.08800000, 15.75000000, 0, lc};
  Point(1884) = {  5.67000000, 15.33200000, 0, lc};
  Point(1885) = {  5.67000000, 16.16800000, 0, lc};
  Circle(2507) = {1885,1877,1883};
  Circle(2508) = {1883,1877,1884};
  Circle(2509) = {1884,1877,1882};
  Circle(2510) = {1882,1877,1885};
  Line Loop(2511) = {2507,2508,2509,2510};   // fuel surface

// define rod regions
  Plane Surface(2512) = {2506,2511};   // clad region
  Plane Surface(2513) = {2511};      // fuel region
  Physical Surface("RegClad0513")={2512};   // pin clad
  Physical Surface("RegFuel0513")={2513};   // pin fuel

// ==============================
//    define rod 6,13

  Point(1886) = {  6.93000000, 15.75000000, 0, lc};

  Point(1887) = {  6.45500000, 15.75000000, 0, lc};
  Point(1888) = {  7.40500000, 15.75000000, 0, lc};
  Point(1889) = {  6.93000000, 15.27500000, 0, lc};
  Point(1890) = {  6.93000000, 16.22500000, 0, lc};
  Circle(2514) = {1890,1886,1888};
  Circle(2515) = {1888,1886,1889};
  Circle(2516) = {1889,1886,1887};
  Circle(2517) = {1887,1886,1890};
  Line Loop(2518) = {2514,2515,2516,2517};   // clad surface

  Point(1891) = {  6.51200000, 15.75000000, 0, lc};
  Point(1892) = {  7.34800000, 15.75000000, 0, lc};
  Point(1893) = {  6.93000000, 15.33200000, 0, lc};
  Point(1894) = {  6.93000000, 16.16800000, 0, lc};
  Circle(2519) = {1894,1886,1892};
  Circle(2520) = {1892,1886,1893};
  Circle(2521) = {1893,1886,1891};
  Circle(2522) = {1891,1886,1894};
  Line Loop(2523) = {2519,2520,2521,2522};   // fuel surface

// define rod regions
  Plane Surface(2524) = {2518,2523};   // clad region
  Plane Surface(2525) = {2523};      // fuel region
  Physical Surface("RegClad0613")={2524};   // pin clad
  Physical Surface("RegFuel0613")={2525};   // pin fuel

// ==============================
//    define rod 7,13

  Point(1895) = {  8.19000000, 15.75000000, 0, lc};

  Point(1896) = {  7.71500000, 15.75000000, 0, lc};
  Point(1897) = {  8.66500000, 15.75000000, 0, lc};
  Point(1898) = {  8.19000000, 15.27500000, 0, lc};
  Point(1899) = {  8.19000000, 16.22500000, 0, lc};
  Circle(2526) = {1899,1895,1897};
  Circle(2527) = {1897,1895,1898};
  Circle(2528) = {1898,1895,1896};
  Circle(2529) = {1896,1895,1899};
  Line Loop(2530) = {2526,2527,2528,2529};   // clad surface

  Point(1900) = {  7.77200000, 15.75000000, 0, lc};
  Point(1901) = {  8.60800000, 15.75000000, 0, lc};
  Point(1902) = {  8.19000000, 15.33200000, 0, lc};
  Point(1903) = {  8.19000000, 16.16800000, 0, lc};
  Circle(2531) = {1903,1895,1901};
  Circle(2532) = {1901,1895,1902};
  Circle(2533) = {1902,1895,1900};
  Circle(2534) = {1900,1895,1903};
  Line Loop(2535) = {2531,2532,2533,2534};   // fuel surface

// define rod regions
  Plane Surface(2536) = {2530,2535};   // clad region
  Plane Surface(2537) = {2535};      // fuel region
  Physical Surface("RegClad0713")={2536};   // pin clad
  Physical Surface("RegFuel0713")={2537};   // pin fuel

// ==============================
//    define rod 8,13

  Point(1904) = {  9.45000000, 15.75000000, 0, lc};

  Point(1905) = {  8.97500000, 15.75000000, 0, lc};
  Point(1906) = {  9.92500000, 15.75000000, 0, lc};
  Point(1907) = {  9.45000000, 15.27500000, 0, lc};
  Point(1908) = {  9.45000000, 16.22500000, 0, lc};
  Circle(2538) = {1908,1904,1906};
  Circle(2539) = {1906,1904,1907};
  Circle(2540) = {1907,1904,1905};
  Circle(2541) = {1905,1904,1908};
  Line Loop(2542) = {2538,2539,2540,2541};   // clad surface

  Point(1909) = {  9.03200000, 15.75000000, 0, lc};
  Point(1910) = {  9.86800000, 15.75000000, 0, lc};
  Point(1911) = {  9.45000000, 15.33200000, 0, lc};
  Point(1912) = {  9.45000000, 16.16800000, 0, lc};
  Circle(2543) = {1912,1904,1910};
  Circle(2544) = {1910,1904,1911};
  Circle(2545) = {1911,1904,1909};
  Circle(2546) = {1909,1904,1912};
  Line Loop(2547) = {2543,2544,2545,2546};   // fuel surface

// define rod regions
  Plane Surface(2548) = {2542,2547};   // clad region
  Plane Surface(2549) = {2547};      // fuel region
  Physical Surface("RegClad0813")={2548};   // pin clad
  Physical Surface("RegFuel0813")={2549};   // pin fuel

// ==============================
//    define rod 9,13

  Point(1913) = { 10.71000000, 15.75000000, 0, lc};

  Point(1914) = { 10.23500000, 15.75000000, 0, lc};
  Point(1915) = { 11.18500000, 15.75000000, 0, lc};
  Point(1916) = { 10.71000000, 15.27500000, 0, lc};
  Point(1917) = { 10.71000000, 16.22500000, 0, lc};
  Circle(2550) = {1917,1913,1915};
  Circle(2551) = {1915,1913,1916};
  Circle(2552) = {1916,1913,1914};
  Circle(2553) = {1914,1913,1917};
  Line Loop(2554) = {2550,2551,2552,2553};   // clad surface

  Point(1918) = { 10.29200000, 15.75000000, 0, lc};
  Point(1919) = { 11.12800000, 15.75000000, 0, lc};
  Point(1920) = { 10.71000000, 15.33200000, 0, lc};
  Point(1921) = { 10.71000000, 16.16800000, 0, lc};
  Circle(2555) = {1921,1913,1919};
  Circle(2556) = {1919,1913,1920};
  Circle(2557) = {1920,1913,1918};
  Circle(2558) = {1918,1913,1921};
  Line Loop(2559) = {2555,2556,2557,2558};   // fuel surface

// define rod regions
  Plane Surface(2560) = {2554,2559};   // clad region
  Plane Surface(2561) = {2559};      // fuel region
  Physical Surface("RegClad0913")={2560};   // pin clad
  Physical Surface("RegFuel0913")={2561};   // pin fuel

// ==============================
//    define rod 10,13

  Point(1922) = { 11.97000000, 15.75000000, 0, lc};

  Point(1923) = { 11.49500000, 15.75000000, 0, lc};
  Point(1924) = { 12.44500000, 15.75000000, 0, lc};
  Point(1925) = { 11.97000000, 15.27500000, 0, lc};
  Point(1926) = { 11.97000000, 16.22500000, 0, lc};
  Circle(2562) = {1926,1922,1924};
  Circle(2563) = {1924,1922,1925};
  Circle(2564) = {1925,1922,1923};
  Circle(2565) = {1923,1922,1926};
  Line Loop(2566) = {2562,2563,2564,2565};   // clad surface

  Point(1927) = { 11.55200000, 15.75000000, 0, lc};
  Point(1928) = { 12.38800000, 15.75000000, 0, lc};
  Point(1929) = { 11.97000000, 15.33200000, 0, lc};
  Point(1930) = { 11.97000000, 16.16800000, 0, lc};
  Circle(2567) = {1930,1922,1928};
  Circle(2568) = {1928,1922,1929};
  Circle(2569) = {1929,1922,1927};
  Circle(2570) = {1927,1922,1930};
  Line Loop(2571) = {2567,2568,2569,2570};   // fuel surface

// define rod regions
  Plane Surface(2572) = {2566,2571};   // clad region
  Plane Surface(2573) = {2571};      // fuel region
  Physical Surface("RegClad1013")={2572};   // pin clad
  Physical Surface("RegFuel1013")={2573};   // pin fuel

// ==============================
//    define rod 11,13

  Point(1931) = { 13.23000000, 15.75000000, 0, lc};

  Point(1932) = { 12.75500000, 15.75000000, 0, lc};
  Point(1933) = { 13.70500000, 15.75000000, 0, lc};
  Point(1934) = { 13.23000000, 15.27500000, 0, lc};
  Point(1935) = { 13.23000000, 16.22500000, 0, lc};
  Circle(2574) = {1935,1931,1933};
  Circle(2575) = {1933,1931,1934};
  Circle(2576) = {1934,1931,1932};
  Circle(2577) = {1932,1931,1935};
  Line Loop(2578) = {2574,2575,2576,2577};   // clad surface

  Point(1936) = { 12.81200000, 15.75000000, 0, lc};
  Point(1937) = { 13.64800000, 15.75000000, 0, lc};
  Point(1938) = { 13.23000000, 15.33200000, 0, lc};
  Point(1939) = { 13.23000000, 16.16800000, 0, lc};
  Circle(2579) = {1939,1931,1937};
  Circle(2580) = {1937,1931,1938};
  Circle(2581) = {1938,1931,1936};
  Circle(2582) = {1936,1931,1939};
  Line Loop(2583) = {2579,2580,2581,2582};   // fuel surface

// define rod regions
  Plane Surface(2584) = {2578,2583};   // clad region
  Plane Surface(2585) = {2583};      // fuel region
  Physical Surface("RegClad1113")={2584};   // pin clad
  Physical Surface("RegFuel1113")={2585};   // pin fuel

// ==============================
//    define rod 12,13

  Point(1940) = { 14.49000000, 15.75000000, 0, lc};

  Point(1941) = { 14.01500000, 15.75000000, 0, lc};
  Point(1942) = { 14.96500000, 15.75000000, 0, lc};
  Point(1943) = { 14.49000000, 15.27500000, 0, lc};
  Point(1944) = { 14.49000000, 16.22500000, 0, lc};
  Circle(2586) = {1944,1940,1942};
  Circle(2587) = {1942,1940,1943};
  Circle(2588) = {1943,1940,1941};
  Circle(2589) = {1941,1940,1944};
  Line Loop(2590) = {2586,2587,2588,2589};   // clad surface

  Point(1945) = { 14.07200000, 15.75000000, 0, lc};
  Point(1946) = { 14.90800000, 15.75000000, 0, lc};
  Point(1947) = { 14.49000000, 15.33200000, 0, lc};
  Point(1948) = { 14.49000000, 16.16800000, 0, lc};
  Circle(2591) = {1948,1940,1946};
  Circle(2592) = {1946,1940,1947};
  Circle(2593) = {1947,1940,1945};
  Circle(2594) = {1945,1940,1948};
  Line Loop(2595) = {2591,2592,2593,2594};   // fuel surface

// define rod regions
  Plane Surface(2596) = {2590,2595};   // clad region
  Plane Surface(2597) = {2595};      // fuel region
  Physical Surface("RegClad1213")={2596};   // pin clad
  Physical Surface("RegFuel1213")={2597};   // pin fuel

// ==============================
//    define rod 13,13

  Point(1949) = { 15.75000000, 15.75000000, 0, lc};

  Point(1950) = { 15.27500000, 15.75000000, 0, lc};
  Point(1951) = { 16.22500000, 15.75000000, 0, lc};
  Point(1952) = { 15.75000000, 15.27500000, 0, lc};
  Point(1953) = { 15.75000000, 16.22500000, 0, lc};
  Circle(2598) = {1953,1949,1951};
  Circle(2599) = {1951,1949,1952};
  Circle(2600) = {1952,1949,1950};
  Circle(2601) = {1950,1949,1953};
  Line Loop(2602) = {2598,2599,2600,2601};   // clad surface

  Point(1954) = { 15.33200000, 15.75000000, 0, lc};
  Point(1955) = { 16.16800000, 15.75000000, 0, lc};
  Point(1956) = { 15.75000000, 15.33200000, 0, lc};
  Point(1957) = { 15.75000000, 16.16800000, 0, lc};
  Circle(2603) = {1957,1949,1955};
  Circle(2604) = {1955,1949,1956};
  Circle(2605) = {1956,1949,1954};
  Circle(2606) = {1954,1949,1957};
  Line Loop(2607) = {2603,2604,2605,2606};   // fuel surface

// define rod regions
  Plane Surface(2608) = {2602,2607};   // clad region
  Plane Surface(2609) = {2607};      // fuel region
  Physical Surface("RegClad1313")={2608};   // pin clad
  Physical Surface("RegFuel1313")={2609};   // pin fuel

// ==============================
//    define rod 14,13

  Point(1958) = { 17.01000000, 15.75000000, 0, lc};

  Point(1959) = { 16.53500000, 15.75000000, 0, lc};
  Point(1960) = { 17.48500000, 15.75000000, 0, lc};
  Point(1961) = { 17.01000000, 15.27500000, 0, lc};
  Point(1962) = { 17.01000000, 16.22500000, 0, lc};
  Circle(2610) = {1962,1958,1960};
  Circle(2611) = {1960,1958,1961};
  Circle(2612) = {1961,1958,1959};
  Circle(2613) = {1959,1958,1962};
  Line Loop(2614) = {2610,2611,2612,2613};   // clad surface

  Point(1963) = { 16.59200000, 15.75000000, 0, lc};
  Point(1964) = { 17.42800000, 15.75000000, 0, lc};
  Point(1965) = { 17.01000000, 15.33200000, 0, lc};
  Point(1966) = { 17.01000000, 16.16800000, 0, lc};
  Circle(2615) = {1966,1958,1964};
  Circle(2616) = {1964,1958,1965};
  Circle(2617) = {1965,1958,1963};
  Circle(2618) = {1963,1958,1966};
  Line Loop(2619) = {2615,2616,2617,2618};   // fuel surface

// define rod regions
  Plane Surface(2620) = {2614,2619};   // clad region
  Plane Surface(2621) = {2619};      // fuel region
  Physical Surface("RegClad1413")={2620};   // pin clad
  Physical Surface("RegFuel1413")={2621};   // pin fuel

// ==============================
//    define rod 15,13

  Point(1967) = { 18.27000000, 15.75000000, 0, lc};

  Point(1968) = { 17.79500000, 15.75000000, 0, lc};
  Point(1969) = { 18.74500000, 15.75000000, 0, lc};
  Point(1970) = { 18.27000000, 15.27500000, 0, lc};
  Point(1971) = { 18.27000000, 16.22500000, 0, lc};
  Circle(2622) = {1971,1967,1969};
  Circle(2623) = {1969,1967,1970};
  Circle(2624) = {1970,1967,1968};
  Circle(2625) = {1968,1967,1971};
  Line Loop(2626) = {2622,2623,2624,2625};   // clad surface

  Point(1972) = { 17.85200000, 15.75000000, 0, lc};
  Point(1973) = { 18.68800000, 15.75000000, 0, lc};
  Point(1974) = { 18.27000000, 15.33200000, 0, lc};
  Point(1975) = { 18.27000000, 16.16800000, 0, lc};
  Circle(2627) = {1975,1967,1973};
  Circle(2628) = {1973,1967,1974};
  Circle(2629) = {1974,1967,1972};
  Circle(2630) = {1972,1967,1975};
  Line Loop(2631) = {2627,2628,2629,2630};   // fuel surface

// define rod regions
  Plane Surface(2632) = {2626,2631};   // clad region
  Plane Surface(2633) = {2631};      // fuel region
  Physical Surface("RegClad1513")={2632};   // pin clad
  Physical Surface("RegFuel1513")={2633};   // pin fuel

// ==============================
//    define rod 16,13

  Point(1976) = { 19.53000000, 15.75000000, 0, lc};

  Point(1977) = { 19.05500000, 15.75000000, 0, lc};
  Point(1978) = { 20.00500000, 15.75000000, 0, lc};
  Point(1979) = { 19.53000000, 15.27500000, 0, lc};
  Point(1980) = { 19.53000000, 16.22500000, 0, lc};
  Circle(2634) = {1980,1976,1978};
  Circle(2635) = {1978,1976,1979};
  Circle(2636) = {1979,1976,1977};
  Circle(2637) = {1977,1976,1980};
  Line Loop(2638) = {2634,2635,2636,2637};   // clad surface

  Point(1981) = { 19.11200000, 15.75000000, 0, lc};
  Point(1982) = { 19.94800000, 15.75000000, 0, lc};
  Point(1983) = { 19.53000000, 15.33200000, 0, lc};
  Point(1984) = { 19.53000000, 16.16800000, 0, lc};
  Circle(2639) = {1984,1976,1982};
  Circle(2640) = {1982,1976,1983};
  Circle(2641) = {1983,1976,1981};
  Circle(2642) = {1981,1976,1984};
  Line Loop(2643) = {2639,2640,2641,2642};   // fuel surface

// define rod regions
  Plane Surface(2644) = {2638,2643};   // clad region
  Plane Surface(2645) = {2643};      // fuel region
  Physical Surface("RegClad1613")={2644};   // pin clad
  Physical Surface("RegFuel1613")={2645};   // pin fuel

// ==============================
//    define rod 17,13

  Point(1985) = { 20.79000000, 15.75000000, 0, lc};

  Point(1986) = { 20.31500000, 15.75000000, 0, lc};
  Point(1987) = { 21.26500000, 15.75000000, 0, lc};
  Point(1988) = { 20.79000000, 15.27500000, 0, lc};
  Point(1989) = { 20.79000000, 16.22500000, 0, lc};
  Circle(2646) = {1989,1985,1987};
  Circle(2647) = {1987,1985,1988};
  Circle(2648) = {1988,1985,1986};
  Circle(2649) = {1986,1985,1989};
  Line Loop(2650) = {2646,2647,2648,2649};   // clad surface

  Point(1990) = { 20.37200000, 15.75000000, 0, lc};
  Point(1991) = { 21.20800000, 15.75000000, 0, lc};
  Point(1992) = { 20.79000000, 15.33200000, 0, lc};
  Point(1993) = { 20.79000000, 16.16800000, 0, lc};
  Circle(2651) = {1993,1985,1991};
  Circle(2652) = {1991,1985,1992};
  Circle(2653) = {1992,1985,1990};
  Circle(2654) = {1990,1985,1993};
  Line Loop(2655) = {2651,2652,2653,2654};   // fuel surface

// define rod regions
  Plane Surface(2656) = {2650,2655};   // clad region
  Plane Surface(2657) = {2655};      // fuel region
  Physical Surface("RegClad1713")={2656};   // pin clad
  Physical Surface("RegFuel1713")={2657};   // pin fuel

// ==============================
//    define rod 1,14

  Point(1994) = {  0.63000000, 17.01000000, 0, lc};

  Point(1995) = {  0.15500000, 17.01000000, 0, lc};
  Point(1996) = {  1.10500000, 17.01000000, 0, lc};
  Point(1997) = {  0.63000000, 16.53500000, 0, lc};
  Point(1998) = {  0.63000000, 17.48500000, 0, lc};
  Circle(2658) = {1998,1994,1996};
  Circle(2659) = {1996,1994,1997};
  Circle(2660) = {1997,1994,1995};
  Circle(2661) = {1995,1994,1998};
  Line Loop(2662) = {2658,2659,2660,2661};   // clad surface

  Point(1999) = {  0.21200000, 17.01000000, 0, lc};
  Point(2000) = {  1.04800000, 17.01000000, 0, lc};
  Point(2001) = {  0.63000000, 16.59200000, 0, lc};
  Point(2002) = {  0.63000000, 17.42800000, 0, lc};
  Circle(2663) = {2002,1994,2000};
  Circle(2664) = {2000,1994,2001};
  Circle(2665) = {2001,1994,1999};
  Circle(2666) = {1999,1994,2002};
  Line Loop(2667) = {2663,2664,2665,2666};   // fuel surface

// define rod regions
  Plane Surface(2668) = {2662,2667};   // clad region
  Plane Surface(2669) = {2667};      // fuel region
  Physical Surface("RegClad0114")={2668};   // pin clad
  Physical Surface("RegFuel0114")={2669};   // pin fuel

// ==============================
//    define rod 2,14

  Point(2003) = {  1.89000000, 17.01000000, 0, lc};

  Point(2004) = {  1.41500000, 17.01000000, 0, lc};
  Point(2005) = {  2.36500000, 17.01000000, 0, lc};
  Point(2006) = {  1.89000000, 16.53500000, 0, lc};
  Point(2007) = {  1.89000000, 17.48500000, 0, lc};
  Circle(2670) = {2007,2003,2005};
  Circle(2671) = {2005,2003,2006};
  Circle(2672) = {2006,2003,2004};
  Circle(2673) = {2004,2003,2007};
  Line Loop(2674) = {2670,2671,2672,2673};   // clad surface

  Point(2008) = {  1.47200000, 17.01000000, 0, lc};
  Point(2009) = {  2.30800000, 17.01000000, 0, lc};
  Point(2010) = {  1.89000000, 16.59200000, 0, lc};
  Point(2011) = {  1.89000000, 17.42800000, 0, lc};
  Circle(2675) = {2011,2003,2009};
  Circle(2676) = {2009,2003,2010};
  Circle(2677) = {2010,2003,2008};
  Circle(2678) = {2008,2003,2011};
  Line Loop(2679) = {2675,2676,2677,2678};   // fuel surface

// define rod regions
  Plane Surface(2680) = {2674,2679};   // clad region
  Plane Surface(2681) = {2679};      // fuel region
  Physical Surface("RegClad0214")={2680};   // pin clad
  Physical Surface("RegFuel0214")={2681};   // pin fuel

// ==============================
//    define rod 3,14

  Point(2012) = {  3.15000000, 17.01000000, 0, lc};

  Point(2013) = {  2.67500000, 17.01000000, 0, lc};
  Point(2014) = {  3.62500000, 17.01000000, 0, lc};
  Point(2015) = {  3.15000000, 16.53500000, 0, lc};
  Point(2016) = {  3.15000000, 17.48500000, 0, lc};
  Circle(2682) = {2016,2012,2014};
  Circle(2683) = {2014,2012,2015};
  Circle(2684) = {2015,2012,2013};
  Circle(2685) = {2013,2012,2016};
  Line Loop(2686) = {2682,2683,2684,2685};   // clad surface

  Point(2017) = {  2.73200000, 17.01000000, 0, lc};
  Point(2018) = {  3.56800000, 17.01000000, 0, lc};
  Point(2019) = {  3.15000000, 16.59200000, 0, lc};
  Point(2020) = {  3.15000000, 17.42800000, 0, lc};
  Circle(2687) = {2020,2012,2018};
  Circle(2688) = {2018,2012,2019};
  Circle(2689) = {2019,2012,2017};
  Circle(2690) = {2017,2012,2020};
  Line Loop(2691) = {2687,2688,2689,2690};   // fuel surface

// define rod regions
  Plane Surface(2692) = {2686,2691};   // clad region
  Plane Surface(2693) = {2691};      // fuel region
  Physical Surface("RegClad0314")={2692};   // pin clad
  Physical Surface("RegFuel0314")={2693};   // pin fuel

// ==============================
//    define rod 4,14

  Point(2021) = {  4.41000000, 17.01000000, 0, lc};

  Point(2022) = {  3.93500000, 17.01000000, 0, lc};
  Point(2023) = {  4.88500000, 17.01000000, 0, lc};
  Point(2024) = {  4.41000000, 16.53500000, 0, lc};
  Point(2025) = {  4.41000000, 17.48500000, 0, lc};
  Circle(2694) = {2025,2021,2023};
  Circle(2695) = {2023,2021,2024};
  Circle(2696) = {2024,2021,2022};
  Circle(2697) = {2022,2021,2025};
  Line Loop(2698) = {2694,2695,2696,2697};   // clad surface

  Point(2026) = {  3.99200000, 17.01000000, 0, lc};
  Point(2027) = {  4.82800000, 17.01000000, 0, lc};
  Point(2028) = {  4.41000000, 16.59200000, 0, lc};
  Point(2029) = {  4.41000000, 17.42800000, 0, lc};
  Circle(2699) = {2029,2021,2027};
  Circle(2700) = {2027,2021,2028};
  Circle(2701) = {2028,2021,2026};
  Circle(2702) = {2026,2021,2029};
  Line Loop(2703) = {2699,2700,2701,2702};   // fuel surface

// define rod regions
  Plane Surface(2704) = {2698,2703};   // clad region
  Plane Surface(2705) = {2703};      // fuel region
  Physical Surface("RegClad0414")={2704};   // pin clad
  Physical Surface("RegFuel0414")={2705};   // pin fuel

// ==============================
//    define rod 5,14

  Point(2030) = {  5.67000000, 17.01000000, 0, lc};

  Point(2031) = {  5.19500000, 17.01000000, 0, lc};
  Point(2032) = {  6.14500000, 17.01000000, 0, lc};
  Point(2033) = {  5.67000000, 16.53500000, 0, lc};
  Point(2034) = {  5.67000000, 17.48500000, 0, lc};
  Circle(2706) = {2034,2030,2032};
  Circle(2707) = {2032,2030,2033};
  Circle(2708) = {2033,2030,2031};
  Circle(2709) = {2031,2030,2034};
  Line Loop(2710) = {2706,2707,2708,2709};   // clad surface

  Point(2035) = {  5.25200000, 17.01000000, 0, lc};
  Point(2036) = {  6.08800000, 17.01000000, 0, lc};
  Point(2037) = {  5.67000000, 16.59200000, 0, lc};
  Point(2038) = {  5.67000000, 17.42800000, 0, lc};
  Circle(2711) = {2038,2030,2036};
  Circle(2712) = {2036,2030,2037};
  Circle(2713) = {2037,2030,2035};
  Circle(2714) = {2035,2030,2038};
  Line Loop(2715) = {2711,2712,2713,2714};   // fuel surface

// define rod regions
  Plane Surface(2716) = {2710,2715};   // clad region
  Plane Surface(2717) = {2715};      // fuel region
  Physical Surface("RegClad0514")={2716};   // pin clad
  Physical Surface("RegFuel0514")={2717};   // pin fuel

// ==============================
//    define rod 6,14

  Point(2039) = {  6.93000000, 17.01000000, 0, lc};

  Point(2040) = {  6.45500000, 17.01000000, 0, lc};
  Point(2041) = {  7.40500000, 17.01000000, 0, lc};
  Point(2042) = {  6.93000000, 16.53500000, 0, lc};
  Point(2043) = {  6.93000000, 17.48500000, 0, lc};
  Circle(2718) = {2043,2039,2041};
  Circle(2719) = {2041,2039,2042};
  Circle(2720) = {2042,2039,2040};
  Circle(2721) = {2040,2039,2043};
  Line Loop(2722) = {2718,2719,2720,2721};   // clad surface

  Point(2044) = {  6.51200000, 17.01000000, 0, lc};
  Point(2045) = {  7.34800000, 17.01000000, 0, lc};
  Point(2046) = {  6.93000000, 16.59200000, 0, lc};
  Point(2047) = {  6.93000000, 17.42800000, 0, lc};
  Circle(2723) = {2047,2039,2045};
  Circle(2724) = {2045,2039,2046};
  Circle(2725) = {2046,2039,2044};
  Circle(2726) = {2044,2039,2047};
  Line Loop(2727) = {2723,2724,2725,2726};   // fuel surface

// define rod regions
  Plane Surface(2728) = {2722,2727};   // clad region
  Plane Surface(2729) = {2727};      // fuel region
  Physical Surface("RegClad0614")={2728};   // pin clad
  Physical Surface("RegFuel0614")={2729};   // pin fuel

// ==============================
//    define rod 7,14

  Point(2048) = {  8.19000000, 17.01000000, 0, lc};

  Point(2049) = {  7.71500000, 17.01000000, 0, lc};
  Point(2050) = {  8.66500000, 17.01000000, 0, lc};
  Point(2051) = {  8.19000000, 16.53500000, 0, lc};
  Point(2052) = {  8.19000000, 17.48500000, 0, lc};
  Circle(2730) = {2052,2048,2050};
  Circle(2731) = {2050,2048,2051};
  Circle(2732) = {2051,2048,2049};
  Circle(2733) = {2049,2048,2052};
  Line Loop(2734) = {2730,2731,2732,2733};   // clad surface

  Point(2053) = {  7.77200000, 17.01000000, 0, lc};
  Point(2054) = {  8.60800000, 17.01000000, 0, lc};
  Point(2055) = {  8.19000000, 16.59200000, 0, lc};
  Point(2056) = {  8.19000000, 17.42800000, 0, lc};
  Circle(2735) = {2056,2048,2054};
  Circle(2736) = {2054,2048,2055};
  Circle(2737) = {2055,2048,2053};
  Circle(2738) = {2053,2048,2056};
  Line Loop(2739) = {2735,2736,2737,2738};   // fuel surface

// define rod regions
  Plane Surface(2740) = {2734,2739};   // clad region
  Plane Surface(2741) = {2739};      // fuel region
  Physical Surface("RegClad0714")={2740};   // pin clad
  Physical Surface("RegFuel0714")={2741};   // pin fuel

// ==============================
//    define rod 8,14

  Point(2057) = {  9.45000000, 17.01000000, 0, lc};

  Point(2058) = {  8.97500000, 17.01000000, 0, lc};
  Point(2059) = {  9.92500000, 17.01000000, 0, lc};
  Point(2060) = {  9.45000000, 16.53500000, 0, lc};
  Point(2061) = {  9.45000000, 17.48500000, 0, lc};
  Circle(2742) = {2061,2057,2059};
  Circle(2743) = {2059,2057,2060};
  Circle(2744) = {2060,2057,2058};
  Circle(2745) = {2058,2057,2061};
  Line Loop(2746) = {2742,2743,2744,2745};   // clad surface

  Point(2062) = {  9.03200000, 17.01000000, 0, lc};
  Point(2063) = {  9.86800000, 17.01000000, 0, lc};
  Point(2064) = {  9.45000000, 16.59200000, 0, lc};
  Point(2065) = {  9.45000000, 17.42800000, 0, lc};
  Circle(2747) = {2065,2057,2063};
  Circle(2748) = {2063,2057,2064};
  Circle(2749) = {2064,2057,2062};
  Circle(2750) = {2062,2057,2065};
  Line Loop(2751) = {2747,2748,2749,2750};   // fuel surface

// define rod regions
  Plane Surface(2752) = {2746,2751};   // clad region
  Plane Surface(2753) = {2751};      // fuel region
  Physical Surface("RegClad0814")={2752};   // pin clad
  Physical Surface("RegFuel0814")={2753};   // pin fuel

// ==============================
//    define rod 9,14

  Point(2066) = { 10.71000000, 17.01000000, 0, lc};

  Point(2067) = { 10.23500000, 17.01000000, 0, lc};
  Point(2068) = { 11.18500000, 17.01000000, 0, lc};
  Point(2069) = { 10.71000000, 16.53500000, 0, lc};
  Point(2070) = { 10.71000000, 17.48500000, 0, lc};
  Circle(2754) = {2070,2066,2068};
  Circle(2755) = {2068,2066,2069};
  Circle(2756) = {2069,2066,2067};
  Circle(2757) = {2067,2066,2070};
  Line Loop(2758) = {2754,2755,2756,2757};   // clad surface

  Point(2071) = { 10.29200000, 17.01000000, 0, lc};
  Point(2072) = { 11.12800000, 17.01000000, 0, lc};
  Point(2073) = { 10.71000000, 16.59200000, 0, lc};
  Point(2074) = { 10.71000000, 17.42800000, 0, lc};
  Circle(2759) = {2074,2066,2072};
  Circle(2760) = {2072,2066,2073};
  Circle(2761) = {2073,2066,2071};
  Circle(2762) = {2071,2066,2074};
  Line Loop(2763) = {2759,2760,2761,2762};   // fuel surface

// define rod regions
  Plane Surface(2764) = {2758,2763};   // clad region
  Plane Surface(2765) = {2763};      // fuel region
  Physical Surface("RegClad0914")={2764};   // pin clad
  Physical Surface("RegFuel0914")={2765};   // pin fuel

// ==============================
//    define rod 10,14

  Point(2075) = { 11.97000000, 17.01000000, 0, lc};

  Point(2076) = { 11.49500000, 17.01000000, 0, lc};
  Point(2077) = { 12.44500000, 17.01000000, 0, lc};
  Point(2078) = { 11.97000000, 16.53500000, 0, lc};
  Point(2079) = { 11.97000000, 17.48500000, 0, lc};
  Circle(2766) = {2079,2075,2077};
  Circle(2767) = {2077,2075,2078};
  Circle(2768) = {2078,2075,2076};
  Circle(2769) = {2076,2075,2079};
  Line Loop(2770) = {2766,2767,2768,2769};   // clad surface

  Point(2080) = { 11.55200000, 17.01000000, 0, lc};
  Point(2081) = { 12.38800000, 17.01000000, 0, lc};
  Point(2082) = { 11.97000000, 16.59200000, 0, lc};
  Point(2083) = { 11.97000000, 17.42800000, 0, lc};
  Circle(2771) = {2083,2075,2081};
  Circle(2772) = {2081,2075,2082};
  Circle(2773) = {2082,2075,2080};
  Circle(2774) = {2080,2075,2083};
  Line Loop(2775) = {2771,2772,2773,2774};   // fuel surface

// define rod regions
  Plane Surface(2776) = {2770,2775};   // clad region
  Plane Surface(2777) = {2775};      // fuel region
  Physical Surface("RegClad1014")={2776};   // pin clad
  Physical Surface("RegFuel1014")={2777};   // pin fuel

// ==============================
//    define rod 11,14

  Point(2084) = { 13.23000000, 17.01000000, 0, lc};

  Point(2085) = { 12.75500000, 17.01000000, 0, lc};
  Point(2086) = { 13.70500000, 17.01000000, 0, lc};
  Point(2087) = { 13.23000000, 16.53500000, 0, lc};
  Point(2088) = { 13.23000000, 17.48500000, 0, lc};
  Circle(2778) = {2088,2084,2086};
  Circle(2779) = {2086,2084,2087};
  Circle(2780) = {2087,2084,2085};
  Circle(2781) = {2085,2084,2088};
  Line Loop(2782) = {2778,2779,2780,2781};   // clad surface

  Point(2089) = { 12.81200000, 17.01000000, 0, lc};
  Point(2090) = { 13.64800000, 17.01000000, 0, lc};
  Point(2091) = { 13.23000000, 16.59200000, 0, lc};
  Point(2092) = { 13.23000000, 17.42800000, 0, lc};
  Circle(2783) = {2092,2084,2090};
  Circle(2784) = {2090,2084,2091};
  Circle(2785) = {2091,2084,2089};
  Circle(2786) = {2089,2084,2092};
  Line Loop(2787) = {2783,2784,2785,2786};   // fuel surface

// define rod regions
  Plane Surface(2788) = {2782,2787};   // clad region
  Plane Surface(2789) = {2787};      // fuel region
  Physical Surface("RegClad1114")={2788};   // pin clad
  Physical Surface("RegFuel1114")={2789};   // pin fuel

// ==============================
//    define rod 12,14

  Point(2093) = { 14.49000000, 17.01000000, 0, lc};

  Point(2094) = { 14.01500000, 17.01000000, 0, lc};
  Point(2095) = { 14.96500000, 17.01000000, 0, lc};
  Point(2096) = { 14.49000000, 16.53500000, 0, lc};
  Point(2097) = { 14.49000000, 17.48500000, 0, lc};
  Circle(2790) = {2097,2093,2095};
  Circle(2791) = {2095,2093,2096};
  Circle(2792) = {2096,2093,2094};
  Circle(2793) = {2094,2093,2097};
  Line Loop(2794) = {2790,2791,2792,2793};   // clad surface

  Point(2098) = { 14.07200000, 17.01000000, 0, lc};
  Point(2099) = { 14.90800000, 17.01000000, 0, lc};
  Point(2100) = { 14.49000000, 16.59200000, 0, lc};
  Point(2101) = { 14.49000000, 17.42800000, 0, lc};
  Circle(2795) = {2101,2093,2099};
  Circle(2796) = {2099,2093,2100};
  Circle(2797) = {2100,2093,2098};
  Circle(2798) = {2098,2093,2101};
  Line Loop(2799) = {2795,2796,2797,2798};   // fuel surface

// define rod regions
  Plane Surface(2800) = {2794,2799};   // clad region
  Plane Surface(2801) = {2799};      // fuel region
  Physical Surface("RegClad1214")={2800};   // pin clad
  Physical Surface("RegFuel1214")={2801};   // pin fuel

// ==============================
//    define rod 13,14

  Point(2102) = { 15.75000000, 17.01000000, 0, lc};

  Point(2103) = { 15.27500000, 17.01000000, 0, lc};
  Point(2104) = { 16.22500000, 17.01000000, 0, lc};
  Point(2105) = { 15.75000000, 16.53500000, 0, lc};
  Point(2106) = { 15.75000000, 17.48500000, 0, lc};
  Circle(2802) = {2106,2102,2104};
  Circle(2803) = {2104,2102,2105};
  Circle(2804) = {2105,2102,2103};
  Circle(2805) = {2103,2102,2106};
  Line Loop(2806) = {2802,2803,2804,2805};   // clad surface

  Point(2107) = { 15.33200000, 17.01000000, 0, lc};
  Point(2108) = { 16.16800000, 17.01000000, 0, lc};
  Point(2109) = { 15.75000000, 16.59200000, 0, lc};
  Point(2110) = { 15.75000000, 17.42800000, 0, lc};
  Circle(2807) = {2110,2102,2108};
  Circle(2808) = {2108,2102,2109};
  Circle(2809) = {2109,2102,2107};
  Circle(2810) = {2107,2102,2110};
  Line Loop(2811) = {2807,2808,2809,2810};   // fuel surface

// define rod regions
  Plane Surface(2812) = {2806,2811};   // clad region
  Plane Surface(2813) = {2811};      // fuel region
  Physical Surface("RegClad1314")={2812};   // pin clad
  Physical Surface("RegFuel1314")={2813};   // pin fuel

// ==============================
//    define rod 14,14

  Point(2111) = { 17.01000000, 17.01000000, 0, lc};

  Point(2112) = { 16.53500000, 17.01000000, 0, lc};
  Point(2113) = { 17.48500000, 17.01000000, 0, lc};
  Point(2114) = { 17.01000000, 16.53500000, 0, lc};
  Point(2115) = { 17.01000000, 17.48500000, 0, lc};
  Circle(2814) = {2115,2111,2113};
  Circle(2815) = {2113,2111,2114};
  Circle(2816) = {2114,2111,2112};
  Circle(2817) = {2112,2111,2115};
  Line Loop(2818) = {2814,2815,2816,2817};   // clad surface

  Point(2116) = { 16.59200000, 17.01000000, 0, lc};
  Point(2117) = { 17.42800000, 17.01000000, 0, lc};
  Point(2118) = { 17.01000000, 16.59200000, 0, lc};
  Point(2119) = { 17.01000000, 17.42800000, 0, lc};
  Circle(2819) = {2119,2111,2117};
  Circle(2820) = {2117,2111,2118};
  Circle(2821) = {2118,2111,2116};
  Circle(2822) = {2116,2111,2119};
  Line Loop(2823) = {2819,2820,2821,2822};   // fuel surface

// define rod regions
  Plane Surface(2824) = {2818,2823};   // clad region
  Plane Surface(2825) = {2823};      // fuel region
  Physical Surface("RegClad1414")={2824};   // pin clad
  Physical Surface("RegFuel1414")={2825};   // pin fuel

// ==============================
//    define rod 15,14

  Point(2120) = { 18.27000000, 17.01000000, 0, lc};

  Point(2121) = { 17.79500000, 17.01000000, 0, lc};
  Point(2122) = { 18.74500000, 17.01000000, 0, lc};
  Point(2123) = { 18.27000000, 16.53500000, 0, lc};
  Point(2124) = { 18.27000000, 17.48500000, 0, lc};
  Circle(2826) = {2124,2120,2122};
  Circle(2827) = {2122,2120,2123};
  Circle(2828) = {2123,2120,2121};
  Circle(2829) = {2121,2120,2124};
  Line Loop(2830) = {2826,2827,2828,2829};   // clad surface

  Point(2125) = { 17.85200000, 17.01000000, 0, lc};
  Point(2126) = { 18.68800000, 17.01000000, 0, lc};
  Point(2127) = { 18.27000000, 16.59200000, 0, lc};
  Point(2128) = { 18.27000000, 17.42800000, 0, lc};
  Circle(2831) = {2128,2120,2126};
  Circle(2832) = {2126,2120,2127};
  Circle(2833) = {2127,2120,2125};
  Circle(2834) = {2125,2120,2128};
  Line Loop(2835) = {2831,2832,2833,2834};   // fuel surface

// define rod regions
  Plane Surface(2836) = {2830,2835};   // clad region
  Plane Surface(2837) = {2835};      // fuel region
  Physical Surface("RegClad1514")={2836};   // pin clad
  Physical Surface("RegFuel1514")={2837};   // pin fuel

// ==============================
//    define rod 16,14

  Point(2129) = { 19.53000000, 17.01000000, 0, lc};

  Point(2130) = { 19.05500000, 17.01000000, 0, lc};
  Point(2131) = { 20.00500000, 17.01000000, 0, lc};
  Point(2132) = { 19.53000000, 16.53500000, 0, lc};
  Point(2133) = { 19.53000000, 17.48500000, 0, lc};
  Circle(2838) = {2133,2129,2131};
  Circle(2839) = {2131,2129,2132};
  Circle(2840) = {2132,2129,2130};
  Circle(2841) = {2130,2129,2133};
  Line Loop(2842) = {2838,2839,2840,2841};   // clad surface

  Point(2134) = { 19.11200000, 17.01000000, 0, lc};
  Point(2135) = { 19.94800000, 17.01000000, 0, lc};
  Point(2136) = { 19.53000000, 16.59200000, 0, lc};
  Point(2137) = { 19.53000000, 17.42800000, 0, lc};
  Circle(2843) = {2137,2129,2135};
  Circle(2844) = {2135,2129,2136};
  Circle(2845) = {2136,2129,2134};
  Circle(2846) = {2134,2129,2137};
  Line Loop(2847) = {2843,2844,2845,2846};   // fuel surface

// define rod regions
  Plane Surface(2848) = {2842,2847};   // clad region
  Plane Surface(2849) = {2847};      // fuel region
  Physical Surface("RegClad1614")={2848};   // pin clad
  Physical Surface("RegFuel1614")={2849};   // pin fuel

// ==============================
//    define rod 17,14

  Point(2138) = { 20.79000000, 17.01000000, 0, lc};

  Point(2139) = { 20.31500000, 17.01000000, 0, lc};
  Point(2140) = { 21.26500000, 17.01000000, 0, lc};
  Point(2141) = { 20.79000000, 16.53500000, 0, lc};
  Point(2142) = { 20.79000000, 17.48500000, 0, lc};
  Circle(2850) = {2142,2138,2140};
  Circle(2851) = {2140,2138,2141};
  Circle(2852) = {2141,2138,2139};
  Circle(2853) = {2139,2138,2142};
  Line Loop(2854) = {2850,2851,2852,2853};   // clad surface

  Point(2143) = { 20.37200000, 17.01000000, 0, lc};
  Point(2144) = { 21.20800000, 17.01000000, 0, lc};
  Point(2145) = { 20.79000000, 16.59200000, 0, lc};
  Point(2146) = { 20.79000000, 17.42800000, 0, lc};
  Circle(2855) = {2146,2138,2144};
  Circle(2856) = {2144,2138,2145};
  Circle(2857) = {2145,2138,2143};
  Circle(2858) = {2143,2138,2146};
  Line Loop(2859) = {2855,2856,2857,2858};   // fuel surface

// define rod regions
  Plane Surface(2860) = {2854,2859};   // clad region
  Plane Surface(2861) = {2859};      // fuel region
  Physical Surface("RegClad1714")={2860};   // pin clad
  Physical Surface("RegFuel1714")={2861};   // pin fuel

// ==============================
//    define rod 1,15

  Point(2147) = {  0.63000000, 18.27000000, 0, lc};

  Point(2148) = {  0.15500000, 18.27000000, 0, lc};
  Point(2149) = {  1.10500000, 18.27000000, 0, lc};
  Point(2150) = {  0.63000000, 17.79500000, 0, lc};
  Point(2151) = {  0.63000000, 18.74500000, 0, lc};
  Circle(2862) = {2151,2147,2149};
  Circle(2863) = {2149,2147,2150};
  Circle(2864) = {2150,2147,2148};
  Circle(2865) = {2148,2147,2151};
  Line Loop(2866) = {2862,2863,2864,2865};   // clad surface

  Point(2152) = {  0.21200000, 18.27000000, 0, lc};
  Point(2153) = {  1.04800000, 18.27000000, 0, lc};
  Point(2154) = {  0.63000000, 17.85200000, 0, lc};
  Point(2155) = {  0.63000000, 18.68800000, 0, lc};
  Circle(2867) = {2155,2147,2153};
  Circle(2868) = {2153,2147,2154};
  Circle(2869) = {2154,2147,2152};
  Circle(2870) = {2152,2147,2155};
  Line Loop(2871) = {2867,2868,2869,2870};   // fuel surface

// define rod regions
  Plane Surface(2872) = {2866,2871};   // clad region
  Plane Surface(2873) = {2871};      // fuel region
  Physical Surface("RegClad0115")={2872};   // pin clad
  Physical Surface("RegFuel0115")={2873};   // pin fuel

// ==============================
//    define rod 2,15

  Point(2156) = {  1.89000000, 18.27000000, 0, lc};

  Point(2157) = {  1.41500000, 18.27000000, 0, lc};
  Point(2158) = {  2.36500000, 18.27000000, 0, lc};
  Point(2159) = {  1.89000000, 17.79500000, 0, lc};
  Point(2160) = {  1.89000000, 18.74500000, 0, lc};
  Circle(2874) = {2160,2156,2158};
  Circle(2875) = {2158,2156,2159};
  Circle(2876) = {2159,2156,2157};
  Circle(2877) = {2157,2156,2160};
  Line Loop(2878) = {2874,2875,2876,2877};   // clad surface

  Point(2161) = {  1.47200000, 18.27000000, 0, lc};
  Point(2162) = {  2.30800000, 18.27000000, 0, lc};
  Point(2163) = {  1.89000000, 17.85200000, 0, lc};
  Point(2164) = {  1.89000000, 18.68800000, 0, lc};
  Circle(2879) = {2164,2156,2162};
  Circle(2880) = {2162,2156,2163};
  Circle(2881) = {2163,2156,2161};
  Circle(2882) = {2161,2156,2164};
  Line Loop(2883) = {2879,2880,2881,2882};   // fuel surface

// define rod regions
  Plane Surface(2884) = {2878,2883};   // clad region
  Plane Surface(2885) = {2883};      // fuel region
  Physical Surface("RegClad0215")={2884};   // pin clad
  Physical Surface("RegFuel0215")={2885};   // pin fuel

// ==============================
//    define rod 3,15

  Point(2165) = {  3.15000000, 18.27000000, 0, lc};

  Point(2166) = {  2.67500000, 18.27000000, 0, lc};
  Point(2167) = {  3.62500000, 18.27000000, 0, lc};
  Point(2168) = {  3.15000000, 17.79500000, 0, lc};
  Point(2169) = {  3.15000000, 18.74500000, 0, lc};
  Circle(2886) = {2169,2165,2167};
  Circle(2887) = {2167,2165,2168};
  Circle(2888) = {2168,2165,2166};
  Circle(2889) = {2166,2165,2169};
  Line Loop(2890) = {2886,2887,2888,2889};   // clad surface

  Point(2170) = {  2.73200000, 18.27000000, 0, lc};
  Point(2171) = {  3.56800000, 18.27000000, 0, lc};
  Point(2172) = {  3.15000000, 17.85200000, 0, lc};
  Point(2173) = {  3.15000000, 18.68800000, 0, lc};
  Circle(2891) = {2173,2165,2171};
  Circle(2892) = {2171,2165,2172};
  Circle(2893) = {2172,2165,2170};
  Circle(2894) = {2170,2165,2173};
  Line Loop(2895) = {2891,2892,2893,2894};   // fuel surface

// define rod regions
  Plane Surface(2896) = {2890,2895};   // clad region
  Plane Surface(2897) = {2895};      // fuel region
  Physical Surface("RegClad0315")={2896};   // pin clad
  Physical Surface("RegFuel0315")={2897};   // pin fuel

// ==============================
//    define rod 4,15

  Point(2174) = {  4.41000000, 18.27000000, 0, lc};

  Point(2175) = {  3.93500000, 18.27000000, 0, lc};
  Point(2176) = {  4.88500000, 18.27000000, 0, lc};
  Point(2177) = {  4.41000000, 17.79500000, 0, lc};
  Point(2178) = {  4.41000000, 18.74500000, 0, lc};
  Circle(2898) = {2178,2174,2176};
  Circle(2899) = {2176,2174,2177};
  Circle(2900) = {2177,2174,2175};
  Circle(2901) = {2175,2174,2178};
  Line Loop(2902) = {2898,2899,2900,2901};   // clad surface

  Point(2179) = {  3.99200000, 18.27000000, 0, lc};
  Point(2180) = {  4.82800000, 18.27000000, 0, lc};
  Point(2181) = {  4.41000000, 17.85200000, 0, lc};
  Point(2182) = {  4.41000000, 18.68800000, 0, lc};
  Circle(2903) = {2182,2174,2180};
  Circle(2904) = {2180,2174,2181};
  Circle(2905) = {2181,2174,2179};
  Circle(2906) = {2179,2174,2182};
  Line Loop(2907) = {2903,2904,2905,2906};   // fuel surface

// define rod regions
  Plane Surface(2908) = {2902,2907};   // clad region
  Plane Surface(2909) = {2907};      // fuel region
  Physical Surface("RegClad0415")={2908};   // pin clad
  Physical Surface("RegFuel0415")={2909};   // pin fuel

// ==============================
//    define rod 5,15

  Point(2183) = {  5.67000000, 18.27000000, 0, lc};

  Point(2184) = {  5.19500000, 18.27000000, 0, lc};
  Point(2185) = {  6.14500000, 18.27000000, 0, lc};
  Point(2186) = {  5.67000000, 17.79500000, 0, lc};
  Point(2187) = {  5.67000000, 18.74500000, 0, lc};
  Circle(2910) = {2187,2183,2185};
  Circle(2911) = {2185,2183,2186};
  Circle(2912) = {2186,2183,2184};
  Circle(2913) = {2184,2183,2187};
  Line Loop(2914) = {2910,2911,2912,2913};   // clad surface

  Point(2188) = {  5.25200000, 18.27000000, 0, lc};
  Point(2189) = {  6.08800000, 18.27000000, 0, lc};
  Point(2190) = {  5.67000000, 17.85200000, 0, lc};
  Point(2191) = {  5.67000000, 18.68800000, 0, lc};
  Circle(2915) = {2191,2183,2189};
  Circle(2916) = {2189,2183,2190};
  Circle(2917) = {2190,2183,2188};
  Circle(2918) = {2188,2183,2191};
  Line Loop(2919) = {2915,2916,2917,2918};   // fuel surface

// define rod regions
  Plane Surface(2920) = {2914,2919};   // clad region
  Plane Surface(2921) = {2919};      // fuel region
  Physical Surface("RegClad0515")={2920};   // pin clad
  Physical Surface("RegFuel0515")={2921};   // pin fuel

// ==============================
//    define rod 6,15

  Point(2192) = {  6.93000000, 18.27000000, 0, lc};

  Point(2193) = {  6.45500000, 18.27000000, 0, lc};
  Point(2194) = {  7.40500000, 18.27000000, 0, lc};
  Point(2195) = {  6.93000000, 17.79500000, 0, lc};
  Point(2196) = {  6.93000000, 18.74500000, 0, lc};
  Circle(2922) = {2196,2192,2194};
  Circle(2923) = {2194,2192,2195};
  Circle(2924) = {2195,2192,2193};
  Circle(2925) = {2193,2192,2196};
  Line Loop(2926) = {2922,2923,2924,2925};   // clad surface

  Point(2197) = {  6.51200000, 18.27000000, 0, lc};
  Point(2198) = {  7.34800000, 18.27000000, 0, lc};
  Point(2199) = {  6.93000000, 17.85200000, 0, lc};
  Point(2200) = {  6.93000000, 18.68800000, 0, lc};
  Circle(2927) = {2200,2192,2198};
  Circle(2928) = {2198,2192,2199};
  Circle(2929) = {2199,2192,2197};
  Circle(2930) = {2197,2192,2200};
  Line Loop(2931) = {2927,2928,2929,2930};   // fuel surface

// define rod regions
  Plane Surface(2932) = {2926,2931};   // clad region
  Plane Surface(2933) = {2931};      // fuel region
  Physical Surface("RegClad0615")={2932};   // pin clad
  Physical Surface("RegFuel0615")={2933};   // pin fuel

// ==============================
//    define rod 7,15

  Point(2201) = {  8.19000000, 18.27000000, 0, lc};

  Point(2202) = {  7.71500000, 18.27000000, 0, lc};
  Point(2203) = {  8.66500000, 18.27000000, 0, lc};
  Point(2204) = {  8.19000000, 17.79500000, 0, lc};
  Point(2205) = {  8.19000000, 18.74500000, 0, lc};
  Circle(2934) = {2205,2201,2203};
  Circle(2935) = {2203,2201,2204};
  Circle(2936) = {2204,2201,2202};
  Circle(2937) = {2202,2201,2205};
  Line Loop(2938) = {2934,2935,2936,2937};   // clad surface

  Point(2206) = {  7.77200000, 18.27000000, 0, lc};
  Point(2207) = {  8.60800000, 18.27000000, 0, lc};
  Point(2208) = {  8.19000000, 17.85200000, 0, lc};
  Point(2209) = {  8.19000000, 18.68800000, 0, lc};
  Circle(2939) = {2209,2201,2207};
  Circle(2940) = {2207,2201,2208};
  Circle(2941) = {2208,2201,2206};
  Circle(2942) = {2206,2201,2209};
  Line Loop(2943) = {2939,2940,2941,2942};   // fuel surface

// define rod regions
  Plane Surface(2944) = {2938,2943};   // clad region
  Plane Surface(2945) = {2943};      // fuel region
  Physical Surface("RegClad0715")={2944};   // pin clad
  Physical Surface("RegFuel0715")={2945};   // pin fuel

// ==============================
//    define rod 8,15

  Point(2210) = {  9.45000000, 18.27000000, 0, lc};

  Point(2211) = {  8.97500000, 18.27000000, 0, lc};
  Point(2212) = {  9.92500000, 18.27000000, 0, lc};
  Point(2213) = {  9.45000000, 17.79500000, 0, lc};
  Point(2214) = {  9.45000000, 18.74500000, 0, lc};
  Circle(2946) = {2214,2210,2212};
  Circle(2947) = {2212,2210,2213};
  Circle(2948) = {2213,2210,2211};
  Circle(2949) = {2211,2210,2214};
  Line Loop(2950) = {2946,2947,2948,2949};   // clad surface

  Point(2215) = {  9.03200000, 18.27000000, 0, lc};
  Point(2216) = {  9.86800000, 18.27000000, 0, lc};
  Point(2217) = {  9.45000000, 17.85200000, 0, lc};
  Point(2218) = {  9.45000000, 18.68800000, 0, lc};
  Circle(2951) = {2218,2210,2216};
  Circle(2952) = {2216,2210,2217};
  Circle(2953) = {2217,2210,2215};
  Circle(2954) = {2215,2210,2218};
  Line Loop(2955) = {2951,2952,2953,2954};   // fuel surface

// define rod regions
  Plane Surface(2956) = {2950,2955};   // clad region
  Plane Surface(2957) = {2955};      // fuel region
  Physical Surface("RegClad0815")={2956};   // pin clad
  Physical Surface("RegFuel0815")={2957};   // pin fuel

// ==============================
//    define rod 9,15

  Point(2219) = { 10.71000000, 18.27000000, 0, lc};

  Point(2220) = { 10.23500000, 18.27000000, 0, lc};
  Point(2221) = { 11.18500000, 18.27000000, 0, lc};
  Point(2222) = { 10.71000000, 17.79500000, 0, lc};
  Point(2223) = { 10.71000000, 18.74500000, 0, lc};
  Circle(2958) = {2223,2219,2221};
  Circle(2959) = {2221,2219,2222};
  Circle(2960) = {2222,2219,2220};
  Circle(2961) = {2220,2219,2223};
  Line Loop(2962) = {2958,2959,2960,2961};   // clad surface

  Point(2224) = { 10.29200000, 18.27000000, 0, lc};
  Point(2225) = { 11.12800000, 18.27000000, 0, lc};
  Point(2226) = { 10.71000000, 17.85200000, 0, lc};
  Point(2227) = { 10.71000000, 18.68800000, 0, lc};
  Circle(2963) = {2227,2219,2225};
  Circle(2964) = {2225,2219,2226};
  Circle(2965) = {2226,2219,2224};
  Circle(2966) = {2224,2219,2227};
  Line Loop(2967) = {2963,2964,2965,2966};   // fuel surface

// define rod regions
  Plane Surface(2968) = {2962,2967};   // clad region
  Plane Surface(2969) = {2967};      // fuel region
  Physical Surface("RegClad0915")={2968};   // pin clad
  Physical Surface("RegFuel0915")={2969};   // pin fuel

// ==============================
//    define rod 10,15

  Point(2228) = { 11.97000000, 18.27000000, 0, lc};

  Point(2229) = { 11.49500000, 18.27000000, 0, lc};
  Point(2230) = { 12.44500000, 18.27000000, 0, lc};
  Point(2231) = { 11.97000000, 17.79500000, 0, lc};
  Point(2232) = { 11.97000000, 18.74500000, 0, lc};
  Circle(2970) = {2232,2228,2230};
  Circle(2971) = {2230,2228,2231};
  Circle(2972) = {2231,2228,2229};
  Circle(2973) = {2229,2228,2232};
  Line Loop(2974) = {2970,2971,2972,2973};   // clad surface

  Point(2233) = { 11.55200000, 18.27000000, 0, lc};
  Point(2234) = { 12.38800000, 18.27000000, 0, lc};
  Point(2235) = { 11.97000000, 17.85200000, 0, lc};
  Point(2236) = { 11.97000000, 18.68800000, 0, lc};
  Circle(2975) = {2236,2228,2234};
  Circle(2976) = {2234,2228,2235};
  Circle(2977) = {2235,2228,2233};
  Circle(2978) = {2233,2228,2236};
  Line Loop(2979) = {2975,2976,2977,2978};   // fuel surface

// define rod regions
  Plane Surface(2980) = {2974,2979};   // clad region
  Plane Surface(2981) = {2979};      // fuel region
  Physical Surface("RegClad1015")={2980};   // pin clad
  Physical Surface("RegFuel1015")={2981};   // pin fuel

// ==============================
//    define rod 11,15

  Point(2237) = { 13.23000000, 18.27000000, 0, lc};

  Point(2238) = { 12.75500000, 18.27000000, 0, lc};
  Point(2239) = { 13.70500000, 18.27000000, 0, lc};
  Point(2240) = { 13.23000000, 17.79500000, 0, lc};
  Point(2241) = { 13.23000000, 18.74500000, 0, lc};
  Circle(2982) = {2241,2237,2239};
  Circle(2983) = {2239,2237,2240};
  Circle(2984) = {2240,2237,2238};
  Circle(2985) = {2238,2237,2241};
  Line Loop(2986) = {2982,2983,2984,2985};   // clad surface

  Point(2242) = { 12.81200000, 18.27000000, 0, lc};
  Point(2243) = { 13.64800000, 18.27000000, 0, lc};
  Point(2244) = { 13.23000000, 17.85200000, 0, lc};
  Point(2245) = { 13.23000000, 18.68800000, 0, lc};
  Circle(2987) = {2245,2237,2243};
  Circle(2988) = {2243,2237,2244};
  Circle(2989) = {2244,2237,2242};
  Circle(2990) = {2242,2237,2245};
  Line Loop(2991) = {2987,2988,2989,2990};   // fuel surface

// define rod regions
  Plane Surface(2992) = {2986,2991};   // clad region
  Plane Surface(2993) = {2991};      // fuel region
  Physical Surface("RegClad1115")={2992};   // pin clad
  Physical Surface("RegFuel1115")={2993};   // pin fuel

// ==============================
//    define rod 12,15

  Point(2246) = { 14.49000000, 18.27000000, 0, lc};

  Point(2247) = { 14.01500000, 18.27000000, 0, lc};
  Point(2248) = { 14.96500000, 18.27000000, 0, lc};
  Point(2249) = { 14.49000000, 17.79500000, 0, lc};
  Point(2250) = { 14.49000000, 18.74500000, 0, lc};
  Circle(2994) = {2250,2246,2248};
  Circle(2995) = {2248,2246,2249};
  Circle(2996) = {2249,2246,2247};
  Circle(2997) = {2247,2246,2250};
  Line Loop(2998) = {2994,2995,2996,2997};   // clad surface

  Point(2251) = { 14.07200000, 18.27000000, 0, lc};
  Point(2252) = { 14.90800000, 18.27000000, 0, lc};
  Point(2253) = { 14.49000000, 17.85200000, 0, lc};
  Point(2254) = { 14.49000000, 18.68800000, 0, lc};
  Circle(2999) = {2254,2246,2252};
  Circle(3000) = {2252,2246,2253};
  Circle(3001) = {2253,2246,2251};
  Circle(3002) = {2251,2246,2254};
  Line Loop(3003) = {2999,3000,3001,3002};   // fuel surface

// define rod regions
  Plane Surface(3004) = {2998,3003};   // clad region
  Plane Surface(3005) = {3003};      // fuel region
  Physical Surface("RegClad1215")={3004};   // pin clad
  Physical Surface("RegFuel1215")={3005};   // pin fuel

// ==============================
//    define rod 13,15

  Point(2255) = { 15.75000000, 18.27000000, 0, lc};

  Point(2256) = { 15.27500000, 18.27000000, 0, lc};
  Point(2257) = { 16.22500000, 18.27000000, 0, lc};
  Point(2258) = { 15.75000000, 17.79500000, 0, lc};
  Point(2259) = { 15.75000000, 18.74500000, 0, lc};
  Circle(3006) = {2259,2255,2257};
  Circle(3007) = {2257,2255,2258};
  Circle(3008) = {2258,2255,2256};
  Circle(3009) = {2256,2255,2259};
  Line Loop(3010) = {3006,3007,3008,3009};   // clad surface

  Point(2260) = { 15.33200000, 18.27000000, 0, lc};
  Point(2261) = { 16.16800000, 18.27000000, 0, lc};
  Point(2262) = { 15.75000000, 17.85200000, 0, lc};
  Point(2263) = { 15.75000000, 18.68800000, 0, lc};
  Circle(3011) = {2263,2255,2261};
  Circle(3012) = {2261,2255,2262};
  Circle(3013) = {2262,2255,2260};
  Circle(3014) = {2260,2255,2263};
  Line Loop(3015) = {3011,3012,3013,3014};   // fuel surface

// define rod regions
  Plane Surface(3016) = {3010,3015};   // clad region
  Plane Surface(3017) = {3015};      // fuel region
  Physical Surface("RegClad1315")={3016};   // pin clad
  Physical Surface("RegFuel1315")={3017};   // pin fuel

// ==============================
//    define rod 14,15

  Point(2264) = { 17.01000000, 18.27000000, 0, lc};

  Point(2265) = { 16.53500000, 18.27000000, 0, lc};
  Point(2266) = { 17.48500000, 18.27000000, 0, lc};
  Point(2267) = { 17.01000000, 17.79500000, 0, lc};
  Point(2268) = { 17.01000000, 18.74500000, 0, lc};
  Circle(3018) = {2268,2264,2266};
  Circle(3019) = {2266,2264,2267};
  Circle(3020) = {2267,2264,2265};
  Circle(3021) = {2265,2264,2268};
  Line Loop(3022) = {3018,3019,3020,3021};   // clad surface

  Point(2269) = { 16.59200000, 18.27000000, 0, lc};
  Point(2270) = { 17.42800000, 18.27000000, 0, lc};
  Point(2271) = { 17.01000000, 17.85200000, 0, lc};
  Point(2272) = { 17.01000000, 18.68800000, 0, lc};
  Circle(3023) = {2272,2264,2270};
  Circle(3024) = {2270,2264,2271};
  Circle(3025) = {2271,2264,2269};
  Circle(3026) = {2269,2264,2272};
  Line Loop(3027) = {3023,3024,3025,3026};   // fuel surface

// define rod regions
  Plane Surface(3028) = {3022,3027};   // clad region
  Plane Surface(3029) = {3027};      // fuel region
  Physical Surface("RegClad1415")={3028};   // pin clad
  Physical Surface("RegFuel1415")={3029};   // pin fuel

// ==============================
//    define rod 15,15

  Point(2273) = { 18.27000000, 18.27000000, 0, lc};

  Point(2274) = { 17.79500000, 18.27000000, 0, lc};
  Point(2275) = { 18.74500000, 18.27000000, 0, lc};
  Point(2276) = { 18.27000000, 17.79500000, 0, lc};
  Point(2277) = { 18.27000000, 18.74500000, 0, lc};
  Circle(3030) = {2277,2273,2275};
  Circle(3031) = {2275,2273,2276};
  Circle(3032) = {2276,2273,2274};
  Circle(3033) = {2274,2273,2277};
  Line Loop(3034) = {3030,3031,3032,3033};   // clad surface

  Point(2278) = { 17.85200000, 18.27000000, 0, lc};
  Point(2279) = { 18.68800000, 18.27000000, 0, lc};
  Point(2280) = { 18.27000000, 17.85200000, 0, lc};
  Point(2281) = { 18.27000000, 18.68800000, 0, lc};
  Circle(3035) = {2281,2273,2279};
  Circle(3036) = {2279,2273,2280};
  Circle(3037) = {2280,2273,2278};
  Circle(3038) = {2278,2273,2281};
  Line Loop(3039) = {3035,3036,3037,3038};   // fuel surface

// define rod regions
  Plane Surface(3040) = {3034,3039};   // clad region
  Plane Surface(3041) = {3039};      // fuel region
  Physical Surface("RegClad1515")={3040};   // pin clad
  Physical Surface("RegFuel1515")={3041};   // pin fuel

// ==============================
//    define rod 16,15

  Point(2282) = { 19.53000000, 18.27000000, 0, lc};

  Point(2283) = { 19.05500000, 18.27000000, 0, lc};
  Point(2284) = { 20.00500000, 18.27000000, 0, lc};
  Point(2285) = { 19.53000000, 17.79500000, 0, lc};
  Point(2286) = { 19.53000000, 18.74500000, 0, lc};
  Circle(3042) = {2286,2282,2284};
  Circle(3043) = {2284,2282,2285};
  Circle(3044) = {2285,2282,2283};
  Circle(3045) = {2283,2282,2286};
  Line Loop(3046) = {3042,3043,3044,3045};   // clad surface

  Point(2287) = { 19.11200000, 18.27000000, 0, lc};
  Point(2288) = { 19.94800000, 18.27000000, 0, lc};
  Point(2289) = { 19.53000000, 17.85200000, 0, lc};
  Point(2290) = { 19.53000000, 18.68800000, 0, lc};
  Circle(3047) = {2290,2282,2288};
  Circle(3048) = {2288,2282,2289};
  Circle(3049) = {2289,2282,2287};
  Circle(3050) = {2287,2282,2290};
  Line Loop(3051) = {3047,3048,3049,3050};   // fuel surface

// define rod regions
  Plane Surface(3052) = {3046,3051};   // clad region
  Plane Surface(3053) = {3051};      // fuel region
  Physical Surface("RegClad1615")={3052};   // pin clad
  Physical Surface("RegFuel1615")={3053};   // pin fuel

// ==============================
//    define rod 17,15

  Point(2291) = { 20.79000000, 18.27000000, 0, lc};

  Point(2292) = { 20.31500000, 18.27000000, 0, lc};
  Point(2293) = { 21.26500000, 18.27000000, 0, lc};
  Point(2294) = { 20.79000000, 17.79500000, 0, lc};
  Point(2295) = { 20.79000000, 18.74500000, 0, lc};
  Circle(3054) = {2295,2291,2293};
  Circle(3055) = {2293,2291,2294};
  Circle(3056) = {2294,2291,2292};
  Circle(3057) = {2292,2291,2295};
  Line Loop(3058) = {3054,3055,3056,3057};   // clad surface

  Point(2296) = { 20.37200000, 18.27000000, 0, lc};
  Point(2297) = { 21.20800000, 18.27000000, 0, lc};
  Point(2298) = { 20.79000000, 17.85200000, 0, lc};
  Point(2299) = { 20.79000000, 18.68800000, 0, lc};
  Circle(3059) = {2299,2291,2297};
  Circle(3060) = {2297,2291,2298};
  Circle(3061) = {2298,2291,2296};
  Circle(3062) = {2296,2291,2299};
  Line Loop(3063) = {3059,3060,3061,3062};   // fuel surface

// define rod regions
  Plane Surface(3064) = {3058,3063};   // clad region
  Plane Surface(3065) = {3063};      // fuel region
  Physical Surface("RegClad1715")={3064};   // pin clad
  Physical Surface("RegFuel1715")={3065};   // pin fuel

// ==============================
//    define rod 1,16

  Point(2300) = {  0.63000000, 19.53000000, 0, lc};

  Point(2301) = {  0.15500000, 19.53000000, 0, lc};
  Point(2302) = {  1.10500000, 19.53000000, 0, lc};
  Point(2303) = {  0.63000000, 19.05500000, 0, lc};
  Point(2304) = {  0.63000000, 20.00500000, 0, lc};
  Circle(3066) = {2304,2300,2302};
  Circle(3067) = {2302,2300,2303};
  Circle(3068) = {2303,2300,2301};
  Circle(3069) = {2301,2300,2304};
  Line Loop(3070) = {3066,3067,3068,3069};   // clad surface

  Point(2305) = {  0.21200000, 19.53000000, 0, lc};
  Point(2306) = {  1.04800000, 19.53000000, 0, lc};
  Point(2307) = {  0.63000000, 19.11200000, 0, lc};
  Point(2308) = {  0.63000000, 19.94800000, 0, lc};
  Circle(3071) = {2308,2300,2306};
  Circle(3072) = {2306,2300,2307};
  Circle(3073) = {2307,2300,2305};
  Circle(3074) = {2305,2300,2308};
  Line Loop(3075) = {3071,3072,3073,3074};   // fuel surface

// define rod regions
  Plane Surface(3076) = {3070,3075};   // clad region
  Plane Surface(3077) = {3075};      // fuel region
  Physical Surface("RegClad0116")={3076};   // pin clad
  Physical Surface("RegFuel0116")={3077};   // pin fuel

// ==============================
//    define rod 2,16

  Point(2309) = {  1.89000000, 19.53000000, 0, lc};

  Point(2310) = {  1.41500000, 19.53000000, 0, lc};
  Point(2311) = {  2.36500000, 19.53000000, 0, lc};
  Point(2312) = {  1.89000000, 19.05500000, 0, lc};
  Point(2313) = {  1.89000000, 20.00500000, 0, lc};
  Circle(3078) = {2313,2309,2311};
  Circle(3079) = {2311,2309,2312};
  Circle(3080) = {2312,2309,2310};
  Circle(3081) = {2310,2309,2313};
  Line Loop(3082) = {3078,3079,3080,3081};   // clad surface

  Point(2314) = {  1.47200000, 19.53000000, 0, lc};
  Point(2315) = {  2.30800000, 19.53000000, 0, lc};
  Point(2316) = {  1.89000000, 19.11200000, 0, lc};
  Point(2317) = {  1.89000000, 19.94800000, 0, lc};
  Circle(3083) = {2317,2309,2315};
  Circle(3084) = {2315,2309,2316};
  Circle(3085) = {2316,2309,2314};
  Circle(3086) = {2314,2309,2317};
  Line Loop(3087) = {3083,3084,3085,3086};   // fuel surface

// define rod regions
  Plane Surface(3088) = {3082,3087};   // clad region
  Plane Surface(3089) = {3087};      // fuel region
  Physical Surface("RegClad0216")={3088};   // pin clad
  Physical Surface("RegFuel0216")={3089};   // pin fuel

// ==============================
//    define rod 3,16

  Point(2318) = {  3.15000000, 19.53000000, 0, lc};

  Point(2319) = {  2.67500000, 19.53000000, 0, lc};
  Point(2320) = {  3.62500000, 19.53000000, 0, lc};
  Point(2321) = {  3.15000000, 19.05500000, 0, lc};
  Point(2322) = {  3.15000000, 20.00500000, 0, lc};
  Circle(3090) = {2322,2318,2320};
  Circle(3091) = {2320,2318,2321};
  Circle(3092) = {2321,2318,2319};
  Circle(3093) = {2319,2318,2322};
  Line Loop(3094) = {3090,3091,3092,3093};   // clad surface

  Point(2323) = {  2.73200000, 19.53000000, 0, lc};
  Point(2324) = {  3.56800000, 19.53000000, 0, lc};
  Point(2325) = {  3.15000000, 19.11200000, 0, lc};
  Point(2326) = {  3.15000000, 19.94800000, 0, lc};
  Circle(3095) = {2326,2318,2324};
  Circle(3096) = {2324,2318,2325};
  Circle(3097) = {2325,2318,2323};
  Circle(3098) = {2323,2318,2326};
  Line Loop(3099) = {3095,3096,3097,3098};   // fuel surface

// define rod regions
  Plane Surface(3100) = {3094,3099};   // clad region
  Plane Surface(3101) = {3099};      // fuel region
  Physical Surface("RegClad0316")={3100};   // pin clad
  Physical Surface("RegFuel0316")={3101};   // pin fuel

// ==============================
//    define rod 4,16

  Point(2327) = {  4.41000000, 19.53000000, 0, lc};

  Point(2328) = {  3.93500000, 19.53000000, 0, lc};
  Point(2329) = {  4.88500000, 19.53000000, 0, lc};
  Point(2330) = {  4.41000000, 19.05500000, 0, lc};
  Point(2331) = {  4.41000000, 20.00500000, 0, lc};
  Circle(3102) = {2331,2327,2329};
  Circle(3103) = {2329,2327,2330};
  Circle(3104) = {2330,2327,2328};
  Circle(3105) = {2328,2327,2331};
  Line Loop(3106) = {3102,3103,3104,3105};   // clad surface

  Point(2332) = {  3.99200000, 19.53000000, 0, lc};
  Point(2333) = {  4.82800000, 19.53000000, 0, lc};
  Point(2334) = {  4.41000000, 19.11200000, 0, lc};
  Point(2335) = {  4.41000000, 19.94800000, 0, lc};
  Circle(3107) = {2335,2327,2333};
  Circle(3108) = {2333,2327,2334};
  Circle(3109) = {2334,2327,2332};
  Circle(3110) = {2332,2327,2335};
  Line Loop(3111) = {3107,3108,3109,3110};   // fuel surface

// define rod regions
  Plane Surface(3112) = {3106,3111};   // clad region
  Plane Surface(3113) = {3111};      // fuel region
  Physical Surface("RegClad0416")={3112};   // pin clad
  Physical Surface("RegFuel0416")={3113};   // pin fuel

// ==============================
//    define rod 5,16

  Point(2336) = {  5.67000000, 19.53000000, 0, lc};

  Point(2337) = {  5.19500000, 19.53000000, 0, lc};
  Point(2338) = {  6.14500000, 19.53000000, 0, lc};
  Point(2339) = {  5.67000000, 19.05500000, 0, lc};
  Point(2340) = {  5.67000000, 20.00500000, 0, lc};
  Circle(3114) = {2340,2336,2338};
  Circle(3115) = {2338,2336,2339};
  Circle(3116) = {2339,2336,2337};
  Circle(3117) = {2337,2336,2340};
  Line Loop(3118) = {3114,3115,3116,3117};   // clad surface

  Point(2341) = {  5.25200000, 19.53000000, 0, lc};
  Point(2342) = {  6.08800000, 19.53000000, 0, lc};
  Point(2343) = {  5.67000000, 19.11200000, 0, lc};
  Point(2344) = {  5.67000000, 19.94800000, 0, lc};
  Circle(3119) = {2344,2336,2342};
  Circle(3120) = {2342,2336,2343};
  Circle(3121) = {2343,2336,2341};
  Circle(3122) = {2341,2336,2344};
  Line Loop(3123) = {3119,3120,3121,3122};   // fuel surface

// define rod regions
  Plane Surface(3124) = {3118,3123};   // clad region
  Plane Surface(3125) = {3123};      // fuel region
  Physical Surface("RegClad0516")={3124};   // pin clad
  Physical Surface("RegFuel0516")={3125};   // pin fuel

// ==============================
//    define rod 6,16

  Point(2345) = {  6.93000000, 19.53000000, 0, lc};

  Point(2346) = {  6.45500000, 19.53000000, 0, lc};
  Point(2347) = {  7.40500000, 19.53000000, 0, lc};
  Point(2348) = {  6.93000000, 19.05500000, 0, lc};
  Point(2349) = {  6.93000000, 20.00500000, 0, lc};
  Circle(3126) = {2349,2345,2347};
  Circle(3127) = {2347,2345,2348};
  Circle(3128) = {2348,2345,2346};
  Circle(3129) = {2346,2345,2349};
  Line Loop(3130) = {3126,3127,3128,3129};   // clad surface

  Point(2350) = {  6.51200000, 19.53000000, 0, lc};
  Point(2351) = {  7.34800000, 19.53000000, 0, lc};
  Point(2352) = {  6.93000000, 19.11200000, 0, lc};
  Point(2353) = {  6.93000000, 19.94800000, 0, lc};
  Circle(3131) = {2353,2345,2351};
  Circle(3132) = {2351,2345,2352};
  Circle(3133) = {2352,2345,2350};
  Circle(3134) = {2350,2345,2353};
  Line Loop(3135) = {3131,3132,3133,3134};   // fuel surface

// define rod regions
  Plane Surface(3136) = {3130,3135};   // clad region
  Plane Surface(3137) = {3135};      // fuel region
  Physical Surface("RegClad0616")={3136};   // pin clad
  Physical Surface("RegFuel0616")={3137};   // pin fuel

// ==============================
//    define rod 7,16

  Point(2354) = {  8.19000000, 19.53000000, 0, lc};

  Point(2355) = {  7.71500000, 19.53000000, 0, lc};
  Point(2356) = {  8.66500000, 19.53000000, 0, lc};
  Point(2357) = {  8.19000000, 19.05500000, 0, lc};
  Point(2358) = {  8.19000000, 20.00500000, 0, lc};
  Circle(3138) = {2358,2354,2356};
  Circle(3139) = {2356,2354,2357};
  Circle(3140) = {2357,2354,2355};
  Circle(3141) = {2355,2354,2358};
  Line Loop(3142) = {3138,3139,3140,3141};   // clad surface

  Point(2359) = {  7.77200000, 19.53000000, 0, lc};
  Point(2360) = {  8.60800000, 19.53000000, 0, lc};
  Point(2361) = {  8.19000000, 19.11200000, 0, lc};
  Point(2362) = {  8.19000000, 19.94800000, 0, lc};
  Circle(3143) = {2362,2354,2360};
  Circle(3144) = {2360,2354,2361};
  Circle(3145) = {2361,2354,2359};
  Circle(3146) = {2359,2354,2362};
  Line Loop(3147) = {3143,3144,3145,3146};   // fuel surface

// define rod regions
  Plane Surface(3148) = {3142,3147};   // clad region
  Plane Surface(3149) = {3147};      // fuel region
  Physical Surface("RegClad0716")={3148};   // pin clad
  Physical Surface("RegFuel0716")={3149};   // pin fuel

// ==============================
//    define rod 8,16

  Point(2363) = {  9.45000000, 19.53000000, 0, lc};

  Point(2364) = {  8.97500000, 19.53000000, 0, lc};
  Point(2365) = {  9.92500000, 19.53000000, 0, lc};
  Point(2366) = {  9.45000000, 19.05500000, 0, lc};
  Point(2367) = {  9.45000000, 20.00500000, 0, lc};
  Circle(3150) = {2367,2363,2365};
  Circle(3151) = {2365,2363,2366};
  Circle(3152) = {2366,2363,2364};
  Circle(3153) = {2364,2363,2367};
  Line Loop(3154) = {3150,3151,3152,3153};   // clad surface

  Point(2368) = {  9.03200000, 19.53000000, 0, lc};
  Point(2369) = {  9.86800000, 19.53000000, 0, lc};
  Point(2370) = {  9.45000000, 19.11200000, 0, lc};
  Point(2371) = {  9.45000000, 19.94800000, 0, lc};
  Circle(3155) = {2371,2363,2369};
  Circle(3156) = {2369,2363,2370};
  Circle(3157) = {2370,2363,2368};
  Circle(3158) = {2368,2363,2371};
  Line Loop(3159) = {3155,3156,3157,3158};   // fuel surface

// define rod regions
  Plane Surface(3160) = {3154,3159};   // clad region
  Plane Surface(3161) = {3159};      // fuel region
  Physical Surface("RegClad0816")={3160};   // pin clad
  Physical Surface("RegFuel0816")={3161};   // pin fuel

// ==============================
//    define rod 9,16

  Point(2372) = { 10.71000000, 19.53000000, 0, lc};

  Point(2373) = { 10.23500000, 19.53000000, 0, lc};
  Point(2374) = { 11.18500000, 19.53000000, 0, lc};
  Point(2375) = { 10.71000000, 19.05500000, 0, lc};
  Point(2376) = { 10.71000000, 20.00500000, 0, lc};
  Circle(3162) = {2376,2372,2374};
  Circle(3163) = {2374,2372,2375};
  Circle(3164) = {2375,2372,2373};
  Circle(3165) = {2373,2372,2376};
  Line Loop(3166) = {3162,3163,3164,3165};   // clad surface

  Point(2377) = { 10.29200000, 19.53000000, 0, lc};
  Point(2378) = { 11.12800000, 19.53000000, 0, lc};
  Point(2379) = { 10.71000000, 19.11200000, 0, lc};
  Point(2380) = { 10.71000000, 19.94800000, 0, lc};
  Circle(3167) = {2380,2372,2378};
  Circle(3168) = {2378,2372,2379};
  Circle(3169) = {2379,2372,2377};
  Circle(3170) = {2377,2372,2380};
  Line Loop(3171) = {3167,3168,3169,3170};   // fuel surface

// define rod regions
  Plane Surface(3172) = {3166,3171};   // clad region
  Plane Surface(3173) = {3171};      // fuel region
  Physical Surface("RegClad0916")={3172};   // pin clad
  Physical Surface("RegFuel0916")={3173};   // pin fuel

// ==============================
//    define rod 10,16

  Point(2381) = { 11.97000000, 19.53000000, 0, lc};

  Point(2382) = { 11.49500000, 19.53000000, 0, lc};
  Point(2383) = { 12.44500000, 19.53000000, 0, lc};
  Point(2384) = { 11.97000000, 19.05500000, 0, lc};
  Point(2385) = { 11.97000000, 20.00500000, 0, lc};
  Circle(3174) = {2385,2381,2383};
  Circle(3175) = {2383,2381,2384};
  Circle(3176) = {2384,2381,2382};
  Circle(3177) = {2382,2381,2385};
  Line Loop(3178) = {3174,3175,3176,3177};   // clad surface

  Point(2386) = { 11.55200000, 19.53000000, 0, lc};
  Point(2387) = { 12.38800000, 19.53000000, 0, lc};
  Point(2388) = { 11.97000000, 19.11200000, 0, lc};
  Point(2389) = { 11.97000000, 19.94800000, 0, lc};
  Circle(3179) = {2389,2381,2387};
  Circle(3180) = {2387,2381,2388};
  Circle(3181) = {2388,2381,2386};
  Circle(3182) = {2386,2381,2389};
  Line Loop(3183) = {3179,3180,3181,3182};   // fuel surface

// define rod regions
  Plane Surface(3184) = {3178,3183};   // clad region
  Plane Surface(3185) = {3183};      // fuel region
  Physical Surface("RegClad1016")={3184};   // pin clad
  Physical Surface("RegFuel1016")={3185};   // pin fuel

// ==============================
//    define rod 11,16

  Point(2390) = { 13.23000000, 19.53000000, 0, lc};

  Point(2391) = { 12.75500000, 19.53000000, 0, lc};
  Point(2392) = { 13.70500000, 19.53000000, 0, lc};
  Point(2393) = { 13.23000000, 19.05500000, 0, lc};
  Point(2394) = { 13.23000000, 20.00500000, 0, lc};
  Circle(3186) = {2394,2390,2392};
  Circle(3187) = {2392,2390,2393};
  Circle(3188) = {2393,2390,2391};
  Circle(3189) = {2391,2390,2394};
  Line Loop(3190) = {3186,3187,3188,3189};   // clad surface

  Point(2395) = { 12.81200000, 19.53000000, 0, lc};
  Point(2396) = { 13.64800000, 19.53000000, 0, lc};
  Point(2397) = { 13.23000000, 19.11200000, 0, lc};
  Point(2398) = { 13.23000000, 19.94800000, 0, lc};
  Circle(3191) = {2398,2390,2396};
  Circle(3192) = {2396,2390,2397};
  Circle(3193) = {2397,2390,2395};
  Circle(3194) = {2395,2390,2398};
  Line Loop(3195) = {3191,3192,3193,3194};   // fuel surface

// define rod regions
  Plane Surface(3196) = {3190,3195};   // clad region
  Plane Surface(3197) = {3195};      // fuel region
  Physical Surface("RegClad1116")={3196};   // pin clad
  Physical Surface("RegFuel1116")={3197};   // pin fuel

// ==============================
//    define rod 12,16

  Point(2399) = { 14.49000000, 19.53000000, 0, lc};

  Point(2400) = { 14.01500000, 19.53000000, 0, lc};
  Point(2401) = { 14.96500000, 19.53000000, 0, lc};
  Point(2402) = { 14.49000000, 19.05500000, 0, lc};
  Point(2403) = { 14.49000000, 20.00500000, 0, lc};
  Circle(3198) = {2403,2399,2401};
  Circle(3199) = {2401,2399,2402};
  Circle(3200) = {2402,2399,2400};
  Circle(3201) = {2400,2399,2403};
  Line Loop(3202) = {3198,3199,3200,3201};   // clad surface

  Point(2404) = { 14.07200000, 19.53000000, 0, lc};
  Point(2405) = { 14.90800000, 19.53000000, 0, lc};
  Point(2406) = { 14.49000000, 19.11200000, 0, lc};
  Point(2407) = { 14.49000000, 19.94800000, 0, lc};
  Circle(3203) = {2407,2399,2405};
  Circle(3204) = {2405,2399,2406};
  Circle(3205) = {2406,2399,2404};
  Circle(3206) = {2404,2399,2407};
  Line Loop(3207) = {3203,3204,3205,3206};   // fuel surface

// define rod regions
  Plane Surface(3208) = {3202,3207};   // clad region
  Plane Surface(3209) = {3207};      // fuel region
  Physical Surface("RegClad1216")={3208};   // pin clad
  Physical Surface("RegFuel1216")={3209};   // pin fuel

// ==============================
//    define rod 13,16

  Point(2408) = { 15.75000000, 19.53000000, 0, lc};

  Point(2409) = { 15.27500000, 19.53000000, 0, lc};
  Point(2410) = { 16.22500000, 19.53000000, 0, lc};
  Point(2411) = { 15.75000000, 19.05500000, 0, lc};
  Point(2412) = { 15.75000000, 20.00500000, 0, lc};
  Circle(3210) = {2412,2408,2410};
  Circle(3211) = {2410,2408,2411};
  Circle(3212) = {2411,2408,2409};
  Circle(3213) = {2409,2408,2412};
  Line Loop(3214) = {3210,3211,3212,3213};   // clad surface

  Point(2413) = { 15.33200000, 19.53000000, 0, lc};
  Point(2414) = { 16.16800000, 19.53000000, 0, lc};
  Point(2415) = { 15.75000000, 19.11200000, 0, lc};
  Point(2416) = { 15.75000000, 19.94800000, 0, lc};
  Circle(3215) = {2416,2408,2414};
  Circle(3216) = {2414,2408,2415};
  Circle(3217) = {2415,2408,2413};
  Circle(3218) = {2413,2408,2416};
  Line Loop(3219) = {3215,3216,3217,3218};   // fuel surface

// define rod regions
  Plane Surface(3220) = {3214,3219};   // clad region
  Plane Surface(3221) = {3219};      // fuel region
  Physical Surface("RegClad1316")={3220};   // pin clad
  Physical Surface("RegFuel1316")={3221};   // pin fuel

// ==============================
//    define rod 14,16

  Point(2417) = { 17.01000000, 19.53000000, 0, lc};

  Point(2418) = { 16.53500000, 19.53000000, 0, lc};
  Point(2419) = { 17.48500000, 19.53000000, 0, lc};
  Point(2420) = { 17.01000000, 19.05500000, 0, lc};
  Point(2421) = { 17.01000000, 20.00500000, 0, lc};
  Circle(3222) = {2421,2417,2419};
  Circle(3223) = {2419,2417,2420};
  Circle(3224) = {2420,2417,2418};
  Circle(3225) = {2418,2417,2421};
  Line Loop(3226) = {3222,3223,3224,3225};   // clad surface

  Point(2422) = { 16.59200000, 19.53000000, 0, lc};
  Point(2423) = { 17.42800000, 19.53000000, 0, lc};
  Point(2424) = { 17.01000000, 19.11200000, 0, lc};
  Point(2425) = { 17.01000000, 19.94800000, 0, lc};
  Circle(3227) = {2425,2417,2423};
  Circle(3228) = {2423,2417,2424};
  Circle(3229) = {2424,2417,2422};
  Circle(3230) = {2422,2417,2425};
  Line Loop(3231) = {3227,3228,3229,3230};   // fuel surface

// define rod regions
  Plane Surface(3232) = {3226,3231};   // clad region
  Plane Surface(3233) = {3231};      // fuel region
  Physical Surface("RegClad1416")={3232};   // pin clad
  Physical Surface("RegFuel1416")={3233};   // pin fuel

// ==============================
//    define rod 15,16

  Point(2426) = { 18.27000000, 19.53000000, 0, lc};

  Point(2427) = { 17.79500000, 19.53000000, 0, lc};
  Point(2428) = { 18.74500000, 19.53000000, 0, lc};
  Point(2429) = { 18.27000000, 19.05500000, 0, lc};
  Point(2430) = { 18.27000000, 20.00500000, 0, lc};
  Circle(3234) = {2430,2426,2428};
  Circle(3235) = {2428,2426,2429};
  Circle(3236) = {2429,2426,2427};
  Circle(3237) = {2427,2426,2430};
  Line Loop(3238) = {3234,3235,3236,3237};   // clad surface

  Point(2431) = { 17.85200000, 19.53000000, 0, lc};
  Point(2432) = { 18.68800000, 19.53000000, 0, lc};
  Point(2433) = { 18.27000000, 19.11200000, 0, lc};
  Point(2434) = { 18.27000000, 19.94800000, 0, lc};
  Circle(3239) = {2434,2426,2432};
  Circle(3240) = {2432,2426,2433};
  Circle(3241) = {2433,2426,2431};
  Circle(3242) = {2431,2426,2434};
  Line Loop(3243) = {3239,3240,3241,3242};   // fuel surface

// define rod regions
  Plane Surface(3244) = {3238,3243};   // clad region
  Plane Surface(3245) = {3243};      // fuel region
  Physical Surface("RegClad1516")={3244};   // pin clad
  Physical Surface("RegFuel1516")={3245};   // pin fuel

// ==============================
//    define rod 16,16

  Point(2435) = { 19.53000000, 19.53000000, 0, lc};

  Point(2436) = { 19.05500000, 19.53000000, 0, lc};
  Point(2437) = { 20.00500000, 19.53000000, 0, lc};
  Point(2438) = { 19.53000000, 19.05500000, 0, lc};
  Point(2439) = { 19.53000000, 20.00500000, 0, lc};
  Circle(3246) = {2439,2435,2437};
  Circle(3247) = {2437,2435,2438};
  Circle(3248) = {2438,2435,2436};
  Circle(3249) = {2436,2435,2439};
  Line Loop(3250) = {3246,3247,3248,3249};   // clad surface

  Point(2440) = { 19.11200000, 19.53000000, 0, lc};
  Point(2441) = { 19.94800000, 19.53000000, 0, lc};
  Point(2442) = { 19.53000000, 19.11200000, 0, lc};
  Point(2443) = { 19.53000000, 19.94800000, 0, lc};
  Circle(3251) = {2443,2435,2441};
  Circle(3252) = {2441,2435,2442};
  Circle(3253) = {2442,2435,2440};
  Circle(3254) = {2440,2435,2443};
  Line Loop(3255) = {3251,3252,3253,3254};   // fuel surface

// define rod regions
  Plane Surface(3256) = {3250,3255};   // clad region
  Plane Surface(3257) = {3255};      // fuel region
  Physical Surface("RegClad1616")={3256};   // pin clad
  Physical Surface("RegFuel1616")={3257};   // pin fuel

// ==============================
//    define rod 17,16

  Point(2444) = { 20.79000000, 19.53000000, 0, lc};

  Point(2445) = { 20.31500000, 19.53000000, 0, lc};
  Point(2446) = { 21.26500000, 19.53000000, 0, lc};
  Point(2447) = { 20.79000000, 19.05500000, 0, lc};
  Point(2448) = { 20.79000000, 20.00500000, 0, lc};
  Circle(3258) = {2448,2444,2446};
  Circle(3259) = {2446,2444,2447};
  Circle(3260) = {2447,2444,2445};
  Circle(3261) = {2445,2444,2448};
  Line Loop(3262) = {3258,3259,3260,3261};   // clad surface

  Point(2449) = { 20.37200000, 19.53000000, 0, lc};
  Point(2450) = { 21.20800000, 19.53000000, 0, lc};
  Point(2451) = { 20.79000000, 19.11200000, 0, lc};
  Point(2452) = { 20.79000000, 19.94800000, 0, lc};
  Circle(3263) = {2452,2444,2450};
  Circle(3264) = {2450,2444,2451};
  Circle(3265) = {2451,2444,2449};
  Circle(3266) = {2449,2444,2452};
  Line Loop(3267) = {3263,3264,3265,3266};   // fuel surface

// define rod regions
  Plane Surface(3268) = {3262,3267};   // clad region
  Plane Surface(3269) = {3267};      // fuel region
  Physical Surface("RegClad1716")={3268};   // pin clad
  Physical Surface("RegFuel1716")={3269};   // pin fuel

// ==============================
//    define rod 1,17

  Point(2453) = {  0.63000000, 20.79000000, 0, lc};

  Point(2454) = {  0.15500000, 20.79000000, 0, lc};
  Point(2455) = {  1.10500000, 20.79000000, 0, lc};
  Point(2456) = {  0.63000000, 20.31500000, 0, lc};
  Point(2457) = {  0.63000000, 21.26500000, 0, lc};
  Circle(3270) = {2457,2453,2455};
  Circle(3271) = {2455,2453,2456};
  Circle(3272) = {2456,2453,2454};
  Circle(3273) = {2454,2453,2457};
  Line Loop(3274) = {3270,3271,3272,3273};   // clad surface

  Point(2458) = {  0.21200000, 20.79000000, 0, lc};
  Point(2459) = {  1.04800000, 20.79000000, 0, lc};
  Point(2460) = {  0.63000000, 20.37200000, 0, lc};
  Point(2461) = {  0.63000000, 21.20800000, 0, lc};
  Circle(3275) = {2461,2453,2459};
  Circle(3276) = {2459,2453,2460};
  Circle(3277) = {2460,2453,2458};
  Circle(3278) = {2458,2453,2461};
  Line Loop(3279) = {3275,3276,3277,3278};   // fuel surface

// define rod regions
  Plane Surface(3280) = {3274,3279};   // clad region
  Plane Surface(3281) = {3279};      // fuel region
  Physical Surface("RegClad0117")={3280};   // pin clad
  Physical Surface("RegFuel0117")={3281};   // pin fuel

// ==============================
//    define rod 2,17

  Point(2462) = {  1.89000000, 20.79000000, 0, lc};

  Point(2463) = {  1.41500000, 20.79000000, 0, lc};
  Point(2464) = {  2.36500000, 20.79000000, 0, lc};
  Point(2465) = {  1.89000000, 20.31500000, 0, lc};
  Point(2466) = {  1.89000000, 21.26500000, 0, lc};
  Circle(3282) = {2466,2462,2464};
  Circle(3283) = {2464,2462,2465};
  Circle(3284) = {2465,2462,2463};
  Circle(3285) = {2463,2462,2466};
  Line Loop(3286) = {3282,3283,3284,3285};   // clad surface

  Point(2467) = {  1.47200000, 20.79000000, 0, lc};
  Point(2468) = {  2.30800000, 20.79000000, 0, lc};
  Point(2469) = {  1.89000000, 20.37200000, 0, lc};
  Point(2470) = {  1.89000000, 21.20800000, 0, lc};
  Circle(3287) = {2470,2462,2468};
  Circle(3288) = {2468,2462,2469};
  Circle(3289) = {2469,2462,2467};
  Circle(3290) = {2467,2462,2470};
  Line Loop(3291) = {3287,3288,3289,3290};   // fuel surface

// define rod regions
  Plane Surface(3292) = {3286,3291};   // clad region
  Plane Surface(3293) = {3291};      // fuel region
  Physical Surface("RegClad0217")={3292};   // pin clad
  Physical Surface("RegFuel0217")={3293};   // pin fuel

// ==============================
//    define rod 3,17

  Point(2471) = {  3.15000000, 20.79000000, 0, lc};

  Point(2472) = {  2.67500000, 20.79000000, 0, lc};
  Point(2473) = {  3.62500000, 20.79000000, 0, lc};
  Point(2474) = {  3.15000000, 20.31500000, 0, lc};
  Point(2475) = {  3.15000000, 21.26500000, 0, lc};
  Circle(3294) = {2475,2471,2473};
  Circle(3295) = {2473,2471,2474};
  Circle(3296) = {2474,2471,2472};
  Circle(3297) = {2472,2471,2475};
  Line Loop(3298) = {3294,3295,3296,3297};   // clad surface

  Point(2476) = {  2.73200000, 20.79000000, 0, lc};
  Point(2477) = {  3.56800000, 20.79000000, 0, lc};
  Point(2478) = {  3.15000000, 20.37200000, 0, lc};
  Point(2479) = {  3.15000000, 21.20800000, 0, lc};
  Circle(3299) = {2479,2471,2477};
  Circle(3300) = {2477,2471,2478};
  Circle(3301) = {2478,2471,2476};
  Circle(3302) = {2476,2471,2479};
  Line Loop(3303) = {3299,3300,3301,3302};   // fuel surface

// define rod regions
  Plane Surface(3304) = {3298,3303};   // clad region
  Plane Surface(3305) = {3303};      // fuel region
  Physical Surface("RegClad0317")={3304};   // pin clad
  Physical Surface("RegFuel0317")={3305};   // pin fuel

// ==============================
//    define rod 4,17

  Point(2480) = {  4.41000000, 20.79000000, 0, lc};

  Point(2481) = {  3.93500000, 20.79000000, 0, lc};
  Point(2482) = {  4.88500000, 20.79000000, 0, lc};
  Point(2483) = {  4.41000000, 20.31500000, 0, lc};
  Point(2484) = {  4.41000000, 21.26500000, 0, lc};
  Circle(3306) = {2484,2480,2482};
  Circle(3307) = {2482,2480,2483};
  Circle(3308) = {2483,2480,2481};
  Circle(3309) = {2481,2480,2484};
  Line Loop(3310) = {3306,3307,3308,3309};   // clad surface

  Point(2485) = {  3.99200000, 20.79000000, 0, lc};
  Point(2486) = {  4.82800000, 20.79000000, 0, lc};
  Point(2487) = {  4.41000000, 20.37200000, 0, lc};
  Point(2488) = {  4.41000000, 21.20800000, 0, lc};
  Circle(3311) = {2488,2480,2486};
  Circle(3312) = {2486,2480,2487};
  Circle(3313) = {2487,2480,2485};
  Circle(3314) = {2485,2480,2488};
  Line Loop(3315) = {3311,3312,3313,3314};   // fuel surface

// define rod regions
  Plane Surface(3316) = {3310,3315};   // clad region
  Plane Surface(3317) = {3315};      // fuel region
  Physical Surface("RegClad0417")={3316};   // pin clad
  Physical Surface("RegFuel0417")={3317};   // pin fuel

// ==============================
//    define rod 5,17

  Point(2489) = {  5.67000000, 20.79000000, 0, lc};

  Point(2490) = {  5.19500000, 20.79000000, 0, lc};
  Point(2491) = {  6.14500000, 20.79000000, 0, lc};
  Point(2492) = {  5.67000000, 20.31500000, 0, lc};
  Point(2493) = {  5.67000000, 21.26500000, 0, lc};
  Circle(3318) = {2493,2489,2491};
  Circle(3319) = {2491,2489,2492};
  Circle(3320) = {2492,2489,2490};
  Circle(3321) = {2490,2489,2493};
  Line Loop(3322) = {3318,3319,3320,3321};   // clad surface

  Point(2494) = {  5.25200000, 20.79000000, 0, lc};
  Point(2495) = {  6.08800000, 20.79000000, 0, lc};
  Point(2496) = {  5.67000000, 20.37200000, 0, lc};
  Point(2497) = {  5.67000000, 21.20800000, 0, lc};
  Circle(3323) = {2497,2489,2495};
  Circle(3324) = {2495,2489,2496};
  Circle(3325) = {2496,2489,2494};
  Circle(3326) = {2494,2489,2497};
  Line Loop(3327) = {3323,3324,3325,3326};   // fuel surface

// define rod regions
  Plane Surface(3328) = {3322,3327};   // clad region
  Plane Surface(3329) = {3327};      // fuel region
  Physical Surface("RegClad0517")={3328};   // pin clad
  Physical Surface("RegFuel0517")={3329};   // pin fuel

// ==============================
//    define rod 6,17

  Point(2498) = {  6.93000000, 20.79000000, 0, lc};

  Point(2499) = {  6.45500000, 20.79000000, 0, lc};
  Point(2500) = {  7.40500000, 20.79000000, 0, lc};
  Point(2501) = {  6.93000000, 20.31500000, 0, lc};
  Point(2502) = {  6.93000000, 21.26500000, 0, lc};
  Circle(3330) = {2502,2498,2500};
  Circle(3331) = {2500,2498,2501};
  Circle(3332) = {2501,2498,2499};
  Circle(3333) = {2499,2498,2502};
  Line Loop(3334) = {3330,3331,3332,3333};   // clad surface

  Point(2503) = {  6.51200000, 20.79000000, 0, lc};
  Point(2504) = {  7.34800000, 20.79000000, 0, lc};
  Point(2505) = {  6.93000000, 20.37200000, 0, lc};
  Point(2506) = {  6.93000000, 21.20800000, 0, lc};
  Circle(3335) = {2506,2498,2504};
  Circle(3336) = {2504,2498,2505};
  Circle(3337) = {2505,2498,2503};
  Circle(3338) = {2503,2498,2506};
  Line Loop(3339) = {3335,3336,3337,3338};   // fuel surface

// define rod regions
  Plane Surface(3340) = {3334,3339};   // clad region
  Plane Surface(3341) = {3339};      // fuel region
  Physical Surface("RegClad0617")={3340};   // pin clad
  Physical Surface("RegFuel0617")={3341};   // pin fuel

// ==============================
//    define rod 7,17

  Point(2507) = {  8.19000000, 20.79000000, 0, lc};

  Point(2508) = {  7.71500000, 20.79000000, 0, lc};
  Point(2509) = {  8.66500000, 20.79000000, 0, lc};
  Point(2510) = {  8.19000000, 20.31500000, 0, lc};
  Point(2511) = {  8.19000000, 21.26500000, 0, lc};
  Circle(3342) = {2511,2507,2509};
  Circle(3343) = {2509,2507,2510};
  Circle(3344) = {2510,2507,2508};
  Circle(3345) = {2508,2507,2511};
  Line Loop(3346) = {3342,3343,3344,3345};   // clad surface

  Point(2512) = {  7.77200000, 20.79000000, 0, lc};
  Point(2513) = {  8.60800000, 20.79000000, 0, lc};
  Point(2514) = {  8.19000000, 20.37200000, 0, lc};
  Point(2515) = {  8.19000000, 21.20800000, 0, lc};
  Circle(3347) = {2515,2507,2513};
  Circle(3348) = {2513,2507,2514};
  Circle(3349) = {2514,2507,2512};
  Circle(3350) = {2512,2507,2515};
  Line Loop(3351) = {3347,3348,3349,3350};   // fuel surface

// define rod regions
  Plane Surface(3352) = {3346,3351};   // clad region
  Plane Surface(3353) = {3351};      // fuel region
  Physical Surface("RegClad0717")={3352};   // pin clad
  Physical Surface("RegFuel0717")={3353};   // pin fuel

// ==============================
//    define rod 8,17

  Point(2516) = {  9.45000000, 20.79000000, 0, lc};

  Point(2517) = {  8.97500000, 20.79000000, 0, lc};
  Point(2518) = {  9.92500000, 20.79000000, 0, lc};
  Point(2519) = {  9.45000000, 20.31500000, 0, lc};
  Point(2520) = {  9.45000000, 21.26500000, 0, lc};
  Circle(3354) = {2520,2516,2518};
  Circle(3355) = {2518,2516,2519};
  Circle(3356) = {2519,2516,2517};
  Circle(3357) = {2517,2516,2520};
  Line Loop(3358) = {3354,3355,3356,3357};   // clad surface

  Point(2521) = {  9.03200000, 20.79000000, 0, lc};
  Point(2522) = {  9.86800000, 20.79000000, 0, lc};
  Point(2523) = {  9.45000000, 20.37200000, 0, lc};
  Point(2524) = {  9.45000000, 21.20800000, 0, lc};
  Circle(3359) = {2524,2516,2522};
  Circle(3360) = {2522,2516,2523};
  Circle(3361) = {2523,2516,2521};
  Circle(3362) = {2521,2516,2524};
  Line Loop(3363) = {3359,3360,3361,3362};   // fuel surface

// define rod regions
  Plane Surface(3364) = {3358,3363};   // clad region
  Plane Surface(3365) = {3363};      // fuel region
  Physical Surface("RegClad0817")={3364};   // pin clad
  Physical Surface("RegFuel0817")={3365};   // pin fuel

// ==============================
//    define rod 9,17

  Point(2525) = { 10.71000000, 20.79000000, 0, lc};

  Point(2526) = { 10.23500000, 20.79000000, 0, lc};
  Point(2527) = { 11.18500000, 20.79000000, 0, lc};
  Point(2528) = { 10.71000000, 20.31500000, 0, lc};
  Point(2529) = { 10.71000000, 21.26500000, 0, lc};
  Circle(3366) = {2529,2525,2527};
  Circle(3367) = {2527,2525,2528};
  Circle(3368) = {2528,2525,2526};
  Circle(3369) = {2526,2525,2529};
  Line Loop(3370) = {3366,3367,3368,3369};   // clad surface

  Point(2530) = { 10.29200000, 20.79000000, 0, lc};
  Point(2531) = { 11.12800000, 20.79000000, 0, lc};
  Point(2532) = { 10.71000000, 20.37200000, 0, lc};
  Point(2533) = { 10.71000000, 21.20800000, 0, lc};
  Circle(3371) = {2533,2525,2531};
  Circle(3372) = {2531,2525,2532};
  Circle(3373) = {2532,2525,2530};
  Circle(3374) = {2530,2525,2533};
  Line Loop(3375) = {3371,3372,3373,3374};   // fuel surface

// define rod regions
  Plane Surface(3376) = {3370,3375};   // clad region
  Plane Surface(3377) = {3375};      // fuel region
  Physical Surface("RegClad0917")={3376};   // pin clad
  Physical Surface("RegFuel0917")={3377};   // pin fuel

// ==============================
//    define rod 10,17

  Point(2534) = { 11.97000000, 20.79000000, 0, lc};

  Point(2535) = { 11.49500000, 20.79000000, 0, lc};
  Point(2536) = { 12.44500000, 20.79000000, 0, lc};
  Point(2537) = { 11.97000000, 20.31500000, 0, lc};
  Point(2538) = { 11.97000000, 21.26500000, 0, lc};
  Circle(3378) = {2538,2534,2536};
  Circle(3379) = {2536,2534,2537};
  Circle(3380) = {2537,2534,2535};
  Circle(3381) = {2535,2534,2538};
  Line Loop(3382) = {3378,3379,3380,3381};   // clad surface

  Point(2539) = { 11.55200000, 20.79000000, 0, lc};
  Point(2540) = { 12.38800000, 20.79000000, 0, lc};
  Point(2541) = { 11.97000000, 20.37200000, 0, lc};
  Point(2542) = { 11.97000000, 21.20800000, 0, lc};
  Circle(3383) = {2542,2534,2540};
  Circle(3384) = {2540,2534,2541};
  Circle(3385) = {2541,2534,2539};
  Circle(3386) = {2539,2534,2542};
  Line Loop(3387) = {3383,3384,3385,3386};   // fuel surface

// define rod regions
  Plane Surface(3388) = {3382,3387};   // clad region
  Plane Surface(3389) = {3387};      // fuel region
  Physical Surface("RegClad1017")={3388};   // pin clad
  Physical Surface("RegFuel1017")={3389};   // pin fuel

// ==============================
//    define rod 11,17

  Point(2543) = { 13.23000000, 20.79000000, 0, lc};

  Point(2544) = { 12.75500000, 20.79000000, 0, lc};
  Point(2545) = { 13.70500000, 20.79000000, 0, lc};
  Point(2546) = { 13.23000000, 20.31500000, 0, lc};
  Point(2547) = { 13.23000000, 21.26500000, 0, lc};
  Circle(3390) = {2547,2543,2545};
  Circle(3391) = {2545,2543,2546};
  Circle(3392) = {2546,2543,2544};
  Circle(3393) = {2544,2543,2547};
  Line Loop(3394) = {3390,3391,3392,3393};   // clad surface

  Point(2548) = { 12.81200000, 20.79000000, 0, lc};
  Point(2549) = { 13.64800000, 20.79000000, 0, lc};
  Point(2550) = { 13.23000000, 20.37200000, 0, lc};
  Point(2551) = { 13.23000000, 21.20800000, 0, lc};
  Circle(3395) = {2551,2543,2549};
  Circle(3396) = {2549,2543,2550};
  Circle(3397) = {2550,2543,2548};
  Circle(3398) = {2548,2543,2551};
  Line Loop(3399) = {3395,3396,3397,3398};   // fuel surface

// define rod regions
  Plane Surface(3400) = {3394,3399};   // clad region
  Plane Surface(3401) = {3399};      // fuel region
  Physical Surface("RegClad1117")={3400};   // pin clad
  Physical Surface("RegFuel1117")={3401};   // pin fuel

// ==============================
//    define rod 12,17

  Point(2552) = { 14.49000000, 20.79000000, 0, lc};

  Point(2553) = { 14.01500000, 20.79000000, 0, lc};
  Point(2554) = { 14.96500000, 20.79000000, 0, lc};
  Point(2555) = { 14.49000000, 20.31500000, 0, lc};
  Point(2556) = { 14.49000000, 21.26500000, 0, lc};
  Circle(3402) = {2556,2552,2554};
  Circle(3403) = {2554,2552,2555};
  Circle(3404) = {2555,2552,2553};
  Circle(3405) = {2553,2552,2556};
  Line Loop(3406) = {3402,3403,3404,3405};   // clad surface

  Point(2557) = { 14.07200000, 20.79000000, 0, lc};
  Point(2558) = { 14.90800000, 20.79000000, 0, lc};
  Point(2559) = { 14.49000000, 20.37200000, 0, lc};
  Point(2560) = { 14.49000000, 21.20800000, 0, lc};
  Circle(3407) = {2560,2552,2558};
  Circle(3408) = {2558,2552,2559};
  Circle(3409) = {2559,2552,2557};
  Circle(3410) = {2557,2552,2560};
  Line Loop(3411) = {3407,3408,3409,3410};   // fuel surface

// define rod regions
  Plane Surface(3412) = {3406,3411};   // clad region
  Plane Surface(3413) = {3411};      // fuel region
  Physical Surface("RegClad1217")={3412};   // pin clad
  Physical Surface("RegFuel1217")={3413};   // pin fuel

// ==============================
//    define rod 13,17

  Point(2561) = { 15.75000000, 20.79000000, 0, lc};

  Point(2562) = { 15.27500000, 20.79000000, 0, lc};
  Point(2563) = { 16.22500000, 20.79000000, 0, lc};
  Point(2564) = { 15.75000000, 20.31500000, 0, lc};
  Point(2565) = { 15.75000000, 21.26500000, 0, lc};
  Circle(3414) = {2565,2561,2563};
  Circle(3415) = {2563,2561,2564};
  Circle(3416) = {2564,2561,2562};
  Circle(3417) = {2562,2561,2565};
  Line Loop(3418) = {3414,3415,3416,3417};   // clad surface

  Point(2566) = { 15.33200000, 20.79000000, 0, lc};
  Point(2567) = { 16.16800000, 20.79000000, 0, lc};
  Point(2568) = { 15.75000000, 20.37200000, 0, lc};
  Point(2569) = { 15.75000000, 21.20800000, 0, lc};
  Circle(3419) = {2569,2561,2567};
  Circle(3420) = {2567,2561,2568};
  Circle(3421) = {2568,2561,2566};
  Circle(3422) = {2566,2561,2569};
  Line Loop(3423) = {3419,3420,3421,3422};   // fuel surface

// define rod regions
  Plane Surface(3424) = {3418,3423};   // clad region
  Plane Surface(3425) = {3423};      // fuel region
  Physical Surface("RegClad1317")={3424};   // pin clad
  Physical Surface("RegFuel1317")={3425};   // pin fuel

// ==============================
//    define rod 14,17

  Point(2570) = { 17.01000000, 20.79000000, 0, lc};

  Point(2571) = { 16.53500000, 20.79000000, 0, lc};
  Point(2572) = { 17.48500000, 20.79000000, 0, lc};
  Point(2573) = { 17.01000000, 20.31500000, 0, lc};
  Point(2574) = { 17.01000000, 21.26500000, 0, lc};
  Circle(3426) = {2574,2570,2572};
  Circle(3427) = {2572,2570,2573};
  Circle(3428) = {2573,2570,2571};
  Circle(3429) = {2571,2570,2574};
  Line Loop(3430) = {3426,3427,3428,3429};   // clad surface

  Point(2575) = { 16.59200000, 20.79000000, 0, lc};
  Point(2576) = { 17.42800000, 20.79000000, 0, lc};
  Point(2577) = { 17.01000000, 20.37200000, 0, lc};
  Point(2578) = { 17.01000000, 21.20800000, 0, lc};
  Circle(3431) = {2578,2570,2576};
  Circle(3432) = {2576,2570,2577};
  Circle(3433) = {2577,2570,2575};
  Circle(3434) = {2575,2570,2578};
  Line Loop(3435) = {3431,3432,3433,3434};   // fuel surface

// define rod regions
  Plane Surface(3436) = {3430,3435};   // clad region
  Plane Surface(3437) = {3435};      // fuel region
  Physical Surface("RegClad1417")={3436};   // pin clad
  Physical Surface("RegFuel1417")={3437};   // pin fuel

// ==============================
//    define rod 15,17

  Point(2579) = { 18.27000000, 20.79000000, 0, lc};

  Point(2580) = { 17.79500000, 20.79000000, 0, lc};
  Point(2581) = { 18.74500000, 20.79000000, 0, lc};
  Point(2582) = { 18.27000000, 20.31500000, 0, lc};
  Point(2583) = { 18.27000000, 21.26500000, 0, lc};
  Circle(3438) = {2583,2579,2581};
  Circle(3439) = {2581,2579,2582};
  Circle(3440) = {2582,2579,2580};
  Circle(3441) = {2580,2579,2583};
  Line Loop(3442) = {3438,3439,3440,3441};   // clad surface

  Point(2584) = { 17.85200000, 20.79000000, 0, lc};
  Point(2585) = { 18.68800000, 20.79000000, 0, lc};
  Point(2586) = { 18.27000000, 20.37200000, 0, lc};
  Point(2587) = { 18.27000000, 21.20800000, 0, lc};
  Circle(3443) = {2587,2579,2585};
  Circle(3444) = {2585,2579,2586};
  Circle(3445) = {2586,2579,2584};
  Circle(3446) = {2584,2579,2587};
  Line Loop(3447) = {3443,3444,3445,3446};   // fuel surface

// define rod regions
  Plane Surface(3448) = {3442,3447};   // clad region
  Plane Surface(3449) = {3447};      // fuel region
  Physical Surface("RegClad1517")={3448};   // pin clad
  Physical Surface("RegFuel1517")={3449};   // pin fuel

// ==============================
//    define rod 16,17

  Point(2588) = { 19.53000000, 20.79000000, 0, lc};

  Point(2589) = { 19.05500000, 20.79000000, 0, lc};
  Point(2590) = { 20.00500000, 20.79000000, 0, lc};
  Point(2591) = { 19.53000000, 20.31500000, 0, lc};
  Point(2592) = { 19.53000000, 21.26500000, 0, lc};
  Circle(3450) = {2592,2588,2590};
  Circle(3451) = {2590,2588,2591};
  Circle(3452) = {2591,2588,2589};
  Circle(3453) = {2589,2588,2592};
  Line Loop(3454) = {3450,3451,3452,3453};   // clad surface

  Point(2593) = { 19.11200000, 20.79000000, 0, lc};
  Point(2594) = { 19.94800000, 20.79000000, 0, lc};
  Point(2595) = { 19.53000000, 20.37200000, 0, lc};
  Point(2596) = { 19.53000000, 21.20800000, 0, lc};
  Circle(3455) = {2596,2588,2594};
  Circle(3456) = {2594,2588,2595};
  Circle(3457) = {2595,2588,2593};
  Circle(3458) = {2593,2588,2596};
  Line Loop(3459) = {3455,3456,3457,3458};   // fuel surface

// define rod regions
  Plane Surface(3460) = {3454,3459};   // clad region
  Plane Surface(3461) = {3459};      // fuel region
  Physical Surface("RegClad1617")={3460};   // pin clad
  Physical Surface("RegFuel1617")={3461};   // pin fuel

// ==============================
//    define rod 17,17

  Point(2597) = { 20.79000000, 20.79000000, 0, lc};

  Point(2598) = { 20.31500000, 20.79000000, 0, lc};
  Point(2599) = { 21.26500000, 20.79000000, 0, lc};
  Point(2600) = { 20.79000000, 20.31500000, 0, lc};
  Point(2601) = { 20.79000000, 21.26500000, 0, lc};
  Circle(3462) = {2601,2597,2599};
  Circle(3463) = {2599,2597,2600};
  Circle(3464) = {2600,2597,2598};
  Circle(3465) = {2598,2597,2601};
  Line Loop(3466) = {3462,3463,3464,3465};   // clad surface

  Point(2602) = { 20.37200000, 20.79000000, 0, lc};
  Point(2603) = { 21.20800000, 20.79000000, 0, lc};
  Point(2604) = { 20.79000000, 20.37200000, 0, lc};
  Point(2605) = { 20.79000000, 21.20800000, 0, lc};
  Circle(3467) = {2605,2597,2603};
  Circle(3468) = {2603,2597,2604};
  Circle(3469) = {2604,2597,2602};
  Circle(3470) = {2602,2597,2605};
  Line Loop(3471) = {3467,3468,3469,3470};   // fuel surface

// define rod regions
  Plane Surface(3472) = {3466,3471};   // clad region
  Plane Surface(3473) = {3471};      // fuel region
  Physical Surface("RegClad1717")={3472};   // pin clad
  Physical Surface("RegFuel1717")={3473};   // pin fuel

//====================================================
// Define coolant region and label
  Plane Surface(3474) ={5, 10,  22,  34,  46,  58,  70,  82,  94,  106,  118,
  130,  142,  154,  166,  178,  190,  202,  214,  226,  238,
  250,  262,  274,  286,  298,  310,  322,  334,  346,  358,
  370,  382,  394,  406,  418,  430,  442,  454,  466,  478,
  490,  502,  514,  526,  538,  550,  562,  574,  586,  598,
  610,  622,  634,  646,  658,  670,  682,  694,  706,  718,
  730,  742,  754,  766,  778,  790,  802,  814,  826,  838,
  850,  862,  874,  886,  898,  910,  922,  934,  946,  958,
  970,  982,  994,  1006,  1018,  1030,  1042,  1054,  1066,  1078,
  1090,  1102,  1114,  1126,  1138,  1150,  1162,  1174,  1186,  1198,
  1210,  1222,  1234,  1246,  1258,  1270,  1282,  1294,  1306,  1318,
  1330,  1342,  1354,  1366,  1378,  1390,  1402,  1414,  1426,  1438,
  1450,  1462,  1474,  1486,  1498,  1510,  1522,  1534,  1546,  1558,
  1570,  1582,  1594,  1606,  1618,  1630,  1642,  1654,  1666,  1678,
  1690,  1702,  1714,  1726,  1738,  1750,  1762,  1774,  1786,  1798,
  1810,  1822,  1834,  1846,  1858,  1870,  1882,  1894,  1906,  1918,
  1930,  1942,  1954,  1966,  1978,  1990,  2002,  2014,  2026,  2038,
  2050,  2062,  2074,  2086,  2098,  2110,  2122,  2134,  2146,  2158,
  2170,  2182,  2194,  2206,  2218,  2230,  2242,  2254,  2266,  2278,
  2290,  2302,  2314,  2326,  2338,  2350,  2362,  2374,  2386,  2398,
  2410,  2422,  2434,  2446,  2458,  2470,  2482,  2494,  2506,  2518,
  2530,  2542,  2554,  2566,  2578,  2590,  2602,  2614,  2626,  2638,
  2650,  2662,  2674,  2686,  2698,  2710,  2722,  2734,  2746,  2758,
  2770,  2782,  2794,  2806,  2818,  2830,  2842,  2854,  2866,  2878,
  2890,  2902,  2914,  2926,  2938,  2950,  2962,  2974,  2986,  2998,
  3010,  3022,  3034,  3046,  3058,  3070,  3082,  3094,  3106,  3118,
  3130,  3142,  3154,  3166,  3178,  3190,  3202,  3214,  3226,  3238,
  3250,  3262,  3274,  3286,  3298,  3310,  3322,  3334,  3346,  3358,
  3370,  3382,  3394,  3406,  3418,  3430,  3442,  3454,  3466};
  Physical Surface("RegCool")={3474};

