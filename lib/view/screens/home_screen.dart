import 'package:advanced_to_do_list/features/tasks/data/notefication/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:advanced_to_do_list/features/tasks/data/models/task_model.dart';
import 'package:advanced_to_do_list/features/tasks/data/services/task_servies.dart';
import 'package:advanced_to_do_list/features/tasks/data/services/category_servies.dart';
import 'package:advanced_to_do_list/core/routes/app_routes.dart';
import 'package:advanced_to_do_list/theme/app_colors.dart';
import 'package:advanced_to_do_list/view/widgets/Categories_widget.dart';
import 'package:advanced_to_do_list/view/widgets/task_card.dart';
import 'package:advanced_to_do_list/features/tasks/data/models/category_model.dart';
import 'package:advanced_to_do_list/view/screens/add_custom_category_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(String)? onNavigateToRoute;

  const HomeScreen({super.key, this.onNavigateToRoute});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskService _taskService = TaskService();
  final CategoryService _categoryService = CategoryService();
  final User? currentUser = FirebaseAuth.instance.currentUser;

  String userName = 'User';

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }
  

  Future<void> _fetchUserName() async {
    if (currentUser != null) {
      if (currentUser!.displayName != null &&
          currentUser!.displayName!.isNotEmpty) {
        setState(() {
          userName = currentUser!.displayName!;
        });
        return;
      }

      try {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .get();
        if (doc.exists && doc.data() != null) {
          final data = doc.data() as Map<String, dynamic>;
          if (data.containsKey('name') && data['name'] != null) {
            setState(() {
              userName = data['name'];
            });
            return;
          }
        }
      } catch (_) {}

      if (currentUser!.email != null) {
        setState(() {
          userName = currentUser!.email!.split('@').first;
        });
      }
    }
  }

  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Hi, $userName',
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      const Text(
                        '👋',
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: AppColors.black,
                      size: 26,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Container(
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: AppColors.taskBackground,
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: AppColors.secondaryText),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        'Search for tasks, events',
                        style: TextStyle(color: AppColors.secondaryText),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddCustomCategoryScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    label: const Text(
                      "Add Custom",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              StreamBuilder<List<CategoryModel>>(
                stream: _categoryService.getUserCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Text('Error loading categories.');
                  }

                  final categories = snapshot.data ?? [];

                  if (categories.isEmpty) {
                    return const Text(
                      'No categories found. Add a custom one!',
                      style: TextStyle(color: AppColors.secondaryText),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.1,
                    ),
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: CategoryWidget(
                              icon: cat.iconData,
                              title: cat.name,
                              color: cat.color,
                              borderColor: cat.color,
                            ),
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text('Delete Category'),
                                    content: Text(
                                        'Are you sure you want to delete "${cat.name}"?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(ctx),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(ctx);
                                          await _categoryService
                                              .deleteCategory(cat.id);
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 14,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 18.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Today's Tasks",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  Row(
                    children: [
                      
                      InkWell(
                        onTap: () {
                          if (widget.onNavigateToRoute != null) {
                            widget.onNavigateToRoute!(AppRoutes.allTasks);
                          } else {
                            Navigator.pushNamed(context, AppRoutes.allTasks);
                          }
                        },
                        child: const Text(
                          "See all",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              Expanded(
                child: StreamBuilder<List<TaskModel>>(
                  stream: _taskService.getUserTasks(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Center(child: Text('Error loading tasks.'));
                    }

                    final tasks = snapshot.data ?? [];

                    if (tasks.isEmpty) {
                      return const Center(
                        child: Text(
                          'No tasks for today. Add a new task!',
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 15,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12.0),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Row(
                          children: [
                            Checkbox(
                              value: task.isCompleted,
                              activeColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              onChanged: (bool? value) async {
                                if (value != null) {
                                  try {
                                    await _taskService.updateTaskCompletion(
                                        task.id, value);
                                  } catch (e) {
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Failed to update status: $e')),
                                    );
                                  }
                                }
                              },
                            ),
                            Expanded(
                              child: TaskCard(
                                title: task.title,
                                date: '${task.date} - ${task.time}',
                                category: task.category,
                                iconName: task.iconName,
                                categoryColor: Color(task.colorValue),
                                isOverdue: false,
                                isCompleted: task.isCompleted,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
