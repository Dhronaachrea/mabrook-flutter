import 'package:flutter/material.dart';
import 'package:mabrook/l10n/l10n.dart';
import 'package:mabrook/models/request/status_model.dart';
import 'package:velocity_x/velocity_x.dart';

class FilterSheet extends StatefulWidget {
  final List<StatusModel> _statusList;
  final Function(List<String>) onReset;

  const FilterSheet(this._statusList, this.onReset, {Key? key})
      : super(key: key);

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  List<String> selectedValues = ["ALL"];

  @override
  Widget build(BuildContext context) {
    var onReset = widget.onReset;
    return Wrap(
      children: [
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  context.l10n.voucher_status,
                  style: const TextStyle(color: Colors.black, fontSize: 24),
                ),
                Expanded(child: Container(),),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                    child: const Icon(Icons.clear)
                )
              ],
            ),
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget._statusList.length,
            itemBuilder: (context, position) {
              return Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: widget._statusList[position].value,
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                widget._statusList[position].value = true;
                                for (int i = 0;
                                    i < widget._statusList.length;
                                    i++) {
                                  if (i == position) {
                                    continue;
                                  }
                                  widget._statusList[i].value = false;
                                }
                              }
                            });
                          }),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          widget._statusList[position].name.toString(),
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          _submitButton(onReset),
        ],
      )
      ],
    );
  }

  _submitButton(Function(List<String>) onReset) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          onPrimary: Colors.white,
          shadowColor: Colors.greenAccent,
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0)),
        ),
        onPressed: () {
          Navigator.pop(context);
          onReset(selectedValues);
        },
        child: Text(
          context.l10n.cap_submit,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    ).pOnly(top:10,bottom:20);
  }
}
