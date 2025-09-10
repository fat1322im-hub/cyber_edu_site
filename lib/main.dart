import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const CyberSecurityApp());
}

class CyberSecurityApp extends StatelessWidget {
  const CyberSecurityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CyberSecurity',
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

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
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
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.8)),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 1.0)),
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3A5F), Color(0xFF0F1B33)],
          ),
        ),
        child: Stack(
          children: [
            FadeTransition(
              opacity: _opacityAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.shield, size: 140, color: Color(0xFF4ECDC4)),
                      const SizedBox(height: 20),
                      const Text(
                        'أهلاً وسهلاً بكم في',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4ECDC4),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'CyberSecurity',
                        style: TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4ECDC4),
                          letterSpacing: 2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'درعك الرقمي ضد التهديدات الإلكترونية',
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= اختيار المسار =================
class PathChoicePage extends StatelessWidget {
  const PathChoicePage({super.key});

  // ✅ دالة لعرض نافذة معلومات عن التطبيق
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
            '🌟 عن تطبيق CyberSecurity',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        content: Column(
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
              'مطورة ومصممة هذا البرنامج',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const Divider(color: Colors.white30, height: 32),
            const Text(
              '🎯 هدف التطبيق:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'تم تصميم تطبيق "CyberSecurity" لنشر التوعية الرقمية وحماية المستخدمين من المخاطر الإلكترونية مثل التصيد، الاختراق، والابتزاز. '
              'يقدم التطبيق محتوى تعليميًا وتطبيقيًا بطريقة سهلة الاستخدام وتفاعلية، ومناسبة لكل الأعمار — خاصة الأطفال وأولياء الأمور.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white70,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            const Text(
              '💡 ماذا ستستفيد من هذا التطبيق؟',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4ECDC4),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              '• قسم "الحماية الرقمية": ستتعلم أساسيات حماية نفسك وطفلك، وكيفية تأمين حساباتك وبطاقات الدفع، وتتعرف على التحذيرات الهامة لتجنب الوقوع ضحية للنصب.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                height: 1.5,
              ),
              textAlign: TextAlign.right,
            ),
            const Text(
              '• قسم "التطبيق العملي": ستختبر معلوماتك من خلال أدوات تفاعلية مثل فحص قوة كلمة المرور، كشف الروابط الضارة، البطاقات التعليمية، وألعاب تقيس مستوى معرفتك.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                height: 1.5,
              ),
              textAlign: TextAlign.right,
            ),
            const Text(
              '•  قسم "البوت الذكي": سوف يساعدك بشكل بسيط',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                height: 1.5,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 24),
            const Text(
              '🛡️ التطبيق هو درعك الرقمي. نهدف لبناء مجتمع واعٍ ومتمكن من مواجهة التهديدات الإلكترونية بثقة وأمان.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4ECDC4),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4ECDC4),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text(
                'إغلاق',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
        actionsPadding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختر مسارك'),
        // ✅ إضافة زر المعلومات بجانب العنوان
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () => _showAboutDialog(context),
            tooltip: 'عن التطبيق',
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
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildChoiceCard(
                context: context,
                title: 'الحماية الرقمية 🛡️',
                subtitle: 'تعلم كيف تحمي نفسك من السرقة والخداع الإلكتروني',
                icon: Icons.security,
                color: const Color(0xFF4ECDC4),
                nextPage: const AwarenessMenuPage(),
              ),
              const SizedBox(height: 16),
              _buildChoiceCard(
                context: context,
                title: 'التطبيق العملي 💡',
                subtitle: 'جرب ما تعلمته في بيئة آمنة',
                icon: Icons.play_circle,
                color: Colors.green,
                nextPage: const PracticePage(),
              ),
              const SizedBox(height: 16),
              _buildChoiceCard(
                context: context,
                title: 'البوت الذكي 🤖',
                subtitle: 'اسأل واحصل على إجابة فورية',
                icon: Icons.chat,
                color: Colors.purple,
                nextPage: const ChatBotScreen(),
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
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => nextPage));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: color.withOpacity(0.4)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 14,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 36),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 15, color: Colors.white60),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color, size: 22),
          ],
        ),
      ),
    );
  }
}

// ================= قائمة التوعية =================
class AwarenessMenuPage extends StatelessWidget {
  const AwarenessMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('دليل الحماية الرقمية')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3A5F), Color(0xFF0F1B33)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              _buildItem(
                title: ' حماية الطفل الإلكتروني 🧒',
                icon: Icons.child_care,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChildProtectionPage()),
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildItem(
                title: ' البطاقة والدفع الآمن 💳',
                icon: Icons.payment,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaymentSecurityPage()),
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildItem(
                title: ' حماية الحسابات والبريد الإلكتروني 🔐',
                icon: Icons.verified_user,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AccountSecurityPage()),
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildItem(
                title: ' تحذيرات رقمية مهمة ⚠️',
                icon: Icons.warning,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SafetyWarningsPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem({required String title, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF4ECDC4).withOpacity(0.4)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4ECDC4).withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF4ECDC4).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF4ECDC4), size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4ECDC4),
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: const Color(0xFF4ECDC4), size: 18),
          ],
        ),
      ),
    );
  }
}

