import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
}

Future<FilePickerResult?> pickImage() async {
  final image = await FilePicker.platform.pickFiles(type: FileType.image);

  return image;
}
// Explanation of the code and the use of ..:

// 1. Cascading operator (..)

// It's a shorthand way to call multiple methods on the same object, making code more concise and readable.
// It allows you to chain method calls without having to repeatedly write the object's name.
// 2. Function breakdown:

// - void showSnackBar(BuildContext context, String text):

// This function displays a temporary message (snackbar) at the bottom of the screen in a Flutter app.
// It takes two arguments:
// context: Provides information about the current screen's context, needed to access the ScaffoldMessenger.
// text: The text content to display in the snackbar.
// - Function steps:

// Accessing ScaffoldMessenger:
// ScaffoldMessenger.of(context): Retrieves the ScaffoldMessenger instance associated with the current context. It's responsible for managing snackbars and other screen-level communications.
// Hiding any existing snackbar:
// ..hideCurrentSnackBar(): Calls the hideCurrentSnackBar() method on the ScaffoldMessenger to dismiss any previously displayed snackbar, ensuring a clean presentation of the new one.
// Creating and showing the new snackbar:
// ..showSnackBar(SnackBar(content: Text(text),)):
// Creates a new SnackBar object with the specified text content.
// Calls the showSnackBar() method on the ScaffoldMessenger to display it.
// Summary:

// The function efficiently displays a snackbar with the given text using cascading operators for a compact and readable code style.
// It first hides any existing snackbars to avoid overlap and then presents the new one clearly.