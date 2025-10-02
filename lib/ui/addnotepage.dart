// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sqflite_database_project/Data/Local/db_helper.dart';
// import 'package:sqflite_database_project/Data/provider/db_provider.dart';
//
// class AddNotePage extends StatefulWidget {
//   final bool isUpdate;
//   final String title;
//   final String desc;
//   final int sno;
//
//   const AddNotePage({
//     super.key,
//     this.isUpdate = false,
//     this.sno = 0,
//     this.title = "",
//     this.desc = "",
//   });
//
//   @override
//   State<AddNotePage> createState() => _AddNotePageState();
// }
//
// class _AddNotePageState extends State<AddNotePage> {
//   final _formKey = GlobalKey<FormState>();
//   final _controller1 = TextEditingController();
//   final _controller2 = TextEditingController();
//   final _focusNode1 = FocusNode();
//   final _focusNode2 = FocusNode();
//
//   final DBHelper dbRef = DBHelper.getInstance;
//
//   @override
//   void initState() {
//     super.initState();
//     // Pre-fill fields if update
//     _controller1.text = widget.title;
//     _controller2.text = widget.desc;
//   }
//
//   @override
//   void dispose() {
//     _controller1.dispose();
//     _controller2.dispose();
//     _focusNode1.dispose();
//     _focusNode2.dispose();
//     super.dispose();
//   }
//
//   Future<void> _save() async {
//     const isUpdate = true;
//     int sno = 0;
//     if (_formKey.currentState?.validate() ?? false) {
//       final title = _controller1.text.trim();
//       final desc = _controller2.text.trim();
//
//
//       bool check = isUpdate;
//       if(isUpdate){
//         context.read<DbProvider>().addNote(title, desc);
//
//       }else{
//         context.read<DbProvider>().updateNote(title, desc, sno);
//       }
//       // bool check = widget.isUpdate
//       //     ? await dbRef.updateNote(
//       //   mTitle: title,
//       //   mDesc: desc,
//       //   sno: widget.sno,
//       // )
//       //     : await dbRef.addNote(
//       //   nTitle: title,
//       //   nDesc: desc,
//       // );
//
//       if (check) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Saved: "$title" and "$desc"')),
//         );
//         Navigator.of(context).pop(true); // return success
//       }
//     } else {
//       if (_controller1.text.trim().isEmpty) {
//         _focusNode1.requestFocus();
//       } else {
//         _focusNode2.requestFocus();
//       }
//     }
//   }
//
//   OutlineInputBorder _outlineBorder(Color color) {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8),
//       borderSide: BorderSide(color: color, width: 1.5),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.isUpdate ? "Update Note" : "Add Note")),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 controller: _controller1,
//                 focusNode: _focusNode1,
//                 textInputAction: TextInputAction.next,
//                 onFieldSubmitted: (_) => _focusNode2.requestFocus(),
//                 decoration: InputDecoration(
//                   labelText: 'Title',
//                   hintText: 'Enter title',
//                   enabledBorder: _outlineBorder(Colors.grey),
//                   focusedBorder: _outlineBorder(Theme.of(context).primaryColor),
//                 ),
//                 validator: (v) =>
//                 v == null || v.trim().isEmpty ? 'Please enter a value' : null,
//               ),
//               const SizedBox(height: 12),
//               TextFormField(
//                 controller: _controller2,
//                 focusNode: _focusNode2,
//                 textInputAction: TextInputAction.done,
//                 onFieldSubmitted: (_) => _save(),
//                 maxLines: 4,
//                 decoration: InputDecoration(
//                   labelText: 'Description',
//                   hintText: 'Enter description',
//                   enabledBorder: _outlineBorder(Colors.grey),
//                   focusedBorder: _outlineBorder(Theme.of(context).primaryColor),
//                 ),
//                 validator: (v) =>
//                 v == null || v.trim().isEmpty ? 'Please enter a value' : null,
//               ),
//               const SizedBox(height: 18),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => Navigator.of(context).pop(),
//                       child: const Text('Cancel'),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: _save,
//                       child: Text(widget.isUpdate ? 'Update' : 'Save'),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_database_project/Data/provider/db_provider.dart';

class AddNotePage extends StatefulWidget {
  final bool isUpdate;
  final String title;
  final String desc;
  final int sno;

  const AddNotePage({
    super.key,
    this.isUpdate = false,
    this.sno = 0,
    this.title = "",
    this.desc = "",
  });

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _formKey = GlobalKey<FormState>();
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();

  @override
  void initState() {
    super.initState();
    // pre-fill when editing
    _controller1.text = widget.title;
    _controller2.text = widget.desc;
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      if (_controller1.text.trim().isEmpty) {
        _focusNode1.requestFocus();
      } else {
        _focusNode2.requestFocus();
      }
      return;
    }

    final title = _controller1.text.trim();
    final desc = _controller2.text.trim();

    if (widget.isUpdate) {
      await context.read<DbProvider>().updateNote(title, desc, widget.sno);
    } else {
      await context.read<DbProvider>().addNote(title, desc);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(widget.isUpdate ? 'Updated' : 'Saved')),
    );

    Navigator.of(context).pop(true);
  }

  OutlineInputBorder _outlineBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: 1.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.isUpdate ? "Update Note" : "Add Note")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _controller1,
                focusNode: _focusNode1,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => _focusNode2.requestFocus(),
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter title',
                  enabledBorder: _outlineBorder(Colors.grey),
                  focusedBorder:
                  _outlineBorder(Theme.of(context).primaryColor),
                ),
                validator: (v) =>
                v == null || v.trim().isEmpty ? 'Please enter a value' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _controller2,
                focusNode: _focusNode2,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _save(),
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter description',
                  enabledBorder: _outlineBorder(Colors.grey),
                  focusedBorder:
                  _outlineBorder(Theme.of(context).primaryColor),
                ),
                validator: (v) =>
                v == null || v.trim().isEmpty ? 'Please enter a value' : null,
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _save,
                      child: Text(widget.isUpdate ? 'Update' : 'Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
