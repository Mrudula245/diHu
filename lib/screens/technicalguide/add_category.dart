
import 'package:dihub/models/category_model.dart';
import 'package:dihub/screens/technicalguide/view_category.dart';
import 'package:dihub/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final CategoryService _categoryService = CategoryService();
  final TextEditingController _titleController = TextEditingController();

  void _addCategory() async {
    String id = Uuid().v1(); // Generate a unique ID
    String title = _titleController.text;
    if (title.isNotEmpty) {
      await _categoryService.addCategory(CategoryModel(title: title, id: id)); // Pass the generated ID
      _titleController.clear();
    }
  }

  void _navigateToActivityListPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewCategory()), // Navigate to ActivityListPage
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(backgroundColor: Colors.cyan,
        title: Text('Category Manager',style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addCategory,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _navigateToActivityListPage,
            child: Text(
              'View Category',
              style: TextStyle(color: Colors.white), // Set text color to white
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Set button background color to blue
            ),
          )

        ],
      ),
    );
  }
}