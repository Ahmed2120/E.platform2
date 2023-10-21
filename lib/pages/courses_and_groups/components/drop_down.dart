import 'package:dropdown_search/dropdown_search.dart';
import 'package:eplatform/model/customModel.dart';
import 'package:flutter/material.dart';

class DropDownBooking extends StatelessWidget {
  DropDownBooking(this.list, this.onChange, this.item, this.hintText, {Key? key}) : super(key: key);

  List<CustomModel> list; Function onChange; CustomModel ? item ;String  hintText;

  @override
  Widget build(BuildContext context) {
    return  DropdownSearch<CustomModel>(
      popupProps: const PopupProps.menu(
        fit: FlexFit.loose
       // showSelectedItems: true,
        // showSearchBox: true
      ),
      items: list,
      itemAsString: (CustomModel customModel) => customModel.Name,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            suffixIconColor: Color(0xFF00B0BD),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,

            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(10)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(10)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(15))
        ),
      ),
      onChanged:(value)=> onChange(value),
       selectedItem: item,
    );
  }
}
