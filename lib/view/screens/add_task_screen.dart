import 'package:advanced_to_do_list/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add task',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2196F3),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFF2196F3),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                    
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFFF8A65),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF6FF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFB3E5FC),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: TextEditingController(text: 'Finish Report'),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2196F3),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF6FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: 'Work',
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black54,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Work',
                        child: Text(
                          'Work',
                          style: TextStyle(
                            color: AppColors.darkBlue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Personal',
                        child: Text(
                          'Personal',
                          style: TextStyle(
                            color: AppColors.overdue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'health',
                        child: Text(
                          'health',
                          style: TextStyle(
                            color: AppColors.overdue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'shopping',
                        child: Text(
                          'Shopping',
                          style: TextStyle(
                            color: AppColors.yellow,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Study',
                        child: Text(
                          'Study',
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'religion',
                        child: Text(
                          'religion',
                          style: TextStyle(
                            color: AppColors.green,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        value = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Date',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2196F3),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Icon(Icons.calendar_today_outlined,
                      color: Colors.amber, size: 22),
                  SizedBox(width: 12),
                  Text(
                    'Set due date',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  Icon(Icons.access_time, color: Color(0xFFFF8A65), size: 22),
                  SizedBox(width: 12),
                  Text(
                    'Set Time',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                'Reminder',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2196F3),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Icon(Icons.notifications_none,
                      color: Color(0xFFFF8A65), size: 22),
                  SizedBox(width: 12),
                  Text(
                    'Set Reminder',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                'Notes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2196F3),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDF6FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Make sure to research from internet',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: const Color(0xFF2196F3),
                  elevation: 0,
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 30,
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
