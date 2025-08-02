import 'package:flutter/material.dart';

class SelectFormField<T> extends FormField<T> {
  SelectFormField({
    super.key,
    required List<T> options,
    required String Function(T) itemTitleBuilder,
    required FormFieldSetter<T> super.onSaved,
    required InputDecoration decoration,
    super.initialValue,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,
    String label = 'Select an option',
  }) : super(
         builder: (FormFieldState<T> state) {
           return InputDecorator(
             decoration: decoration,
             isEmpty: state.value == null,
             child: DropdownButtonHideUnderline(
               child: DropdownButton<T>(
                 value: state.value,
                 isExpanded: true,
                 onChanged: (T? newValue) {
                   state.didChange(newValue);
                 },
                 items: options.map((T option) {
                   return DropdownMenuItem<T>(
                     value: option,
                     child: Text(itemTitleBuilder(option)),
                   );
                 }).toList(),
               ),
             ),
           );
         },
       );
}
