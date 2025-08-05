import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/scheduler.dart'; // For the frame callback

import '../theme.dart'; // Import your theme file (adjust the path if necessary)

class Story1Page extends StatefulWidget {
  final bool isChildModeActive;
  final bool isDarkModeActive;
  final void Function(bool) toggleDarkMode;
  final void Function(bool) toggleChildMode;

  const Story1Page({
    required this.isChildModeActive,
    required this.isDarkModeActive,
    required this.toggleDarkMode,
    required this.toggleChildMode,
  });

  @override
  _Story1PageState createState() => _Story1PageState();
}

class _Story1PageState extends State<Story1Page> {
  late AudioPlayer _audioPlayer;
  double _progress = 0.0;
  late Duration _audioDuration;
  final ScrollController _scrollController = ScrollController();
  bool _isPlaying = false; // Flag to track play state

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _audioPlayer.setAsset('assets/audio/storys/story_1.mp3').then((_) {
      _audioPlayer.durationStream.listen((duration) {
        if (duration != null) {
          setState(() {
            _audioDuration = duration;
          });
        }
      });
    });

    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _progress = position.inMilliseconds / (_audioDuration.inMilliseconds);
      });
      // Scroll down as the audio progresses
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent * _progress);
      });
    });

    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use the appropriate theme based on dark mode
    final ThemeData theme = widget.isDarkModeActive ? darkTheme : lightTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'قصة الارنب الكسول',
          style: theme.appBarTheme.titleTextStyle,
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        // Removed the actions property to hide the button
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: widget.isDarkModeActive
              ? darkPrimaryGradient // Apply dark gradient
              : lightPrimaryGradient, // Apply light gradient
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'قصة الارنب الكسول',
              style: theme.textTheme.displayLarge?.copyWith(
                color: widget.isDarkModeActive ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 20), // Spacing for audio icon
            IconButton(
              icon: Icon(
                _isPlaying
                    ? Icons.pause_circle_outline
                    : Icons.play_circle_outline,
              ),
              iconSize: 48,
              color: widget.isDarkModeActive ? Colors.white : Colors.black,
              onPressed: _togglePlayPause,
            ),
            const SizedBox(height: 20), // Spacing for progress bar
            if (_isPlaying) // Show progress bar only when playing
              Slider(
                value: _progress,
                onChanged: (value) {
                  setState(() {
                    _progress = value;
                  });
                  final position = Duration(
                      milliseconds:
                          (value * _audioDuration.inMilliseconds).toInt());
                  _audioPlayer.seek(position);
                },
                min: 0.0,
                max: 1.0,
                activeColor:
                    widget.isDarkModeActive ? Colors.white : Colors.black,
                inactiveColor:
                    widget.isDarkModeActive ? Colors.grey : Colors.grey[400],
              ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Text(
                  '''في يوم من الأيام، كان هناك أرنب صغير يُدعى "كسول". كان الأرنب يعيش في غابة جميلة مليئة بالأشجار العالية والزهور الملونة. وكان "كسول" يحب النوم واللعب طوال اليوم، وكان يكره العمل أو بذل أي جهد.

ذات صباح، اجتمع جميع حيوانات الغابة للتخطيط لجمع الطعام من أجل فصل الشتاء القادم. قال الثعلب: "علينا أن نجمع الكثير من الطعام لنستعد للشتاء، فالثلج سيغطي الأرض ولن نجد شيئًا نأكله". وافق الجميع، وبدأ كل حيوان في العمل بجد.

أما الأرنب "كسول"، فقد قال لنفسه: "لماذا أعمل وأتعب؟ الشتاء بعيد، سأستمتع بوقتي الآن". وبدلاً من العمل، ذهب لينام تحت شجرة كبيرة. وبقي الأرنب على حاله لأيام عديدة، لا يفعل شيئًا سوى النوم واللعب.

ومرت الأيام، وجاء الشتاء بثلوجه الباردة. استيقظ الأرنب "كسول" في يوم شديد البرودة، وكان جائعًا جدًا. خرج من منزله يبحث عن الطعام، ولكنه لم يجد شيئًا. توجه إلى أصدقائه يطلب المساعدة، فذهب إلى الثعلب وقال: "هل يمكنك أن تعطيني بعض الطعام؟ أنا جائع جدًا!" نظر الثعلب إليه وقال: "ألم تقم بجمع الطعام عندما كنا نعمل؟". شعر الأرنب بالخجل ولم يعرف ماذا يقول.

بعدها ذهب إلى السنجاب، وطلب منه الطعام، فقال السنجاب: "لقد عملت بجد لجمع الطعام طوال الصيف، وأنت كنت نائمًا. الآن عليك أن تتحمل عاقبة كسلك".

وأخيرًا، ذهب الأرنب إلى عائلة الأرانب التي تعيش بالقرب منه، وطلب منهم المساعدة. قررت عائلة الأرانب مساعدته، وأعطته بعض الطعام. ولكنه تعلم درسًا مهمًا في ذلك اليوم. قال الأرنب لنفسه: "العمل الجاد والمشاركة مع الآخرين هما مفتاح السعادة. لن أكون كسولاً مرة أخرى!"

ومنذ ذلك اليوم، بدأ الأرنب "كسول" يعمل بجد ويشارك أصدقاءه في جمع الطعام وتحضير مستلزمات الشتاء. وتعلم أن الوقت لا ينتظر أحدًا، وأن العمل الجاد هو الطريق الوحيد للنجاح.''',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 18,
                    color:
                        widget.isDarkModeActive ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
