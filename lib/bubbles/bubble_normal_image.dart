import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

const double BUBBLE_RADIUS_IMAGE = 16;

///basic image bubble type
///
///
/// image bubble should have [id] to work with Hero animations
/// [id] must be a unique value
///chat bubble [BorderRadius] can be customized using [bubbleRadius]
///chat bubble color can be customized using [color]
///chat bubble tail can be customized  using [tail]
///chat bubble display image can be changed using [image]
///[image] is a required parameter
///[id] must be an unique value for each other
///[id] is also a required parameter
///message sender can be changed using [isSender]
///[sent],[delivered] and [seen] can be used to display the message state

class BubbleNormalImage extends StatelessWidget {
  static const loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  final String id;
  final Uint8List image;
  final double bubbleRadius;
  final bool isSender;
  final Color color;
  final bool tail;
  final bool sent;
  final bool delivered;
  final bool seen;
  final DateTime? timestamp;
  final void Function()? onTap;

  const BubbleNormalImage({
    Key? key,
    required this.id,
    required this.image,
    this.bubbleRadius = BUBBLE_RADIUS_IMAGE,
    this.isSender = true,
    this.color = Colors.white70,
    this.tail = true,
    this.sent = false,
    this.delivered = false,
    this.seen = false,
    this.onTap,
    this.timestamp,
  }) : super(key: key);

  /// image bubble builder method
  @override
  Widget build(BuildContext context) {
    bool stateTick = false;
    Icon? stateIcon;
    if (sent) {
      stateTick = true;
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

    return Row(
      children: <Widget>[
        isSender
            ? const Expanded(
                child: SizedBox(
                  width: 5,
                ),
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .5,
                maxHeight: MediaQuery.of(context).size.width * .5),
            child: GestureDetector(
                child: Hero(
                  tag: id,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(bubbleRadius),
                            topRight: Radius.circular(bubbleRadius),
                            bottomLeft: Radius.circular(tail
                                ? isSender
                                    ? bubbleRadius
                                    : 0
                                : BUBBLE_RADIUS_IMAGE),
                            bottomRight: Radius.circular(tail
                                ? isSender
                                    ? 0
                                    : bubbleRadius
                                : BUBBLE_RADIUS_IMAGE),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(bubbleRadius),
                            child: Image.memory(image, fit: BoxFit.cover),
                          ),
                        ),
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
                    ],
                  ),
                ),
                onTap: onTap ??
                    () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  _DetailScreen(
                            tag: id,
                            image: image,
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = 0.0;
                            const end = 1.0;
                            const curve = Curves.easeInOut;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            var opacityAnimation = tween.animate(animation);

                            return FadeTransition(
                              opacity: opacityAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    }),
          ),
        )
      ],
    );
  }
}

/// detail screen of the image, display when tap on the image bubble
class _DetailScreen extends StatefulWidget {
  final String tag;
  final Uint8List image;

  const _DetailScreen({Key? key, required this.tag, required this.image})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

/// created using the Hero Widget
class _DetailScreenState extends State<_DetailScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              PhotoView(
                heroAttributes: PhotoViewHeroAttributes(tag: widget.tag),
                enableRotation: true,
                imageProvider: MemoryImage(widget.image),
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 2,
              ),
              Positioned(
                top: 50.0,
                left: 20.0,
                child: Material(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(25),
                    child: InkWell(
                        onTap: () => Navigator.pop(context),
                        splashColor:
                            Theme.of(context).platform == TargetPlatform.iOS
                                ? Colors.transparent
                                : null,
                        borderRadius: BorderRadius.circular(25),
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 28,
                          ),
                        ))),

                // child: IconButton(
                //   icon: Icon(Icons.close),
                //   color: Colors.white,
                //   onPressed: () {
                //     // Close the screen when pressing the "Close" button
                //     Navigator.pop(context);
                //   },
                // ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     child: Scaffold(
  //       body: Center(
  //         child: Hero(
  //           tag: widget.tag,
  //           child: PhotoView(
  //             imageProvider: AssetImage(widget.image.path),
  //           ),
  //         ),
  //       ),
  //     ),
  //     onTap: () {
  //       Navigator.pop(context);
  //     },
  //   );
  // }
}
