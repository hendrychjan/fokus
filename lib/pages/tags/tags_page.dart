import 'package:flutter/material.dart';
import 'package:fokus/components/form/form_base.dart';
import 'package:fokus/database/app_database.dart';
import 'package:fokus/forms/tag_form.dart';
import 'package:fokus/repository/tag_repository.dart';
import 'package:fokus/services/app_controller.dart';
import 'package:get/get.dart';

class TagsPage extends StatelessWidget {
  TagsPage({super.key});

  TagRepository get _tagRepository => AppController.to.tagRepository;

  final GlobalKey<FormState> createTagFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updateTagFormKey = GlobalKey<FormState>();

  /// Create/update a tag the database
  Future<void> _handleSaveTag(Tag tag) async {
    await _tagRepository.save(tag);
    Get.back();
  }

  /// Delete a tag from the database
  Future<void> _handleDeleteTag(Tag tag) async {
    await _tagRepository.delete(tag);
    Get.back();
  }

  /// Open a dialog for creating a new tag
  void _openCreateDialog() {
    Get.to(
      () => TagForm(
        config: FormConfig(
          formKey: createTagFormKey,
          title: "Create a tag",
          submitText: "Create",
          onSubmit: _handleSaveTag,
        ),
      ),
      fullscreenDialog: true,
    );
  }

  /// Open a dialog for editing tags
  void _openEditDialog(Tag tag) {
    Get.to(
      () => TagForm(
        config: FormConfig(
          formKey: updateTagFormKey,
          submitText: "Update",
          title: "Update a tag",
          initialValue: tag,
          onSubmit: _handleSaveTag,
          onDelete: _handleDeleteTag,
        ),
      ),
      fullscreenDialog: true,
    );
  }

  /// Create a list view item from a tag
  Widget _tagItemBuilder(BuildContext context, int index, List<Tag> tags) {
    final tag = tags[index];

    return GestureDetector(
      onTap: () => _openEditDialog(tag),
      child: ListTile(
        title: Text(tag.title, style: TextStyle(color: Color(tag.colorARGB))),
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
        stream: _tagRepository.getAllStream(),
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
