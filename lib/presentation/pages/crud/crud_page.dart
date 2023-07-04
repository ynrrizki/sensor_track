import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sensor_track/presentation/blocs/item/item_bloc.dart';
import 'package:sensor_track/presentation/widgets/item_card_widget.dart';

class CrudPage extends StatelessWidget {
  const CrudPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CRUD PAGE'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      backgroundColor: Colors.blue[100],
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showModalBottomSheetRounded(
          context,
          child: const FormWidget(),
        ),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state is ItemLoaded) {
            if (state.items.isEmpty) {
              return const Center(
                child: Text('Data is Empty'),
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 25,
                  horizontal: 15,
                ),
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return ItemCardWidget(
                    title: item.name!,
                    icon: const Icon(Icons.insert_emoticon),
                    subtitle: Text('${item.createdAt}'),
                    trail: IconButton(
                      onPressed: () => _showModalBottomSheetRounded(
                        context,
                        child: OptionInput(
                          id: item.id,
                          name: item.name!,
                          createdAt: item.createdAt!.toIso8601String(),
                        ),
                      ),
                      icon: const Icon(Icons.more_vert),
                    ),
                  );
                },
              );
            }
          } else if (state is ItemLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ItemError) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class OptionInput extends StatefulWidget {
  const OptionInput({
    super.key,
    required this.id,
    required this.name,
    required this.createdAt,
  });
  final dynamic id;
  final String name;
  final String createdAt;

  @override
  State<OptionInput> createState() => _OptionInputState();
}

class _OptionInputState extends State<OptionInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          editOption(context),
          deleteOption(context, widget.id),
          // submitted
        ],
      ),
    );
  }

  Card deleteOption(BuildContext context, int id) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.red,
        ),
      ),
      child: ListTile(
        onTap: () async {
          Navigator.pop(context);
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Please Confirm'),
                content: const Text('Are you sure to remove the item?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.read<ItemBloc>().add(
                            DeleteItem(id: id),
                          );
                      Navigator.of(context).pop();
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No'),
                  )
                ],
              );
            },
          );
        },
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.delete),
        ),
        title: const Text(
          'Delete',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  Card editOption(BuildContext context) {
    return Card(
      elevation: 0,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.yellow,
        ),
      ),
      child: ListTile(
        onTap: () async {
          Navigator.pop(context);
          return _showModalBottomSheetRounded(
            context,
            child: FormWidget(
              id: widget.id,
              nameText: widget.name,
              dateTimeText: widget.createdAt,
            ),
          );
        },
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.yellow.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.edit),
        ),
        title: Text(
          'Edit',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.yellow[900],
          ),
        ),
      ),
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({
    super.key,
    this.id,
    this.nameText = '',
    this.dateTimeText = '',
  });
  final dynamic id;
  final String nameText;
  final String dateTimeText;
  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final DateFormat _dateFormat = DateFormat("yyyy-MM-dd");
  @override
  void initState() {
    _namaController.text = widget.nameText;
    _tanggalController.text = widget.dateTimeText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // input text
          inputTextItem(),
          const SizedBox(height: 25),
          // input datetime
          inputDateItem(),
          const SizedBox(height: 15),
          // submitted
          ElevatedButton(
            onPressed: () {
              final namaBarang = _namaController.text;
              final tanggalBarang = _tanggalController.text;
              if (widget.id != null) {
                context.read<ItemBloc>().add(
                      EditItem(
                        id: widget.id,
                        name: namaBarang,
                        createdAt: DateTime.parse(tanggalBarang),
                      ),
                    );
              } else {
                context.read<ItemBloc>().add(
                      AddItem(
                        name: namaBarang,
                        createdAt: DateTime.parse(tanggalBarang),
                      ),
                    );
              }

              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
              backgroundColor: Colors.blueAccent,
            ),
            child: const Center(
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }

  DateTimeField inputDateItem() {
    return DateTimeField(
      controller: _tanggalController,
      format: _dateFormat,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        labelText: 'Tanggal Barang',
      ),
      onShowPicker: (context, currentValue) {
        return showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          initialDate: currentValue ?? DateTime.now(),
          lastDate: DateTime(2100),
        );
      },
    );
  }

  TextField inputTextItem() {
    return TextField(
      controller: _namaController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        labelText: 'Nama Barang',
      ),
    );
  }
}

Future<dynamic> _showModalBottomSheetRounded(BuildContext context,
    {required Widget child}) {
  return showModalBottomSheet(
    context: context,
    enableDrag: true,
    showDragHandle: true,
    isScrollControlled: true,
    backgroundColor: Colors.grey[200],
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: child,
    ),
  );
}
