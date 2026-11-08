import 'package:advanced_to_do_list/features/tasks/data/services/category_servies.dart';
import 'package:flutter/material.dart';
import 'package:advanced_to_do_list/theme/app_colors.dart';
// تأكد من مسار الاستيراد الصحيح للـ CategoryService بناءً على مشروعك

class AddCustomCategoryScreen extends StatefulWidget {
  const AddCustomCategoryScreen({super.key});

  @override
  State<AddCustomCategoryScreen> createState() =>
      _AddCustomCategoryScreenState();
}

class _AddCustomCategoryScreenState extends State<AddCustomCategoryScreen> {
  final _categoryNameController = TextEditingController();
  final CategoryService _categoryService = CategoryService();

  Color _selectedColor = Colors.blue;
  String _selectedIconName = 'folder';
  bool _isLoading = false;

  final List<Map<String, dynamic>> _availableIcons = [
    {'name': 'folder', 'icon': Icons.folder_outlined},
    {'name': 'star', 'icon': Icons.star_outline},
    {'name': 'work', 'icon': Icons.work_outline},
    {'name': 'home', 'icon': Icons.home_outlined},
    {'name': 'fitness', 'icon': Icons.fitness_center},
    {'name': 'code', 'icon': Icons.code},
    {'name': 'book', 'icon': Icons.book_outlined},
    {'name': 'flight', 'icon': Icons.flight},
  ];

  final List<Color> _availableColors = [
    Colors.blue,
    Colors.deepOrange,
    Colors.amber,
    Colors.redAccent,
    Colors.purple,
    Colors.green,
    Colors.teal,
    Colors.pink,
  ];

  @override
  void dispose() {
    _categoryNameController.dispose();
    super.dispose();
  }

  Future<void> _saveCategoryToFirebase() async {
    final categoryName = _categoryNameController.text.trim();
    if (categoryName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a category name.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
     
      await _categoryService.addCategory(
        name: categoryName,
        iconName: _selectedIconName,
        colorValue: _selectedColor.value,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Category "$categoryName" added to Firebase successfully!')),
      );

      // الرجوع للصفحة السابقة بعد النجاح
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add category: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add Custom Category'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Category Name',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF6FF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFB3E5FC)),
                ),
                child: TextField(
                  controller: _categoryNameController,
                  decoration: const InputDecoration(
                    hintText: 'e.g., Projects, Gym, Finance',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Choose Icon',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _availableIcons.length,
                  itemBuilder: (context, index) {
                    final item = _availableIcons[index];
                    final String iconName = item['name'];
                    final IconData iconData = item['icon'];
                    final isSelected = _selectedIconName == iconName;

                    return GestureDetector(
                      onTap: () => setState(() => _selectedIconName = iconName),
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryBlue.withValues(alpha: 0.2)
                              : const Color(0xFFEDF6FF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryBlue
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Icon(iconData,
                            color: isSelected
                                ? AppColors.primaryBlue
                                : Colors.black54),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Choose Color',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _availableColors.length,
                  itemBuilder: (context, index) {
                    final color = _availableColors[index];
                    final isSelected = _selectedColor == color;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedColor = color),
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                isSelected ? Colors.black : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(Icons.check,
                                color: Colors.white, size: 20)
                            : null,
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveCategoryToFirebase,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Save Category',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
