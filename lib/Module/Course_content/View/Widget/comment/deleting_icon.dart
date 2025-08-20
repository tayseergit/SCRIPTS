import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';

class DeleteLoadingIcon extends StatefulWidget {
  final bool isLoading;

  const DeleteLoadingIcon({super.key, required this.isLoading});

  @override
  State<DeleteLoadingIcon> createState() => _DeleteLoadingIconState();
}

class _DeleteLoadingIconState extends State<DeleteLoadingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      lowerBound: 0.8, // min zoom
      upperBound: 1.2, // max zoom
    );

    if (widget.isLoading) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(DeleteLoadingIcon oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isLoading && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.isLoading && _controller.isAnimating) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;
    
    return ScaleTransition(
      scale: _controller,
      child: Icon(
        Icons.delete,
        color: widget.isLoading ? appColors.red : appColors.red,
      ),
    );
  }
}
