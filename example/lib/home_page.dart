import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_asset_picker/form_builder_asset_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  final List<String>? _allowedExtensions = ['pdf'];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            controller: _scrollController,
            children: [
          FormBuilder(
              key: _formKey,
              child: Wrap(runSpacing: 20, children: [
                FormBuilderTextField(
                    name: 'name',
                    decoration: const InputDecoration(labelText: 'Name')),
                FormBuilderAssetPicker(
                    name: 'pick-file',
                    allowedExtensions: _allowedExtensions,
                    allowMultiple: true,
                    maxFiles: 5,
                    type: FileType.custom,
                    decoration: const InputDecoration(border: InputBorder.none),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Field required';
                      }

                      bool _checkExt = val.every((element) {
                        if (!_allowedExtensions!.contains(element.extension)) {
                          return false;
                        } else {
                          return true;
                        }
                      });

                      if (_checkExt == false) {
                        return 'File extension not allowed';
                      }

                      return null;
                    })
              ])),
          ButtonBar(alignment: MainAxisAlignment.center, children: [
            ElevatedButton(
                child: const Text("Submit"),
                onPressed: () {
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate()) {
                    // print(_formKey.currentState!.value);
                    // var files = _formKey.currentState!.value['pick-file'];
                    // print(files);
                  } else {
                    // print("validation failed");
                  }
                }),
            const SizedBox(height: 10),
            ElevatedButton(
                child: const Text("Reset"),
                onPressed: () {
                  _formKey.currentState!.reset();
                })
          ])
        ]));
  }
}
