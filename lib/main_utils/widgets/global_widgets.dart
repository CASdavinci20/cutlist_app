import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/PublicVar.dart';

class ShowProcessingIndicator extends StatelessWidget {
  final double? size;
  const ShowProcessingIndicator({Key? key, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 20,
      width: size ?? 20,
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey[100],
        strokeWidth: 2.0,
        valueColor:
            AlwaysStoppedAnimation<Color>(Color(PublicVar.primaryColor)),
      ),
    );
  }
}

class CircleLeadingImages extends StatelessWidget {
  final data;
  const CircleLeadingImages({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: Colors.blue,
        height: 30,
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Text(
          data,
          style: TextStyle(
              color: Colors.orange, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ShowPageLoading extends StatelessWidget {
  final text, textColor;
  const ShowPageLoading({
    Key? key,
    this.text,
    this.textColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceFont = deviceHeight * 0.01;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ShowProcessingIndicator(
              size: deviceHeight * 0.04,
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.01,
          ),
          Text(
            text ?? 'One moment please...',
            style: TextStyle(
              fontSize: 2.2 * deviceFont,
              color: textColor ?? Color(PublicVar.black),
            ),
          )
        ],
      ),
    );
  }
}

class AppBackButton extends StatelessWidget {
  final onPressed, color;
  const AppBackButton({Key? key, this.onPressed, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        iconSize: 40,
        icon: Icon(
          Icons.chevron_left_rounded,
          size: 40,
          color: color ?? Color(PublicVar.textPrimaryDark),
        ));
  }
}

class GetImageProvider extends StatelessWidget {
  final url, placeHolder, height;
  const GetImageProvider({Key? key, this.url, this.placeHolder, this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: double.infinity,
      height: height,
      imageUrl: url ?? "",
      placeholderFadeInDuration: Duration(milliseconds: 10),
      placeholder: (context, url) => Image.asset(
        placeHolder,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
      errorWidget: (context, url, error) => Image.asset(
        placeHolder,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
      fit: BoxFit.cover,
    );
  }
}

class DisplayMessage extends StatelessWidget {
  final String asset, title, message, btnText;
  final Function onPress;
  final double btnWidth;
  final textColor;
  const DisplayMessage(
      {Key? key,
      required this.asset,
      required this.message,
      required this.title,
      required this.btnText,
      required this.onPress,
      required this.btnWidth,
      this.textColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceFont = deviceHeight * 0.01;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            asset == ""
                ? SizedBox()
                : Image.asset(
                    asset,
                    height: 80,
                  ),
            title == ""
                ? SizedBox()
                : Padding(
                    padding: EdgeInsets.only(
                        left: 14.0, right: 14.0, top: 14.0, bottom: 5),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor ?? Color(PublicVar.black)),
                    ),
                  ),
            message == ""
                ? SizedBox()
                : Padding(
                    padding: EdgeInsets.only(
                        left: 14.0, right: 14.0, top: 5.0, bottom: 15),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 2.2 * deviceFont,
                          color: textColor ?? Color(PublicVar.black),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
            btnText == ""
                ? SizedBox()
                : ButtonWidget(
                    onPress: onPress,
                    width: btnWidth ?? deviceWidth * 0.20,
                    height: 40.0,
                    fontSize: 14.0,
                    txColor: Color(PublicVar.primaryDark),
                    bgColor: Colors.white,
                    border: Border.all(
                      color: Color(PublicVar.primaryDark),
                    ),
                    text: btnText,
                    addIconBG: false,
                    loading: false,
                  )
          ],
        ),
      ),
    );
  }
}

class GetTileStatus extends StatelessWidget {
  final bool done;
  const GetTileStatus({Key? key, required this.done}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.done ? "Done" : "Pending...",
      style: TextStyle(
          color: this.done ? Colors.green : Colors.orange,
          fontSize: 18,
          fontWeight: FontWeight.bold),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final width,
      height,
      text,
      bgColor,
      txColor,
      radius,
      child,
      onPress,
      textIcon,
      border,
      fontSize,
      icon,
      iconColor,
      iconSize;

  bool loading = false, addIconBG = false;
  ButtonWidget({
    Key? key,
    this.width,
    this.height,
    this.text,
    this.bgColor,
    this.txColor,
    this.radius,
    this.border,
    this.child,
    this.onPress,
    required this.loading,
    this.textIcon,
    this.fontSize,
    required this.addIconBG,
    this.icon,
    this.iconColor,
    this.iconSize,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (addIconBG == null) {
      addIconBG = true;
    }
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          border: border ?? Border.all(width: 0, color: Colors.transparent),
          borderRadius: BorderRadius.circular(radius ?? 8)),
      child: child ??
          Material(
            color: bgColor,
            elevation: 0.5,
            shadowColor: Colors.grey[100],
            borderOnForeground: false,
            borderRadius: BorderRadius.circular(radius ?? 8),
            child: InkWell(
              onTap: onPress,
              splashColor: Colors.grey[200],
              borderRadius: BorderRadius.circular(radius ?? 8),
              child: icon == null
                  ? Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Center(
                        child: loading
                            ? ShowProcessingIndicator(
                                size: 20,
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(),
                                  Flexible(
                                      fit: FlexFit.loose,
                                      child: Text(
                                        text,
                                        style: TextStyle(
                                            color: txColor,
                                            fontSize: fontSize ?? 16,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  textIcon != null
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              radius ?? 40),
                                          child: Container(
                                              height: 20,
                                              width: 20,
                                              color: addIconBG
                                                  ? Colors.white
                                                  : Colors.transparent,
                                              alignment: Alignment.center,
                                              child: Icon(
                                                textIcon,
                                                color: addIconBG
                                                    ? bgColor
                                                    : txColor,
                                                size: 16,
                                              )))
                                      : SizedBox()
                                ],
                              ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(radius ?? 40),
                      child: Container(
                          height: height,
                          width: width,
                          color: bgColor,
                          child: Icon(
                            icon,
                            color: iconColor,
                            size: iconSize,
                          ))),
            ),
          ),
    );
  }
}
