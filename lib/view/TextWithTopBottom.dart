import 'package:flutter/material.dart';
import 'package:paytend_pay_sdk/res/ResColors.dart';

class TextWithTopBottom extends StatefulWidget {
  final String hintText;
  final String valueText;
  final bool isShowError;

  TextWithTopBottom({Key key, this.hintText, this.valueText, this.isShowError})
      : super(key: key);

  @override
  _TextWithTopBottomState createState() => _TextWithTopBottomState();
}

class _TextWithTopBottomState extends State<TextWithTopBottom> {

  _isShowTop() {
    return widget.valueText != widget.hintText;
  }

  _isShowError() {
    return widget.isShowError;
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
                      Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                        size: 12,
                      ),
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
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Text(widget.valueText,
                      style: TextStyle(
                          fontSize: 17, color: ResColors.BLACK_333333)),
                ),
              ),
              Container(
                child: Image.asset(
                  'images/down.png',
                  package: 'paytend_pay_sdk',
                  width: 22,
                  height: 22,
                ),
              )
            ],
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