// ================= 1. حماية الطفل الإلكتروني =================
class ChildProtectionPage extends StatelessWidget {
  const ChildProtectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حماية الطفل الإلكتروني')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3A5F), Color(0xFF0F1B33)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'حماية الطفل في العالم الرقمي مسؤولية واعية. إليك أبرز المخاطر والحلول:',
                style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.7),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 30),
              _buildSection(
                'مشاهدة محتوى غير مناسب 🎬',
                'مثل: فيديوهات عنف، حوادث، أو ألعاب تحتوي على مشاهد مخيفة.\n• الحل: استخدم تطبيقات مخصصة للأطفال مثل YouTube Kids، وفعّل الفلترة.',
              ),
              _buildSection(
                'التحدث مع غرباء (Grooming) 👤',
                'شخص بالغ يتظاهر بأنه طفل لاستدراج طفلك، ثم يطلب صورًا أو فيديوهات.\n• الحل: علّم طفلك: "لا تتحدث مع من لا تعرفه"، وعطّل خاصية الدردشة في الألعاب إن أمكن.',
              ),
              _buildSection(
                'التنمر الإلكتروني (Cyberbullying)',
                'يُسخر منه أحد في مجموعة واتساب أو إنستغرام، أو ينشر صورته بطريقة محرجة.\n• الحل: شجعه على الإبلاغ فورًا، ولا توبخه إذا تعرض لذلك.',
              ),
              _buildSection(
                'الإفراط في استخدام الشاشة ⏳',
                'يلعب لساعات دون توقف، ويُهمل الدراسة أو النوم.\n• الحل: حدد وقتًا يوميًا للجهاز (مثلاً: ساعة بعد الدراسة)، واستخدم أدوات التوقيت.',
              ),
              _buildSection(
                'الضغط على روابط خطرة 🔗',
                'يضغط على إعلان يقول "اربح لعبة مجانية!"، فيُصاب الجهاز بفيروس.\n• الحل: لا تسمح له بتنزيل تطبيقات من خارج المتجر الرسمي (مثل Google Play أو App Store).',
              ),
              const SizedBox(height: 30),
              _buildSubtitle('أدوات الحماية المتاحة 🛠️'),
              _buildTable(
                headers: ['الأداة', 'ما تفعله'],
                rows: [
                  ['Google Family Link', 'تحكم في الوقت والتطبيقات، ورؤية مكانه'],
                  ['Apple Screen Time', 'حدد وقت كل تطبيق، ومنع المواقع غير اللائقة'],
                  ['Kaspersky Safe Kids', 'راقب المحتوى والدردشات، واحصل على تحذيرات'],
                  ['Bark', 'يُحذّر من التنمر أو الابتزاز عبر 30+ تطبيق'],
                ],
              ),
              const SizedBox(height: 30),
              _buildSubtitle('نصائح عملية للوالدين 💡'),
              _buildTips([
                'لا تترك الطفل يستخدم الجهاز في غرفة نومه ليلًا',
                'لا تسمح له بتنزيل تطبيقات من مصادر غير موثوقة',
                'استخدم بريدًا إلكترونيًا منفصلًا له',
                'فعّل المصادقة الثنائية على حسابه',
                'علّمه ألا يشارك صوره أو بياناته مع أحد',
              ]),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A5F).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF4ECDC4), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4ECDC4).withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      '🌟 رسالة من CyberSecurity إليك:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4ECDC4),
                      ),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'الأمان لا يعني الحبس، بل التوعية والثقة.\nكل خطوة تأخذها لحماية طفلك، تبني له مستقبلاً آمناً.\nأنت درعه الرقمي.',
                      style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.8),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4ECDC4),
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 15, color: Colors.white70, height: 1.6),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4ECDC4),
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildTable({required List<String> headers, required List<List<String>> rows}) {
    return Table(
      textDirection: TextDirection.rtl,
      border: TableBorder.all(color: const Color(0xFF4ECDC4).withOpacity(0.4), width: 1.5),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Color(0xFF1E3A5F)),
          children: headers.map((h) => Padding(
            padding: const EdgeInsets.all(12),
            child: Text(h, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          )).toList(),
        ),
        ...rows.map((row) => TableRow(
          decoration: BoxDecoration(color: Colors.white10),
          children: row.map((cell) => Padding(
            padding: const EdgeInsets.all(12),
            child: Text(cell, style: const TextStyle(fontSize: 14, color: Colors.white70), textAlign: TextAlign.center),
          )).toList(),
        )),
      ],
    );
  }

  Widget _buildTips(List<String> tips) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: tips.map((tip) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            const Icon(Icons.circle, color: Color(0xFF4ECDC4), size: 8),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                tip,
                style: const TextStyle(fontSize: 15, color: Colors.white70),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}

// ================= 2. البطاقة والدفع الآمن =================
class PaymentSecurityPage extends StatelessWidget {
  const PaymentSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('البطاقة والدفع الآمن')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3A5F), Color(0xFF0F1B33)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'البطاقة البنكية هدف رئيسي للمحتالين. إليك كيف تحافظ على أموالك:',
                style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.7),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 30),
              _buildSection(
                'عدم ربط بطاقة ائتمان مباشرة بالتطبيقات 💳',
                'مثل: جوجل بلاي، آيتونز، أو أمازون.\n• الحل: استخدم بطاقة مدفوعة مسبقًا (Prepaid Card) برصيد محدود.',
              ),
              _buildSection(
                'تفعيل "طلب الموافقة" على الشراء 🔒',
                'يمنع الشراء العرضي أو غير المقصود.\n• الحل: موجود في: Google Play > الإعدادات > طريقة الدفع > طلب الموافقة.',
              ),
              _buildSection(
                'عدم استخدام "حفظ كلمة المرور" في المتصفح ❌',
                'لأن أي شخص يصل إلى جهازك يمكنه الشراء.',
              ),
              _buildSection(
                'التأكد من أن الموقع آمن 🔐',
                'تحقق من أن الرابط يبدأ بـ https:// وليس http://.\n• الحل: ابحث عن رمز القفل 🔒 بجانب الرابط.',
              ),
              const SizedBox(height: 30),
              _buildSubtitle('كيف تتجنب حالات النصب؟ 🚫'),
              _buildTable(
                headers: ['الحالة', 'الحل'],
                rows: [
                  ['"اربح جائزة!"', 'لا تصدق العروض "الجيدة جدًا ليكونوا حقيقيين"'],
                  ['"حسابك مغلق، انقر هنا"', 'لا تنقر على روابط من جهات مجهولة'],
                  ['"شخص من دعم فني" يطلب صلاحيات', 'لا تعطِ أحدًا صلاحيات جهازك أبدًا'],
                  ['"ارسل 100 ريال لإلغاء الاشتراك"', 'لا تدفع أبدًا – هذا احتيال'],
                ],
              ),
              const SizedBox(height: 30),
              _buildSubtitle('نصائح حماية إضافية 💡'),
              _buildTips([
                'لا تشارك صورة بطاقة الدفع أبدًا',
                'لا تستخدم الواي فاي العام للشراء',
                'غيّر كلمة مرور الحساب البنكي بانتظام',
                'فعّل إشعارات الشراء على هاتفك',
              ]),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A5F).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.orange, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      '💡 تذكّر:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'الشراء الآمن = وعي + تحقق + احتياط.\nلا تدع الطمع أو الخوف يخدعك.\nأنت أذكى من أي رسالة احتيال.',
                      style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.8),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4ECDC4),
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 15, color: Colors.white70, height: 1.6),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4ECDC4),
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildTable({required List<String> headers, required List<List<String>> rows}) {
    return Table(
      textDirection: TextDirection.rtl,
      border: TableBorder.all(color: const Color(0xFF4ECDC4).withOpacity(0.4), width: 1.5),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Color(0xFF1E3A5F)),
          children: headers.map((h) => Padding(
            padding: const EdgeInsets.all(12),
            child: Text(h, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          )).toList(),
        ),
        ...rows.map((row) => TableRow(
          decoration: BoxDecoration(color: Colors.white10),
          children: row.map((cell) => Padding(
            padding: const EdgeInsets.all(12),
            child: Text(cell, style: const TextStyle(fontSize: 14, color: Colors.white70), textAlign: TextAlign.center),
          )).toList(),
        )),
      ],
    );
  }

  Widget _buildTips(List<String> tips) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: tips.map((tip) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            const Icon(Icons.circle, color: Color(0xFF4ECDC4), size: 8),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                tip,
                style: const TextStyle(fontSize: 15, color: Colors.white70),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}

