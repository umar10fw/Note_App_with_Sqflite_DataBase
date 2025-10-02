// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sqflite_database_project/Data/Local/db_helper.dart';
// import 'package:sqflite_database_project/Data/provider/db_provider.dart';
//
// import 'addnotepage.dart';
//
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   List<Map<String, dynamic>> allNotes = [];
//   DBHelper? dbRef;
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<DbProvider>().initialNotes();
//     // dbRef = DBHelper.getInstance;
//     // getNotes();
//   }
//   //
//   // getNotes() async {
//   //   allNotes = await dbRef!.getAllNote();
//   //   setState(() {});
//   // }
//
//   final _formKey = GlobalKey<FormState>();
//   final _controller1 = TextEditingController();
//   final _controller2 = TextEditingController();
//   final _focusNode1 = FocusNode();
//   final _focusNode2 = FocusNode();
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
//   OutlineInputBorder _outlineBorder(Color color) {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8),
//       borderSide: BorderSide(color: color, width: 1.5),
//     );
//   }
//
//   void save(BuildContext context,
//       {required bool isUpdate, required int sno}) async {
//     const isUpdate = false;
//     if (_formKey.currentState?.validate() ?? false) {
//       final v1 = _controller1.text.trim();
//       final v2 = _controller2.text.trim();
//       var title = _controller1.text;
//       var desc = _controller2.text;
//       if (title.isNotEmpty && desc.isNotEmpty) {
//         bool check = isUpdate
//             ? await dbRef!.updateNote(
//                 mTitle: title,
//                 mDesc: desc,
//                 sno: sno,
//               )
//             : await dbRef!.addNote(nTitle: title, nDesc: desc);
//         if (check) {
//           allNotes;
//         }
//       }
//       _controller1.clear();
//       _controller2.clear();
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Saved: "$v1" and "$v2"')),
//       );
//
//       Navigator.of(context).pop();
//     } else {
//       if (_controller1.text.trim().isEmpty) {
//         _focusNode1.requestFocus();
//       } else {
//         _focusNode2.requestFocus();
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Note"),
//       ),
//       body: Consumer<DbProvider>(builder: (context, provider, child) {
//
//         List<Map<String, dynamic>> allNotes = provider.getNotes();
//
//         return allNotes.isNotEmpty
//             ? ListView.builder(
//           itemCount: allNotes.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               leading: Text("${index + 1}"),
//               title: Text(allNotes[index][DBHelper.Column_title]),
//               subtitle: Text(allNotes[index][DBHelper.Column_desc]),
//               trailing: SizedBox(
//                 width: 100,
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.edit, color: Colors.blue),
//                       iconSize: 20,
//                       tooltip: "Edit",
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => AddNotePage(
//                                 isUpdate: true,
//                                 title: allNotes[index][DBHelper.Column_title],
//                                 desc: allNotes[index][DBHelper.Column_desc],
//                                 sno: allNotes[index][DBHelper.Column_sn],
//                               ),
//                             ));
//                         // openSheet(context,isUpdate: true,sno: allNotes[index][DBHelper.Column_sn]);
//                         // _controller1.text = allNotes[index][DBHelper.Column_title];
//                         // _controller2.text = allNotes[index][DBHelper.Column_desc];
//                       },
//                     ),
//                     InkWell(
//                         onTap: () async {
//
//                           // bool check = await dbRef!.deleteNote(sno: allNotes[index][DBHelper.Column_sn]);
//                           // if(check){
//                           //   getNotes();
//                           // }
//                         },
//                         child: Icon(
//                           Icons.delete,
//                           color: Colors.red,
//                         ))
//                   ],
//                 ),
//               ),
//             );
//           },
//         )
//             : Center(
//           child: Text("No Notes yet"),
//         );
//       },),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => AddNotePage(),
//               ));
//           // _controller1.clear();
//           // _controller2.clear();
//           // openSheet(context, isUpdate: false);
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
//
//   void openSheet(BuildContext context, {bool isUpdate = false, int sno = 0}) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true, // so sheet rises above keyboard
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) => Padding(
//           // viewInsets padding makes room for keyboard
//           padding: EdgeInsets.only(top: 16.0),
//           child: Padding(
//             padding: EdgeInsets.only(
//               left: 16,
//               right: 16,
//               bottom: MediaQuery.of(context).viewInsets.bottom + 100,
//               top: 8,
//             ),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min, // sheet height fits content
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // little grabber
//                   Center(
//                     child: Container(
//                       width: 40,
//                       height: 4,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//
//                   // Title
//                   Text(
//                     isUpdate ? 'Update Notes' : 'Add Note',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),
//
//                   // First TextField
//                   TextFormField(
//                     controller: _controller1,
//                     focusNode: _focusNode1,
//                     textInputAction: TextInputAction.next,
//                     onFieldSubmitted: (_) {
//                       // move focus to second field when pressing next
//                       _focusNode2.requestFocus();
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'your title',
//                       hintText: 'Enter Title',
//                       enabledBorder: _outlineBorder(Colors.grey),
//                       focusedBorder:
//                           _outlineBorder(Theme.of(context).primaryColor),
//                       border: _outlineBorder(Colors.grey),
//                       contentPadding: const EdgeInsets.symmetric(
//                           vertical: 14, horizontal: 12),
//                     ),
//                     validator: (v) {
//                       if (v == null || v.trim().isEmpty) {
//                         return 'Please enter a value';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 12),
//
//                   // Second TextField
//                   TextFormField(
//                     controller: _controller2,
//                     focusNode: _focusNode2,
//                     textInputAction: TextInputAction.done,
//                     onFieldSubmitted: (_) =>
//                         save(context, isUpdate: true, sno: sno),
//                     maxLines: 4,
//                     decoration: InputDecoration(
//                       labelText: 'Enter your Description',
//                       hintText: 'Description',
//                       enabledBorder: _outlineBorder(Colors.grey),
//                       focusedBorder:
//                           _outlineBorder(Theme.of(context).primaryColor),
//                       border: _outlineBorder(Colors.grey),
//                       contentPadding: const EdgeInsets.symmetric(
//                           vertical: 14, horizontal: 12),
//                     ),
//                     validator: (v) {
//                       if (v == null || v.trim().isEmpty) {
//                         return 'Please enter a value';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 18),
//
//                   // Buttons row
//                   Row(
//                     children: [
//                       Expanded(
//                         child: OutlinedButton(
//                           onPressed: () {
//                             Navigator.of(context).pop(); // close sheet
//                           },
//                           style: OutlinedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             side: BorderSide(color: Colors.grey.shade600),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: const Text('Cancel'),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: OutlinedButton(
//                           onPressed: () =>
//                               save(context, isUpdate: true, sno: sno),
//                           style: OutlinedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             side: BorderSide(
//                               color: Theme.of(context).primaryColor,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: Text(isUpdate ? 'Update' : 'Save'),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_database_project/Data/Local/db_helper.dart';
import 'package:sqflite_database_project/Data/provider/db_provider.dart';
import 'package:sqflite_database_project/ui/setting/thememode.dart';
import 'addnotepage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // load notes from DB through provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DbProvider>().initialNotes();
    });
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
        title:  Text("Notes"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(
                        width: 11,
                      ),
                      Text("Setting")
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingPage(),
                        ));
                  },
                )
              ];
            },
          )
        ],
      ),
      body: Consumer<DbProvider>(builder: (context, provider, child) {
        final allNotes = provider.getNotes();
        if (allNotes.isEmpty) {
          return const Center(child: Text("No Notes yet"));
        }

        return ListView.builder(
          itemCount: allNotes.length,
          itemBuilder: (context, index) {
            final item = allNotes[index];
            return ListTile(
              leading: Text("${index + 1}"),
              title: Text(item[DBHelper.Column_title] ?? ''),
              subtitle: Text(item[DBHelper.Column_desc] ?? ''),
              trailing: SizedBox(
                width: 110,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () async {
                        // Open AddNotePage in update mode
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddNotePage(
                              isUpdate: true,
                              title: item[DBHelper.Column_title] ?? '',
                              desc: item[DBHelper.Column_desc] ?? '',
                              sno: item[DBHelper.Column_sn] ?? 0,
                            ),
                          ),
                        );
                        // Provider will notify and rebuild automatically
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        final sno = item[DBHelper.Column_sn];
                        if (sno != null) {
                          final confirmed = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('Delete'),
                                  content: const Text('Delete this note?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, false),
                                        child: const Text('Cancel')),
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, true),
                                        child: const Text('Delete')),
                                  ],
                                ),
                              ) ??
                              false;
                          if (confirmed) {
                            await context.read<DbProvider>().deleteNote(sno);
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddNotePage()),
          );
          // provider notifies on add, so list refreshes automatically
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
