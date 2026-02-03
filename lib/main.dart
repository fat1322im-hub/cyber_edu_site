import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const CyberSecurityApp());
}

class CyberSecurityApp extends StatelessWidget {
  const CyberSecurityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'مستودع الأمن السيبراني',
      theme: ThemeData(
        fontFamily: 'Tajawal',
        scaffoldBackgroundColor: const Color(0xFF0F1B33),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E3A5F),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white70),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4ECDC4),
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4ECDC4),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.white,
            height: 1.6,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            color: Colors.white70,
            height: 1.5,
          ),
        ).apply(
          displayColor: Colors.white,
          bodyColor: Colors.white,
        ),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF4ECDC4),
          secondary: Color(0xFF6C5CE7),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF4ECDC4),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: SplashScreen(),
      ),
    );
  }
}

// ================= الشاشة الترحيبية =================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
      ),
    );
    _scaleAnimation = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutBack),
      ),
    );
    _controller.forward();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PathChoicePage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3A5F), Color(0xFF0F1B33)],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A2E4D),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF4ECDC4).withOpacity(0.4),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF4ECDC4)
                                .withOpacity(0.25),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.security,
                        size: 72,
                        color: Color(0xFF4ECDC4),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'أهلاً وسهلاً بكم في',
                      style: textTheme.titleLarge?.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4ECDC4),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'مستودع الأمن السيبراني',
                      style: textTheme.titleLarge?.copyWith(
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 1.0,
                          ) ??
                          const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.0,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'مركز الموارد، التدريب، والمحاكاة لحمايةك الرقمية',
                      style: textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================= اختيار المسار =================
class PathChoicePage extends StatelessWidget {
  const PathChoicePage({super.key});

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: const Color(0xFF1E3A5F),
        title: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4ECDC4), Color(0xFF1E3A5F)],
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: const Text(
            '🌟 عن مستودع الأمن السيبراني',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFF4ECDC4),
                child: Icon(Icons.security, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 16),
              const Text(
                'فاطم عامر',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4ECDC4),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'مطور/ة ومصممة هذا المستودع التعليمي',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const Divider(color: Colors.white30, height: 32),
              const Text(
                '🎯 هدف المستودع:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'نقدم محتوى تعليميًا وتدريبيًا عمليًا لبناء مهارات الأمن السيبراني، مع أدوات لفحص الحسابات، محاكاة هجمات آمنة، ومسارات تعلم تفاعلية تشبه تجربة Duolingo.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white70,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4ECDC4),
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'إغلاق',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
        actionsPadding:
            const EdgeInsets.only(bottom: 16, right: 16, left: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختر مسارك'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () => _showAboutDialog(context),
            tooltip: 'عن المستودع',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3A5F), Color(0xFF0F1B33)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildChoiceCard(
                context: context,
                title: 'المساعد الذكي',
                subtitle: 'اسألني أي شيء عن الأمن السيبراني (محترف ومتخصص)',
                icon: Icons.smart_toy,
                color: Color(0xFF4ECDC4),
                nextPage: const CyberAssistantPage(),
              ),
              const SizedBox(height: 16),
              _buildChoiceCard(
                context: context,
                title: 'مسار التعلم التفاعلي',
                subtitle: 'تعلم وتمرّن بمستويات، تحديات، وألعاب تعليمية',
                icon: Icons.school,
                color: Color(0xFF6C5CE7),
                nextPage: const CyberLearningPathPage(),
              ),
              const SizedBox(height: 16),
              _buildChoiceCard(
                context: context,
                title: 'التطبيق العملي',
                subtitle: 'أدوات تفاعلية: فحص كلمات المرور، كشف روابط، بطاقات تعليمية',
                icon: Icons.play_circle,
                color: Colors.green,
                nextPage: const PracticePage(),
              ),
              const SizedBox(height: 16),
              _buildChoiceCard(
                context: context,
                title: 'محاكي الهجمات',
                subtitle: 'تعلم كيف يهاجم المخترقون — وكيف تحمي نفسك (محاكاة آمنة)',
                icon: Icons.bug_report,
                color: Colors.red,
                nextPage: const AttackSimulatorLab(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget nextPage,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => nextPage));
      },
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: color.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.85),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                color: color.withOpacity(0.7), size: 18),
          ],
        ),
      ),
    );
  }
}
// ================= نموذج التقدم (بدون تغيير) =================
class UserProgress {
  static final UserProgress _instance = UserProgress._internal();
  factory UserProgress() => _instance;
  UserProgress._internal();
  int _xp = 0;
  int _level = 1;
  int _streakDays = 0;
  int _hearts = 5;
  final List<String> _completedLessons = [];
  DateTime _lastStudyDate = DateTime.now().subtract(const Duration(days: 2));
  
  int get xp => _xp;
  int get level => _level;
  int get streakDays => _streakDays;
  int get hearts => _hearts;
  List<String> get completedLessons => List.unmodifiable(_completedLessons);
  
  int xpForNextLevel() {
    return _level * 100;
  }
  
  double progressToNextLevel() {
    return _xp / xpForNextLevel();
  }
  
  bool isLessonCompleted(String lessonId) {
    return _completedLessons.contains(lessonId);
  }
  
  // ✅ إصلاح: فتح الدرس عند إكمال الدرس السابق
  bool isLessonUnlocked(Lesson lesson) {
    if (lesson.levelRequired == 1) return true;
    
    final currentIndex = learningPath.indexWhere((l) => l.id == lesson.id);
    if (currentIndex > 0) {
      final previousLesson = learningPath[currentIndex - 1];
      return isLessonCompleted(previousLesson.id);
    }
    return _level >= lesson.levelRequired;
  }
  
  void completeLesson(String lessonId, int xpReward) {
    if (!_completedLessons.contains(lessonId)) {
      _completedLessons.add(lessonId);
      
      // تحديث الـ XP والمستوى
      _xp += xpReward;
      while (_xp >= xpForNextLevel()) {
        _xp -= xpForNextLevel();
        _level++;
      }
      
      // تحديث السلسلة (Streak)
      final today = DateTime.now();
      final diff = today.difference(_lastStudyDate).inDays;
      if (diff == 0) {
        // نفس اليوم - لا تغيير
      } else if (diff == 1) {
        _streakDays++;
      } else if (diff > 1) {
        _streakDays = 1;
      }
      _lastStudyDate = today;
      
      // استعادة القلوب تدريجياً
      if (_hearts < 5) {
        _hearts = (_hearts + 1).clamp(0, 5);
      }
    }
  }
  
  void loseHeart() {
    if (_hearts > 0) {
      _hearts--;
    }
  }
  
  void restoreHearts() {
    _hearts = 5;
  }
}

// ================= نموذج الدرس (بدون تغيير) =================
class Lesson {
  final String id;
  final String title;
  final String description;
  final int xpReward;
  final int levelRequired;
  final List<LessonStep> steps;
  final String icon;
  final Color color;
  final bool isLocked;
  final bool isCompleted;
  
  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.xpReward,
    required this.levelRequired,
    required this.steps,
    required this.icon,
    required this.color,
    this.isLocked = false,
    this.isCompleted = false,
  });
}

class LessonStep {
  final String type; // 'quiz', 'interactive', 'video', 'reading'
  final String title;
  final String content;
  final List<QuizOption>? options;
  final int correctAnswerIndex;
  final int level; // مستوى داخلي داخل الدرس
  
  LessonStep({
    required this.type,
    required this.title,
    required this.content,
    this.options,
    this.correctAnswerIndex = -1,
    this.level = 1,
  });
}

class QuizOption {
  final String text;
  final bool isCorrect;
  
  QuizOption(this.text, this.isCorrect);
}

// ================= مسار التعلم التفاعلي (بدون تغيير) =================
final List<Lesson> learningPath = [
  Lesson(
    id: 'l1',
    title: 'أساسيات الحماية',
    description: 'تعرف على المفاهيم الأساسية للأمن السيبراني',
    xpReward: 50,
    levelRequired: 1,
    icon: '🛡️',
    color: const Color(0xFF4ECDC4),
    steps: [
      LessonStep(
        level: 1,
        type: 'reading',
        title: 'ما هو الأمن السيبراني؟',
        content: 'الأمن السيبراني هو حماية الأنظمة والشبكات والبرامج من الهجمات الرقمية التي تستهدف سرقة البيانات أو إتلافها أو تعطيلها.',
      ),
      LessonStep(
        level: 2,
        type: 'quiz',
        title: 'لماذا نحتاج للأمن السيبراني؟ (مستوى 2)',
        content: 'اختر الإجابة الصحيحة:',
        options: [
          QuizOption('لحماية بياناتنا الشخصية', true),
          QuizOption('لتزيين حساباتنا', false),
          QuizOption('لزيادة سرعة الإنترنت', false),
        ],
        correctAnswerIndex: 0,
      ),
      LessonStep(
        level: 3,
        type: 'quiz',
        title: 'مفهوم الهجوم والدفاع (مستوى 3)',
        content: 'اختر أفضل وصف للدفاع السيبراني:',
        options: [
          QuizOption('حظر كل الاتصالات نهائياً', false),
          QuizOption('موازنة بين الوصول والأمان', true),
          QuizOption('تعطيل الإنترنت لمنع الهجمات', false),
        ],
        correctAnswerIndex: 1,
      ),
    ],
    isCompleted: false,
  ),
  Lesson(
    id: 'l2',
    title: 'كلمات المرور القوية',
    description: 'تعلّم كيفية إنشاء كلمات مرور لا يمكن اختراقها',
    xpReward: 75,
    levelRequired: 2,
    icon: '🔑',
    color: const Color(0xFF6C5CE7),
    steps: [
      LessonStep(
        level: 1,
        type: 'reading',
        title: 'أنشئ كلمة مرور قوية',
        content: 'استخدم الأداة التفاعلية لفحص قوة كلمة المرور',
      ),
      LessonStep(
        level: 2,
        type: 'quiz',
        title: 'ما هي أفضل كلمة مرور؟',
        content: 'اختر الخيار الأقوى:',
        options: [
          QuizOption('123456', false),
          QuizOption('password', false),
          QuizOption('قهوة-قمر-كتاب-2026!', true),
        ],
        correctAnswerIndex: 2,
      ),
      LessonStep(
        level: 3,
        type: 'reading',
        title: 'حسّن كلمة المرور',
        content: 'قم بتحويل كلمة مرور بسيطة إلى واحدة قوية باستخدام القواعد المقترحة',
      ),
    ],
    isLocked: true,
  ),
  Lesson(
    id: 'l3',
    title: 'التصيد الإلكتروني',
    description: 'تعلّم كيفية اكتشاف الرسائل والروابط الاحتيالية',
    xpReward: 100,
    levelRequired: 3,
    icon: '🎣',
    color: Colors.red,
    steps: [
      LessonStep(
        level: 1,
        type: 'reading',
        title: 'حلل الرابط (مستوى 1)',
        content: 'استخدم أداة كشف الروابط الضارة لفحص روابط حقيقية',
      ),
      LessonStep(
        level: 2,
        type: 'quiz',
        title: 'كيف تتجنب التصيد؟ (مستوى 2)',
        content: 'اختر أفضل ممارسة:',
        options: [
          QuizOption('النقر على كل روابط البريد', false),
          QuizOption('التحقق من عنوان الموقع قبل الإدخال', true),
          QuizOption('مشاركة كلمة المرور مع الأصدقاء', false),
        ],
        correctAnswerIndex: 1,
      ),
      LessonStep(
        level: 3,
        type: 'reading',
        title: 'التعرف على رسائل تصيّد',
        content: 'تحليل رسالة بريد والإشارة للعناصر المشبوهة (تحدي مستوى 3)',
      ),
    ],
    isLocked: true,
  ),
  Lesson(
    id: 'l4',
    title: 'حماية الأطفال',
    description: 'أدوات ونصائح لحماية أطفالك في العالم الرقمي',
    xpReward: 120,
    levelRequired: 4,
    icon: '👶',
    color: Colors.orange,
    steps: [
      LessonStep(
        level: 1,
        type: 'reading',
        title: 'مخاطر الإنترنت على الأطفال',
        content: 'التعرض لمحتوى غير مناسب، التنمر الإلكتروني، والتواصل مع الغرباء هم أبرز المخاطر التي تواجه الأطفال على الإنترنت.',
      ),
      LessonStep(
        level: 2,
        type: 'quiz',
        title: 'ما هي أفضل أداة للرقابة الأبوية؟',
        content: 'اختر الإجابة الصحيحة:',
        options: [
          QuizOption('Google Family Link', true),
          QuizOption('تطبيق الألعاب', false),
          QuizOption('متصفح الإنترنت العادي', false),
        ],
        correctAnswerIndex: 0,
      ),
      LessonStep(
        level: 3,
        type: 'reading',
        title: 'إعداد أدوات الرقابة',
        content: 'تطبيق عملي لإعداد الرقابة الأبوية على جهاز حقيقي أو افتراضي',
      ),
    ],
    isLocked: true,
  ),
];

