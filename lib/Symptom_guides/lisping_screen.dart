import 'package:flutter/material.dart';
import '../theme.dart';

class LispingScreen extends StatelessWidget {
  final bool isChildModeActive;
  final void Function(bool) toggleDarkMode;
  final void Function(bool) toggleChildMode;
  final bool isDarkModeActive;

  LispingScreen({
    required this.isChildModeActive,
    required this.toggleDarkMode,
    required this.toggleChildMode,
    required this.isDarkModeActive,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final CustomThemeData customThemeData = theme.customThemeData;

    return Scaffold(
      appBar: AppBar(
        title: Text('اللّدغة'),
        backgroundColor: isDarkModeActive
            ? Colors.transparent
            : theme.appBarTheme.backgroundColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkModeActive
              ? customThemeData.darkPrimaryGradient
              : customThemeData.lightPrimaryGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(
              children: [
                _buildLispingContentCard(
                  context: context,
                  title: 'انواع اللدغه؟',
                  content:
                      '''1-لادغه سينيه: وتحدث عندما يندفع اللسان ضد الاسنان الاماميه. 

2-لدغه جانبيه: تحدث عند تدفق الهواء حول اللسان او اعلى جانبيه مما يتسبب بنطق احرف 
مخالفة. 

3-لدغه حنكية: وتحدث عندما يلامس منتصف اللسان الحنك الرخو اوثقف الفم عند محاوله النطق.''',
                  isDarkModeActive: isDarkModeActive,
                ),
                _buildLispingContentCard(
                  context: context,
                  title: 'ماهي طرق علاج اللدغه؟ ',
                  content:
                      '''1-يسمى علاج اللدغه بعلاج الناطق الساكن او علاج طريقه التعبير اللفظي والتي عاد ما تتضمن علاجا قصيرا للكلام وهو علاج ناجح بشكل عام تتضمن جلسات علاج النطق مجموعه واسعه من الانشطه والتدريبات على الكلام تعتمد على العديد من المتغيرات كمده جلسه العلاج عاده ما تكون ما بين نصف ساعه أو ساعه واحده وموقع جلسه العلاج في المنزل او المدرسه او منشاه خاصه وعمر الطفل ونوع اللجهه التي تتم معالجتها على محتوى هذه الجلسات. 


2-خلال هذه الجلسات يتم تعليم الطفل الصوت الذي يواجه مشكله بنطقه بشكل معزول وعندما يتقن هذا الصوت سيتعلم الطفل حينئذ  نطق الصوت في المقاطع ثم الكلمات ثم العبارات ثم الجمل وعندما يصبح الطفل قادرا على النطق بكامل الجمله دون ان يتلعثم يتركز الاهتمام على صنع الاصوات الصحيحه طوال المحادثه الطبيعيه في المراحل النهائيه من العلاج يتم تعليم الطفل كيفيه مراقبه خطابه وكيفيه تصحيحه حسب الضرورة. 

3-يكون خيار العلاج ضروريه عندما يناهز عمر الطفل من الخامسه الى الثامنة من عمرو وذلك لامكانيه تاثير اللجهه على مدى ثقته بنفسه وطريقه تعبيره وتواصله مع الاخرين يمكن للعلاج ان يكون قصير الامد اي قد يستغرق بضعه اشهر فقط وبعد الحالات قد تتطلب سنه او ما يزيد عنها بقليل.''',
                  isDarkModeActive: isDarkModeActive,
                ),
                _buildLispingContentCard(
                  context: context,
                  title: 'كيف تجنب اضرار اللدغة منذ الولاده؟',
                  content:
                      '''1-يمكن تقليل فرص تكوين اللجهه عند الطفل من خلال تجنب العوامل المسببه لها كالاعتماد على الرضاعه الطبيعيه والامتناع عن استخدام اللهايات 

2-إضافه إلى التحدث مع الطفل بشكل واضح وسليم دون استخدام طريقة الطفل في الكلام والحرص على علاج مشاكل الحساسيه وامراض الجهاز التنفسي العلوي وعلى المجرى التنفسي  مفتوحا والحد من تاثير انسداد على قدرة الطفل على النطق. 

3-يمكن فحص السمع والاسنان بشكل دوري لتقييمهما وتشجيع الطفل على تطوير الكلام وتحفيزه على التعلم وتقويه عضلات الفم عن طريق استخدام القشه في الشرب وتشكيل فقاعات الصابون.''',
                  isDarkModeActive: isDarkModeActive,
                ),
                _buildLispingContentCard(
                  context: context,
                  title: 'كيف يتم تشخيص اللدغة؟ ',
                  content:
                      '''1-يحدد الطبيب اذا ما كانت هناك مخالفات بنيوية داخل الفم او مشاكل في سماع الطفل ويمكن علاج الحساسيه المرتبطه باللدغه والمشاكل الانفيه اضافه الى اجراء تقييم لقدره الطفل على اصدار او نطق اصوات الكلام من قبل اخصائي علم النطق واللغه الذي بدوره سياخذ بالتاريخ الطبي للطفل ويفحص تشريح فم الطفل والحركات التي يمكنه القيام بها. 

2ـ بعد ذلك غالبا ما يتم تسجيل خطاب الطفل وقراءته بصوت عالي لتحليل لاحقا والتي توفر معلومات حول جوده صوت الطفل وكيف يتحدث بطلاقه ومهارة صنع الصوت الدلالي والبدني الطفل.''',
                  isDarkModeActive: isDarkModeActive,
                ),
                _buildLispingContentCard(
                  context: context,
                  title: 'عنوان',
                  content: '''محتوي''',
                  isDarkModeActive: isDarkModeActive,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLispingContentCard({
    required BuildContext context,
    required String title,
    required String content,
    required bool isDarkModeActive,
  }) {
    //final ThemeData theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      color: isDarkModeActive
          ? Color(0xFF5D6D7E) // Darker Gray for dark mode
          : Colors.white, // Default card color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          title,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isDarkModeActive
                ? Colors.white
                : Colors.black, // Dark mode text color
          ),
        ),
        subtitle: Text(
          content,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: isDarkModeActive
                ? Colors.white
                : Colors.black, // Dark mode text color
          ),
        ),
      ),
    );
  }
}
