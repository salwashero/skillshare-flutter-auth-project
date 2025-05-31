// screens/blog_list_screen.dart - شاشة قائمة المدونات
import 'package:flutter/material.dart';
import '../models/blog_post.dart';
import 'blog_detail_screen.dart';

class BlogListScreen extends StatelessWidget {
  const BlogListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // شريط التطبيق
      appBar: AppBar(
        title: const Text('مدونتي'),
        elevation: 0,
        actions: [
          // زر البحث (وظيفي للمظهر فقط)
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('وظيفة البحث غير متاحة في هذا الإصدار')),
              );
            },
          ),
        ],
      ),
      
      // محتوى الشاشة - قائمة المنشورات
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: blogPosts.length,
        itemBuilder: (context, index) {
          // الحصول على منشور المدونة الحالي
          final post = blogPosts[index];
          
          // إنشاء بطاقة لكل منشور
          return Card(
            margin: const EdgeInsets.only(bottom: 20),
            child: InkWell(
              // عند النقر على البطاقة، الانتقال إلى شاشة تفاصيل المنشور
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogDetailScreen(post: post),
                  ),
                );
              },
              // تأثير التموج عند النقر
              borderRadius: BorderRadius.circular(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // صورة المنشور
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        color: Colors.grey[300],
                        child: Center(
                          child: Icon(
                            _getIconForPost(post.id),
                            size: 50,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // محتوى البطاقة
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // عنوان المنشور
                        Text(
                          post.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        // معلومات الكاتب والتاريخ
                        Row(
                          children: [
                            const Icon(Icons.person_outline, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              post.author,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const SizedBox(width: 16),
                            const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              post.date,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        
                        // ملخص المنشور
                        Text(
                          post.summary,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 16),
                        
                        // زر "اقرأ المزيد"
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            icon: const Icon(Icons.arrow_forward),
                            label: const Text('اقرأ المزيد'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlogDetailScreen(post: post),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      
      // زر عائم لإضافة منشور جديد (وظيفي للمظهر فقط)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('وظيفة إضافة منشور جديد غير متاحة في هذا الإصدار')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  
  // دالة مساعدة لاختيار أيقونة مناسبة لكل منشور بناءً على معرفه
  IconData _getIconForPost(String id) {
    switch (id) {
      case '1':
        return Icons.flutter_dash;
      case '2':
        return Icons.data_object;
      case '3':
        return Icons.design_services;
      case '4':
        return Icons.navigation;
      default:
        return Icons.article;
    }
  }
}