// ================= مسار التعلم التفاعلي (واجهة الدروس) - تم التعديل =================
class CyberLearningPathPage extends StatefulWidget {
  const CyberLearningPathPage({super.key});
  
  @override
  State<CyberLearningPathPage> createState() => _CyberLearningPathPageState();
}

class _CyberLearningPathPageState extends State<CyberLearningPathPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final UserProgress progress = UserProgress();
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
    _controller.forward();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'مسار التعلم التفاعلي',
          textDirection: TextDirection.rtl,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProgressDashboard(progress: progress),
                ),
              );
            },
            tooltip: 'لوحة التقدم',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3A5F), Color(0xFF0F1B33)],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0), // ✅ تقليل padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // ✅ كامل العرض
              children: [
                // معلومات المستخدم والـ XP
                ScaleTransition(
                  scale: _animation,
                  child: Container(
                    padding: const EdgeInsets.all(12), // ✅ تقليل الحجم
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A365D).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF4ECDC4),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // ✅ النص من اليمين
                              children: [
                                Text(
                                  'المستوى ${progress.level}',
                                  style: const TextStyle(
                                    fontSize: 18, // ✅ تقليل الحجم
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4ECDC4),
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${progress.xp} / ${progress.xpForNextLevel()} XP',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(8), // ✅ تقليل الحجم
                              decoration: BoxDecoration(
                                color: const Color(0xFF4ECDC4).withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.security,
                                color: Color(0xFF4ECDC4),
                                size: 24, // ✅ تقليل الحجم
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        XPProgressBar(progress: progress.progressToNextLevel()),
                        const SizedBox(height: 8),
                        StreakTracker(streakDays: progress.streakDays),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // العنوان
                Text(
                  'الدروس المتاحة',
                  style: Theme.of(context).textTheme.titleMedium,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center, // ✅ النص في الوسط
                ),
                const SizedBox(height: 8),
                // قائمة الدروس
                ...learningPath.map((lesson) {
                  final isUnlocked = progress.isLessonUnlocked(lesson);
                  final isCompleted = progress.isLessonCompleted(lesson.id);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4), // ✅ تقليل المسافة
                    child: _buildLessonCard(
                      lesson,
                      isUnlocked,
                      isCompleted,
                      () {
                        if (isUnlocked) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LessonScreen(
                                lesson: lesson,
                                onComplete: () {
                                  progress.completeLesson(lesson.id, lesson.xpReward);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.star, color: Colors.yellow),
                                          const SizedBox(width: 8),
                                          Text(
                                            'حصلت على ${lesson.xpReward} XP! 🎉',
                                            style: const TextStyle(color: Colors.white),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ],
                                      ),
                                      backgroundColor: const Color(0xFF1A365D),
                                    ),
                                  );
                                  setState(() {});
                                },
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'أكمل الدرس السابق لفتح هذا الدرس!',
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Color(0xFF1A365D),
                            ),
                          );
                        }
                      },
                    ),
                  );
                }).toList(),
                const SizedBox(height: 24),
                // رسالة تحفيزية
                Container(
                  padding: const EdgeInsets.all(12), // ✅ تقليل الحجم
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A365D).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF4ECDC4).withOpacity(0.7),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '💡 تلميح:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF4ECDC4),
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'استمر يومياً للحفاظ على سلسلة التعلم (Streak) واحصل على مكافآت إضافية! كل 7 أيام تحصل على 50 XP إضافية.',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  // ✅ تم تعديل المربعات لتكون أصغر والنص في الوسط
  Widget _buildLessonCard(
    Lesson lesson,
    bool isUnlocked,
    bool isCompleted,
    VoidCallback onTap,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: isCompleted
            ? Colors.green.withOpacity(0.15)
            : isUnlocked
                ? Colors.white.withOpacity(0.08)
                : Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12), // ✅ تقليل نصف القطر
        border: Border.all(
          color: isCompleted
              ? Colors.green
              : isUnlocked
                  ? lesson.color.withOpacity(0.6)
                  : Colors.grey,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: lesson.color.withOpacity(0.2),
            blurRadius: 6, // ✅ تقليل الظل
            offset: const Offset(0, 3), // ✅ تقليل الظل
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isUnlocked ? onTap : null,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(10), // ✅ تقليل padding
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6), // ✅ تقليل الحجم
                  decoration: BoxDecoration(
                    color: lesson.color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    lesson.icon,
                    style: const TextStyle(fontSize: 20), // ✅ تقليل الحجم
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center, // ✅ النص في الوسط
                    children: [
                      Text(
                        lesson.title,
                        style: TextStyle(
                          fontSize: 15, // ✅ تقليل الحجم
                          fontWeight: FontWeight.bold,
                          color: isCompleted ? Colors.green : lesson.color,
                        ),
                        textAlign: TextAlign.center, // ✅ النص في الوسط
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        lesson.description,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11, // ✅ تقليل الحجم
                        ),
                        textAlign: TextAlign.center, // ✅ النص في الوسط
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                if (isCompleted)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3), // ✅ تقليل الحجم
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.check_circle, size: 12, color: Colors.green),
                        SizedBox(width: 4),
                        Text(
                          'مكتمل',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3), // ✅ تقليل الحجم
                    decoration: BoxDecoration(
                      color: lesson.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '+${lesson.xpReward} XP',
                      style: TextStyle(
                        color: lesson.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= شاشة الدرس التفاعلي - تم التعديل =================
class LessonScreen extends StatefulWidget {
  final Lesson lesson;
  final VoidCallback onComplete;
  
  const LessonScreen({
    super.key,
    required this.lesson,
    required this.onComplete,
  });
  
  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int _currentStepIndex = 0;
  int _selectedOption = -1;
  bool _isAnswerCorrect = false;
  bool _isStepCompleted = false;
  
  @override
  Widget build(BuildContext context) {
    final step = widget.lesson.steps[_currentStepIndex];
    return Scaffold(
      backgroundColor: const Color(0xFF0F1B33),
      appBar: AppBar(
        title: Text(
          'الدرس: ${widget.lesson.title} - مستوى ${step.level}',
          textDirection: TextDirection.rtl,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(Icons.star, color: Color(0xFF4ECDC4), size: 18),
                const SizedBox(width: 4),
                Text(
                  '${widget.lesson.xpReward} XP',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // شريط التقدم
          Container(
            height: 6,
            color: Colors.white10,
            child: FractionallySizedBox(
              widthFactor: (_currentStepIndex + 1) / widget.lesson.steps.length,
              child: Container(
                color: widget.lesson.color,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // محتوى الدرس
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildStepContent(step),
            ),
          ),
          // أزرار التحكم
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildActionButtons(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStepContent(LessonStep step) {
    if (step.type == 'reading') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            step.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4ECDC4),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          Text(
            step.content,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
        ],
      );
    } else if (step.type == 'quiz') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            step.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4ECDC4),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          Text(
            step.content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 24),
          ...List.generate(
            step.options?.length ?? 0,
            (index) => _buildQuizOption(step.options![index], index),
          ),
        ],
      );
    } else {
      return const Center(
        child: Text(
          'محتوى قادم قريبًا...',
          style: TextStyle(color: Colors.white, fontSize: 18),
          textDirection: TextDirection.rtl,
        ),
      );
    }
  }
  
  Widget _buildQuizOption(QuizOption option, int index) {
    final isSelected = _selectedOption == index;
    final isCorrect = option.isCorrect;
    Color? bgColor;
    if (_isStepCompleted) {
      bgColor = isCorrect ? Colors.green : (isSelected ? Colors.red : null);
    } else {
      bgColor = isSelected ? widget.lesson.color.withOpacity(0.3) : null;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: bgColor ?? Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? widget.lesson.color : Colors.white.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: !_isStepCompleted
                ? () {
                    setState(() {
                      _selectedOption = index;
                      _isAnswerCorrect = option.isCorrect;
                      _isStepCompleted = true;
                    });
                  }
                : null,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  if (_isStepCompleted)
                    Icon(
                      isCorrect ? Icons.check_circle : (isSelected ? Icons.cancel : Icons.circle),
                      color: isCorrect ? Colors.green : Colors.red,
                      size: 18,
                    )
                  else
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: widget.lesson.color.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: widget.lesson.color,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      option.text,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildActionButtons() {
    return Column(
      children: [
        if (_isStepCompleted && widget.lesson.steps.length > 1)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              '✓ أكملت المستوى ${_currentStepIndex + 1} من ${widget.lesson.steps.length}',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
          ),
        Row(
          children: [
            if (_currentStepIndex > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _currentStepIndex--;
                      _selectedOption = -1;
                      _isAnswerCorrect = false;
                      _isStepCompleted = false;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white30),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'السابق',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              )
            else
              const Expanded(child: SizedBox()),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: _canProceed()
                    ? () {
                        if (_currentStepIndex == widget.lesson.steps.length - 1) {
                          widget.onComplete();
                          Navigator.pop(context);
                        } else {
                          setState(() {
                            _currentStepIndex++;
                            _selectedOption = -1;
                            _isAnswerCorrect = false;
                            _isStepCompleted = false;
                          });
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _canProceed() ? widget.lesson.color : Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  _currentStepIndex == widget.lesson.steps.length - 1
                      ? 'إنهاء الدرس'
                      : 'التالي',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  bool _canProceed() {
    final step = widget.lesson.steps[_currentStepIndex];
    if (step.type == 'reading') return true;
    if (step.type == 'quiz') return _isStepCompleted;
    return true;
  }
}

// ================= لوحة التقدم - تم التعديل =================
class ProgressDashboard extends StatelessWidget {
  final UserProgress progress;
  const ProgressDashboard({super.key, required this.progress});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة التقدم', textDirection: TextDirection.rtl),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3A5F), Color(0xFF0F1B33)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ملخص التقدم
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A365D).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'مستوى ${progress.level}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4ECDC4),
                      ),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'إجمالي الـ XP: ${((progress.level - 1) * progress.xpForNextLevel()) + progress.xp}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem(
                          Icons.favorite,
                          Colors.red,
                          '${progress.hearts}/5',
                          'قلوب',
                        ),
                        _buildStatItem(
                          Icons.calendar_today,
                          Colors.orange,
                          '${progress.streakDays} يوم',
                          'سلسلة',
                        ),
                        _buildStatItem(
                          Icons.school,
                          Colors.purple,
                          '${progress.completedLessons.length}/${learningPath.length}',
                          'دروس',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // الإحصائيات
              Text(
                'إحصائيات التعلم',
                style: Theme.of(context).textTheme.titleMedium,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              _buildStatCard('أعلى سلسلة', '12 يوم', Icons.emoji_events, Colors.yellow),
              const SizedBox(height: 8),
              _buildStatCard('أفضل درس', 'كلمات المرور', Icons.verified, Colors.green),
              const SizedBox(height: 8),
              _buildStatCard('الوقت المستغرق', '47 دقيقة', Icons.timer, Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildStatItem(IconData icon, Color color, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textDirection: TextDirection.rtl,
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
  
  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
        ],
      ),
    );
  }
}

// ================= شريط التقدم - تم التعديل =================
class XPProgressBar extends StatelessWidget {
  final double progress;
  const XPProgressBar({super.key, required this.progress});
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              width: constraints.maxWidth,
              height: 6, // ✅ تقليل الارتفاع
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              width: constraints.maxWidth * progress.clamp(0.0, 1.0),
              height: 6,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4ECDC4), Color(0xFF6C5CE7)],
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ================= متتبع السلسلة - تم التعديل =================
class StreakTracker extends StatelessWidget {
  final int streakDays;
  const StreakTracker({super.key, required this.streakDays});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '🔥 سلسلة التعلم: $streakDays يوم',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
              textDirection: TextDirection.rtl,
            ),
            if (streakDays >= 7)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.yellow.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '+50 XP',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 6,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: streakDays > 14 ? 14 : streakDays,
            itemBuilder: (context, index) {
              final day = streakDays - index;
              return Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Container(
                  width: 22, // ✅ تقليل العرض
                  height: 6,
                  decoration: BoxDecoration(
                    color: _getStreakColor(day),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  
  Color _getStreakColor(int day) {
    if (day <= 3) return Colors.grey;
    if (day <= 7) return Colors.green;
    if (day <= 14) return Colors.blue;
    return Colors.purple;
  }
}












// ================= التطبيق العملي المتقدم =================
class PracticePage extends StatelessWidget {
  const PracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: Color(0xFF0F1626),
        appBar: AppBar(
          title: const Text('التطبيق العملي المتقدم'),
          backgroundColor: Color(0xFF122235),
          elevation: 2,
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Color(0xFF4ECDC4),
            tabs: [
              Tab(icon: Icon(Icons.lock), text: 'كلمات المرور'),
              Tab(icon: Icon(Icons.link), text: 'تحليل الروابط'),
              Tab(icon: Icon(Icons.book), text: 'الموسوعة'),
              Tab(icon: Icon(Icons.style), text: 'البطاقات'),
              Tab(icon: Icon(Icons.question_answer), text: 'الأسئلة'),
              Tab(icon: Icon(Icons.videogame_asset), text: 'اللعبة'),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F1626), Color(0xFF061022)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const TabBarView(
            children: [
              Padding(padding: EdgeInsets.all(12), child: PasswordCheckerPro()),
              Padding(padding: EdgeInsets.all(12), child: PhishingDetector()),
              Padding(padding: EdgeInsets.all(12), child: GlossaryList()),
              Padding(padding: EdgeInsets.all(12), child: FlashcardsSection()),
              Padding(padding: EdgeInsets.all(12), child: FAQBot()),
              Padding(padding: EdgeInsets.all(12), child: SecurityGame()),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= فحص كلمة المرور المتقدم =================
class PasswordCheckerPro extends StatefulWidget {
  const PasswordCheckerPro({super.key});

  @override
  _PasswordCheckerProState createState() => _PasswordCheckerProState();
}

class _PasswordCheckerProState extends State<PasswordCheckerPro> {
  final TextEditingController _controller = TextEditingController();
  bool _isPasswordVisible = false;
  String _strength = 'ضعيفة';
  Color _strengthColor = Colors.red;
  double _strengthBar = 0.0;
  String _comparison = '';
  List<Map<String, dynamic>> _criteria = [
    {'text': 'على الأقل 8 أحرف', 'met': false, 'weight': 1},
    {'text': 'حرف كبير (A-Z)', 'met': false, 'weight': 1},
    {'text': 'حرف صغير (a-z)', 'met': false, 'weight': 1},
    {'text': 'رقم (0-9)', 'met': false, 'weight': 1},
    {'text': 'رمز (!@#\$%)', 'met': false, 'weight': 2},
  ];

  void _checkPassword() {
    String password = _controller.text;
    int score = 0;
    if (password.isEmpty) {
      _resetState();
      if (mounted) setState(() {});
      return;
    }
    _criteria[0]['met'] = password.length >= 8;
    _criteria[1]['met'] = RegExp(r'[A-Z]').hasMatch(password);
    _criteria[2]['met'] = RegExp(r'[a-z]').hasMatch(password);
    _criteria[3]['met'] = RegExp(r'[0-9]').hasMatch(password);
    _criteria[4]['met'] = RegExp(
            r'''[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:\'",<>\.\?\/\\|]''')
        .hasMatch(password);
    for (var criterion in _criteria) {
      if (criterion['met']) {
        score += criterion['weight'] as int;
      }
    }
    if (score <= 3) {
      _strength = 'ضعيفة';
      _strengthColor = Colors.red;
      _strengthBar = 0.3;
    } else if (score <= 5) {
      _strength = 'متوسطة';
      _strengthColor = Colors.orange;
      _strengthBar = 0.6;
    } else {
      _strength = 'قوية';
      _strengthColor = Colors.green;
      _strengthBar = 1.0;
    }
    _compareWithCommonPasswords(password);
    if (mounted) {
      setState(() {});
    }
  }

  void _resetState() {
    _strength = 'ضعيفة';
    _strengthColor = Colors.red;
    _strengthBar = 0.0;
    _comparison = '';
    for (var criterion in _criteria) {
      criterion['met'] = false;
    }
  }

  void _compareWithCommonPasswords(String password) {
    List<String> commonPasswords = [
      '123456',
      'password',
      '123456789',
      '12345678',
      '12345',
      '1234567',
      'qwerty',
      'abc123',
      'password1',
      '111111',
      '1234567890',
      'iloveyou'
    ];
    if (commonPasswords.contains(password.toLowerCase())) {
      _comparison = '⚠️ هذه كلمة مرور شائعة جدًا وسهلة الاختراق!';
    } else if (password.length < 8) {
      _comparison =
          '⚠️ كلمة المرور قصيرة جدًا — يُنصح باستخدام 12 حرفًا فأكثر.';
    } else {
      _comparison = '✅ كلمة المرور غير شائعة — هذا جيد للأمان.';
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_checkPassword);
  }

  @override
  void dispose() {
    _controller.removeListener(_checkPassword);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.1),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              '🔐 فحص كلمة المرور المتقدم',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4ECDC4),
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Colors.white.withOpacity(0.3), width: 1),
              ),
              child: TextField(
                controller: _controller,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                obscureText: !_isPasswordVisible,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'أدخل كلمة المرور',
                  hintStyle: const TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      if (mounted) {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'قوة كلمة المرور: $_strength',
                  style: TextStyle(
                    color: _strengthColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: _strengthBar,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _strengthColor == Colors.red
                            ? Colors.red.shade800
                            : _strengthColor == Colors.orange
                                ? Colors.orange.shade800
                                : Colors.green.shade800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_comparison.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _comparison.contains('⚠️')
                      ? Colors.red.withOpacity(0.2)
                      : Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _comparison.contains('⚠️')
                        ? Colors.red
                        : Colors.green,
                    width: 1,
                  ),
                ),
                child: Text(
                  _comparison,
                  style: TextStyle(
                    color: _comparison.contains('⚠️')
                        ? Colors.red
                        : Colors.green,
                    fontSize: 14,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            const SizedBox(height: 20),
            if (_controller.text.isNotEmpty) ...[
              const Text(
                'الشروط المطلوبة:',
                style: TextStyle(
                  color: Color(0xFF4ECDC4),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 12),
              ..._criteria.map((criterion) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Icon(
                        criterion['met']!
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: criterion['met']!
                            ? Colors.green
                            : Colors.red,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          criterion['text']!,
                          style: TextStyle(
                            color: criterion['met']!
                                ? Colors.white
                                : Colors.white70,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: 20),
            ],
            if (_controller.text.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _strengthColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: _strengthColor.withOpacity(0.5), width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _strength == 'قوية'
                          ? '✅ ممتاز! هذه كلمة مرور قوية وآمنة.'
                          : _strength == 'متوسطة'
                              ? '💡 جيدة، لكن يمكن تحسينها بإضافة رمز أو رقم.'
                              : '⚠️ ضعيفة! يُنصح بتغييرها لتجنب الاختراق.',
                      style: TextStyle(
                        color: _strengthColor,
                        fontSize: 14,
                        height: 1.6,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8),
                    if (_strength != 'قوية')
                      const Text(
                        '💡 نصيحة: استخدم 12 حرفًا فأكثر، مع مزيج من الأحرف الكبيرة والصغيرة والأرقام والرموز.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.right,
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ================= كشف الروابط الضارة =================
class PhishingDetector extends StatefulWidget {
  const PhishingDetector({super.key});

  @override
  _PhishingDetectorState createState() => _PhishingDetectorState();
}

class _PhishingDetectorState extends State<PhishingDetector> {
  final TextEditingController _urlController = TextEditingController();
  String _result = '';
  Color _resultColor = Colors.white70;
  bool _isLoading = false;

  void _analyzeLink() {
    String url = _urlController.text.trim();
    if (url.isEmpty) {
      _showResult('يرجى إدخال رابط للتحليل.', Colors.orange);
      return;
    }
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    setState(() {
      _isLoading = true;
      _result = '';
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      bool isSafe = true;
      List<String> warnings = [];
      if (!url.startsWith('https://')) {
        isSafe = false;
        warnings.add('• لا يستخدم تشفير HTTPS الآمن.');
      }
      String? host;
      try {
        Uri uri = Uri.parse(url);
        host = uri.host;
      } catch (e) {
        setState(() {
          _isLoading = false;
          _result =
              'رابط غير صالح. تأكد من صيغته (مثال: https://example.com)';
          _resultColor = Colors.red;
        });
        return;
      }
      final ipRegex = RegExp(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$');
      if (ipRegex.hasMatch(host!)) {
        isSafe = false;
        warnings.add(
            '• يستخدم عنوان IP مباشر بدلاً من اسم نطاق (Domain)، وهذا غير معتاد وقد يكون خطيرًا.');
      }
      List<String> suspiciousWords = [
        'login',
        'secure',
        'verify',
        'account',
        'update',
        'free',
        'win',
        'prize',
        'gift'
      ];
      String urlLower = url.toLowerCase();
      for (String word in suspiciousWords) {
        if (urlLower.contains(word) && !host.contains(word)) {
          warnings.add('• يحتوي على كلمة مشبوهة: "$word".');
        }
      }
      if (isSafe && warnings.isEmpty) {
        _showResult('✅ الرابط آمن للاستخدام.', Colors.green);
      } else if (isSafe) {
        _showResult(
            '⚠️ الرابط يستخدم HTTPS، لكن:\n${warnings.join('\n')}',
            Colors.orange);
      } else {
        _showResult(
            '🚨 الرابط قد يكون خطيرًا للأسباب التالية:\n${warnings.join('\n')}',
            Colors.red);
      }
    });
  }

  void _showResult(String message, Color color) {
    if (!mounted) return;
    setState(() {
      _result = message;
      _resultColor = color;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.1),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              '🔍 كشف الروابط الضارة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4ECDC4),
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 16),
            const Text(
              'أدخل أي رابط (URL) وسأحلله لك فورًا لتحديد مدى أمانه.',
              style: TextStyle(fontSize: 14, color: Colors.white70),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _urlController,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                hintText: 'https://example.com',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                suffixIcon: _urlController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white54),
                        onPressed: () => _urlController.clear(),
                      )
                    : null,
              ),
              onSubmitted: (_) => _analyzeLink(),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _analyzeLink,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4ECDC4),
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.black),
                    )
                  : const Icon(Icons.search),
              label: Text(
                _isLoading ? 'جاري التحليل...' : 'تحليل الرابط',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            if (_result.isNotEmpty)
              AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: 1.0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _resultColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _resultColor, width: 1.5),
                  ),
                  child: Text(
                    _result,
                    style: TextStyle(
                      fontSize: 15,
                      color: _resultColor,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ================= موسوعة الأمن =================
class GlossaryList extends StatelessWidget {
  const GlossaryList({super.key});

  static const List<Map<String, String>> terms = [
    {
      'term': 'Phishing',
      'meaning': 'التصيد: محاولة خداعك لسرقة بياناتك عبر روابط أو رسائل تبدو رسمية.'
    },
    {
      'term': 'Malware',
      'meaning': 'برامج خبيثة: برمجيات تضر بجهازك، مثل الفيروسات أو برامج التجسس.'
    },
    {
      'term': 'Firewall',
      'meaning': 'جدار الحماية: نظام يمنع الوصول غير المصرح به إلى جهازك.'
    },
    {
      'term': '2FA',
      'meaning': 'المصادقة الثنائية: طبقة أمان إضافية تتطلب شيئين للدخول (كلمة مرور + هاتف).'
    },
    {
      'term': 'VPN',
      'meaning': 'شبكة افتراضية خاصة: تحمي اتصالك بالإنترنت من المراقبة.'
    },
    {
      'term': 'Encryption',
      'meaning': 'التشفير: تحويل البيانات إلى شكل غير قابل للقراءة من قبل الغرباء.'
    },
    {
      'term': 'Ransomware',
      'meaning': 'برمجية فدية: تُشفّر ملفاتك وتطلب فدية لاستعادتها.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: terms.length,
      separatorBuilder: (_, __) =>
          const Divider(color: Colors.grey, indent: 20, endIndent: 20),
      itemBuilder: (context, index) {
        final term = terms[index];
        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Text(
            term['term']!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF4ECDC4),
              fontSize: 16,
            ),
            textAlign: TextAlign.right,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              term['meaning']!,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
              textAlign: TextAlign.right,
            ),
          ),
        );
      },
    );
  }
}

// ================= البطاقات التفاعلية =================
class FlashcardsSection extends StatefulWidget {
  const FlashcardsSection({super.key});

  @override
  _FlashcardsSectionState createState() => _FlashcardsSectionState();
}

class _FlashcardsSectionState extends State<FlashcardsSection>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isFront = true; // true = السؤال، false = الإجابة
  final List<Map<String, String>> flashcards = [
    {
      'question': 'ما هو التصيد الإلكتروني؟',
      'answer': 'محاولة خداعك لسرقة بياناتك عبر روابط أو رسائل تبدو رسمية.',
    },
    {
      'question': 'لماذا نفعل المصادقة الثنائية؟',
      'answer': 'لإضافة طبقة حماية إضافية، حتى لو عرف أحد كلمة المرور.',
    },
    {
      'question': 'كيف نحمي بطاقة الدفع؟',
      'answer': 'بعدم كتابة بياناتها على مواقع غير موثوقة، واستخدام بطاقة افتراضية.',
    },
    {
      'question': 'ماذا نفعل إذا تعرضنا لابتزاز إلكتروني؟',
      'answer': 'لا ندفع، نحفظ الأدلة، ونبلغ الجهات المختصة فوراً.',
    },
  ];

  void _flipCard() {
    setState(() {
      _isFront = !_isFront;
    });
  }

  void _nextCard() {
    if (_currentIndex < flashcards.length - 1) {
      setState(() {
        _currentIndex++;
        _isFront = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🎉 أكملت جميع البطاقات!'),
          backgroundColor: Color(0xFF4ECDC4),
          duration: Duration(seconds: 2),
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _currentIndex = 0;
          _isFront = true;
        });
      });
    }
  }

  void _previousCard() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _isFront = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentCard = flashcards[_currentIndex];
    return Card(
      color: Colors.white.withOpacity(0.1),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              '🃏 البطاقات التفاعلية',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4ECDC4),
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFF1E3A5F).withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFF4ECDC4), width: 1),
              ),
              child: Text(
                'البطاقة ${_currentIndex + 1} من ${flashcards.length}',
                style: const TextStyle(
                  color: Color(0xFF4ECDC4),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1A365D), Color(0xFF2C5282)],
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  )
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
                      );
                    },
                    child: _isFront
                        ? _buildCardFace(
                            key: const ValueKey('front'),
                            text: currentCard['question']!,
                            icon: Icons.help_outline,
                            bgColor: Color(0xFF1E3A5F),
                          )
                        : const SizedBox.shrink(),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
                      );
                    },
                    child: !_isFront
                        ? _buildCardFace(
                            key: const ValueKey('back'),
                            text: currentCard['answer']!,
                            icon: Icons.check_circle,
                            bgColor: Color(0xFF4ECDC4),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: _flipCard,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                      color: Colors.white.withOpacity(0.3), width: 1),
                ),
                child: Text(
                  _isFront ? 'أظهر الإجابة' : 'أظهر السؤال',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _currentIndex > 0 ? _previousCard : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade700,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  icon: const Icon(Icons.arrow_back_ios_new, size: 16),
                  label: const Text(
                    'السابق',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _nextCard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4ECDC4),
                    foregroundColor: Colors.black,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  icon: Icon(_currentIndex < flashcards.length - 1
                      ? Icons.arrow_forward_ios
                      : Icons.refresh),
                  label: Text(
                    _currentIndex < flashcards.length - 1
                        ? 'التالي'
                        : 'إعادة',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'انقر على البطاقة أو الزر أدناه لتبديل الوجه',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardFace({
    required Key key,
    required String text,
    required IconData icon,
    required Color bgColor,
  }) {
    return Container(
      key: key,
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            icon,
            size: 36,
            color: Colors.white,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                height: 1.6,
              ),
              textAlign: TextAlign.right,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}

// ================= الأسئلة السريعة =================
class FAQBot extends StatefulWidget {
  const FAQBot({super.key});

  @override
  _FAQBotState createState() => _FAQBotState();
}

class _FAQBotState extends State<FAQBot> {
  String _answer = '';
  final Map<String, String> faq = {
    'بريد':
        'لتحمي بريدك: استخدم كلمة مرور قوية، فعل 2FA، ولا تفتح روابط مشبوهة.',
    'حساب':
        'استخدم كلمة مرور قوية، فعل 2FA، ولا تشارك بياناتك مع أحد.',
    'دفع':
        'لا تكتب بيانات بطاقة الدفع على مواقع غير موثوقة. تأكد من أن الموقع يبدأ بـ https://.',
    'طفل':
        'استخدم أدوات الرقابة الأبوية، حدّد وقت الشاشة، وعلّمه ألا يتحدث مع غرباء.',
    'روابط': 'لا تنقر على روابط من جهات مجهولة. قد تكون تصيداً إلكترونياً.',
    'سرقة': 'لتجنب السرقة: لا تستخدم كلمات مرور بسيطة، ولا تفتح روابط غريبة.',
    'تحديث':
        'حدّث تطبيقاتك وهاتفك باستمرار. التحديثات تصلح الثغرات الأمنية.',
    'خصوصية':
        'اجعل حساباتك خاصة، ولا تشارك معلوماتك الشخصية على الإنترنت.',
  };

  void _ask(String q) {
    if (mounted) {
      setState(() {
        _answer = faq[q] ?? 'عذراً، لا أملك إجابة حالياً.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.1),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              '❓ الأسئلة السريعة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4ECDC4),
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.end,
              spacing: 12,
              runSpacing: 12,
              children: [
                for (String q in [
                  'بريد',
                  'حساب',
                  'دفع',
                  'طفل',
                  'روابط',
                  'سرقة',
                  'تحديث',
                  'خصوصية'
                ])
                  InkWell(
                    onTap: () => _ask(q),
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF1A365D),
                            Color(0xFF2C5282),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: Color(0xFF4ECDC4).withOpacity(0.5),
                            width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF4ECDC4).withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Text(
                        q,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            if (_answer.isNotEmpty)
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: 1.0,
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xFF4ECDC4), width: 2),
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      const Icon(Icons.check_circle,
                          color: Color(0xFF4ECDC4), size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _answer,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.7,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.right,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ================= لعبة الحماية الرقمية =================
class SecurityGame extends StatefulWidget {
  const SecurityGame({super.key});

  @override
  _SecurityGameState createState() => _SecurityGameState();
}

class _SecurityGameState extends State<SecurityGame>
    with SingleTickerProviderStateMixin {
  int _score = 0;
  int _questionIndex = 0;
  bool _answerSubmitted = false;
  String _selectedOption = '';
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'هل من الآمن استخدام كلمة المرور "123456"؟',
      'options': ['نعم', 'لا'],
      'correct': 1,
    },
    {
      'question': 'ماذا تفعل إذا وصلتك رسالة تقول "لقد ربحت سيارة!"؟',
      'options': ['أنقر على الرابط', 'احذف الرسالة'],
      'correct': 1,
    },
    {
      'question': 'هل يُسمح لطفلك باستخدام جهازك دون رقابة؟',
      'options': ['نعم', 'لا'],
      'correct': 1,
    },
    {
      'question': 'ما أفضل طريقة لحماية بريدك الإلكتروني؟',
      'options': ['استخدام اسمك فقط', 'تفعيل المصادقة الثنائية (2FA)'],
      'correct': 1,
    },
    {
      'question': 'ما الفرق بين "https://" و "http://"?',
      'options': ['لا فرق', 'https:// يعني أن الموقع آمن'],
      'correct': 1,
    },
  ];

  void _checkAnswer(String option, int selectedIndex) {
    if (_answerSubmitted) return;
    if (mounted) {
      setState(() {
        _selectedOption = option;
        _answerSubmitted = true;
      });
    }
    final correctIndex = questions[_questionIndex]['correct'];
    final isCorrect = selectedIndex == correctIndex;
    if (isCorrect) {
      _score++;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text('إجابة صحيحة! ✅'),
            ],
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.cancel, color: Colors.white),
              SizedBox(width: 10),
              Text('إجابة خاطئة! ❌'),
            ],
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      if (_questionIndex < questions.length - 1) {
        if (mounted) {
          setState(() {
            _questionIndex++;
            _selectedOption = '';
            _answerSubmitted = false;
          });
        }
      } else {
        if (mounted) {
          _showResultDialog();
        }
      }
    });
  }

  void _showResultDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Color(0xFF1E3A5F),
        title: const Text(
          '🎉 انتهت اللعبة!',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xFF4ECDC4),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.stars, size: 50, color: Colors.yellow),
            const SizedBox(height: 16),
            Text(
              'درجتك: $_score من ${questions.length}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildScoreMessage(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (mounted) {
                setState(() {
                  _score = 0;
                  _questionIndex = 0;
                  _selectedOption = '';
                  _answerSubmitted = false;
                });
              }
            },
            style: TextButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              backgroundColor: Color(0xFF4ECDC4),
            ),
            child: const Text(
              'إعادة اللعب 🔄',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreMessage() {
    if (_score == questions.length) {
      return const Text(
        'ممتاز! أنت خبير في الأمن السيبراني! 🏆',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.green, fontSize: 16),
      );
    } else if (_score >= questions.length * 0.7) {
      return const Text(
        'ممتاز! لديك معرفة قوية بالأمن الرقمي. 👏',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16),
      );
    } else {
      return const Text(
        'جيد! استمر في التعلم وستصبح خبيرًا. 💡',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.orange, fontSize: 16),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[_questionIndex];
    final correctIndex = q['correct'];
    return Card(
      color: Colors.white.withOpacity(0.1),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFF4ECDC4).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFF4ECDC4), width: 1.5),
              ),
              child: Text(
                'السؤال ${_questionIndex + 1} من ${questions.length}',
                style: const TextStyle(
                  color: Color(0xFF4ECDC4),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Text(
              q['question'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.6,
              ),
              textAlign: TextAlign.right,
              softWrap: true,
            ),
            const SizedBox(height: 20),
            ...List.generate(q['options'].length, (i) {
              final option = q['options'][i];
              final isCorrect = i == correctIndex;
              final isSelected = _selectedOption == option;
              Color? buttonColor;
              if (!_answerSubmitted) {
                buttonColor = Color(0xFF1E3A5F);
              } else {
                if (isSelected) {
                  buttonColor = isCorrect ? Colors.green : Colors.red;
                } else {
                  buttonColor =
                      isCorrect ? Colors.green.withOpacity(0.3) : null;
                }
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  onPressed: _answerSubmitted
                      ? null
                      : () => _checkAnswer(option, i),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                    side: BorderSide(
                      color: isSelected
                          ? Colors.white
                          : buttonColor == Color(0xFF1E3A5F)
                              ? Colors.white24
                              : Colors.transparent,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        option,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                      if (_answerSubmitted)
                        Icon(
                          isCorrect ? Icons.check_circle : Icons.cancel,
                          color: isCorrect ? Colors.white : Colors.white,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ================= نماذج الهجوم =================
class SimpleAttack {
  final String title;
  final String icon;
  final Color color;
  final List<SimpleStep> steps;
  final String tip;

  const SimpleAttack({
    required this.title,
    required this.icon,
    required this.color,
    required this.steps,
    required this.tip,
  });
}

class SimpleStep {
  final String illustration;
  final String description;

  const SimpleStep({
    required this.illustration,
    required this.description,
  });
}

// ================= مختبر محاكاة الهجمات =================
class AttackSimulatorLab extends StatefulWidget {
  const AttackSimulatorLab({Key? key}) : super(key: key);

  @override
  State<AttackSimulatorLab> createState() => _AttackSimulatorLabState();
}

class _AttackSimulatorLabState extends State<AttackSimulatorLab> {
  int _currentStep = 0;
  SimpleAttack? _selectedAttack;
  final List<SimpleAttack> _attacks = [
    SimpleAttack(
      title: '💥 محاولة تخمين كلمة المرور',
      icon: '🔑',
      color: Color(0xFF4ECDC4),
      tip: '✅ نصيحتنا: استخدم كلمات مرور طويلة وفعّل المصادقة الثنائية.',
      steps: [
        SimpleStep(
          illustration: '🕵️‍♂️',
          description:
              'شخص مجهول يحاول الدخول إلى حسابك عبر تجربة كلمات مرور شائعة مثل "123456" أو "password".',
        ),
        SimpleStep(
          illustration: '🤖',
          description: 'يستخدم برنامجًا يجرب آلاف المحاولات في الدقيقة!',
        ),
        SimpleStep(
          illustration: '🔓',
          description: 'إذا كانت كلمة مرورك ضعيفة... سيتمكن من الدخول!',
        ),
        SimpleStep(
          illustration: '🛡️',
          description:
              'لكن إذا فعّلت "المصادقة الثنائية"، فحتى لو عرف كلمة المرور... لن يدخل!',
        ),
      ],
    ),
    SimpleAttack(
      title: '💉 محاولة سرقة بيانات الموقع',
      icon: '💻',
      color: Color(0xFFE74C3C),
      tip: '✅ نصيحتنا: لا تدخل بياناتك في مواقع مشبوهة وأبلغ الدعم عن الأخطاء.',
      steps: [
        SimpleStep(
          illustration: '🔍',
          description:
              'المخترق يكتب رموزًا غريبة في حقول الموقع (مثل: "admin\' OR \'1\'=\'1").',
        ),
        SimpleStep(
          illustration: '💥',
          description: 'إذا كان الموقع غير محمي، تظهر له جميع بيانات المستخدمين!',
        ),
        SimpleStep(
          illustration: '📁',
          description: 'قد يسرق أسماء المستخدمين، كلمات المرور، وحتى معلومات البطاقات!',
        ),
        SimpleStep(
          illustration: '✅',
          description: 'المواقع الآمنة تمنع هذا الهجوم تلقائيًا.',
        ),
      ],
    ),
    SimpleAttack(
      title: '🌐 محاولة سرقة الجلسة عبر التعليقات',
      icon: '💬',
      color: Color(0xFF2ECC71),
      tip: '✅ نصيحتنا: لا تضغط على روابط غريبة في التعليقات.',
      steps: [
        SimpleStep(
          illustration: '📝',
          description:
              'شخص يكتب تعليقًا يحتوي على كود خفي في موقع غير محمي.',
        ),
        SimpleStep(
          illustration: '👁️',
          description: 'عندما تزور الصفحة، يُنفّذ الكود تلقائيًا في متصفحك!',
        ),
        SimpleStep(
          illustration: '🍪',
          description:
              'يُرسل الكود "ملفات تعريف الارتباط" (cookies) الخاصة بك إلى المخترق.',
        ),
        SimpleStep(
          illustration: '👤',
          description:
              'يستخدمها لتسجيل الدخول كأنه أنت — دون معرفة كلمة المرور!',
        ),
      ],
    ),
  ];

  void _startAttack(SimpleAttack attack) {
    setState(() {
      _selectedAttack = attack;
      _currentStep = 0;
    });
  }

  void _nextStep() {
    if (_currentStep < (_selectedAttack?.steps.length ?? 1) - 1) {
      setState(() => _currentStep++);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _reset() {
    setState(() {
      _selectedAttack = null;
      _currentStep = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFF0F172A),
        appBar: AppBar(
          title: const Text(
            '🛡️ مختبر الأمان البسيط',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          backgroundColor: Color(0xFF1E293B),
          centerTitle: true,
          actions: [
            if (_selectedAttack != null)
              IconButton(
                icon: const Icon(Icons.home, color: Colors.white),
                onPressed: _reset,
                tooltip: 'العودة للقائمة',
              ),
          ],
        ),
        body: _selectedAttack == null
            ? _buildAttackSelection()
            : _buildSimulationView(),
      ),
    );
  }

  Widget _buildAttackSelection() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'اختر سيناريو لتتعلّمه في دقيقة:',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ..._attacks.map((attack) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: _buildAttackCard(attack),
                )),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green, width: 1),
              ),
              child: const Text(
                '✅ كل ما تراه محاكاة بسيطة — لمساعدتك على الفهم، وليس للتخويف.',
                style: TextStyle(color: Colors.green, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttackCard(SimpleAttack attack) {
    return Card(
      color: attack.color.withOpacity(0.12),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: attack.color, width: 1.5),
      ),
      child: InkWell(
        onTap: () => _startAttack(attack),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                attack.icon,
                style: const TextStyle(fontSize: 48),
              ),
              const SizedBox(height: 16),
              Text(
                attack.title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimulationView() {
    final attack = _selectedAttack!;
    final step = attack.steps[_currentStep];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: (_currentStep + 1) / attack.steps.length,
                    backgroundColor: Colors.grey[800],
                    color: attack.color,
                    minHeight: 8,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${_currentStep + 1} / ${attack.steps.length}',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Card(
            color: Color(0xFF1E293B),
            elevation: 6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    step.illustration,
                    style: const TextStyle(fontSize: 64),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    step.description,
                    style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (_currentStep > 0)
                ElevatedButton(
                  onPressed: _prevStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('السابق',
                      style: TextStyle(fontSize: 17)),
                ),
              if (_currentStep == attack.steps.length - 1)
                ElevatedButton(
                  onPressed: _reset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('إنهاء',
                      style: TextStyle(fontSize: 17)),
                )
              else
                ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: attack.color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('التالي',
                      style: TextStyle(fontSize: 17)),
                ),
            ],
          ),
          const SizedBox(height: 25),
          if (_currentStep == attack.steps.length - 1)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue, width: 1.5),
              ),
              child: Column(
                children: [
                  const Text(
                    '✨ نصيحة واقعية يمكنك تطبيقها الآن:',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    attack.tip,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 16, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}












// ================= المساعد الذكي المطور - نسخة مُحسنة للإجابات =================
// مساعدة لتجنب هجمات التعبيرات النمطية
extension RegexEscape on String {
  String escape() {
    return replaceAll(RegExp(r'([.*+?^${}()|[\]\\])'), r'\$1');
  }
}

// هيكل قاعدة المعرفة
class KnowledgeEntry {
  final List<String> keywords;
  final String answer;
  final String category;
  final List<String>? relatedTopics;
  
  KnowledgeEntry({
    required this.keywords,
    required this.answer,
    required this.category,
    this.relatedTopics,
  });
}

class CyberAssistantPage extends StatefulWidget {
  const CyberAssistantPage({super.key});
  
  @override
  State<CyberAssistantPage> createState() => _CyberAssistantPageState();
}

class _CyberAssistantPageState extends State<CyberAssistantPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isThinking = false;
  late List<KnowledgeEntry> _knowledgeBase;
  List<String> _suggestions = [];
  String? _currentCategory;
  
  // تهيئة قاعدة المعرفة الشاملة
  void _initKnowledgeBase() {
    _knowledgeBase = [
      // الأساسيات
      KnowledgeEntry(
        keywords: [
          'ما هو الامن السيبراني',
          'تعريف الامن السيبراني',
          'الامن السيبراني هو',
          'cyber security',
          'ما هو الأمن السيبراني',
          'ماهو الامن السيبراني',
          'مفهوم الامن السيبراني',
          'الامن السراني',
          'ماهو الامن السراني',
          'الامن السيبراني تعريف',
          'ما معني الامن السيبراني',
          'الامن السيبراني',
          'الامن الرقمي',
          'الحماية الرقمية',
          'أمن المعلومات',
        ],
        answer: 'الأمن السيبراني هو مجموعة من التقنيات والممارسات المصممة لحماية:\n'
                '• الأنظمة والشبكات\n'
                '• البرامج والتطبيقات\n'
                '• البيانات والمعلومات\n'
                'من الهجمات الرقمية مثل الاختراق، السرقة، التلف. يهدف لضمان:\n'
                'السرية (عدم الوصول غير المصرح به)\n'
                'السلامة (عدم التعديل غير المصرح به)\n'
                'التوافر (الوصول عند الحاجة)\n'
                'يشمل مجالات: أمن الشبكات، أمن التطبيقات، أمن المعلومات، والاستجابة للحوادث.',
        category: 'أساسيات',
        relatedTopics: ['الثغرات الأمنية', 'كيف يفكر الهاكر', 'التوعية الأمنية'],
      ),
      // الثغرات الأمنية
      KnowledgeEntry(
        keywords: [
          'ثغرة',
          'ثغرات',
          'ثغرات أمنية',
          'vulnerability',
          'vulnerabilities',
          'ما هي الثغرة الأمنية',
          'انواع الثغرات',
          ' holes',
          'exploit',
          'الثغرات',
          'ما هي الثغرات',
          'الثغرات الامنية',
          'ما هي الثغرة',
          'نقطة ضعف',
          'خلل أمني',
        ],
        answer: 'الثغرة الأمنية هي نقطة ضعف في النظام يمكن استغلالها للاختراق.\n'
                'الأنواع الشائعة:\n'
                '• برمجية: أخطاء في كود البرامج (مثل: ثغرة Log4j)\n'
                '• تكوين: إعدادات خاطئة في الخوادم أو الأجهزة\n'
                '• تصميم: عيوب في هيكل النظام نفسه\n'
                '• بشرية: أخطاء المستخدمين (مثل: كلمات مرور ضعيفة)\n'
                '• شبكات: نقاط ضعف في بروتوكولات الاتصال\n'
                'أمثلة واقعية:\n'
                '• ثغرة "السمكة" (Heartbleed) في بروتوكول التشفير\n'
                '• ثغرة "الشريان المفتوح" (EternalBlue) المستخدمة في هجوم الفدية',
        category: 'الثغرات',
        relatedTopics: ['كيف يفكر الهاكر', 'التصيد الإلكتروني', 'الحماية من الثغرات'],
      ),
      // عقلية الهاكر
      KnowledgeEntry(
        keywords: [
          'هاكر',
          'هاكرز',
          'مفكر الهكر',
          'كيف يفكر الهاكر',
          'عقلية الهاكر',
          'هكر',
          'هكرز',
          'طريقة تفكير المخترق',
          'استراتيجية الهجوم',
          'الهاكر',
          'كيف يفكر الهاكر',
          'طريقة تفكير الهاكر',
          'كيف يفكر المخترق',
          'استراتيجية الهاكر',
          'كيف يفكر القراصنة',
          'مخترق',
          'قرصان',
        ],
        answer: 'كيف يفكر الهاكر المحترف؟\n'
                'المرحلة 1: جمع المعلومات\n'
                '• بحث عن أهداف عبر وسائل التواصل الاجتماعي\n'
                '• مسح الشبكات لاكتشاف الثغرات\n'
                '• جمع معلومات الموظفين (الأسماء، المسميات)\n'
                'المرحلة 2: التخطيط\n'
                '• تحديد أضعف نقطة (تقنية أو بشرية)\n'
                '• اختيار أدوات الهجوم المناسبة\n'
                '• التخطيط لتجنب أنظمة الكشف\n'
                'المرحلة 3: التنفيذ\n'
                '• استغلال الثغرة بهدوء\n'
                '• التحرك خطوة بخطوة داخل النظام\n'
                '• إخفاء الآثار لتجنب الاكتشاف\n'
                'المعلومة الأهم: 95% من الهجمات الناجحة تستغل الخطأ البشري وليس الثغرات التقنية!',
        category: 'الهندسة الاجتماعية',
        relatedTopics: ['التصيد الإلكتروني', 'الحماية من الهاكر', 'التوعية الأمنية'],
      ),
      // الحماية الشخصية
      KnowledgeEntry(
        keywords: [
          'احمي نفسي',
          'كيف احمي نفسي',
          'حماية نفسي',
          'نصائح امنية',
          'حماية الحسابات',
          'كيف احمي حساباتي',
          'حماية من الاختراق',
          'الحماية',
          'نصائح أمنية',
          'أمان شخصي',
          'حماية رقمية',
        ],
        answer: 'دليل الحماية الشخصية الشامل:\n'
                'أولاً: كلمات المرور\n'
                '• استخدم مدير كلمات مرور (Bitwarden, 1Password)\n'
                '• كلمة مرور فريدة لكل حساب\n'
                '• 16 حرفاً على الأقل مع رموز وأرقام\n'
                'ثانياً: المصادقة الثنائية\n'
                '• فعّلها في جميع الحسابات المهمة\n'
                '• استخدم تطبيق مصادقة (Google Authenticator)\n'
                '• احتفظ بمفاتيح الاسترداد في مكان آمن\n'
                'ثالثاً: السلوك الرقمي\n'
                '• حدّث أنظمتك وتطبيقاتك فوراً\n'
                '• تجنب الروابط والمرفقات المشبوهة\n'
                '• استخدم شبكة خاصة افتراضية (VPN) على الواي فاي العام\n'
                '• اعمل نسخ احتياطية دورية (قاعدة 3-2-1)',
        category: 'الحماية',
        relatedTopics: ['المصادقة الثنائية', 'كلمات المرور', 'النسخ الاحتياطي'],
      ),
      // المصادقة الثنائية
      KnowledgeEntry(
        keywords: [
          'مصادقة ثنائية',
          '2fa',
          'التحقق بخطوتين',
          'تفعيل المصادقة الثنائية',
          'كيف افعل المصادقة الثنائية',
          'two factor authentication',
          '2 step verification',
          'المصادقة',
          'توثيق',
          'التحقق',
        ],
        answer: 'دليل تفعيل المصادقة الثنائية (2FA):\n'
                'لحسابات جوجل:\n'
                '1. اذهب إلى: إدارة حساب جوجل > الأمان\n'
                '2. اختر "التحقق بخطوتين"\n'
                '3. أضف رقم هاتف أو استخدم تطبيق مصادقة\n'
                '4. احتفظ بمفاتيح الاسترداد\n'
                'لحسابات فيسبوك:\n'
                '1. الإعدادات > الأمان وتسجيل الدخول\n'
                '2. "استخدام المصادقة الثنائية"\n'
                '3. اختر طريقة التحقق (تطبيق، رسالة نصية)\n'
                'نصائح احترافية:\n'
                '• استخدم تطبيق مصادقة (Authy, Google Authenticator) بدلاً من الرسائل النصية (أكثر أماناً)\n'
                '• احتفظ بمفاتيح الاسترداد في مكان مادي آمن (مثل: خزنة)\n'
                '• فعّل 2FA على: البريد الإلكتروني، وسائل التواصل، البنوك، العملات الرقمية',
        category: 'الحماية',
        relatedTopics: ['حماية الحسابات', 'كلمات المرور', 'الأمان البنكي'],
      ),
      // التوعية والتعليم
      KnowledgeEntry(
        keywords: [
          'توعية',
          'تعليم الامن السيبراني',
          'كيف اتعلم الامن السيبراني',
          'مصادر تعلم',
          'كورسات',
          'شهادات امن سيبراني',
          'التوعية الأمنية',
          'تدريب',
          'التعليم',
          'تعلم',
          'دورة',
          'شهادة',
        ],
        answer: 'خريطة تعلم الأمن السيبراني:\n'
                'المستوى المبتدئ:\n'
                '• أساسيات الشبكات (CompTIA Network+)\n'
                '• مفاهيم الأمن (Cybrary - دورات مجانية)\n'
                '• قناة "الأمن السيبراني" على يوتيوب\n'
                'المستوى المتوسط:\n'
                '• شهادة CompTIA Security+\n'
                '• منصة TryHackMe (تدريب عملي)\n'
                '• كتاب "الاختراق الأخلاقي للمبتدئين"\n'
                'المستوى المتقدم:\n'
                '• شهادة OSCP (للمحترفين)\n'
                '• منصة HackTheBox\n'
                '• مؤتمرات مثل Black Hat, DEF CON\n'
                'نصائح ذهبية:\n'
                '• خصص 30 دقيقة يومياً للتعلم\n'
                '• انضم لمجتمعات مثل: Saudi Cyber Community\n'
                '• تدرب على منصات مثل: OverTheWire, VulnHub',
        category: 'التعليم',
        relatedTopics: ['شهادات', 'منصات تدريب', 'مجتمعات'],
      ),
      // التصيد الإلكتروني
      KnowledgeEntry(
        keywords: [
          'تصيد',
          'phishing',
          'التصيد الاحتيالي',
          'رسالة تصيد',
          'كيف اتجنب التصيد',
          'احتيال',
          'scam',
          'التصيد',
          'احتيال إلكتروني',
          'بريد احتيالي',
          'vishing',
          'smishing',
        ],
        answer: 'التصيد الإلكتروني: أنواعه وطرق الحماية\n'
                'الأنواع الشائعة:\n'
                '• بريدي: رسائل تطلب تحديث البيانات عبر رابط مزيف\n'
                '• هاتفي (Vishing): مكالمات انتحال هوية دعم فني\n'
                '• نصي (Smishing): رسائل نصية تحتوي روابط خبيثة\n'
                '• شبكات اجتماعية: حسابات مزيفة تطلب مساعدة مالية\n'
                'كيف تكتشف التصيد؟\n'
                '• تحقق من عنوان المرسل (غالباً يحتوي أخطاء)\n'
                '• مرر الماوس فوق الرابط لترى العنوان الحقيقي\n'
                '• ابحث عن أخطاء إملائية أو لغوية\n'
                '• تحقق من وجود "https://" ورمز القفل\n'
                'إذا وقعت ضحية:\n'
                '1. غير كلمات المرور فوراً\n'
                '2. اتصل بالجهة الرسمية للتأكد\n'
                '3. أبلغ عن الحادث للجهات المختصة',
        category: 'الهندسة الاجتماعية',
        relatedTopics: ['كيف يفكر الهاكر', 'حماية الحسابات', 'الاحتيال المالي'],
      ),
      // كلمات المرور
      KnowledgeEntry(
        keywords: [
          'كلمة مرور',
          'password',
          'كلمة سر قوية',
          'كيف انشئ كلمة مرور قوية',
          'مدير كلمات مرور',
          'passphrase',
          'المرور',
          'باسوورد',
          'سر',
        ],
        answer: 'كلمة المرور القوية: دليل عملي\n'
                'الطريقة الصحيحة (Passphrase):\n'
                'اختر 4-5 كلمات عشوائية غير مرتبطة:\n'
                'مثال: "شمس_بحر_جبل_قمر!2024"\n'
                '• سهلة التذكر، صعبة الاختراق\n'
                '• 20 حرفاً على الأقل\n'
                'ما يجب تجنبه:\n'
                '• كلمات قاموسية (password123)\n'
                '• معلومات شخصية (اسم، تاريخ ميلاد)\n'
                '• نفس كلمة المرور لعدة حسابات\n'
                'أفضل الممارسات:\n'
                '• استخدم مدير كلمات مرور (Bitwarden مجاني ومفتوح المصدر)\n'
                '• فعّل المزامنة المشفرة عبر الأجهزة\n'
                '• أنشئ كلمات مرور عشوائية للحسابات المهمة\n'
                '• غيّر كلمات المرور كل 6 أشهر للحسابات الحرجة',
        category: 'الحماية',
        relatedTopics: ['المصادقة الثنائية', 'حماية الحسابات', 'مدير كلمات المرور'],
      ),
      // حماية الأطفال
      KnowledgeEntry(
        keywords: [
          'طفل',
          'أطفال',
          'حماية الأطفال',
          'رقابة أبوية',
          'أطفال على الإنترنت',
          'cyber safety for kids',
          'الاطفال',
          'أمان العائلة',
          'أطفال رقميون',
        ],
        answer: 'حماية الأطفال في الفضاء الرقمي:\n'
                'أدوات الرقابة:\n'
                '• Google Family Link (للأجهزة أندرويد)\n'
                '• Screen Time (لأجهزة آبل)\n'
                '• تطبيقات مثل: Qustodio, Norton Family\n'
                'القواعد الذهبية:\n'
                '• ضع جهاز الكمبيوتر في مكان عام بالمنزل\n'
                '• حدد أوقات استخدام الشاشة يومياً\n'
                '• ناقش مع طفلك: "لا تشارك معلوماتك الشخصية مع أحد"\n'
                '• علّمه التعرف على السلوك المشبوه\n'
                '• تحقق من أصدقائه على وسائل التواصل\n'
                'علامات الخطر:\n'
                '• إخفاء الشاشة عند دخولك الغرفة\n'
                '• تلقي هدايا أو أموال عبر الإنترنت\n'
                '• تغير مفاجئ في السلوك أو المزاج',
        category: 'الأمان العائلي',
        relatedTopics: ['التوعية الأمنية', 'الهندسة الاجتماعية', 'التنمر الإلكتروني'],
      ),
      // النسخ الاحتياطي
      KnowledgeEntry(
        keywords: [
          'نسخ احتياطي',
          'backup',
          'استعادة البيانات',
          'كيف اعمل نسخ احتياطي',
          'حماية البيانات',
          'ransomware',
          'النسخ',
          'نسخة احتياطية',
          'استعادة',
          'حماية من الفدية',
        ],
        answer: 'النسخ الاحتياطي: درعك ضد الفدية والكوارث\n'
                'قاعدة 3-2-1 الذهبية:\n'
                '• 3 نسخ من بياناتك (الأصل + نسختان احتياطيتان)\n'
                '• على وسيلتين مختلفتين (قرص صلب + سحابة)\n'
                '• 1 نسخة خارج الموقع (للحماية من الحريق/السرقة)\n'
                'الحلول المقترحة:\n'
                '• سحابي: Backblaze, IDrive (تشفير من طرف لطرف)\n'
                '• مادي: قرص صلب خارجي + تحديث أسبوعي\n'
                '• هجين: استخدام Time Machine (لـ Mac) مع سحابة\n'
                'نصائح حاسمة:\n'
                '• اختبر استعادة الملفات شهرياً\n'
                '• شغّل النسخ الاحتياطي التلقائي\n'
                '• احتفظ بنسخة احتياطية مشفرة خارج المنزل\n'
                '• ركّز على الملفات المهمة (مستندات، صور، مشاريع)',
        category: 'الحماية',
        relatedTopics: ['الحماية من الفدية', 'استعادة الكوارث', 'التشفير'],
      ),
      // أمن الشبكات
      KnowledgeEntry(
        keywords: [
          'واي فاي',
          'wifi',
          'أمن الشبكة',
          'راوتر',
          'حماية الواي فاي',
          'شبكة منزلية',
          'الشبكة',
          'راوتر آمن',
          'تشفير الواي فاي',
          'wpa3',
        ],
        answer: 'تأمين شبكة الواي فاي المنزلية:\n'
                'خطوات أساسية:\n'
                '1. غيّر اسم الشبكة وكلمة المرور الافتراضية\n'
                '2. استخدم تشفير WPA3 (أو WPA2 إذا غير متوفر)\n'
                '3. أخفِ اسم الشبكة (Disable SSID Broadcast)\n'
                '4. حدّث برنامج الراوتر (Firmware) شهرياً\n'
                '5. أنشئ شبكة ضيوف منفصلة للأجهزة غير الموثوقة\n'
                'نصائح متقدمة:\n'
                '• عطّل خاصية WPS (ثغرة أمنية شائعة)\n'
                '• فعّل جدار الحماية (Firewall) في الراوتر\n'
                '• راقب الأجهزة المتصلة عبر لوحة التحكم\n'
                '• استخدم قناة غير مزدحمة (1, 6, 11) لتقليل التداخل',
        category: 'الشبكات',
        relatedTopics: ['الحماية من الاختراق', 'الراوتر الآمن', 'الواي فاي العام'],
      ),
      // التحديثات الأمنية
      KnowledgeEntry(
        keywords: [
          'تحديثات',
          'تحديث أمن',
          'patches',
          'لماذا التحديثات مهمة',
          'تحديث النظام',
          'التحديث',
          'تحديث تلقائي',
          'أمان النظام',
        ],
        answer: 'التحديثات الأمنية: درعك الأول\n'
                'لماذا هي حاسمة؟\n'
                '• 60% من الهجمات تستغل ثغرات تم إصلاحها بتحديثات سابقة!\n'
                '• التحديثات تغلق الثغرات التي يكتشفها الباحثون الأمنيون\n'
                '• تمنع الهجمات التلقائية التي تستهدف الأنظمة غير المحدثة\n'
                'أفضل الممارسات:\n'
                '• فعّل التحديثات التلقائية لأنظمة التشغيل\n'
                '• حدّث التطبيقات فور توفر التحديثات\n'
                '• لا تؤجل التحديثات "الحرجة" (Critical Updates)\n'
                '• تأكد من تحديث أجهزة IoT (كاميرات، أجهزة ذكية)\n'
                '• استخدم أدوات مثل: Patch My PC (لويندوز)',
        category: 'الحماية',
        relatedTopics: ['الثغرات الأمنية', 'حماية النظام', 'أمن التطبيقات'],
      ),
    ];
    // توليد الاقتراحات الديناميكية
    _updateSuggestions();
  }
  
  // تحديث الاقتراحات بناءً على الفئة الحالية
  void _updateSuggestions() {
    if (_currentCategory == null) {
      _suggestions = [
        'ما هو الأمن السيبراني؟',
        'ما هي الثغرات الأمنية؟',
        'كيف يفكر الهاكر؟',
        'كيف أحمي نفسي؟',
        'كيف أفعل المصادقة الثنائية؟',
        'ما هو التصيد الإلكتروني؟',
        'كيف أنشئ كلمة مرور قوية؟',
        'كيف أحمي طفلي على الإنترنت؟',
      ];
    } else {
      final related = _knowledgeBase
          .where((e) => e.category == _currentCategory)
          .expand<String>((e) => e.relatedTopics ?? <String>[])
          .toSet()
          .take(5)
          .toList();
      _suggestions = related.isNotEmpty
          ? List<String>.from(related)
          : ['اسأل عن: أساسيات الأمن', 'حماية الحسابات', 'الهندسة الاجتماعية', 'التعليم الأمني'];
    }
  }
  
  // محرك بحث متطور في قاعدة المعرفة - الإصلاح الرئيسي هنا
  String _findAnswer(String question) {
    String lowerQ = question.toLowerCase().trim();
    // تنظيف النص مع الحفاظ على المسافات الطبيعية ودعم الحروف العربية
    String normalizedQ = lowerQ.replaceAll(RegExp(r'[^\p{L}\p{N}\s]', unicode: true), ' ');
    normalizedQ = normalizedQ.replaceAll(RegExp(r'\s+'), ' ').trim();
    
    // معالجة المرادفات بشكل صحيح (استبدال المرادفات بالمصطلح القياسي)
    final synonyms = {
      'هاكر': ['هكر', 'مخترق', 'قرصان', 'هكرز', 'الهاكر', 'الهكر', 'القراصنة'],
      'حماية': ['أمان', 'تأمين', 'وقاية', 'الحماية', 'احمي', 'يحمي', 'الامان'],
      'ثغرة': ['خلل', 'ضعف', 'الثغرات', 'ثغرات', 'نقاط ضعف', 'خلل أمني'],
      'امن': ['أمن', 'الامن', 'الامن السيبراني', 'الامن السراني', 'الامن الرقمي'],
      'تصيد': ['احتيال', 'scam', 'التصيد', 'رسالة تصيد', 'احتيال إلكتروني', 'بريد احتيالي'],
      'كلمة مرور': ['باسوورد', 'سر', 'المرور', 'password'],
      'مصادقة': ['توثيق', 'التحقق', '2fa', '2 step'],
      'نسخ احتياطي': ['نسخة احتياطية', 'النسخ', 'backup', 'استعادة'],
    };
    
    // استبدال المرادفات بالمصطلح القياسي (باستخدام حدود الكلمات لتجنب الاستبدال الجزئي)
    for (var entry in synonyms.entries) {
      for (var synonym in entry.value) {
        if (synonym.isEmpty) continue;
        // استخدام تعبير نمطي لاستبدال الكلمة الكاملة فقط
        normalizedQ = normalizedQ.replaceAll(
          RegExp(r'\b' + synonym.escape() + r'\b', unicode: true),
          entry.key,
        );
      }
    }
    
    KnowledgeEntry? bestMatch;
    int bestScore = 0;
    String bestKeyword = '';
    for (var entry in _knowledgeBase) {
      int score = 0;
      String matchedKeyword = '';
      
      // ترتيب الكلمات المفتاحية من الأطول إلى الأقصر لتحسين الأولوية
      var sortedKeywords = entry.keywords
          .map((k) => k.toLowerCase().replaceAll(RegExp(r'[^\p{L}\p{N}\s]', unicode: true), ' '))
          .map((k) => k.replaceAll(RegExp(r'\s+'), ' ').trim())
          .where((k) => k.isNotEmpty)
          .toList()
        ..sort((a, b) => b.length.compareTo(a.length));
      
      // تقييم كل كلمة مفتاحية
      for (var keyword in sortedKeywords) {
        if (keyword.isEmpty) continue;
        
        // 1. تطابق تام (الأولوية الأعلى) - يفوز تلقائيًا
        if (normalizedQ == keyword) {
          score = 200;
          matchedKeyword = keyword;
          break;
        }
        
        // 2. تطابق مع حدود الكلمة (لمنع التطابق داخل كلمات أخرى)
        else if (normalizedQ.contains(' $keyword ') ||
            normalizedQ.startsWith('$keyword ') ||
            normalizedQ.endsWith(' $keyword')) {
          int matchScore = 120;
          // مكافأة إضافية للعبارات الطويلة (> 8 أحرف)
          if (keyword.length > 8) matchScore += 30;
          if (matchScore > score) {
            score = matchScore;
            matchedKeyword = keyword;
          }
        }
        
        // 3. تطابق جزئي (بحذر - فقط للكلمات المتوسطة/الطويلة)
        else if (keyword.length >= 6 && normalizedQ.contains(keyword)) {
          int matchScore = 60;
          if (keyword.length > 10) matchScore += 20;
          if (matchScore > score) {
            score = matchScore;
            matchedKeyword = keyword;
          }
        }
      }
      
      // تحديث أفضل تطابق
      if (score > bestScore) {
        bestScore = score;
        bestMatch = entry;
        bestKeyword = matchedKeyword;
        _currentCategory = entry.category;
      }
    }
    
    // تحديث الاقتراحات المرتبطة
    _updateSuggestions();
    
    // شرط صارم لضمان جودة الإجابة (الحد الأدنى 100 نقطة)
    if (bestMatch != null && bestScore >= 100) {
      // إضافة سياق إضافي عند التطابق الجزئي
      if (bestScore < 150 && bestKeyword.isNotEmpty) {
        return 'بناءً على سؤالك عن "$bestKeyword"، إليك الإجابة:\n${bestMatch.answer}';
      }
      return bestMatch.answer;
    }
    
    // رسالة مساعدة ذكية عند عدم وجود تطابق جيد
    return _generateSmartSuggestions(normalizedQ);
  }
  
  // دالة مساعدة لتوليد اقتراحات ذكية عند عدم العثور على إجابة
  String _generateSmartSuggestions(String normalizedQ) {
    // اكتشاف الموضوعات المحتملة من السؤال
    List<String> topics = [];
    if (normalizedQ.contains('كلمة مرور') || normalizedQ.contains('باسوورد') || normalizedQ.contains('سر')) {
      topics.add('كيف أنشئ كلمة مرور قوية؟');
    }
    if (normalizedQ.contains('مصادقة') || normalizedQ.contains('2fa') || normalizedQ.contains('توثيق') || normalizedQ.contains('تحقق')) {
      topics.add('كيف أفعل المصادقة الثنائية؟');
    }
    if (normalizedQ.contains('تصيد') || normalizedQ.contains('احتيال') || normalizedQ.contains('رسال') || normalizedQ.contains('scam')) {
      topics.add('ما هو التصيد الإلكتروني؟');
    }
    if (normalizedQ.contains('طفل') || normalizedQ.contains('اطفال') || normalizedQ.contains('عائلي') || normalizedQ.contains('عائلة')) {
      topics.add('كيف أحمي طفلي على الإنترنت؟');
    }
    if (normalizedQ.contains('راوتر') || normalizedQ.contains('واي فاي') || normalizedQ.contains('شبكة') || normalizedQ.contains('wifi')) {
      topics.add('كيف أحمي شبكة الواي فاي المنزلية؟');
    }
    if (normalizedQ.contains('تحديث') || normalizedQ.contains('patches') || normalizedQ.contains('ترقيع')) {
      topics.add('لماذا التحديثات الأمنية مهمة؟');
    }
    if (normalizedQ.contains('نسخ') || normalizedQ.contains('backup') || normalizedQ.contains('استعادة')) {
      topics.add('كيف أعمل نسخ احتياطي آمن؟');
    }
    
    // بناء الرسالة حسب الموضوعات المكتشفة
    if (topics.isNotEmpty) {
      String suggestions = topics.map((t) => '• $t').join('\n');
      return 'لم أفهم سؤالك تمامًا، لكن قد تفيدك هذه الاقتراحات:\n$suggestions\nأو جرب صياغة سؤالك كـ: "ما هو الأمن السيبراني؟"';
    }
    
    // اقتراحات عامة
    return 'عذراً، لم أجد إجابة دقيقة لسؤالك. جرب أحد هذه الأسئلة الشائعة:\n'
        '\n'
        'للمبتدئين:\n'
        '• ما هو الأمن السيبراني؟\n'
        '• ما هي الثغرات الأمنية؟\n'
        '\n'
        'لحماية حساباتك:\n'
        '• كيف أفعل المصادقة الثنائية؟\n'
        '• كيف أنشئ كلمة مرور قوية؟\n'
        '\n'
        'لتفادي الاحتيال:\n'
        '• ما هو التصيد الإلكتروني؟\n'
        '• كيف يفكر الهاكر؟\n'
        '\n'
        'نصيحة: كن دقيقًا في سؤالك مثل: "كيف أحمي نفسي من التصيد؟"';
  }
  
  void _sendMessage() {
    String question = _controller.text.trim();
    if (question.isEmpty) return;
    
    setState(() {
      _messages.add({'sender': 'user', 'text': question});
      _controller.clear();
      _isThinking = true;
    });
    
    _scrollToBottom();
    
    // تحسين تجربة المستخدم: وقت تفكير ديناميكي
    int delay = (question.length * 15).clamp(400, 1200) as int;
    Future.delayed(Duration(milliseconds: delay), () {
      if (!mounted) return;
      String answer = _findAnswer(question);
      setState(() {
        _messages.add({'sender': 'ai', 'text': answer});
        _isThinking = false;
      });
      _scrollToBottom();
    });
  }
  
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 120,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
  
  @override
  void initState() {
    super.initState();
    _initKnowledgeBase();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.shield, color: Colors.white),
            SizedBox(width: 8),
            Text('درع - مساعد الأمن السيبراني'),
          ],
        ),
        backgroundColor: const Color(0xFF0D1B2A),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_book, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('سيتم إضافة مكتبة الموارد قريباً!')),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0D1B2A), Color(0xFF1B263B)],
          ),
        ),
        child: Column(
          children: [
            // شريط الفئة الحالية
            if (_currentCategory != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.black.withOpacity(0.3),
                child: Row(
                  children: [
                    Icon(
                      _getCategoryIcon(_currentCategory!),
                      color: _getCategoryColor(_currentCategory!),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$_currentCategory | نصائح متعلقة',
                      style: TextStyle(
                        color: _getCategoryColor(_currentCategory!),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _messages.isEmpty
                    ? _buildWelcomeScreen()
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final msg = _messages[index];
                          return _buildMessageBubble(msg['text']!, msg['sender']!);
                        },
                      ),
              ),
            ),
            if (_isThinking)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4ECDC4)),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'درع يبحث عن أفضل إجابة...',
                        style: TextStyle(color: Colors.white70, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            _buildSuggestionChips(),
            _buildInputField(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildWelcomeScreen() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E3A5F), Color(0xFF0F1B33)],
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF4ECDC4).withOpacity(0.6),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4ECDC4).withOpacity(0.3),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.shield,
                size: 60,
                color: Color(0xFF4ECDC4),
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'مرحباً! أنا "درع" مساعدك الذكي للأمن السيبراني\n'
              'أقدم معلومات عملية وحديثة لحمايتك في العالم الرقمي',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1B263B).withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF4ECDC4).withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4ECDC4).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'ما الذي يمكنني مساعدتك فيه؟',
                      style: TextStyle(
                        color: Color(0xFF4ECDC4),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildCategoryGrid(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueGrey.shade900, Colors.blueGrey.shade800],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'نصيحة اليوم:\n"المصادقة الثنائية هي أقوى خطوة لحماية حساباتك - فعّلها الآن!"',
                style: TextStyle(
                  color: Color(0xFF4ECDC4),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCategoryGrid() {
    final categories = _knowledgeBase.map((e) => e.category).toSet().toList();
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: categories.take(6).map((category) {
        return GestureDetector(
          onTap: () {
            _currentCategory = category;
            _updateSuggestions();
            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: _getCategoryColor(category).withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _getCategoryColor(category).withOpacity(0.4),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getCategoryIcon(category),
                  size: 16,
                  color: _getCategoryColor(category),
                ),
                const SizedBox(width: 6),
                Text(
                  category,
                  style: TextStyle(
                    color: _getCategoryColor(category),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
  
  Widget _buildSuggestionChips() {
    if (_suggestions.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      color: const Color(0xFF0F172A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, bottom: 8),
            child: Text(
              'اقتراحات سريعة:',
              style: TextStyle(
                color: Color(0xFF4ECDC4),
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _suggestions.map((s) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: FilterChip(
                    label: Text(
                      s,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    backgroundColor: const Color(0xFF1E293B),
                    selectedColor: const Color(0xFF334155),
                    checkmarkColor: const Color(0xFF4ECDC4),
                    onSelected: (selected) {
                      _controller.text = s;
                      _sendMessage();
                    },
                    avatar: Icon(
                      Icons.lightbulb_outline,
                      size: 16,
                      color: Colors.grey.shade400,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: const Color(0xFF0F172A),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: Colors.white.withOpacity(0.15),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                textDirection: TextDirection.rtl,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'اسأل عن: الحماية، الثغرات، المصادقة الثنائية...',
                  hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 15),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send_rounded, color: Color(0xFF4ECDC4)),
                    onPressed: _sendMessage,
                    iconSize: 26,
                  ),
                  prefixIcon: Container(
                    padding: const EdgeInsets.only(left: 12),
                    child: Icon(
                      Icons.security,
                      color: Colors.grey.shade600,
                      size: 24,
                    ),
                  ),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMessageBubble(String text, String sender) {
    bool isUser = sender == 'user';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.88,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isUser ? 22 : 24,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          gradient: isUser
              ? LinearGradient(
                  colors: [const Color(0xFF1E3A5F), const Color(0xFF15233A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [const Color(0xFF1B263B), const Color(0xFF0F172A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(24),
            topRight: const Radius.circular(24),
            bottomLeft: isUser ? const Radius.circular(24) : const Radius.circular(8),
            bottomRight: isUser ? const Radius.circular(8) : const Radius.circular(24),
          ),
          border: Border.all(
            color: isUser
                ? const Color(0xFF4ECDC4).withOpacity(0.5)
                : Colors.white.withOpacity(0.1),
            width: isUser ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: (isUser ? const Color(0xFF4ECDC4) : Colors.blueGrey)
                  .withOpacity(isUser ? 0.2 : 0.15),
              blurRadius: 12,
              offset: Offset(0, isUser ? 4 : 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUser)
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4ECDC4).withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shield,
                      size: 16,
                      color: Color(0xFF4ECDC4),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'درع - المساعد الأمني',
                    style: TextStyle(
                      color: Color(0xFF4ECDC4),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            if (!isUser) const SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.white.withOpacity(0.95),
                fontSize: 16.5,
                height: 1.6,
                fontWeight: isUser ? FontWeight.w500 : FontWeight.w400,
                letterSpacing: 0.2,
              ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl            ),
          ],
        ),
      ),
    );
  }
  
  // مساعدين لواجهة المستخدم
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'الحماية': return const Color(0xFF4ECDC4);
      case 'الثغرات': return const Color(0xFFFF6B6B);
      case 'الهندسة الاجتماعية': return const Color(0xFFFFD166);
      case 'التعليم': return const Color(0xFF6C63FF);
      case 'الأمان العائلي': return const Color(0xFF06D6A0);
      case 'الشبكات': return const Color(0xFF118AB2);
      case 'أساسيات': return const Color(0xFF9B5DE5);
      default: return Colors.blueGrey;
    }
  }
  
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'الحماية': return Icons.lock;
      case 'الثغرات': return Icons.bug_report;
      case 'الهندسة الاجتماعية': return Icons.psychology;
      case 'التعليم': return Icons.school;
      case 'الأمان العائلي': return Icons.family_restroom;
      case 'الشبكات': return Icons.wifi;
      case 'أساسيات': return Icons.info;
      default: return Icons.category;
    }
  }
}