// ================= 3. حماية الحسابات =================
class AccountSecurityPage extends StatelessWidget {
  const AccountSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حماية الحسابات')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3A5F), Color(0xFF0F1B33)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'الحسابات الشخصية (مثل الجيميل، فيسبوك، إنستغرام) هي بوابة خطرة إذا لم تُحمى جيدًا.',
                style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.7),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 30),
              _buildSection(
                'عدم استخدام اسمك أو تاريخ ميلادك في البريد 📧',
                'مثل: ahmed1990@gmail.com.\n• الحل: استخدم بريدًا منفصلًا للتسجيل في المواقع.',
              ),
              _buildSection(
                'عدم فتح مرفقات من جهات مجهولة 📎',
                'قد تحتوي على فيروسات أو برمجيات خبيثة.',
              ),
              _buildSection(
                'عدم قبول طلبات صداقة من أشخاص لا تعرفهم 👥',
                'قد يكونون حسابات وهمية لجمع بياناتك.',
              ),
              _buildSection(
                'عدم نشر صور عائلتك أو منزلك 🏠',
                'لأنها قد تُستخدم ضدك أو للتنمر.',
              ),
              const SizedBox(height: 30),
              _buildSubtitle('كيف تفعل المصادقة الثنائية (2FA)؟ 🔐'),
              _buildTips([
                'افتح إعدادات الحساب (مثل: جيميل أو فيسبوك)',
                'اذهب إلى "الأمان" أو "كلمة المرور"',
                'اختر "المصادقة الثنائية" أو "التحقق بخطوتين"',
                'اختر: رسالة نصية، إشعار على الهاتف، أو تطبيق مثل Google Authenticator',
                'اتبع التعليمات وفعّلها',
              ]),
              const SizedBox(height: 16),
              const Text(
                '✅ مع المصادقة الثنائية، حتى لو عرف أحد كلمة المرور، لا يستطيع الدخول بدون هاتفك.',
                style: TextStyle(fontSize: 15, color: Colors.green, height: 1.6),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 30),
              _buildSubtitle('نصائح مهمة 💡'),
              _buildTips([
                'غيّر كلمات المرور كل 3-6 أشهر',
                'لا تستخدم كلمات بسيطة مثل "123456" أو "password"',
                'استخدم مدير كلمات مرور مثل Bitwarden (مجاني وآمن)',
                'لا تكتب كلمات المرور على ورقة داخل الجوال',
              ]),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A5F).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.green, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      '✅ نصيحة ذهبية:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'الحساب الآمن = كلمة مرور قوية + مصادقة ثنائية + وعي.\nابدأ اليوم، ولا تؤجل حماية نفسك.\nأنت تستحق الأمان.',
                      style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.8),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4ECDC4),
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 15, color: Colors.white70, height: 1.6),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4ECDC4),
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildTips(List<String> tips) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: tips.map((tip) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            const Icon(Icons.circle, color: Color(0xFF4ECDC4), size: 8),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                tip,
                style: const TextStyle(fontSize: 15, color: Colors.white70),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}

// ================= 4. التحذيرات الرقمية =================
class SafetyWarningsPage extends StatelessWidget {
  const SafetyWarningsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تحذيرات رقمية مهمة')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3A5F), Color(0xFF0F1B33)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'هذه التحذيرات تحميك من الأخطاء الشائعة التي قد تؤدي إلى اختراق أو نصب.',
                style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.7),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 30),
              _buildWarning(
                'عدم فتح روابط من مصادر مجهولة 🔗',
                'سواء في واتساب، إيميل، أو رسائل نصية.\nقد تكون روابط تصيد (Phishing) لسرقة بياناتك.',
              ),
              _buildWarning(
                'عدم تخزين صور حساسة في المحادثات 📸',
                'أي صورة ترسلها قد تُسرب أو تُستخدم ضدك.\nخاصة الصور الشخصية أو الحساسة.',
              ),
              _buildWarning(
                'عدم استخدام نفس كلمة المرور لكل الحسابات 🔑',
                'إذا تسربت من حساب واحد، تُفتح جميع حساباتك.\nاستخدم كلمات مرور مختلفة لكل حساب.',
              ),
              _buildWarning(
                'عدم استخدام الواي فاي العام للدخول إلى الحسابات البنكية 📶',
                'يمكن للقراصنة مراقبة ما تكتبه.\nاستخدم بيانات الهاتف (4G/5G) بدلًا من ذلك.',
              ),
              _buildWarning(
                'عدم قبول طلبات صداقة من أشخاص لا تعرفهم 👥',
                'قد يكونون حسابات وهمية لجمع بياناتك.\nتحقق من صورة الملف، المنشورات، والمشتركين المشتركين.',
              ),
              _buildWarning(
                'عدم التحدث مع أشخاص غرباء في تطبيقات الدردشة العشوائية 🗣️',
                'مثل: Omegle، Chatroulette.\nهذه المواقع خطيرة جدًا، خاصة للأطفال.',
              ),
              _buildWarning(
                'عدم إظهار وجهك أو معلوماتك في البث المباشر 📺',
                'لا تُظهر شاشة حسابك البنكي، بطاقة الهوية، أو عنوان منزلك.',
              ),
              _buildWarning(
                'عدم الثقة في كل ما تراه على الإنترنت ❌',
                'بعض الفيديوهات والأخبار مزيفة.\nتحقق من المصدر قبل مشاركة أي شيء.',
              ),
              const SizedBox(height: 30),
              _buildSummary(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWarning(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD00000),
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 15, color: Colors.white70, height: 1.6),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A5F).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD00000), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            '✅ خلاصة: 5 قواعد ذهبية للحماية',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD00000),
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 12),
          _buildTip('فعل المصادقة الثنائية على كل الحسابات المهمة.'),
          _buildTip('استخدم مدير كلمات مرور.'),
          _buildTip('لا تفتح روابط غريبة.'),
          _buildTip('لا تشارك صور بطاقة الهوية أو الحساب البنكي.'),
          _buildTip('علّم أبناءك السلامة الرقمية بلطف وثقة.'),
        ],
      ),
    );
  }

  Widget _buildTip(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          const Icon(Icons.circle, color: Color(0xFFD00000), size: 8),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, color: Colors.white70),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

