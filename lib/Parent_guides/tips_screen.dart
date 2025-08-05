import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';
import '../theme.dart'; // Import the theme extensions

class TipsScreen extends StatefulWidget {
  final bool isChildModeActive;
  final void Function(bool) toggleDarkMode;
  final void Function(bool) toggleChildMode;
  final bool isDarkModeActive;

  TipsScreen({
    this.isChildModeActive = false,
    required this.toggleDarkMode,
    required this.toggleChildMode,
    required this.isDarkModeActive,
  });

  @override
  _TipsScreenState createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  late bool _isDarkModeActive;
  late bool _isChildModeActive;

  @override
  void initState() {
    super.initState();
    _isDarkModeActive = widget.isDarkModeActive;
    _isChildModeActive = widget.isChildModeActive;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // List of sections to display
    final List<Map<String, String>> sections = [
      {
        'title': 'مقدمة',
        'content':
            '''تعريف التربيه الصالحه والسليمه للطفل،  هي تلبيه احتياجات الطفل وفقا للمعايير الصحيحه التي تتغير من زمن الي اخر، والتي تضمن دعم وتعزيز النمو الجسدي والعقلي والاجتماعي والعاطفي ضمن مناخ عاطفي وظروف جيده، ولأن الام هي الشخص الذي يقضي الطفل معاها معظم الوقت،  فالمسؤوليه الكبيره تقع عليها،  ولذالك خصصنا مساعدة للامهات من خلال تقديم نصائح التي تجعل تربيتها لطفلها سليمة
            
             يبدأ التطور المعرفي للطفل منذ عامه الاول، وبخلاف ذلك فان اسلوب التربيه السلبي يؤدي الي ظهور اعراض سلبيه داخليه وخارجيه، فقد بينت الدراسات ان حالات الاكتئاب التي تصيب الاطفال بعمر المراهقه ناتجه عن طفوله قاسيه او مهملة'''
      },
      {
        'title': ' نصيحة 1',
        'content':
            '• عدم مشاركه الطفل في العاب عنيفه مثل الملاكمه التايكوندو الكونغ فو وغيرها من الالعاب التي تحث على العنف منذ الصغر بل يجب ان يمارس رياضات مثل السباحه وركوب العجل وركوب الخيل ويمارس انشطه الانتباه ويحفز التركيز ويمارس بعض التمارين المنزليه وغيرها.'
      },
      {
        'title': ' نصيحة 2',
        'content': '''من الاضرار التي تسبب مشاكل للطفل.

• استخدام الهاتف اكثر من الوقت اللازم.
• اكل السكريات كثيرا.
• اكل المعلبات بكثره مما يسبب المرض الطفل.
• عدم ترك الطفل دون تحدث معه لفتره طويله او اللعب معه لكي يكون اجتماعيآ..'''
      },
      {
        'title': ' نصيحة 3',
        'content':
            '''• لا يجب أن نعاقب الطفل قبل وضع القواعد، ولا نلومه على شيء بعد السماح له بفعل تصرف معين من قبل التقليل من إعطاء الأوامر ومحاولة التكلم مع الأبناء ومناقشتهم.

• إعطاء الطفل حورية التعبير عن مشاعره والامان في التكلم مع الأب والأم وذلك يعطيه ثقه بنفسه.

• يجب التحدث معه وإخباره بما يستطيع فعله أو التكلم فيه، وبما لا يستطيع أن يتكلم فيه أو فعله.'''
      },
      {
        'title': ' نصيحة 4',
        'content': '''الاخطاء الشائعه عند تربية الاطفال.

• يتجه بعض الآباء إلى ضرب وتعنيف الأبناء عند عدم تنفيذ ما يطلب منهم، أو عند الخروج عن حدود الأدب، ولكن مع كثرة الضرب لا يتأثر الأبناء به ويصبح بالنسبة لهم شيئاً عادياً.

• لابد من الابتعاد عن التدليل الزائد للأبناء ، وكذلك القسوة الزائدة؛ مثل كثرة الضرب، وأن يكون هناك توازن في إعطاء الأبناء الحب والحنان والأمان أيضاً.

• أيضاً من الأخطاء الشائعة عدم المساواة بين الأبناء في التعامل أو العقاب أو التدليل، وهذا يجعل الأطفال يشعرون بغيرة تجاه بعضهم.'''
      },
      {
        'title': ' نصيحة 5',
        'content': '''قواعد علي الام الالتزام بها.

• الالتزام بروتين معين يومي؛ بمعنى تحديد وقت للطعام، للنوم والراحة، لمشاهدة التليفزيون أو اللعب، والمذاكرة أيضاً حتى يدرك الطفل قيمة الوقت.

• اطلب من طفلك المساعدة والمشاركة في تقديم الخدمة؛ هذا يعلم الأبناء التعاون ومعنى الإحساس بالآخر.

• تعليم الطفل أن يضع الأشياء في مكانها سواء الملابس أو الألعاب، وهذا يعلم الأبناء النظافة والنظام.

• وتكوني نعم القدوة: حيث يكون الآباء قدوة لأبنائهم في كل شيئ مثل التصرفات والافعال والكلام وطريقة معاملة الآخرين وغيرها.'''
      },
      {
        'title': ' نصيحة 6',
        'content': '''تصرفات ابتعدي عنها.

• يقوم بعض الآباء بالضغط الشديد على الأبناء دراسياً واجتماعياً دون قصد؛ حيث يضغط الأهل على الطفل لكي يدرس ويصبح الأفضل، وحتى يكون من الأوائل من دون النظر إلى ميول ومواهب وقدرات الطفل.

والبديل:
• أن تشعروا طفلكم بأنه شخص مميز وفريد جداً من نوعه يجد البعض من الأهل صعوبة رغم ما يعطي هذا الطفلَ من إحساس بالثقة بالذات عالية جداً تساعده في بناء شخصيته، وفي جعله ينمو بشكل سوي نفسياً.

• يجب أن تعطي الأم ابنها الثقة في إبداء رأيه، ويجب أن تستمع إليه جيداً، وتأخذ رأيه بعين الاعتبار، كل هذا يساعد في بناء شخصية الطفل، وتعطيه ثقة بالنفس كبيرة.'''
      },
      //{'title': ' نصيحة 7', 'content': ''' '''},

      // Add more sections here as needed
    ];

    return Scaffold(
      appBar: CustomAppBar(
        onDarkModeToggle: () {
          setState(() {
            _isDarkModeActive = !_isDarkModeActive;
            widget.toggleDarkMode(_isDarkModeActive);
          });
        },
        onLanguageChange: () {
          // Handle language change
        },
        onChildModeToggle: () {
          setState(() {
            _isChildModeActive = !_isChildModeActive;
            widget.toggleChildMode(_isChildModeActive);
          });
        },
        isChildModeActive: _isChildModeActive,
      ),
      drawer: CustomDrawer(
        onDarkModeToggle: () {
          setState(() {
            _isDarkModeActive = !_isDarkModeActive;
            widget.toggleDarkMode(_isDarkModeActive);
          });
        },
        onLanguageChange: () {
          // Handle language change
        },
        onChildModeToggle: () {
          setState(() {
            _isChildModeActive = !_isChildModeActive;
            widget.toggleChildMode(_isChildModeActive);
          });
        },
        isDarkModeActive: _isDarkModeActive,
        isChildModeActive: _isChildModeActive,
        onDarkModeChanged: (bool value) {
          setState(() {
            _isDarkModeActive = value;
            widget.toggleDarkMode(value);
          });
        },
        onChildModeChanged: (bool value) {
          setState(() {
            _isChildModeActive = value;
            widget.toggleChildMode(value);
          });
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: _isDarkModeActive
              ? theme.customThemeData.darkSecondaryGradient
              : theme.customThemeData.lightSecondaryGradient,
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(maxWidth: 800),
            decoration: BoxDecoration(
              gradient: _isDarkModeActive
                  ? theme.customThemeData.darkModeContainerGradient
                  : theme.customThemeData.lightSecondaryGradient,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: EdgeInsets.all(20),
            child: ListView.builder(
              itemCount: sections.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    _buildExpandableTextSection(
                      sections[index]['title']!,
                      sections[index]['content']!,
                      _isDarkModeActive,
                      initiallyExpanded:
                          index == 0, // Always expand the first section
                    ),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableTextSection(
      String title, String content, bool isDarkModeActive,
      {bool initiallyExpanded = false}) {
    return ExpansionTile(
      title: Text(
        title,
        textAlign: TextAlign.right, // Align title to the right
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isDarkModeActive ? Colors.white : Colors.black,
        ),
      ),
      initiallyExpanded:
          initiallyExpanded, // Control the initial expansion state
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            content,
            textAlign: TextAlign.right, // Align content to the right
            textDirection: TextDirection.rtl, // Ensure RTL text direction
            style: TextStyle(
              fontSize: 16,
              color: isDarkModeActive ? Colors.white70 : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
