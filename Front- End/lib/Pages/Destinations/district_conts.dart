// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'district_destinations.dart';



final List<String> districts = [
    'AMPARA',
    'ANURADHAPURA',
    'BADULLA',
    'BATTICALOA',
    'COLOMBO',
    'GALLE',
    'GAMPAHA',
    'HAMBANTOTA',
    'JAFFNA',
    'KALUTARA',
    'KANDY',
    'KEGALLE',
    'KILINOCHCHI',
    'KURUNEGALA',
    'MANNAR',
    'MATALE',
    'MATARA',
    'MONARAGALA',
    'MULLAITIVU',
    'NUWARA ELIYA',
    'POLONNARUWA',
    'PUTTALAM',
    'RATNAPURA',
    'TRINCOMALEE',
    'VAVUNIYA',
  ];

final List<String> districts_images = [
  "assets/images/destinations_images/districts/Ampara.jpg",
  "assets/images/destinations_images/districts/Anuradhapura.jpg",
  "assets/images/destinations_images/districts/Badulla.jpg",
  "assets/images/destinations_images/districts/Batticoloa.jpg",
  "assets/images/destinations_images/districts/Colombo.jpg",
  "assets/images/destinations_images/districts/Galle.jpg",
  "assets/images/destinations_images/districts/Gampaha.jpg",
  "assets/images/destinations_images/districts/Hambantota.jpg",
  "assets/images/destinations_images/districts/Jaffna.jpg",
  "assets/images/destinations_images/districts/Kaluthara.jpg",
  "assets/images/destinations_images/districts/Kandy.jpg",
  "assets/images/destinations_images/districts/Kegalle.jpg",
  "assets/images/destinations_images/districts/Kilinochchi.jpg",
  "assets/images/destinations_images/districts/Kurunegale.jpg",
  "assets/images/destinations_images/districts/Mannar.jpg",
  "assets/images/destinations_images/districts/Matale.jpg",
  "assets/images/destinations_images/districts/Matara.jpg",
  "assets/images/destinations_images/districts/Monaragale.jpg",
  "assets/images/destinations_images/districts/Mullaiteevu.JPG",
  "assets/images/destinations_images/districts/Nuware eliya.jpg",
  "assets/images/destinations_images/districts/Polonnaruwa.jpg",
  "assets/images/destinations_images/districts/Puttalam.jpg",
  "assets/images/destinations_images/districts/Ratnapura.jpg",
  "assets/images/destinations_images/districts/Trincomale.jpg",
  "assets/images/destinations_images/districts/Vavuniya.jpg"
]; 

// Mapping of district names to respective pages
 final Map<String, Widget> districtPages = {
   'AMPARA': const AmparaPage(),
  // 'ANURADHAPURA': AnuradhapuraPage(),
  // 'BADULLA': BadullaPage(),
  // 'BATTICALOA': BatticaloaPage(),
   'COLOMBO': const ColomboPage(),
  // 'GALLE': GallePage(),
  // 'GAMPAHA': GampahaPage(),
  // 'HAMBANTOTA': HambantotaPage(),
  // 'JAFFNA': JaffnaPage(),
  // 'KALUTARA': KalutaraPage(),
  // 'KANDY': KandyPage(),
  // 'KEGALLE': KegallePage(),
  // 'KILINOCHCHI': KilinochchiPage(),
  // 'KURUNEGALA': KurunegalaPage(),
  // 'MANNAR': MannarPage(),
  // 'MATALE': MatalePage(),
  // 'MATARA': MataraPage(),
  // 'MONARAGALA': MonaragalaPage(),
  // 'MULLAITIVU': MullaitivuPage(),
  // 'NUWARA ELIYA': NuwaraEliyaPage(),
  // 'POLONNARUWA': PolonnaruwaPage(),
  // 'PUTTALAM': PuttalamPage(),
  // 'RATNAPURA': RatnapuraPage(),
  // 'TRINCOMALEE': TrincomaleePage(),
  // 'VAVUNIYA': VavuniyaPage(),
};
  