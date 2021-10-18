import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/selected_task_provider.dart';
import 'package:todo/screens/update_task_screen/update_task_screen.dart';
import 'package:todo/service/validators.dart';

typedef TaskUpdateFunction = Future<void> Function(BuildContext context);

class Body extends StatefulWidget {
  final TaskUpdateFunction taskUpdateFunction;

  const Body({Key? key, required this.taskUpdateFunction}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with TaskValidators {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  late String _defaultName;
  late String _defaultDescription;

  void initDefaultValue() {
    _defaultName = context.read<SelectedTaskProvider>().name;
    _defaultDescription = context.read<SelectedTaskProvider>().description;
  }

  @override
  void didChangeDependencies() {
    initDefaultValue();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  void _nameEditingComplete() {
    FocusScope.of(context).requestFocus(_descriptionFocusNode);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: UpdateTaskScreen.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: TextFormField(
                      key: const Key('name'),
                      onSaved: (value) => context
                          .read<SelectedTaskProvider>()
                          .updateTask(name: value),
                      initialValue: _defaultName,
                      focusNode: _nameFocusNode,
                      keyboardType: TextInputType.name,
                      enabled: !context.select<SelectedTaskProvider, bool>(
                          (SelectedTaskProvider selectTaskProvider) =>
                              selectTaskProvider.loading),
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: UnderlineInputBorder(),
                      ),
                      validator: validateName,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: _nameEditingComplete,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: TextFormField(
                      key: const Key('description'),
                      initialValue: _defaultDescription,
                      onSaved: (value) => context
                          .read<SelectedTaskProvider>()
                          .updateTask(description: value),
                      keyboardType: TextInputType.name,
                      focusNode: _descriptionFocusNode,
                      enabled: !context.select<SelectedTaskProvider, bool>(
                          (SelectedTaskProvider selectTaskProvider) =>
                              selectTaskProvider.loading),
                      decoration: const InputDecoration(
                        labelText: 'description',
                        border: UnderlineInputBorder(),
                      ),
                      onEditingComplete: () =>
                          widget.taskUpdateFunction(context),
                      textInputAction: TextInputAction.done,
                      maxLength: 100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
