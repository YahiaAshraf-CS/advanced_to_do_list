import 'package:advanced_to_do_list/core/routes/app_routes.dart';
import 'package:advanced_to_do_list/theme/app_colors.dart';
import 'package:advanced_to_do_list/view/widgets/Categories_widget.dart';
import 'package:advanced_to_do_list/view/widgets/task_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children:[
            
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                
                borderRadius: BorderRadius.circular(12.0),
                color: AppColors.taskBackground,
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withOpacity(0.1),
                //     blurRadius: 4.0,
                //     offset: const Offset(0, 2),
                //   ),
                // ],
              ),
              child: Row(

                children:[
                  Icon(Icons.search),
                  SizedBox(width: 10.0),
                  Text('Search for tasks, events'),
                ],
              ),
            ),
            SizedBox(height: 18.0),
            Text(
              "Categories",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              )

            ),
            SizedBox(height: 12.0),
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
            SizedBox(height: 18.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text("Today's tasks",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                )),
               InkWell(
                onTap: (){
                  
                },
                child: Text("See all",
                style: TextStyle(
                  
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),),
               )
              ],
            ),
            SizedBox(height: 12.0),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 12.0),
                itemCount: 10,
                itemBuilder: (context, index) => const TaskCard(
                  title: 'Finish Report',
                  date: 'Thu, 7 Sept 2023',
                  isOverdue: true,
                ),
              ),
            )
          ],
        
         
        ),
        
      ),
     
    );
  }
}