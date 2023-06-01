import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomBottomBar extends StatefulWidget {
  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  void _toggleButtons() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController?.forward();
      } else {
        _animationController?.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: _toggleButtons,
            child: Container(
              width: 47,
              height: 47,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Icon(
                Icons.menu_book,
                color: Colors.white,
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _animationController!,
            builder: (context, child) {
              return Transform.translate(
                child: child,
                offset: Offset.fromDirection(1),
              );
            },
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double screenHeight = constraints.maxHeight;
                double screenWidth = constraints.maxWidth;

                if (kDebugMode) {
                  print(
                      "(DEBUG_MODE) BOTTOMBAR.BUILD.CHILD.LAYOUTBUILDER.SCREENHEIGHT = $screenHeight");
                  print(
                      "(DEBUG_MODE) BOTTOMBAR.BUILD.CHILD.LAYOUTBUILDER.SCREENWIDTH = $screenWidth");
                }

                return Container(
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.2,
                  child: _isExpanded
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              right: 0,
                              bottom: screenHeight * 0.14,
                              left: 0,
                              child: AnimatedOpacity(
                                opacity: _isExpanded ? 1.0 : 0.0,
                                duration: Duration(milliseconds: 500),
                                child: GestureDetector(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                    ),
                                    child: Icon(
                                      Icons.visibility,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 35,
                              top: 0,
                              bottom: 0,
                              child: AnimatedOpacity(
                                opacity: _isExpanded ? 1.0 : 0.0,
                                duration: Duration(milliseconds: 500),
                                child: GestureDetector(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 35,
                              top: 0,
                              bottom: 0,
                              child: AnimatedOpacity(
                                opacity: _isExpanded ? 1.0 : 0.0,
                                duration: Duration(milliseconds: 500),
                                child: GestureDetector(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 55,
                              bottom: 5,
                              child: AnimatedOpacity(
                                opacity: _isExpanded ? 1.0 : 0.0,
                                duration: Duration(milliseconds: 500),
                                child: GestureDetector(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                    ),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 55,
                              bottom: 5,
                              child: AnimatedOpacity(
                                opacity: _isExpanded ? 1 : 0.0,
                                duration: Duration(seconds: 5),
                                child: GestureDetector(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                    ),
                                    child: Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
