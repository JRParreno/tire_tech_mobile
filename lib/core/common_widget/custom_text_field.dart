import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tire_tech_mobile/core/common_widget/custom_text.dart';
import 'package:tire_tech_mobile/core/utils/size_config.dart';
import 'package:tire_tech_mobile/gen/colors.gen.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.textController,
    this.maxLength,
    this.parametersValidate = '',
    this.focus = false,
    this.mode,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction,
    this.minLines,
    this.maxLines = 1,
    this.onChanged,
    this.errorText,
    this.onTap,
    this.suffixIcon,
    this.inputFormatters,
    this.padding,
    this.helpText,
    this.hintText,
    this.validators,
    this.obscureText = false,
    this.focusNode,
  });

  final String labelText;
  final TextEditingController textController;
  final bool focus;
  final int? maxLength;
  final String? parametersValidate;
  final AutovalidateMode? mode;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? minLines;
  final int? maxLines;
  final Function(String)? onChanged;
  final String? errorText;
  final Function()? onTap;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? padding;
  final String? helpText;
  final String? hintText;
  final FormFieldValidator<String>? validators;
  final bool obscureText;
  final FocusNode? focusNode;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                widget.padding ?? const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: widget.labelText),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  focusNode: widget.focusNode,
                  obscureText: widget.obscureText,
                  inputFormatters: widget.inputFormatters,
                  onTap: widget.onTap,
                  onChanged: widget.onChanged,
                  readOnly: widget.readOnly,
                  maxLength: widget.maxLength,
                  controller: widget.textController,
                  autovalidateMode: widget.mode,
                  keyboardType: widget.keyboardType,
                  textInputAction: widget.textInputAction,
                  minLines: widget.minLines,
                  maxLines: widget.maxLines,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    counterText: '',
                    focusColor: Colors.blue,
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      letterSpacing: .3,
                      fontWeight: FontWeight.w400,
                    ),
                    floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                        (Set<MaterialState> states) {
                      final Color? color = states.contains(MaterialState.error)
                          ? ColorName.error
                          : null;
                      return TextStyle(
                        fontSize: 16,
                        letterSpacing: .5,
                        fontWeight: FontWeight.w700,
                        color: color,
                      );
                    }),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: const BorderSide(
                        color: ColorName.error,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: const BorderSide(
                        color: ColorName.border,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: const BorderSide(
                        color: ColorName.placeHolder,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: const BorderSide(
                        color: ColorName.error,
                      ),
                    ),
                    // contentPadding: EdgeInsets.symmetric(
                    //   horizontal: SizeConfig.getProportionateScreenWidth(16),
                    //   vertical: SizeConfig.getProportionateScreenHeight(16.5),
                    // ),
                    errorStyle: const TextStyle(
                      fontSize: 0,
                      height: 0,
                    ),
                    suffixIcon: widget.suffixIcon,
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  validator: widget.validators ??
                      (value) {
                        if ((value == null || value.isEmpty) &&
                            widget.parametersValidate != null) {
                          return widget.parametersValidate;
                        }
                        return null;
                      },
                ),
              ],
            ),
          ),
          if (widget.helpText != null) ...[
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.only(left: 10),
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.getProportionateScreenWidth(40),
              ),
              child: Text(
                widget.helpText!,
                style: const TextStyle(
                  fontSize: 12,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
          if (widget.errorText != null) ...[
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.only(left: 10),
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.getProportionateScreenWidth(40),
              ),
              child: Text(
                widget.errorText!,
                style: const TextStyle(
                  fontSize: 12,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w400,
                  color: ColorName.error,
                ),
              ),
            ),
          ],
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  String emptyValidation(String value, String messageError) {
    if (value.isEmpty) {
      return messageError;
    }
    return '';
  }
}
