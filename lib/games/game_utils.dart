library game_utils;

import 'dart:math';

// Shared between all games
final Map<String, String> categoryManifests = {
  'animals': 'assets/images/skills/animals/manifest.json',
  'fruits': 'assets/images/skills/fruits/manifest.json',
  'vegetables': 'assets/images/skills/vegetables/manifest.json',
  'colors': 'assets/images/skills/colors/manifest.json',
  'careers': 'assets/images/skills/careers/manifest.json',
  'clothing': 'assets/images/skills/clothing/manifest.json',
  'transportation': 'assets/images/skills/transportation/manifest.json',
  'insects': 'assets/images/skills/insects/manifest.json',
  'kitchen utensils': 'assets/images/skills/kitchen_utensils/manifest.json',
  'school supplies': 'assets/images/skills/school_supplies/manifest.json',
  'household items': 'assets/images/skills/household_items/manifest.json',
  // Add other categories here
};

final Map<String, String> arabicNames = {
  'cat': 'قطة',
  'dog': 'كلب',
  'lion': 'أسد',
  'tiger': 'نمر',
  'elephant': 'فيل',
  'bird': 'عصفور',
  'fish': 'سمكة',
  'apple': 'تفاحة',
  'banana': 'موزة',
  'orange': 'برتقالة',
  'grape': 'عنب',
  'watermelon': 'بطيخ',
  'carrot': 'جزر',
  'tomato': 'طماطم',
  'cucumber': 'خيار',
  'red': 'أحمر',
  'yellow': 'أصفر',
  'green': 'أخضر',
  'bear': 'دب',
  'camel': 'جمل',
  'chicken': 'دجاجة',
  'cow': 'بقرة',
  'deer': 'غزال',
  'fox': 'ثعلب',
  'frog': 'ضفدع',
  'horse': 'حصان',
  'monkey': 'قرد',
  'rabbit': 'أرنب',
  'sheep': 'خروف',
  'wolf': 'ذئب',
  'zebra': 'حمار وحشي',
  'ant': 'نملة',
  'bee': 'نحلة',
  'butterfly': 'فراشة',
  'doctor': 'طبيب',
  'teacher': 'معلم',
  'engineer': 'مهندس',
  'shirt': 'قميص',
  'pants': 'بنطال',
  'hat': 'قبعة',
  // Add other translations here
};

// Export the Random instance
final Random random = Random();
