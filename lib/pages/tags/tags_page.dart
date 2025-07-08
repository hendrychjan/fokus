import 'package:flutter/material.dart';
import 'package:fokus/forms/tag_form.dart';
import 'package:fokus/models/tag.dart';
import 'package:get/get.dart';

class TagsPage extends StatelessWidget {
  TagsPage({super.key});

  final GlobalKey<FormState> createTagFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updateTagFormKey = GlobalKey<FormState>();

  /// Create/update a tag the database
  Future<void> _handleSaveTag(Tag tag) async {
    await tag.save();
    Get.back();
  }

  /// Delete a tag from the database
  Future<void> _handleDeleteTag(Tag tag) async {
    await tag.delete();
    Get.back();
  }

  /// Open a dialog for creating a new tag
  void _openCreateDialog() {
    Get.to(
      TagForm(
        formKey: createTagFormKey,
        title: "Create a tag",
        submitText: "Create",
        onSubmit: _handleSaveTag,
      ),
      fullscreenDialog: true,
    );
  }

  /// Open a dialog for editing tags
  void _openEditDialog(Tag tag) {
    Get.to(
      TagForm(
        formKey: updateTagFormKey,
        submitText: "Update",
        title: "Update a tag",
        initialValue: tag,
        onSubmit: _handleSaveTag,
        onDelete: _handleDeleteTag,
      ),
    );
  }

  /// Create a list view item from a tag
  Widget _tagItemBuilder(BuildContext context, int index, List<Tag> tags) {
    final tag = tags[index];

    return GestureDetector(
      onTap: () => _openEditDialog(tag),
      child: ListTile(
        title: Text(tag.title),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tags"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreateDialog,
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<List<Tag>>(
        stream: Tag.getAllStream(),
        builder: (context, snapshot) {
          // Check the stream state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tags yet'));
          }

          // Create list items from stream's items
          final tags = snapshot.data!;
          return ListView.builder(
            itemCount: tags.length,
            itemBuilder: (context, index) =>
                _tagItemBuilder(context, index, tags),
          );
        },
      ),
    );
  }
}
