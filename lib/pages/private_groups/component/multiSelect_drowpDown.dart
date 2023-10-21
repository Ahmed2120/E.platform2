import 'package:dropdown_search/dropdown_search.dart';
import 'package:eplatform/model/customModel.dart';
import 'package:flutter/material.dart';

class MultiSelectDropDown extends StatelessWidget {
  MultiSelectDropDown(this.list, this.onChange, this.hintText, {Key? key}) : super(key: key);

  List<CustomModel> list; Function onChange; String? hintText;

  @override
  Widget build(BuildContext context) {
    return  DropdownSearch<CustomModel>.multiSelection(
      popupProps: const PopupPropsMultiSelection.menu(
          // showSelectedItems: true,
          fit: FlexFit.loose
        // showSearchBox: true
      ),
      items: list,
      itemAsString: (CustomModel teacher) => teacher.Name,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            suffixIconColor: Color(0xFF00B0BD),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 5),

            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
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
    );
  }
}
