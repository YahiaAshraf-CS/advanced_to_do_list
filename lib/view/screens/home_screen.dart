import 'package:advanced_to_do_list/theme/app_colors.dart';
import 'package:advanced_to_do_list/view/widgets/Categories_widget.dart';
import 'package:flutter/material.dart';
import 'package:advanced_to_do_list/view/widgets/task_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: AppColors.taskBackground,
              ),
              child: const Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'Search for tasks, events',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18.0),
            const Text(
              "Categories",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 12.0),
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                CategoryWidget(
                  icon: Icons.work_outline,
                  title: 'Work',
                  color: Colors.blue,
                ),
                CategoryWidget(
                  icon: Icons.person_outline,
                  title: 'Personal',
                  color: Colors.deepOrange,
                ),
                CategoryWidget(
                  icon: Icons.shopping_cart_outlined,
                  title: 'Shopping',
                  color: Colors.amber,
                ),
                CategoryWidget(
                  icon: Icons.favorite_border,
                  title: 'Health',
                  color: Colors.redAccent,
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Today's tasks",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                InkWell(
                  onTap: () {},
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
            const SizedBox(height: 12.0),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12.0),
                itemCount: 10,
                itemBuilder: (context, index) => const TaskCard(
                  title: 'Finish Report',
                  date: 'Thu, 7 Sept 2023',
                  isOverdue: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
