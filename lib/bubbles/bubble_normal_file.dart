import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///basic chat bubble type
///
///chat bubble [BorderRadius] can be customized using [bubbleRadius]
///chat bubble color can be customized using [color]
///chat bubble tail can be customized  using [tail]
///chat bubble display message can be changed using [text]
///[text] is the only required parameter
///message sender can be changed using [isSender]
///[sent],[delivered] and [seen] can be used to display the message state
///chat bubble [TextStyle] can be customized using [textStyle]

class BubbleNormalFile extends StatelessWidget {
  final double bubbleRadius;
  final bool isSender;
  final Color color;
  final String nameFile;
  final String amountOfMemory;
  final bool tail;
  final bool sent;
  final bool delivered;
  final bool seen;
  final TextStyle textStyle;
  final DateTime? timestamp;
  final BoxConstraints? constraints;

  BubbleNormalFile({
    Key? key,
    required this.nameFile,
    required this.amountOfMemory,
    this.constraints,
    this.timestamp,
    this.bubbleRadius = 16,
    this.isSender = true,
    this.color = Colors.white70,
    this.tail = true,
    this.sent = false,
    this.delivered = false,
    this.seen = false,
    this.textStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 16,
    ),
  }) : super(key: key);

  ///chat bubble builder method
  @override
  Widget build(BuildContext context) {
    bool stateTick = false;
    Widget? stateIcon;
    if (sent) {
      stateTick = true;
      // stateIcon = Text(
      //   '12:30',
      //   style: TextStyle(fontSize: 12),
      // );
      stateIcon = Icon(
        Icons.done,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (delivered) {
      stateTick = true;
      stateIcon = Icon(
        Icons.done_all,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (seen) {
      stateTick = true;
      stateIcon = Icon(
        Icons.done_all,
        size: 18,
        color: Color(0xFF92DEDA),
      );
    }

    double rightPadding = 12;
    rightPadding += stateTick ? 16 : 0;
    rightPadding += timestamp != null ? 32 : 0;

    return Row(
      children: <Widget>[
        isSender
            ? Expanded(
                child: SizedBox(
                  width: 5,
                ),
              )
            : SizedBox(),
        Container(
          color: Colors.transparent,
          constraints: constraints ??
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(bubbleRadius),
                  topRight: Radius.circular(bubbleRadius),
                  bottomLeft: Radius.circular(tail
                      ? isSender
                          ? bubbleRadius
                          : 0
                      : 16),
                  bottomRight: Radius.circular(tail
                      ? isSender
                          ? 0
                          : bubbleRadius
                      : 16),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 6, rightPadding, 6),
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.file_present_sharp,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(12 + 50, 6, rightPadding, 6),
                        child: Text(
                          nameFile,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(12 + 50, 0, rightPadding, 6),
                        child: Text(
                          amountOfMemory,
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  stateIcon != null && stateTick
                      ? Positioned(
                          bottom: 4,
                          right: 6,
                          child: stateIcon,
                        )
                      : SizedBox(
                          width: 1,
                        ),
                  timestamp != null
                      ? Positioned(
                          bottom: 4,
                          right: stateTick ? 26 : 6,
                          child: Text(
                            DateFormat('HH:mm').format(timestamp!),
                            style: textStyle.copyWith(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 1,
                        )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