// ================= 5. التطبيق العملي المتقدم =================
class PracticePage extends StatelessWidget {
  const PracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('التطبيق العملي المتقدم 💡')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3A5F), Color(0xFF0F1B33)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 20),
              const Text(
                '🔐 فحص كلمة المرور المتقدم',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4ECDC4),
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 10),
              const PasswordCheckerPro(),
              const SizedBox(height: 20),
              const Text(
                '🔍 كشف الروابط الضارة (Phishing Detector)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4ECDC4),
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 10),
              const PhishingDetector(),
              const SizedBox(height: 20),
              const Text(
                '📘 موسوعة الأمن (Cyber Glossary)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4ECDC4),
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 10),
              const GlossaryList(),
              const SizedBox(height: 20),
              const Text(
                '🃏 البطاقات التفاعلية',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4ECDC4),
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 10),
              const FlashcardsSection(),
              const SizedBox(height: 20),
              const Text(
                '❓ الأسئلة السريعة',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4ECDC4),
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 10),
              const FAQBot(),
              const SizedBox(height: 20),
              const Text(
                '🎮 لعبة الحماية الرقمية',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4ECDC4),
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 10),
              const SecurityGame(),
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
  String _comparison = ''; // ✅ تم الاحتفاظ بمقارنة كلمات المرور الشائعة فقط
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

    // --- إذا كانت فارغة، نعيد الضبط ---
    if (password.isEmpty) {
      _resetState();
      if (mounted) setState(() {});
      return;
    }

    // --- تحليل المعايير ---
    _criteria[0]['met'] = password.length >= 8;
    _criteria[1]['met'] = RegExp(r'[A-Z]').hasMatch(password);
    _criteria[2]['met'] = RegExp(r'[a-z]').hasMatch(password);
    _criteria[3]['met'] = RegExp(r'[0-9]').hasMatch(password);
    _criteria[4]['met'] = RegExp(r'''[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:\'",<>\.\?\/\\|]''').hasMatch(password);

    for (var criterion in _criteria) {
      if (criterion['met']) {
        score += criterion['weight'] as int;
      }
    }

    // --- تقييم القوة ---
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

    // --- مقارنة مع كلمات مرور شائعة ---
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
    // إعادة ضبط حالة المعايير
    for (var criterion in _criteria) {
      criterion['met'] = false;
    }
  }

  void _compareWithCommonPasswords(String password) {
    List<String> commonPasswords = [
      '123456', 'password', '123456789', '12345678', '12345', '1234567',
      'qwerty', 'abc123', 'password1', '111111', '1234567890', 'iloveyou'
    ];

    if (commonPasswords.contains(password.toLowerCase())) {
      _comparison = '⚠️ هذه كلمة مرور شائعة جدًا وسهلة الاختراق!';
    } else if (password.length < 8) {
      _comparison = '⚠️ كلمة المرور قصيرة جدًا — يُنصح باستخدام 12 حرفًا فأكثر.';
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
                border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
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
            // --- قوة كلمة المرور ---
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
            // --- مقارنة مع كلمات مرور شائعة ---
            if (_comparison.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _comparison.contains('⚠️') ? Colors.red.withOpacity(0.2) : Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _comparison.contains('⚠️') ? Colors.red : Colors.green,
                    width: 1,
                  ),
                ),
                child: Text(
                  _comparison,
                  style: TextStyle(
                    color: _comparison.contains('⚠️') ? Colors.red : Colors.green,
                    fontSize: 14,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            const SizedBox(height: 20),
            // --- المعايير --- ✅ تظهر فقط إذا كان هناك نص مدخل
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
                        criterion['met']! ? Icons.check_circle : Icons.cancel,
                        color: criterion['met']! ? Colors.green : Colors.red,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          criterion['text']!,
                          style: TextStyle(
                            color: criterion['met']! ? Colors.white : Colors.white70,
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
            // --- رسالة توعوية ---
            if (_controller.text.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _strengthColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _strengthColor.withOpacity(0.5), width: 1.5),
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
                      Text(
                        '💡 نصيحة: استخدم 12 حرفًا فأكثر، مع مزيج من الأحرف الكبيرة والصغيرة والأرقام والرموز.',
                        style: const TextStyle(
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

// ================= كشف الروابط الضارة (Phishing Detector) =================
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

    // --- إضافة https:// إذا لم تكن موجودة ---
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    setState(() {
      _isLoading = true;
      _result = '';
    });

    // --- محاكاة تأخير بسيط لتحسين UX ---
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;

      bool isSafe = true;
      List<String> warnings = [];

      // --- 1. التحقق من HTTPS ---
      if (!url.startsWith('https://')) {
        isSafe = false;
        warnings.add('• لا يستخدم تشفير HTTPS الآمن.');
      }

      // --- 2. التحقق من وجود IP بدلاً من Domain ---
      String? host;
      try {
        Uri uri = Uri.parse(url);
        host = uri.host;
      } catch (e) {
        setState(() {
          _isLoading = false;
          _result = 'رابط غير صالح. تأكد من صيغته (مثال: https://example.com)';
          _resultColor = Colors.red;
        });
        return;
      }

      // --- نمط IP (IPv4 بسيط) ---
      final ipRegex = RegExp(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$');
      if (ipRegex.hasMatch(host!)) {
        isSafe = false;
        warnings.add('• يستخدم عنوان IP مباشر بدلاً من اسم نطاق (Domain)، وهذا غير معتاد وقد يكون خطيرًا.');
      }

      // --- 3. التحقق من كلمات مشبوهة في الرابط ---
      List<String> suspiciousWords = ['login', 'secure', 'verify', 'account', 'update', 'free', 'win', 'prize', 'gift'];
      String urlLower = url.toLowerCase();

      for (String word in suspiciousWords) {
        if (urlLower.contains(word) && !host.contains(word)) {
          warnings.add('• يحتوي على كلمة مشبوهة: "$word".');
        }
      }

      // --- عرض النتيجة ---
      if (isSafe && warnings.isEmpty) {
        _showResult('✅ الرابط آمن للاستخدام.', Colors.green);
      } else if (isSafe) {
        _showResult('⚠️ الرابط يستخدم HTTPS، لكن:\n' + warnings.join('\n'), Colors.orange);
      } else {
        _showResult('🚨 الرابط قد يكون خطيرًا للأسباب التالية:\n' + warnings.join('\n'), Colors.red);
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
            Text(
              'أدخل أي رابط (URL) وسأحلله لك فورًا لتحديد مدى أمانه.',
              style: const TextStyle(fontSize: 14, color: Colors.white70),
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                backgroundColor: const Color(0xFF4ECDC4),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black,
                      ),
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
  const GlossaryList({super.key}); // ✅ Added const constructor

  static const List<Map<String, String>> terms = [
    const {'term': 'Phishing', 'meaning': 'التصيد: محاولة خداعك لسرقة بياناتك عبر روابط أو رسائل تبدو رسمية.'},
    const {'term': 'Malware', 'meaning': 'برامج خبيثة: برمجيات تضر بجهازك، مثل الفيروسات أو برامج التجسس.'},
    const {'term': 'Firewall', 'meaning': 'جدار الحماية: نظام يمنع الوصول غير المصرح به إلى جهازك.'},
    const {'term': '2FA', 'meaning': 'المصادقة الثنائية: طبقة أمان إضافية تتطلب شيئين للدخول (كلمة مرور + هاتف).'},
    const {'term': 'VPN', 'meaning': 'شبكة افتراضية خاصة: تحمي اتصالك بالإنترنت من المراقبة.'},
    const {'term': 'Encryption', 'meaning': 'التشفير: تحويل البيانات إلى شكل غير قابل للقراءة من قبل الغرباء.'},
    const {'term': 'Ransomware', 'meaning': 'برمجية فدية: تُشفّر ملفاتك وتطلب فدية لاستعادتها.'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: terms.length,
      separatorBuilder: (_, __) => const Divider(color: Colors.grey, indent: 20, endIndent: 20),
      itemBuilder: (context, index) {
        final term = terms[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

class _FlashcardsSectionState extends State<FlashcardsSection> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isFlipped = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<Map<String, String>> flashcards = [
    {
      'question': 'ما هو التصيد الإلكتروني؟',
      'answer': 'محاولة خداعك لسرقة بياناتك عبر روابط أو رسائل تبدو رسمية.'
    },
    {
      'question': 'لماذا نفعل المصادقة الثنائية؟',
      'answer': 'لإضافة طبقة حماية إضافية، حتى لو عرف أحد كلمة المرور.'
    },
    {
      'question': 'كيف نحمي بطاقة الدفع؟',
      'answer': 'بعدم كتابة بياناتها على مواقع غير موثوقة، واستخدام بطاقة افتراضية.'
    },
    {
      'question': 'ماذا نفعل إذا تعرضنا لابتزاز؟',
      'answer': 'لا ندفع، نحفظ الأدلة، ونبلغ الجهات المختصة فوراً.'
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_isFlipped) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    if (mounted) {
      setState(() {
        _isFlipped = !_isFlipped;
      });
    }
  }

  void _nextCard() {
    if (_currentIndex < flashcards.length - 1) {
      if (mounted) {
        setState(() {
          _currentIndex++;
          _isFlipped = false;
          _controller.reset();
        });
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🎉 أكملت جميع البطاقات!'),
            backgroundColor: Color(0xFF4ECDC4),
            duration: Duration(seconds: 2),
          ),
        );
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              _currentIndex = 0;
              _isFlipped = false;
              _controller.reset();
            });
          }
        });
      }
    }
  }

  void _previousCard() {
    if (_currentIndex > 0) {
      if (mounted) {
        setState(() {
          _currentIndex--;
          _isFlipped = false;
          _controller.reset();
        });
      }
    }
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
                color: const Color(0xFF1E3A5F).withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF4ECDC4), width: 1),
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
            GestureDetector(
              onTap: _flipCard,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final angle = _animation.value * 3.14159;
                  final transform = Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(angle);
                  return Transform(
                    transform: transform,
                    alignment: Alignment.center,
                    child: angle < 1.57
                        ? _buildCardFace(
                            flashcards[_currentIndex]['question']!,
                            Icons.help_outline,
                            const Color(0xFF1E3A5F),
                          )
                        : _buildCardFace(
                            flashcards[_currentIndex]['answer']!,
                            Icons.check_circle,
                            const Color(0xFF4ECDC4),
                          ),
                  );
                },
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
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  icon: const Icon(Icons.arrow_back_ios_new, size: 16),
                  label: const Text('السابق'),
                ),
                ElevatedButton.icon(
                  onPressed: _nextCard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4ECDC4),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  icon: Icon(_currentIndex < flashcards.length - 1 ? Icons.arrow_forward_ios : Icons.refresh),
                  label: Text(_currentIndex < flashcards.length - 1 ? 'التالي' : 'إعادة'),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: Text(
                'انقر على البطاقة لقلبها 🔄',
                style: TextStyle(fontSize: 12, color: Colors.white70, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardFace(String text, IconData icon, Color bgColor) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(icon, size: 30, color: Colors.white),
          const SizedBox(height: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                height: 1.6,
                fontWeight: FontWeight.w500,
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
    'بريد': 'لتحمي بريدك: استخدم كلمة مرور قوية، فعل 2FA، ولا تفتح روابط مشبوهة.',
    'حساب': 'استخدم كلمة مرور قوية، فعل 2FA، ولا تشارك بياناتك مع أحد.',
    'دفع': 'لا تكتب بيانات بطاقة الدفع على مواقع غير موثوقة. تأكد من أن الموقع يبدأ بـ https://.',
    'طفل': 'استخدم أدوات الرقابة الأبوية، حدّد وقت الشاشة، وعلّمه ألا يتحدث مع غرباء.',
    'روابط': 'لا تنقر على روابط من جهات مجهولة. قد تكون تصيداً إلكترونياً.',
    'سرقة': 'لتجنب السرقة: لا تستخدم كلمات مرور بسيطة، ولا تفتح روابط غريبة.',
    'تحديث': 'حدّث تطبيقاتك وهاتفك باستمرار. التحديثات تصلح الثغرات الأمنية.',
    'خصوصية': 'اجعل حساباتك خاصة، ولا تشارك معلوماتك الشخصية على الإنترنت.',
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
                for (String q in ['بريد', 'حساب', 'دفع', 'طفل', 'روابط', 'سرقة', 'تحديث', 'خصوصية'])
                  GestureDetector(
                    onTap: () => _ask(q),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF1A365D),
                            Color(0xFF2C5282),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xFF4ECDC4).withOpacity(0.5), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4ECDC4).withOpacity(0.2),
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
                    border: Border.all(color: const Color(0xFF4ECDC4), width: 2),
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      const Icon(Icons.check_circle, color: Color(0xFF4ECDC4), size: 20),
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

class _SecurityGameState extends State<SecurityGame> with SingleTickerProviderStateMixin {
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
      'question': 'ما الفرق بين "https://" و "http://"؟',
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
        backgroundColor: const Color(0xFF1E3A5F),
        title: const Text(
          '🎉 انتهت اللعبة!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF4ECDC4), fontSize: 24, fontWeight: FontWeight.bold),
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              backgroundColor: const Color(0xFF4ECDC4),
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
                color: const Color(0xFF4ECDC4).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF4ECDC4), width: 1.5),
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
                buttonColor = const Color(0xFF1E3A5F);
              } else {
                if (isSelected) {
                  buttonColor = isCorrect ? Colors.green : Colors.red;
                } else {
                  buttonColor = isCorrect ? Colors.green.withOpacity(0.3) : null;
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  onPressed: _answerSubmitted ? null : () => _checkAnswer(option, i),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    side: BorderSide(
                      color: isSelected ? Colors.white : buttonColor == const Color(0xFF1E3A5F) ? Colors.white24 : Colors.transparent,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        option,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

// ================= البوت الذكي =================
class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final CyberKnowledgeBase _knowledgeBase = CyberKnowledgeBase();
  List<Map<String, String>> messages = [];

  @override
  void initState() {
    super.initState();
    _addBotMessage(
      '👋 أهلاً بك في **CyberSecurity Pro**!\n'
      'أنا الذكاء الاصطناعي المتخصص في الأمن السيبراني. \n'
      'سأجيبك بدقة على أي سؤال يتعلق بالحماية من الهكر، البرمجيات الخبيثة، التصيد، وهندسة اجتماعية.\n'
      '💡 **جرب أن تسأل عن:**\n'
      '• كيفية حماية حسابك من الاختراق؟\n'
      '• ما هو الـ Phishing وكيف أتجنبه؟\n'
      '• أفضل إعدادات الخصوصية على واتساب؟\n'
      '• كيف أحمي طفلي على الإنترنت؟\n'
      '• ما الفرق بين Firewall و Antivirus؟\n'
      '• كيف أعرف أن جهازي مخترق؟\n'
      'أنا هنا لمساعدتك 24/7. اسألني الآن! 🛡️',
    );
  }

  void _addBotMessage(String text) {
    if (!mounted) return;
    setState(() {
      messages.add({
        'sender': 'bot',
        'text': text,
      });
    });
    _scrollToBottom();
  }

  void _sendMessage() {
    String userMessage = _controller.text.trim();
    if (userMessage.isEmpty || !mounted) return;

    setState(() {
      messages.add({
        'sender': 'user',
        'text': userMessage,
      });
      _controller.clear();
    });

    String reply = _knowledgeBase.getReply(userMessage);
    Future.delayed(const Duration(milliseconds: 600), () {
      _addBotMessage(reply);
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted && _scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('البوت الذكي 🤖 | CyberSecurity Pro'),
          backgroundColor: const Color(0xFF1E3A5F),
          actions: [
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.white),
              onPressed: () {
                setState(() {
                  messages.clear();
                  _addBotMessage('🧹 تم مسح المحادثة.\n' + _knowledgeBase.getWelcomeMessage());
                });
              },
              tooltip: 'مسح المحادثة',
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: messages.isEmpty
                  ? const Center(
                      child: Text(
                        'ابدأ المحادثة بكتابة سؤالك...',
                        style: TextStyle(color: Colors.white54, fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[index];
                        bool isUser = msg['sender'] == 'user';
                        return Align(
                          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isUser ? const Color(0xFF4ECDC4) : const Color(0xFF2D3748),
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(18),
                                topRight: const Radius.circular(18),
                                bottomLeft: isUser ? const Radius.circular(18) : const Radius.circular(4),
                                bottomRight: isUser ? const Radius.circular(4) : const Radius.circular(18),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: SelectionArea(
                              child: Text(
                                msg['text']!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'اكتب سؤالك عن الأمن السيبراني...',
                        hintStyle: const TextStyle(color: Colors.white54, fontSize: 14),
                        filled: true,
                        fillColor: Colors.white10,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    backgroundColor: const Color(0xFF4ECDC4),
                    foregroundColor: Colors.black,
                    onPressed: _sendMessage,
                    tooltip: 'إرسال',
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

// --- فئة قاعدة المعرفة المتقدمة ---
class CyberKnowledgeBase {
  final Map<String, List<String>> _keywords = {
    'حساب': ['حساب', 'اكونت', 'login', 'account', 'تسجيل دخول', 'حسابي', 'حسابك'],
    'كلمة المرور': ['كلمة المرور', 'باسوورد', 'password', 'pass', 'سر', 'رمز السر'],
    'هكر': ['هكر', 'اختراق', 'هاكر', 'hacker', 'hack', 'crack', 'مخترق', 'اختُرقت'],
    'حماية': ['حماية', 'أمن', 'security', 'safe', 'secure', 'أمان', 'تحمي'],
    'فيروس': ['فيروس', 'malware', 'virus', 'برمجيات خبيثة', 'برنامج ضار', 'برمجية خبيثة'],
    'تصيد': ['تصيد', 'phishing', 'خداع', 'احتيال', 'نصب', 'رسالة مزيفة', 'رابط مزيف'],
    'شبكة': ['شبكة', 'network', 'واي فاي', 'wifi', 'راوتر', 'firewall', 'نت'],
    'نظام': ['نظام', 'system', 'windows', 'mac', 'لينكس', 'linux', 'تحديث', 'تحديثات'],
    'طفل': ['طفل', 'أطفال', 'ابني', 'ابنتي', 'child', 'kids', 'parental', 'طفلي', 'أطفالك'],
    'دفع': ['دفع', 'شراء', 'بطاقة', 'credit', 'payment', 'shopping', 'تسوق', 'دفع إلكتروني'],
    'خصوصية': ['خصوصية', 'privacy', 'private', 'إعدادات', 'settings', 'إعدادات الخصوصية'],
    'ابتزاز': ['ابتزاز', 'blackmail', 'تهديد', 'تهديدي', 'صور', 'فيديوهات', 'ابتزاز إلكتروني'],
    'هندسة اجتماعية': ['هندسة اجتماعية', 'social engineering', 'خداع نفسي', 'نصب', 'خداع'],
    'vpn': ['vpn', 'شبكة خاصة', 'مجهول', 'anonymous', 'بروكسي', 'في بي إن'],
    'مصادقة ثنائية': ['مصادقة ثنائية', '2fa', 'two factor', 'تحقق بخطوتين', 'رمز التحقق'],
    'جهاز': ['جهاز', 'كمبيوتر', 'موبايل', 'هاتف', 'device', 'phone', 'laptop', 'تابلت'],
    'واتساب': ['واتساب', 'whatsapp', 'تلغرام', 'telegram', 'سناب', 'snapchat', 'انستا', 'فيسبوك'],
    'سحابة': ['سحابة', 'cloud', 'aws', 'azure', 'icloud', 'onedrive', 'dropbox', 'googledrive'],
    'ذكاء اصطناعي': ['ذكاء اصطناعي', 'ai', 'machine learning', 'deep learning', 'chatgpt', 'ai security', 'بوت'],
    'نسخ احتياطي': ['نسخ احتياطي', 'backup', 'استرجاع', 'استعادة', 'data backup', 'نسخة احتياطية', 'حفظ البيانات'],
    // ✅ إضافات جديدة:
    'بلوك تشين': ['بلوك تشين', 'blockchain', 'سلسلة الكتل', 'بيتكوين', 'عملات رقمية'],
    'هكر أخلاقي': ['هكر أخلاقي', 'ethical hacking', 'اختبار اختراق', 'pentest'],
    'كاميرا': ['كاميرا', 'كاميرا ويب', 'webcam', 'كاميرا الموبايل', 'كاميرا اللاب'],
    'سماعة': ['سماعة', 'ميكروفون', 'mic', 'مايك', 'مايكروفون'],
    'فيسبوك': ['فيسبوك', 'facebook', 'فيس', 'فيس بوك'],
    'انستقرام': ['انستقرام', 'instagram', 'انستا', 'انستجرام'],
    'تويتر': ['تويتر', 'twitter', 'إكس', 'x'],
    'يوتيوب': ['يوتيوب', 'youtube', 'يوتيوب كيدز'],
  };

  String getWelcomeMessage() {
    return '🌟 أهلاً بك مع **سيبرو**، صديقك الذكي في عالم الأمن الرقمي! 🤖\n'
        'أنا هنا علشان أساعدك تحمي نفسك وأهلك من أي خطر إلكتروني.\n'
        'اسألني أي سؤال — حتى لو كان يبدو بسيطًا — وأنا أجاوبك بأسلوب سهل وعملي!';
  }

  String getReply(String query) {
    query = query.toLowerCase().trim();

    // ✅ إذا المستخدم قال "مرحبا" أو "هلا"
    if (query.contains('مرحبا') || query.contains('هلا') || query.contains('اهلا') || query.contains('hello')) {
      return _formatResponse(
        '👋 أهلاً وسهلاً يا صديقي!',
        [
          'أنا **سيبرو**، مساعدك الشخصي في الأمن السيبراني 🤖🛡️',
          'مستعد أساعدك في أي شيء: من حماية حسابك، لحماية طفلك، لتجنب النصب الإلكتروني.',
          '💡 جرب تسألني: "كيف أحمي بريدي؟" أو "شو أعمل إذا ابتزوني؟"',
          'أنا هنا 24/7، وما بخليك تواجه الخطر لوحدك ❤️',
        ],
      );
    }

    // ✅ إذا المستخدم شكر
    if (query.contains('شكرا') || query.contains('thank') || query.contains('ممتاز') || query.contains('رائع')) {
      return _formatResponse(
        '🥰 يسعدني مساعدتك!',
        [
          'هذا واجبي — وأنا فخور إني أساعدك تحمي نفسك وأهلك.',
          'لو عندك أي سؤال ثاني، ما تتردد تسألني.',
          'شارك التطبيق مع أصحابك — كلنا نستحق نعيش بأمان رقمي 🌍🔐',
        ],
      );
    }

    // ✅ الحسابات وكلمات المرور
    if (_matches(query, ['حساب', 'كلمة المرور', 'باسوورد'])) {
      return _formatResponse(
        '🔐 يا صديقي، حسابك هو قصرك الرقمي — خليه محصن! 🏰',
        [
          '🔑 **كلمة المرور القوية**: استخدم 12 حرفًا فأكثر — مزيج من حروف كبيرة، صغيرة، أرقام، ورموز. مثال: `MyP@ssw0rd!2025`',
          '📱 **المصادقة الثنائية (2FA)**: إلزامية! استخدم تطبيق زي Google Authenticator — أحسن من الرسائل النصية.',
          '🧠 **مدير كلمات المرور**: استخدم Bitwarden (مجاني) — بيحفظلك كل كلمات السر وبيولدها قوية.',
          '🚫 **تحذير ذهبي**: لا تستخدم نفس كلمة المرور لأكثر من حساب — لو تسرب واحد، بيكون كلهم في خطر!',
          '⏰ **نصيحة مجانية**: غير كلمات السر كل 6 شهور — خاصة للبريد والبنك.',
        ],
      );
    }

    // ✅ الهكر والاختراق
    if (_matches(query, ['هكر', 'اختراق', 'هاكر'])) {
      return _formatResponse(
        '🛡️ لا تخف — مع سيبرو، أنت بأمان! 🤖',
        [
          '🔄 **حدّث جهازك**: أهم خطوة! التحديثات بتصلح ثغرات يقدر يستغلها الهاكر.',
          '🧱 **فعّل جدار الحماية (Firewall)**: موجود في إعدادات جهازك — شغّله وخلّيه يشتغل دائمًا.',
          '🦠 **برنامج مكافحة فيروسات**: استخدم Bitdefender أو Kaspersky — مجانيين وفعّالين.',
          '📧 **لا تفتح مرفقات مشبوهة**: حتى لو من "صديق" — ممكن يكون جهازه مخترق!',
          '🚨 **إشارات الاختراق**: بطء في الجهاز، نوافذ منبثقة، أو نشاط غريب في الحسابات — روح للطبيب الرقمي فورًا!',
        ],
      );
    }

    // ✅ التصيد وهندسة اجتماعية
    if (_matches(query, ['تصيد', 'هندسة اجتماعية', 'خداع', 'احتيال'])) {
      return _formatResponse(
        '🎣 انتبه! العالم الرقمي مليان صيادين — بس مع سيبرو، مش هتصطادك! 😉',
        [
          '📧 **التصيد (Phishing)**: محاولات انتحال هوية بنوك أو شركات عشان يسرقوا بياناتك — دائمًا تحقق من الرابط والمرسل.',
          '🛑 **قاعدة ذهبية**: لا تنقر على أي رابط في إيميل أو رسالة — حتى لو بدا رسمي. اكتب الرابط يدويًا في المتصفح.',
          '🎭 **هندسة اجتماعية**: شخص يتصل فيك ويقول إنه من الدعم الفني ويطلب صلاحيات — ده خدعة! ما تعطيه أي صلاحيات.',
          '😂 **مثال طريف**: "فزت بسيارة!" — لو كنت فزت، كنت عارف من غير ما يرسلوا لك! 😄',
          '🛡️ **نصيحة سيبرو**: شكّك في كل حاجة — الشك ده حمايتك!',
        ],
      );
    }

    // ✅ حماية الأطفال
    if (_matches(query, ['طفل', 'أطفال', 'parental'])) {
      return _formatResponse(
        '👨‍👩‍👧‍👦 حماية طفلك على الإنترنت أهم من أي لعبة أو فيلم! 💖',
        [
          '⏱️ **حدد وقت الشاشة**: استخدم Google Family Link أو Screen Time — علشان ما يضيع وقته.',
          '🚫 **عطّل الدردشة في الألعاب**: كتير من الألعاب فيها دردشة — خليك حذر وعطّلها.',
          '📺 **استخدم YouTube Kids**: مخصص للأطفال — وبيحميهم من المحتوى غير المناسب.',
          '💬 **علّمه**: "ما تكلم غريب، وما تشارك صورك، وإذا حسيت بخوف، قول لأبوك أو أمك فورًا".',
          '🔄 **حدّث أجهزته**: التحديثات بتصلح ثغرات — خليك دايماً محدث.',
        ],
      );
    }

    // ✅ الدفع والتسوق الآمن
    if (_matches(query, ['دفع', 'شراء', 'بطاقة', 'credit'])) {
      return _formatResponse(
        '💳 التسوق الإلكتروني ممتع — بس لازم يكون آمن! 🛍️',
        [
          '📶 **لا تستخدم الواي فاي العام للدفع**: استخدم بيانات الجوال (4G/5G) — أأمن بكتير.',
          '🛒 **استخدم PayPal أو Apple Pay**: ما يخليك تدخل بيانات بطاقتك مباشرة — بيحمي بياناتك.',
          '💳 **بطاقة افتراضية**: اطلبها من البنك — برصيد محدود، حتى لو سُرقت، الخسارة مش كبيرة.',
          '🔒 **تأكد من القفل**: شوف رمز القفل 🔒 في شريط الرابط — ده معناه أن الموقع آمن.',
          '🔔 **فعّل الإشعارات**: علشان تعرف بأي عملية شراء فورًا — لو ما عملتهاش، تقدر تبلغ البنك.',
        ],
      );
    }

    // ✅ الخصوصية
    if (_matches(query, ['خصوصية', 'واتساب', 'privacy', 'settings'])) {
      return _formatResponse(
        '🙈 خصوصيتك حقك — ما تفرّط فيها! 🛡️',
        [
          '📵 **واتساب**: روح لإعدادات > الحساب > الخصوصية — غير "آخر ظهور" و"صورة الملف" لـ "جهات الاتصال فقط".',
          '👥 **فيسبوك/إنستغرام**: خلي حسابك خاص — وما تشارك معلوماتك الشخصية (عنوان، رقم هاتف، تاريخ ميلاد).',
          '🌐 **جوجل**: روح لـ myaccount.google.com — وأوقف تتبع الموقع والنشاط إذا ما كنتش محتاجه.',
          '🔐 **المصادقة الثنائية**: فعّلها على كل حساباتك — دي خط دفاعك الثاني لو حد عرف كلمة سرك.',
          '🤖 **نصيحة سيبرو**: خصوصيتك مش رفاهية — دي حقك، وواجبك تحميها.',
        ],
      );
    }

    // ✅ الـ VPN
    if (_matches(query, ['vpn', 'شبكة', 'واي فاي', 'network'])) {
      return _formatResponse(
        '🌐 الـ VPN صديقك على الواي فاي العام — بس اختاره بحكمة! 🤫',
        [
          '🔐 **وظيفته**: بيشفر اتصالك ويخبي عنوان IP — ماحدش يقدر يراقبك.',
          '⚠️ **تجنب المجاني**: كتير من الـ VPN المجاني بيبع بياناتك — استخدم NordVPN أو ExpressVPN.',
          '🧱 **جدار الحماية**: فعّله في جهازك — بيحميك من أي محاولة اختراق عبر الشبكة.',
          '📡 **راوتر آمن**: غير كلمة السر الافتراضية — وفعّل التشفير WPA3.',
          '🚫 **تحذير**: لا تستخدم واي فاي مفتوح (بدون باسورد) للدخول على حساباتك أو الدفع — خطر جدًا!',
        ],
      );
    }

    // ✅ الابتزاز الإلكتروني
    if (_matches(query, ['ابتزاز', 'blackmail', 'تهديد'])) {
      return _formatResponse(
        '🚨 لو تعرضت لابتزاز — متستسلمش! أنا معاك 🤝',
        [
          '🛑 **لا تدفع أبدًا**: الدفع ما بيوقفش المبتز — بيطلب أكثر!',
          '📸 **احفظ الأدلة**: خذ سكرين شوت للرسائل والروابط — دي هتساعدك لما تبلغ.',
          '📞 **أبلغ فورًا**: روح لأقرب مركز شرطة أو راسل هيئة الجرائم الإلكترونية في بلدك.',
          '🔐 **غيّر كلمات السر**: غير كل كلمات السر فورًا — خاصة للحسابات المهمة.',
          '❤️ **دعم نفسي**: ما تحسش بالخجل — أنت الضحية. كلم أصدقاءك أو متخصص — ما تواجه الموضوع لوحدك.',
        ],
      );
    }

    // ✅ التخزين السحابي
    if (_matches(query, ['سحابة', 'cloud', 'aws', 'azure'])) {
      return _formatResponse(
        '☁️ السحابة مريحة — بس لازم تحميها زي بيتك! 🏠',
        [
          '🔐 **كلمة مرور قوية + 2FA**: دي أساس الحماية — ما تهملهاش.',
          '🔒 **فعّل التشفير**: في Google Drive أو iCloud — شغّل "Encryption at Rest".',
          '📱 **راجع الأجهزة المرتبطة**: في إعدادات حسابك — افصل أي جهاز ما تعرفوش.',
          '📂 **ما تخزنش ملفات حساسة بدون تشفير**: جوازات، فواتير، صور خاصة — استخدم Cryptomator.',
          '💾 **استراتيجية 3-2-1**: 3 نسخ، على وسائط مختلفة (سحابة + هارد خارجي)، واحدة خارج المنزل.',
        ],
      );
    }

    // ✅ الذكاء الاصطناعي
    if (_matches(query, ['ذكاء اصطناعي', 'ai', 'machine learning'])) {
      return _formatResponse(
        '🤖 الذكاء الاصطناعي سلاح ذو حدين — نستخدمه بحكمة! ⚔️',
        [
          '🛡️ **بيساعد في الأمن**: بيكتشف هجمات وتصيد بسرعة — أحسن من البشر أحيانًا!',
          '🎣 **بيستخدم في الهجمات**: بيولد إيميلات ورسائل تصيد واقعية جدًا — خليك حذر!',
          '🎭 **احذر من الـ Deepfake**: صور وفيديوهات مزيفة — ممكن تستخدم للابتزاز أو التضليل.',
          '💡 **نصيحة سيبرو**: الـ AI أداة — مش بديل للإنسان. استخدمه بذكاء، وما تثق في كل حاجة يصنعها.',
          '⚠️ **خليك حذر من التطبيقات**: اللي بتطلب صلاحيات غريبة باسم "ذكاء اصطناعي" — ممكن تكون خطرة!',
        ],
      );
    }

    // ✅ النسخ الاحتياطي
    if (_matches(query, ['نسخ احتياطي', 'backup', 'استرجاع'])) {
      return _formatResponse(
        '💾 النسخ الاحتياطي هو مظلة أمانك — خليك دايماً مستعد! ☔',
        [
          '📅 **انسخ بانتظام**: كل أسبوع للملفات العادية — وكل يوم للملفات المهمة (شغل، دراسة).',
          '🔢 **استخدم قاعدة 3-2-1**: 3 نسخ، على وسائط مختلفة (كمبيوتر + هارد خارجي + سحابة)، واحدة خارج المنزل.',
          '🔐 **تشفير النسخ**: لما تنزل على السحابة — استخدم Cryptomator أو Boxcryptor.',
          '🧪 **اختبر الاسترجاع**: كل 3 شهور — جرب ترجع ملف من النسخة — تأكد إنها شغالة.',
          '📌 **مثال عملي**: ملفاتك على اللاب + نسخة على هارد خارجي + نسخة مشفرة على Google Drive.',
        ],
      );
    }

    // ✅ الهكر الأخلاقي
    if (_matches(query, ['هكر أخلاقي', 'ethical hacking'])) {
      return _formatResponse(
        '🦸‍♂️ الهكر الأخلاقي — البطل اللي بيدافع عنك! 🦸‍♀️',
        [
          '🔍 **وظيفته**: بيدور على ثغرات في الأنظمة قبل ما الهاكر الحقيقي يلاقيها — وبيصلحها!',
          '🎓 **عايز تتعلمه؟**: ابدأ بأساسيات الشبكات والأمن — بعد كده دور على شهادات زي CEH أو OSCP.',
          '💻 **أدواته**: Kali Linux, Metasploit, Burp Suite — أدوات احترافية بس للدفاع فقط!',
          '⚖️ **مهم جدًا**: الهكر الأخلاقي شرعي بس بإذن — من غير إذن، ده جريمة!',
          '💡 **نصيحة سيبرو**: لو عايز تبدأ، جرب مواقع زي Hack The Box أو TryHackMe — بتعلم بطريقة عملية.',
        ],
      );
    }

    // ✅ البلوك تشين والعملات الرقمية
    if (_matches(query, ['بلوك تشين', 'blockchain', 'عملات رقمية'])) {
      return _formatResponse(
        '⛓️ البلوك تشين تقنية ثورية — بس لازم تتعامل معاها بحذر! 💰',
        [
          '🔐 **الأمان في يدك**: محفظتك الرقمية — كلمة السر بتاعتها لو ضاعت، ضاعت فلوسك للأبد!',
          '⚠️ **احذر من النصب**: كتير من المواقع والعملات وهمية — تحقق من المصدر قبل ما تستثمر.',
          '🌐 **البلوك تشين مش مجهول 100%**: المعاملات عامة — بس ممكن تربطها بيك لو ما احتراستش.',
          '💾 **احفظ مفتاحك الخاص (Private Key)**: في مكان آمن — لو حد شافه، يقدر يسرق كل حاجة!',
          '💡 **نصيحة سيبرو**: لا تستثمر فلوسك كلها — خليك دايماً محتاط، واللي ما تفهموش، ما تدخلش فيه.',
        ],
      );
    }

    // ✅ الكاميرا والميكروفون
    if (_matches(query, ['كاميرا', 'سماعة', 'mic', 'ميكروفون'])) {
      return _formatResponse(
        '📹 الكاميرا والميكروفون — نعمة ممكن تتحول لكابوس! 😱',
        [
          '🛡️ **غطّي الكاميرا**: لاصق صغير على الكاميرا — أبسط وأأمن حل!',
          '🔇 **عطّل الميكروفون**: لما ما تستخدموش — في إعدادات الجهاز أو ببرنامج زي OBS.',
          '📱 **راجع الصلاحيات**: في إعدادات الجوال أو اللاب — شوف مين عنده صلاحية الوصول للكاميرا والميك.',
          '🚨 **تحذير**: كتير من البرمجيات الخبيثة بتدخل على الكاميرا والميك — خليك دايماً محدث ومحمي.',
          '💡 **نصيحة سيبرو**: لما تخلص من مكالمة أو مؤتمر — تأكد إنك قفلت الكاميرا والميك!',
        ],
      );
    }

    // ✅ الرد الافتراضي الذكي
    return _formatResponse(
      '🤔 ما فهمتش سؤالك بالظبط — بس ما تيأسش! 🤗',
      [
        '💡 جرب تصيغ السؤال بطريقة تانية، أو اسأل عن:',
        '• كيف أحمي حسابي من الاختراق؟',
        '• ما هو الـ Phishing؟',
        '• كيف أعرف أن جهازي به فيروس؟',
        '• هل الـ VPN آمن؟',
        '• كيف أحمي طفلي على الإنترنت؟',
        '• شو أعمل إذا تعرضت لابتزاز؟',
        '• كيف أعمل نسخة احتياطية لملفاتي؟',
        '• هل الذكاء الاصطناعي خطير؟',
        '\nأنا هنا دائمًا علشان أساعدك — لا تتردد تسألني أي سؤال! 🤖❤️',
      ],
    );
  }

  bool _matches(String query, List<String> keywords) {
    for (String keyword in keywords) {
      if (_keywords[keyword] != null) {
        for (String synonym in _keywords[keyword]!) {
          if (query.contains(synonym)) {
            return true;
          }
        }
      } else {
        if (query.contains(keyword)) {
          return true;
        }
      }
    }
    return false;
  }

  String _formatResponse(String title, List<String> points) {
    StringBuffer sb = StringBuffer();
    sb.writeln('**$title**\n');
    for (String point in points) {
      sb.writeln('• $point');
    }
    sb.writeln('\n---\n🛡️ *تم الرد بواسطة **سيبرو** — صديقك الذكي في الأمن الرقمي 🤖*');
    return sb.toString();
  }
}