// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../models/note_model.dart';
// import '../db/database_helper.dart';

// class AddNoteScreen extends StatefulWidget {
//   final Note? note;
//   final VoidCallback onSave;

//   AddNoteScreen({this.note, required this.onSave});

//   @override
//   _AddNoteScreenState createState() => _AddNoteScreenState();
// }

// class _AddNoteScreenState extends State<AddNoteScreen> {
//   final locationController = TextEditingController();
//   final descriptionController = TextEditingController();
//   File? imageFile;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.note != null) {
//       locationController.text = widget.note!.locationName;
//       descriptionController.text = widget.note!.description;
//       imageFile = File(widget.note!.imagePath);
//     }
//   }

//   Future pickImage(ImageSource source) async {
//     final picked = await ImagePicker().pickImage(source: source);
//     if (picked != null) setState(() => imageFile = File(picked.path));
//   }

//   void saveNote() async {
//     final note = Note(
//       id: widget.note?.id,
//       locationName: locationController.text,
//       description: descriptionController.text,
//       imagePath: imageFile?.path ?? '',
//     );

//     if (widget.note == null) {
//       await DatabaseHelper().insertNote(note);
//     } else {
//       await DatabaseHelper().updateNote(note);
//     }

//     widget.onSave();
//     Navigator.pop(context);
//   }

//   void deleteImage() {
//     setState(() {
//       imageFile = null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.note == null ? "Add Note" : "Edit Note")),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: ListView(
//           children: [
//             TextField(controller: locationController, decoration: InputDecoration(labelText: "Location Name")),
//             TextField(controller: descriptionController, decoration: InputDecoration(labelText: "Description")),
//             SizedBox(height: 10),
//             imageFile != null
//               ? Column(
//                   children: [
//                     Image.file(imageFile!, height: 200),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         ElevatedButton.icon(onPressed: deleteImage, icon: Icon(Icons.delete), label: Text("Delete")),
//                         ElevatedButton.icon(onPressed: () => pickImage(ImageSource.camera), icon: Icon(Icons.camera), label: Text("Retake")),
//                       ],
//                     )
//                   ],
//                 )
//               : Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton.icon(onPressed: () => pickImage(ImageSource.camera), icon: Icon(Icons.camera), label: Text("Camera")),
//                     ElevatedButton.icon(onPressed: () => pickImage(ImageSource.gallery), icon: Icon(Icons.image), label: Text("Gallery")),
//                   ],
//                 ),
//             SizedBox(height: 20),
//             ElevatedButton(onPressed: saveNote, child: Text("Save Note"))
//           ],
//         ),
//       ),
//     );
//   }
// }





import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/note_model.dart';
import '../db/database_helper.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? note;
  final VoidCallback onSave;

  const AddNoteScreen({super.key, this.note, required this.onSave});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  File? imageFile;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      locationController.text = widget.note!.locationName;
      descriptionController.text = widget.note!.description;
      imageFile = File(widget.note!.imagePath);
    }
  }

  Future pickImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) setState(() => imageFile = File(picked.path));
  }

// *** Store Data in Local Storage  ***

  void saveNote() async {
    final note = Note(
      id: widget.note?.id,
      locationName: locationController.text,
      description: descriptionController.text,
      imagePath: imageFile?.path ?? '',
    );

    if (widget.note == null) {
      await DatabaseHelper().insertNote(note);
    } else {
      await DatabaseHelper().updateNote(note);
    }

    widget.onSave();
    Navigator.pop(context);
  }

  void deleteImage() {
    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            widget.note == null ? "Add Note" : "Edit Note",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF6200EA)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: "Location Name")),
            TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description")),
            SizedBox(height: 10),
            imageFile != null
                ? Column(
                    children: [
                      Image.file(imageFile!, height: 200),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                              onPressed: deleteImage,
                              icon: Icon(Icons.delete),
                              label: Text("Delete")),
                          ElevatedButton.icon(
                              onPressed: () => pickImage(ImageSource.camera),
                              icon: Icon(Icons.camera),
                              label: Text("Retake")),
                        ],
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () => pickImage(ImageSource.camera),
                          icon: Icon(Icons.camera),
                          label: Text("Camera")),
                      ElevatedButton.icon(
                          onPressed: () => pickImage(ImageSource.gallery),
                          icon: Icon(Icons.image),
                          label: Text("Gallery")),
                    ],
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveNote,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6200EA), // Deep Purple
              ),
              child: Text(
                "Save Note",
                style: TextStyle(color: Colors.white), // Make text white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
