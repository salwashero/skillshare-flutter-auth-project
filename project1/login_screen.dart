// login_screen.dart - شاشة تسجيل الدخول
import 'package:flutter/material.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // متحكمات لحقول الإدخال
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // متغير للتحكم في إظهار/إخفاء كلمة المرور
  bool _obscurePassword = true;
  
  // نموذج للتحقق من صحة البيانات
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // تحرير الموارد عند إغلاق الشاشة
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // لون خلفية الشاشة
      backgroundColor: Colors.white,
      
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // شعار التطبيق
                    Icon(
                      Icons.lock_outline,
                      size: 80,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 30),
                    
                    // عنوان الشاشة
                    Text(
                      'تسجيل الدخول',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    // حقل البريد الإلكتروني
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'البريد الإلكتروني',
                        hintText: 'أدخل بريدك الإلكتروني',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال البريد الإلكتروني';
                        }
                        // تحقق بسيط من صيغة البريد الإلكتروني
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'الرجاء إدخال بريد إلكتروني صحيح';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    
                    // حقل كلمة المرور
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'كلمة المرور',
                        hintText: 'أدخل كلمة المرور',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال كلمة المرور';
                        }
                        if (value.length < 6) {
                          return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    
                    // زر "نسيت كلمة المرور؟"
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          // يمكن إضافة وظيفة استعادة كلمة المرور هنا
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('هذه الميزة غير متاحة حاليًا')),
                          );
                        },
                        child: const Text('نسيت كلمة المرور؟'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // زر تسجيل الدخول
                    ElevatedButton(
                      onPressed: _login,
                      child: const Text(
                        'تسجيل الدخول',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // خط فاصل مع نص "أو"
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('أو', style: TextStyle(color: Colors.grey)),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // أزرار تسجيل الدخول بحسابات أخرى
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // زر Google
                        _socialLoginButton(
                          icon: Icons.g_mobiledata,
                          color: Colors.red,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تسجيل الدخول باستخدام Google غير متاح حاليًا')),
                            );
                          },
                        ),
                        const SizedBox(width: 20),
                        // زر Facebook
                        _socialLoginButton(
                          icon: Icons.facebook,
                          color: Colors.blue,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تسجيل الدخول باستخدام Facebook غير متاح حاليًا')),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    
                    // رابط للانتقال إلى شاشة التسجيل
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('ليس لديك حساب؟'),
                        TextButton(
                          onPressed: () {
                            // الانتقال إلى شاشة التسجيل
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterScreen()),
                            );
                          },
                          child: const Text('سجل الآن'),
                        ),
                      ],
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

  // دالة لإنشاء زر تسجيل الدخول بحساب اجتماعي
  Widget _socialLoginButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, color: color, size: 30),
      ),
    );
  }

  // دالة تسجيل الدخول
  void _login() {
    // التحقق من صحة البيانات
    if (_formKey.currentState!.validate()) {
      // هنا يمكن إضافة كود للتحقق من البيانات مع الخادم
      // لكن في هذا المثال سنكتفي بعرض رسالة نجاح
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تسجيل الدخول بنجاح')),
      );
    }
  }
}
