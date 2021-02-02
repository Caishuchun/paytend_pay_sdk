import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paytend_pay_sdk/res/ResColors.dart';

class EditText extends StatefulWidget {
  final int minLen; //输入最少位数限制
  final int maxLen; //输入最大位数限制
  final InputType inputType; //输入类型
  final String hintText; //提示文字
  final bool isShowError; //错误信息
  final FocusNode focusNode;
  final Function callback; //文字变化回调

  EditText({
    Key key,
    this.minLen,
    this.maxLen,
    this.inputType,
    this.hintText,
    this.isShowError = false,
    this.focusNode,
    this.callback,
  }) : super(key: key);

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  TextEditingController _controller;
  FocusNode _focusNode;
  String _text = '';
  bool _isFocus = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = widget.focusNode;
    _controller.addListener(() {
      setState(() {
        _text = _controller.text;
      });
    });

    _focusNode.addListener(() {
      setState(() {
        _isFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _isShowTop() {
    //有内容或者获得焦点了,就显示
    return _isFocus || _text.length > 0;
  }

  _isShowRight() {
    //判断是否显示对号
    return _isShowTop() && _text.length >= widget.minLen;
  }

  _isShowError() {
    return widget.isShowError;
  }

  _getHint() {
    if (_isFocus) {
      return '';
    } else {
      if (_text.length > 0) {
        return '';
      } else {
        return widget.hintText;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 91,
      width: double.infinity,
      child: Column(
        children: [
          _isShowTop()
              ? Container(
                  height: 15,
                  child: Row(
                    children: [
                      _isShowRight()
                          ? Icon(
                              Icons.check,
                              color: Theme.of(context).primaryColor,
                              size: 12,
                            )
                          : SizedBox(),
                      _isShowRight()
                          ? SizedBox(
                              width: 2,
                            )
                          : SizedBox(),
                      Text(
                        widget.hintText,
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                )
              : SizedBox(
                  height: 15,
                ),
          Container(
            height: 40,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              maxLines: 1,
              style: TextStyle(fontSize: 17, color: ResColors.BLACK_333333),
              obscureText:
                  widget.inputType == InputType.NEED_HIDE ? true : false,
              keyboardType: widget.inputType == InputType.NUMBER ||
                      widget.inputType == InputType.NEED_HIDE
                  ? TextInputType.number
                  : TextInputType.emailAddress,
              inputFormatters: [
                widget.inputType == InputType.NUMBER ||
                        widget.inputType == InputType.NEED_HIDE
                    ? WhitelistingTextInputFormatter.digitsOnly
                    : WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9. ]")),
                LengthLimitingTextInputFormatter(widget.maxLen),
              ],
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: _getHint(),
                  hintStyle:
                      TextStyle(fontSize: 17, color: ResColors.BLACK_333333)),
              onChanged: widget.callback,
            ),
          ),
          Divider(
            height: 1,
            color: ResColors.GREY_C8C7CC,
          ),
          SizedBox(
            height: 5,
          ),
          _isShowError()
              ? Container(
                  height: 15,
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        color: Colors.red,
                        size: 12,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        "请输入正确的" + widget.hintText,
                        style: TextStyle(fontSize: 12, color: Colors.red),
                      )
                    ],
                  ),
                )
              : SizedBox(
                  height: 15,
                ),
        ],
      ),
    );
  }
}

enum InputType {
  NUMBER,
  NEED_HIDE,
  OTHER,
}
