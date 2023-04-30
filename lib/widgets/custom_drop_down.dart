import 'package:base_flutter/domain/entities/drop_down_item.dart';
import 'package:base_flutter/extension/string_extensions.dart';
import 'package:base_flutter/utils/app_colors.dart';
import 'package:base_flutter/utils/app_suitable_widget_size.dart';
import 'package:base_flutter/utils/app_text_styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropDownButton extends StatefulWidget {
  final List<DropdownItem> items;
  final DropdownItem initialValue;
  final Function(DropdownItem) onChanged;

  const CustomDropDownButton({
    super.key,
    required this.items,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  DropdownItem? selectedValue;

  @override
  void initState() {
    selectedValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSuitableWidgetSize.getSuitableWidth(6),
        right: AppSuitableWidgetSize.getSuitableWidth(6),
        top: AppSuitableWidgetSize.getSuitableHeight(6),
        bottom: AppSuitableWidgetSize.getSuitableHeight(2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          items: widget.items
              .map((item) => DropdownMenuItem<DropdownItem>(
                    value: item,
                    child:

                    item.dropDownId != selectedValue!.dropDownId
                        ?Text(
                      item.dropDownValue.capitalizeFirst(),
                      style: AppTextStyles
                          .ibarraNova18SemiBoldTextGray828282(),
                      overflow: TextOverflow.ellipsis,
                    ):ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) {
                          return AppColors.linearGradient.createShader(bounds);
                        },
                        child: Text(
                          item.dropDownValue.capitalizeFirst(),
                          style: AppTextStyles
                              .ibarraNova18SemiBoldTextGray828282(),
                          overflow: TextOverflow.ellipsis,
                        )),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as DropdownItem;
              widget.onChanged(value);
            });
          },
          selectedItemBuilder: (BuildContext context) {
            return widget.items.map<Widget>((item) {
              return DropdownMenuItem(
                  value: item.dropDownValue,
                  child:  ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) {
                        return AppColors.linearGradient.createShader(bounds);
                      },
                      child: Text(
                        item.dropDownValue.capitalizeFirst(),
                        style: AppTextStyles
                            .ibarraNova18SemiBoldTextGray828282(),
                        overflow: TextOverflow.ellipsis,
                      )));
            }).toList();
          },
          buttonStyleData: ButtonStyleData(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
                horizontal: AppSuitableWidgetSize.getSuitableWidth(4)),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: AppColors.colorWhite,
                  blurRadius: 1,
                  offset: Offset(0, 5), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black26,
              ),
            ),
            elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 20,
            iconEnabledColor: AppColors.colorOrange,
            iconDisabledColor: AppColors.colorTextGray,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: AppSuitableWidgetSize.getSuitableHeight(100),
            padding: null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              color: Colors.white,
            ),
            elevation: 8,
            scrollbarTheme: ScrollbarThemeData(
              thumbColor: AppColors.colorOrangeMaterialStateProperty,
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all<double>(4),
              thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData:  MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal:
            AppSuitableWidgetSize.getSuitableWidth(6)),
          ),
        ),
      ),
    );
  }
}
