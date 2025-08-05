import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../theme.dart'; // Assuming theme.dart contains your light and dark mode styles

class NumbersDetailScreen extends StatefulWidget {
  @override
  _NumbersDetailScreenState createState() => _NumbersDetailScreenState();
}

class _NumbersDetailScreenState extends State<NumbersDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  List<Map<String, String>> get numbers => [
        {'number': '٠', 'audio': 'assets/audio/numbers/zero.mp3'}, // 0
        {'number': '١', 'audio': 'assets/audio/numbers/one.mp3'}, // 1
        {'number': '٢', 'audio': 'assets/audio/numbers/two.mp3'}, // 2
        {'number': '٣', 'audio': 'assets/audio/numbers/three.mp3'}, // 3
        {'number': '٤', 'audio': 'assets/audio/numbers/four.mp3'}, // 4
        {'number': '٥', 'audio': 'assets/audio/numbers/five.mp3'}, // 5
        {'number': '٦', 'audio': 'assets/audio/numbers/six.mp3'}, // 6
        {'number': '٧', 'audio': 'assets/audio/numbers/seven.mp3'}, // 7
        {'number': '٨', 'audio': 'assets/audio/numbers/eight.mp3'}, // 8
        {'number': '٩', 'audio': 'assets/audio/numbers/nine.mp3'}, // 9
        {'number': '١٠', 'audio': 'assets/audio/numbers/ten.mp3'}, // 10
        {'number': '١١', 'audio': 'assets/audio/numbers/eleven.mp3'}, // 11
        {'number': '١٢', 'audio': 'assets/audio/numbers/twelve.mp3'}, // 12
        {'number': '١٣', 'audio': 'assets/audio/numbers/thirteen.mp3'}, // 13
        {'number': '١٤', 'audio': 'assets/audio/numbers/fourteen.mp3'}, // 14
        {'number': '١٥', 'audio': 'assets/audio/numbers/fifteen.mp3'}, // 15
        {'number': '١٦', 'audio': 'assets/audio/numbers/sixteen.mp3'}, // 16
        {'number': '١٧', 'audio': 'assets/audio/numbers/seventeen.mp3'}, // 17
        {'number': '١٨', 'audio': 'assets/audio/numbers/eighteen.mp3'}, // 18
        {'number': '١٩', 'audio': 'assets/audio/numbers/nineteen.mp3'}, // 19
        {'number': '٢٠', 'audio': 'assets/audio/numbers/twenty.mp3'}, // 20
        {'number': '٢١', 'audio': 'assets/audio/numbers/twenty_one.mp3'}, // 21
        {'number': '٢٢', 'audio': 'assets/audio/numbers/twenty_two.mp3'}, // 22
        {
          'number': '٢٣',
          'audio': 'assets/audio/numbers/twenty_three.mp3'
        }, // 23
        {'number': '٢٤', 'audio': 'assets/audio/numbers/twenty_four.mp3'}, // 24
        {'number': '٢٥', 'audio': 'assets/audio/numbers/twenty_five.mp3'}, // 25
        {'number': '٢٦', 'audio': 'assets/audio/numbers/twenty_six.mp3'}, // 26
        {
          'number': '٢٧',
          'audio': 'assets/audio/numbers/twenty_seven.mp3'
        }, // 27
        {
          'number': '٢٨',
          'audio': 'assets/audio/numbers/twenty_eight.mp3'
        }, // 28
        {'number': '٢٩', 'audio': 'assets/audio/numbers/twenty_nine.mp3'}, // 29
        {'number': '٣٠', 'audio': 'assets/audio/numbers/thirty.mp3'}, // 30
        {'number': '٣١', 'audio': 'assets/audio/numbers/thirty_one.mp3'}, // 31
        {'number': '٣٢', 'audio': 'assets/audio/numbers/thirty_two.mp3'}, // 32
        {
          'number': '٣٣',
          'audio': 'assets/audio/numbers/thirty_three.mp3'
        }, // 33
        {'number': '٣٤', 'audio': 'assets/audio/numbers/thirty_four.mp3'}, // 34
        {'number': '٣٥', 'audio': 'assets/audio/numbers/thirty_five.mp3'}, // 35
        {'number': '٣٦', 'audio': 'assets/audio/numbers/thirty_six.mp3'}, // 36
        {
          'number': '٣٧',
          'audio': 'assets/audio/numbers/thirty_seven.mp3'
        }, // 37
        {
          'number': '٣٨',
          'audio': 'assets/audio/numbers/thirty_eight.mp3'
        }, // 38
        {'number': '٣٩', 'audio': 'assets/audio/numbers/thirty_nine.mp3'}, // 39
        {'number': '٤٠', 'audio': 'assets/audio/numbers/forty.mp3'}, // 40
        {'number': '٤١', 'audio': 'assets/audio/numbers/forty_one.mp3'}, // 41
        {'number': '٤٢', 'audio': 'assets/audio/numbers/forty_two.mp3'}, // 42
        {'number': '٤٣', 'audio': 'assets/audio/numbers/forty_three.mp3'}, // 43
        {'number': '٤٤', 'audio': 'assets/audio/numbers/forty_four.mp3'}, // 44
        {'number': '٤٥', 'audio': 'assets/audio/numbers/forty_five.mp3'}, // 45
        {'number': '٤٦', 'audio': 'assets/audio/numbers/forty_six.mp3'}, // 46
        {'number': '٤٧', 'audio': 'assets/audio/numbers/forty_seven.mp3'}, // 47
        {'number': '٤٨', 'audio': 'assets/audio/numbers/forty_eight.mp3'}, // 48
        {'number': '٤٩', 'audio': 'assets/audio/numbers/forty_nine.mp3'}, // 49
        {'number': '٥٠', 'audio': 'assets/audio/numbers/fifty.mp3'}, // 50
        {'number': '٥١', 'audio': 'assets/audio/numbers/fifty_one.mp3'}, // 51
        {'number': '٥٢', 'audio': 'assets/audio/numbers/fifty_two.mp3'}, // 52
        {'number': '٥٣', 'audio': 'assets/audio/numbers/fifty_three.mp3'}, // 53
        {'number': '٥٤', 'audio': 'assets/audio/numbers/fifty_four.mp3'}, // 54
        {'number': '٥٥', 'audio': 'assets/audio/numbers/fifty_five.mp3'}, // 55
        {'number': '٥٦', 'audio': 'assets/audio/numbers/fifty_six.mp3'}, // 56
        {'number': '٥٧', 'audio': 'assets/audio/numbers/fifty_seven.mp3'}, // 57
        {'number': '٥٨', 'audio': 'assets/audio/numbers/fifty_eight.mp3'}, // 58
        {'number': '٥٩', 'audio': 'assets/audio/numbers/fifty_nine.mp3'}, // 59
        {'number': '٦٠', 'audio': 'assets/audio/numbers/sixty.mp3'}, // 60
        {'number': '٦١', 'audio': 'assets/audio/numbers/sixty_one.mp3'}, // 61
        {'number': '٦٢', 'audio': 'assets/audio/numbers/sixty_two.mp3'}, // 62
        {'number': '٦٣', 'audio': 'assets/audio/numbers/sixty_three.mp3'}, // 63
        {'number': '٦٤', 'audio': 'assets/audio/numbers/sixty_four.mp3'}, // 64
        {'number': '٦٥', 'audio': 'assets/audio/numbers/sixty_five.mp3'}, // 65
        {'number': '٦٦', 'audio': 'assets/audio/numbers/sixty_six.mp3'}, // 66
        {'number': '٦٧', 'audio': 'assets/audio/numbers/sixty_seven.mp3'}, // 67
        {'number': '٦٨', 'audio': 'assets/audio/numbers/sixty_eight.mp3'}, // 68
        {'number': '٦٩', 'audio': 'assets/audio/numbers/sixty_nine.mp3'}, // 69
        {'number': '٧٠', 'audio': 'assets/audio/numbers/seventy.mp3'}, // 70
        {'number': '٧١', 'audio': 'assets/audio/numbers/seventy_one.mp3'}, // 71
        {'number': '٧٢', 'audio': 'assets/audio/numbers/seventy_two.mp3'}, // 72
        {
          'number': '٧٣',
          'audio': 'assets/audio/numbers/seventy_three.mp3'
        }, // 73
        {
          'number': '٧٤',
          'audio': 'assets/audio/numbers/seventy_four.mp3'
        }, // 74
        {
          'number': '٧٥',
          'audio': 'assets/audio/numbers/seventy_five.mp3'
        }, // 75
        {'number': '٧٦', 'audio': 'assets/audio/numbers/seventy_six.mp3'}, // 76
        {
          'number': '٧٧',
          'audio': 'assets/audio/numbers/seventy_seven.mp3'
        }, // 77
        {
          'number': '٧٨',
          'audio': 'assets/audio/numbers/seventy_eight.mp3'
        }, // 78
        {
          'number': '٧٩',
          'audio': 'assets/audio/numbers/seventy_nine.mp3'
        }, // 79
        {'number': '٨٠', 'audio': 'assets/audio/numbers/eighty.mp3'}, // 80
        {'number': '٨١', 'audio': 'assets/audio/numbers/eighty_one.mp3'}, // 81
        {'number': '٨٢', 'audio': 'assets/audio/numbers/eighty_two.mp3'}, // 82
        {
          'number': '٨٣',
          'audio': 'assets/audio/numbers/eighty_three.mp3'
        }, // 83
        {'number': '٨٤', 'audio': 'assets/audio/numbers/eighty_four.mp3'}, // 84
        {'number': '٨٥', 'audio': 'assets/audio/numbers/eighty_five.mp3'}, // 85
        {'number': '٨٦', 'audio': 'assets/audio/numbers/eighty_six.mp3'}, // 86
        {
          'number': '٨٧',
          'audio': 'assets/audio/numbers/eighty_seven.mp3'
        }, // 87
        {
          'number': '٨٨',
          'audio': 'assets/audio/numbers/eighty_eight.mp3'
        }, // 88
        {'number': '٨٩', 'audio': 'assets/audio/numbers/eighty_nine.mp3'}, // 89
        {'number': '٩٠', 'audio': 'assets/audio/numbers/ninety.mp3'}, // 90
        {'number': '٩١', 'audio': 'assets/audio/numbers/ninety_one.mp3'}, // 91
        {'number': '٩٢', 'audio': 'assets/audio/numbers/ninety_two.mp3'}, // 92
        {
          'number': '٩٣',
          'audio': 'assets/audio/numbers/ninety_three.mp3'
        }, // 93
        {'number': '٩٤', 'audio': 'assets/audio/numbers/ninety_four.mp3'}, // 94
        {'number': '٩٥', 'audio': 'assets/audio/numbers/ninety_five.mp3'}, // 95
        {'number': '٩٦', 'audio': 'assets/audio/numbers/ninety_six.mp3'}, // 96
        {
          'number': '٩٧',
          'audio': 'assets/audio/numbers/ninety_seven.mp3'
        }, // 97
        {
          'number': '٩٨',
          'audio': 'assets/audio/numbers/ninety_eight.mp3'
        }, // 98
        {'number': '٩٩', 'audio': 'assets/audio/numbers/ninety_nine.mp3'}, // 99
        {
          'number': '١٠٠',
          'audio': 'assets/audio/numbers/one_hundred.mp3'
        }, // 100
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('الأرقام'), // Numbers
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode ? darkModeContainerGradient : null,
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            final number = numbers[index];

            return GestureDetector(
              onTap: () {
                _onNumberTap(context, number['audio']!, number['number']!);
              },
              child: Container(
                color: Colors.blueAccent, // Change color as needed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      number['number']!,
                      style: TextStyle(color: Colors.white, fontSize: 48),
                    ),
                    SizedBox(height: 8),
                    Text(
                      getArabicName(number['number']!), // Display Arabic name
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String getArabicName(String number) {
    switch (number) {
      case '٠':
        return 'صفر';
      case '١':
        return 'واحد';
      case '٢':
        return 'اثنان';
      case '٣':
        return 'ثلاثة';
      case '٤':
        return 'أربعة';
      case '٥':
        return 'خمسة';
      case '٦':
        return 'ستة';
      case '٧':
        return 'سبعة';
      case '٨':
        return 'ثمانية';
      case '٩':
        return 'تسعة';
      case '١٠':
        return 'عشرة';
      case '١١':
        return 'أحد عشر';
      case '١٢':
        return 'اثنا عشر';
      case '١٣':
        return 'ثلاثة عشر';
      case '١٤':
        return 'أربعة عشر';
      case '١٥':
        return 'خمسة عشر';
      case '١٦':
        return 'ستة عشر';
      case '١٧':
        return 'سبعة عشر';
      case '١٨':
        return 'ثمانية عشر';
      case '١٩':
        return 'تسعة عشر';
      case '٢٠':
        return 'عشرون';
      case '٢١':
        return 'واحد وعشرون';
      case '٢٢':
        return 'اثنان وعشرون';
      case '٢٣':
        return 'ثلاثة وعشرون';
      case '٢٤':
        return 'أربعة وعشرون';
      case '٢٥':
        return 'خمسة وعشرون';
      case '٢٦':
        return 'ستة وعشرون';
      case '٢٧':
        return 'سبعة وعشرون';
      case '٢٨':
        return 'ثمانية وعشرون';
      case '٢٩':
        return 'تسعة وعشرون';
      case '٣٠':
        return 'ثلاثون';
      case '٣١':
        return 'واحد وثلاثون';
      case '٣٢':
        return 'اثنان وثلاثون';
      case '٣٣':
        return 'ثلاثة وثلاثون';
      case '٣٤':
        return 'أربعة وثلاثون';
      case '٣٥':
        return 'خمسة وثلاثون';
      case '٣٦':
        return 'ستة وثلاثون';
      case '٣٧':
        return 'سبعة وثلاثون';
      case '٣٨':
        return 'ثمانية وثلاثون';
      case '٣٩':
        return 'تسعة وثلاثون';
      case '٤٠':
        return 'أربعون';
      case '٤١':
        return 'واحد وأربعون';
      case '٤٢':
        return 'اثنان وأربعون';
      case '٤٣':
        return 'ثلاثة وأربعون';
      case '٤٤':
        return 'أربعة وأربعون';
      case '٤٥':
        return 'خمسة وأربعون';
      case '٤٦':
        return 'ستة وأربعون';
      case '٤٧':
        return 'سبعة وأربعون';
      case '٤٨':
        return 'ثمانية وأربعون';
      case '٤٩':
        return 'تسعة وأربعون';
      case '٥٠':
        return 'خمسون';
      case '٥١':
        return 'واحد وخمسون';
      case '٥٢':
        return 'اثنان وخمسون';
      case '٥٣':
        return 'ثلاثة وخمسون';
      case '٥٤':
        return 'أربعة وخمسون';
      case '٥٥':
        return 'خمسة وخمسون';
      case '٥٦':
        return 'ستة وخمسون';
      case '٥٧':
        return 'سبعة وخمسون';
      case '٥٨':
        return 'ثمانية وخمسون';
      case '٥٩':
        return 'تسعة وخمسون';
      case '٦٠':
        return 'ستون';
      case '٦١':
        return 'واحد وستون';
      case '٦٢':
        return 'اثنان وستون';
      case '٦٣':
        return 'ثلاثة وستون';
      case '٦٤':
        return 'أربعة وستون';
      case '٦٥':
        return 'خمسة وستون';
      case '٦٦':
        return 'ستة وستون';
      case '٦٧':
        return 'سبعة وستون';
      case '٦٨':
        return 'ثمانية وستون';
      case '٦٩':
        return 'تسعة وستون';
      case '٧٠':
        return 'سبعون';
      case '٧١':
        return 'واحد وسبعون';
      case '٧٢':
        return 'اثنان وسبعون';
      case '٧٣':
        return 'ثلاثة وسبعون';
      case '٧٤':
        return 'أربعة وسبعون';
      case '٧٥':
        return 'خمسة وسبعون';
      case '٧٦':
        return 'ستة وسبعون';
      case '٧٧':
        return 'سبعة وسبعون';
      case '٧٨':
        return 'ثمانية وسبعون';
      case '٧٩':
        return 'تسعة وسبعون';
      case '٨٠':
        return 'ثمانون';
      case '٨١':
        return 'واحد وثمانون';
      case '٨٢':
        return 'اثنان وثمانون';
      case '٨٣':
        return 'ثلاثة وثمانون';
      case '٨٤':
        return 'أربعة وثمانون';
      case '٨٥':
        return 'خمسة وثمانون';
      case '٨٦':
        return 'ستة وثمانون';
      case '٨٧':
        return 'سبعة وثمانون';
      case '٨٨':
        return 'ثمانية وثمانون';
      case '٨٩':
        return 'تسعة وثمانون';
      case '٩٠':
        return 'تسعون';
      case '٩١':
        return 'واحد وتسعون';
      case '٩٢':
        return 'اثنان وتسعون';
      case '٩٣':
        return 'ثلاثة وتسعون';
      case '٩٤':
        return 'أربعة وتسعون';
      case '٩٥':
        return 'خمسة وتسعون';
      case '٩٦':
        return 'ستة وتسعون';
      case '٩٧':
        return 'سبعة وتسعون';
      case '٩٨':
        return 'ثمانية وتسعون';
      case '٩٩':
        return 'تسعة وتسعون';
      case '١٠٠':
        return 'مائة';
      default:
        return '';
    }
  }

  void _onNumberTap(
      BuildContext context, String audioPath, String number) async {
    // Attempt to play audio if it exists
    try {
      await _audioPlayer.setAsset(audioPath);
      await _audioPlayer.stop();
      _audioPlayer.play();
    } catch (e) {
      print("Audio file not found: $audioPath"); // Handle missing audio
    }

    // Show the enlarged number in the dialog
    _showNumberDetailDialog(context, audioPath, number);
  }

  void _showNumberDetailDialog(
      BuildContext context, String audioPath, String number) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Display enlarged number view
            Container(
              width: 300,
              height: 300,
              color: Colors.blueAccent, // Change color as needed
              child: Center(
                child: Text(
                  number,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Conditionally show the play button if the audio file exists
            FutureBuilder(
              future: _audioPlayer.setAsset(audioPath),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.error == null) {
                  return ElevatedButton(
                    onPressed: () async {
                      await _audioPlayer.setAsset(audioPath);
                      _audioPlayer.play();
                    },
                    child: Text('تشغيل الصوت'),
                  );
                } else {
                  return SizedBox
                      .shrink(); // Optionally display a message or nothing
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
