import 'package:flutter/material.dart';
import 'package:fokus/forms/category_form.dart';
import 'package:fokus/models/category.dart';
import 'package:get/get.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({super.key});

  final GlobalKey<FormState> createCategoryFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updateCategoryFormKey = GlobalKey<FormState>();

  /// Create/update a category the database
  Future<void> _handleSaveCategory(Category category) async {
    await category.save();
    Get.back();
  }

  /// Delete a category from the database
  Future<void> _handleDeleteCategory(Category category) async {
    await category.delete();
    Get.back();
  }

  /// Open a dialog for creating a new category
  void _openCreateDialog() {
    Get.to(
      CategoryForm(
        formKey: createCategoryFormKey,
        title: "Create a category",
        submitText: "Create",
        onSubmit: _handleSaveCategory,
      ),
      fullscreenDialog: true,
    );
  }

  /// Open a dialog for editing categories
  void _openEditDialog(Category category) {
    Get.to(
      CategoryForm(
        formKey: updateCategoryFormKey,
        submitText: "Update",
        title: "Update a category",
        initialValue: category,
        onSubmit: _handleSaveCategory,
        onDelete: _handleDeleteCategory,
      ),
    );
  }

  /// Create a list view item from a category
  Widget _categoryItemBuilder(
    BuildContext context,
    int index,
    List<Category> categories,
  ) {
    final category = categories[index];

    return GestureDetector(
      onTap: () => _openEditDialog(category),
      child: ListTile(
        title: Text(category.title),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreateDialog,
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<List<Category>>(
        stream: Category.getAllStream(),
        builder: (context, snapshot) {
          // Check the stream state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No categories yet'));
          }

          // Create list items from stream's items
          final categories = snapshot.data!;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) =>
                _categoryItemBuilder(context, index, categories),
          );
        },
      ),
    );
  }
}
