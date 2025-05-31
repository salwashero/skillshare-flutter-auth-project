// register_screen.dart - شاشة التسجيل
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // متحكمات لحقول الإدخال
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  // متغيرات للتحكم في إظهار/إخفاء كلمات المرور
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  
  // نموذج للتحقق من صحة البيانات
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // تحرير الموارد عند إغلاق الشاشة
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // شريط التطبيق مع زر الرجوع
      appBar: AppBar(
        title: const Text('إنشاء حساب جديد'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).primaryColor,
      ),
      
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
                      Icons.person_add_outlined,
                      size: 80,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 30),
                    
                    // حقل اسم المستخدم
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'اسم المستخدم',
                        hintText: 'أدخل اسم المستخدم',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال اسم المستخدم';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    
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
                    const SizedBox(height: 20),
                    
                    // حقل تأكيد كلمة المرور
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        labelText: 'تأكيد كلمة المرور',
                        hintText: 'أعد إدخال كلمة المرور',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء تأكيد كلمة المرور';
                        }
                        if (value != _passwordController.text) {
                          return 'كلمتا المرور غير متطابقتين';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    
                    // زر التسجيل
                    ElevatedButton(
                      onPressed: _register,
                      child: const Text(
                        'إنشاء حساب',
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
                    
                    // أزرار التسجيل بحسابات أخرى
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // زر Google
                        _socialRegisterButton(
                          icon: Icons.g_mobiledata,
                          color: Colors.red,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('التسجيل باستخدام Google غير متاح حاليًا')),
                            );
                          },
                        ),
                        const SizedBox(width: 20),
                        // زر Facebook
                        _socialRegisterButton(
                          icon: Icons.facebook,
                          color: Colors.blue,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('التسجيل باستخدام Facebook غير متاح حاليًا')),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    
                    // رابط للانتقال إلى شاشة تسجيل الدخول
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('لديك حساب بالفعل؟'),
                        TextButton(
                          onPressed: () {
                            // العودة إلى شاشة تسجيل الدخول
                            Navigator.pop(context);
                          },
                          child: const Text('سجل الدخول'),
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

  // دالة لإنشاء زر التسجيل بحساب اجتماعي
  Widget _socialRegisterButton({
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

  // دالة التسجيل
  void _register() {
    // التحقق من صحة البيانات
    if (_formKey.currentState!.validate()) {
      // هنا يمكن إضافة كود للتسجيل مع الخادم
      // لكن في هذا المثال سنكتفي بعرض رسالة نجاح والعودة إلى شاشة تسجيل الدخول
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إنشاء الحساب بنجاح')),
      );
      
      // العودة إلى شاشة تسجيل الدخول بعد ثانيتين
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
  }
}
