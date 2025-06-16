import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnimatedBuilder Only Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AnimatedBuilderOnlyDemo(),
    );
  }
}

class AnimatedBuilderOnlyDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedBuilder Widget Examples'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          DemoSection(
            title: 'Basic AnimatedBuilder',
            child: BasicAnimatedBuilderExample(),
          ),
          
          DemoSection(
            title: 'AnimatedBuilder with Controller',
            child: ControllerAnimatedBuilderExample(),
          ),
          
          DemoSection(
            title: 'AnimatedBuilder with Child Parameter',
            child: ChildParameterExample(),
          ),
          
          DemoSection(
            title: 'Multiple AnimatedBuilder Patterns',
            child: MultipleAnimatedBuilderExample(),
          ),
        ],
      ),
    );
  }
}

class DemoSection extends StatelessWidget {
  final String title;
  final Widget child;

  const DemoSection({Key? key, required this.title, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

// Basic AnimatedBuilder
class BasicAnimatedBuilderExample extends StatefulWidget {
  @override
  _BasicAnimatedBuilderExampleState createState() =>
      _BasicAnimatedBuilderExampleState();
}

class _BasicAnimatedBuilderExampleState extends State<BasicAnimatedBuilderExample>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _controller.value,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          );
        },
      ),
    );
  }
}

// AnimatedBuilder with proper controller setup
class ControllerAnimatedBuilderExample extends StatefulWidget {
  @override
  _ControllerAnimatedBuilderExampleState createState() =>
      _ControllerAnimatedBuilderExampleState();
}

class _ControllerAnimatedBuilderExampleState
    extends State<ControllerAnimatedBuilderExample>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    // Proper controller setup
    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    // Always dispose controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: controller.value * 2 * pi,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        },
      ),
    );
  }
}

// AnimatedBuilder with child parameter
class ChildParameterExample extends StatefulWidget {
  @override
  _ChildParameterExampleState createState() => _ChildParameterExampleState();
}

class _ChildParameterExampleState extends State<ChildParameterExample>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: controller,
        // Static child - built only once
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(Icons.star, color: Colors.white, size: 40),
        ),
        builder: (context, child) {
          return Transform.scale(
            scale: 0.5 + (controller.value * 0.5), // Scale from 0.5 to 1.0
            child: child, // Reuse the static child
          );
        },
      ),
    );
  }
}

// Multiple AnimatedBuilder patterns
class MultipleAnimatedBuilderExample extends StatefulWidget {
  @override
  _MultipleAnimatedBuilderExampleState createState() =>
      _MultipleAnimatedBuilderExampleState();
}

class _MultipleAnimatedBuilderExampleState
    extends State<MultipleAnimatedBuilderExample>
    with TickerProviderStateMixin {
  late AnimationController rotationController;
  late AnimationController scaleController;
  late AnimationController positionController;
  late AnimationController opacityController;

  @override
  void initState() {
    super.initState();
    
    rotationController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    )..repeat();

    scaleController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    positionController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    opacityController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    rotationController.dispose();
    scaleController.dispose();
    positionController.dispose();
    opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Rotation AnimatedBuilder
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('Rotation', style: TextStyle(fontSize: 12)),
                AnimatedBuilder(
                  animation: rotationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: rotationController.value * 2 * pi,
                      child: Container(
                        width: 40,
                        height: 40,
                        color: Colors.purple,
                      ),
                    );
                  },
                ),
              ],
            ),
            
            // Scale AnimatedBuilder
            Column(
              children: [
                Text('Scale', style: TextStyle(fontSize: 12)),
                AnimatedBuilder(
                  animation: scaleController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 0.5 + (scaleController.value * 0.5),
                      child: Container(
                        width: 40,
                        height: 40,
                        color: Colors.orange,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        
        SizedBox(height: 20),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Position AnimatedBuilder
            Column(
              children: [
                Text('Position', style: TextStyle(fontSize: 12)),
                Container(
                  width: 80,
                  height: 50,
                  child: AnimatedBuilder(
                    animation: positionController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(positionController.value * 40 - 20, 0),
                        child: Container(
                          width: 20,
                          height: 20,
                          color: Colors.teal,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            
            // Opacity AnimatedBuilder
            Column(
              children: [
                Text('Opacity', style: TextStyle(fontSize: 12)),
                AnimatedBuilder(
                  animation: opacityController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: opacityController.value,
                      child: Container(
                        width: 40,
                        height: 40,
                        color: Colors.pink,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}