import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget>
    with SingleTickerProviderStateMixin {
  late double _ratingBarValue;
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _ratingBarValue = 3;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Set animation duration
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0), // Start off-screen at bottom
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    // Start the animation when the widget is built
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 104, 103, 103),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return SlideTransition(
            position: _offsetAnimation,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: 300),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(0, 5),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Product Name',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.close_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        _animationController
                                            .reverse()
                                            .then((_) {
                                          Navigator.pop(context);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 4),
                                child: Text(
                                  'Order ID',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: RatingBar.builder(
                                    onRatingUpdate: (newValue) {
                                      setState(() {
                                        _ratingBarValue = newValue;
                                      });
                                    },
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star_rounded,
                                      color: Colors.amber,
                                    ),
                                    direction: Axis.horizontal,
                                    initialRating: _ratingBarValue,
                                    unratedColor: Colors.grey,
                                    itemCount: 5,
                                    itemSize: 40,
                                    glowColor:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 300,
                                constraints: BoxConstraints(
                                  maxWidth: 350,
                                  maxHeight: 200,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  border: Border.all(
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Semantics(
                                    label: 'Review',
                                    hint: 'Enter your comment here',
                                    child: TextFormField(
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                        hintText: 'Comment',
                                        hintStyle: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Theme.of(context).errorColor,
                                            width: 0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Theme.of(context).errorColor,
                                            width: 0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                      ),
                                      maxLines: 3,
                                      minLines: null,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 16),
                                      child: TextButton(
                                        onPressed: () {
                                          print('Cancel button pressed ...');
                                          _animationController
                                              .reverse()
                                              .then((_) {
                                            Navigator.pop(context);
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.all(10),
                                          backgroundColor: Colors.red,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        print('Submit button pressed ...');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text('Submission successful'),
                                          ),
                                        );
                                        _animationController
                                            .reverse()
                                            .then((_) {
                                          Navigator.pop(context);
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(10),
                                        backgroundColor: Colors.blue[700],
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                        elevation: 1,
                                        side: BorderSide(
                                            color: Colors.transparent,
                                            width: 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
