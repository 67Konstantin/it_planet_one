import '/exports.dart';

class CustomTextInput extends StatefulWidget {
  final String labelText;
  final bool isPassword;
  final bool isPhoneNumber;
  final TextEditingController controller;
  final List<String? Function(String)> validationConditions;
  final bool isRequired;

  const CustomTextInput({
    Key? key,
    required this.labelText,
    required this.controller,
    this.isPassword = false,
    this.isPhoneNumber = false,
    this.validationConditions = const [],
    this.isRequired = false,
  }) : super(key: key);

  @override
  CustomTextInputState createState() => CustomTextInputState();
}

class CustomTextInputState extends State<CustomTextInput> {
  bool _isFocused = false;
  bool _hasBeenFocused = false;
  String? _errorText;
  bool _obscureText = true;
  bool get hasError => _errorText != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color fillColor;
    Color borderColor;
    double borderWidth;
    

    if (_errorText != null) {
      fillColor = theme.colorScheme.error.withAlpha(5);
      borderColor = theme.colorScheme.error.withAlpha(80);
      borderWidth = 2.0;
    } else if (_isFocused) {
      fillColor = theme.primaryColor.withAlpha(7);
      borderColor = theme.primaryColor;
      borderWidth = 2.0;
    } else if (widget.controller.text.isNotEmpty) {
      fillColor = theme.primaryColor.withAlpha(7);
      borderColor = theme.primaryColor.withAlpha(200);
      borderWidth = 1.0;
    } else {
      fillColor = theme.dividerColor.withAlpha(7);
      borderColor = theme.dividerColor.withAlpha(80);
      borderWidth = 1.0;
    }

    return Focus(
      onFocusChange: (isFocused) {
        setState(() {
          _isFocused = isFocused;
          if (!isFocused) {
            _hasBeenFocused = true;
            _validate();
          }
        });
      },
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: _errorText != null
                ? theme.colorScheme.error
                : _isFocused
                    ? theme.primaryColor
                    : theme.dividerColor,
          ),
          filled: true,
          fillColor: fillColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(
              color: theme.colorScheme.error.withAlpha(100),
              width: 2.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(
              color: theme.colorScheme.error.withAlpha(200),
              width: 2.0,
            ),
          ),
          errorText: _hasBeenFocused ? _errorText : null,
          suffixIcon: widget.isPassword ? IconButton(
            icon: Icon(
              
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: /* theme.primaryColor.withAlpha(120) , */
              borderColor,
              semanticLabel: 'Показать пароль',
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ) : null,
        ),
        obscureText: widget.isPassword ? _obscureText : false,
        keyboardType: widget.isPhoneNumber ? TextInputType.phone : TextInputType.text,
        onChanged: (value) {
          if (_hasBeenFocused) {
            setState(() {
              _validate();
            });
          }
        },
      ),
    );
  }

  void _validate() {
    _errorText = null;
    if (widget.isRequired && widget.controller.text.isEmpty) {
      _errorText = 'Это поле обязательно';
    } else {
      for (var condition in widget.validationConditions) {
        _errorText = condition(widget.controller.text);
        if (_errorText != null) break;
      }
    }
  }

  void validate() {
    setState(() {
      _validate();
    });
  }
}
