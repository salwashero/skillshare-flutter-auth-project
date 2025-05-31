// screens/blog_detail_screen.dart - شاشة تفاصيل المدونة
import 'package:flutter/material.dart';
import '../models/blog_post.dart';

class BlogDetailScreen extends StatelessWidget {
  final BlogPost post;
  
  // استقبال منشور المدونة كمعامل في المنشئ
  const BlogDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // شريط التطبيق مع زر الرجوع
      appBar: AppBar(
        title: Text(
          post.title,
          // اختصار العنوان إذا كان طويلاً
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          // زر المشاركة (وظيفي للمظهر فقط)
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('وظيفة المشاركة غير متاحة في هذا الإصدار')),
              );
            },
          ),
        ],
      ),
      
      // محتوى الشاشة - تفاصيل المنشور
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المنشور
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.grey[300],
                child: Center(
                  child: Icon(
                    _getIconForPost(post.id),
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            
            // محتوى المنشور
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // عنوان المنشور
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // معلومات الكاتب والتاريخ
                  Row(
                    children: [
                      const Icon(Icons.person_outline, size: 18, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        post.author,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        post.date,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  
                  // خط فاصل
                  const Divider(height: 30),
                  
                  // محتوى المنشور
                  Text(
                    post.content,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                  
                  // خط فاصل
                  const Divider(height: 30),
                  
                  // أزرار التفاعل
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // زر الإعجاب
                      _buildInteractionButton(
                        context: context,
                        icon: Icons.thumb_up_outlined,
                        label: 'أعجبني',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تم تسجيل إعجابك بالمنشور')),
                          );
                        },
                      ),
                      
                      // زر التعليق
                      _buildInteractionButton(
                        context: context,
                        icon: Icons.comment_outlined,
                        label: 'تعليق',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('وظيفة التعليق غير متاحة في هذا الإصدار')),
                          );
                        },
                      ),
                      
                      // زر المشاركة
                      _buildInteractionButton(
                        context: context,
                        icon: Icons.share_outlined,
                        label: 'مشاركة',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('وظيفة المشاركة غير متاحة في هذا الإصدار')),
                          );
                        },
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // منشورات ذات صلة
                  const Text(
                    'منشورات ذات صلة',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // قائمة المنشورات ذات الصلة
                  _buildRelatedPosts(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // دالة مساعدة لإنشاء أزرار التفاعل
  Widget _buildInteractionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
  
  // دالة مساعدة لإنشاء قائمة المنشورات ذات الصلة
  Widget _buildRelatedPosts(BuildContext context) {
    // الحصول على منشورات ذات صلة (باستثناء المنشور الحالي)
    final relatedPosts = blogPosts.where((p) => p.id != post.id).take(2).toList();
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: relatedPosts.length,
      itemBuilder: (context, index) {
        final relatedPost = relatedPosts[index];
        
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {
              // الانتقال إلى المنشور ذي الصلة
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BlogDetailScreen(post: relatedPost),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // أيقونة المنشور
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getIconForPost(relatedPost.id),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // معلومات المنشور
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // عنوان المنشور
                        Text(
                          relatedPost.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        
                        // معلومات الكاتب والتاريخ
                        Text(
                          '${relatedPost.author} • ${relatedPost.date}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
