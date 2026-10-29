import 'package:flutter/material.dart';

class LoadingScreen<T> extends StatefulWidget {
  const LoadingScreen({
    super.key,
    required this.onLoad,
    required this.onFinish,
    this.onError,
    this.message = 'Cargando...',
  });

  final Future<T> Function() onLoad;
  final void Function(T result) onFinish;
  final void Function(Object error)? onError;
  final String message;

  @override
  State<LoadingScreen<T>> createState() => _LoadingScreenState<T>();
}

class _LoadingScreenState<T> extends State<LoadingScreen<T>> {
  @override
  void initState() {
    super.initState();

    // Ejecutar después del primer frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _execute();
    });
  }

  Future<void> _execute() async {
    try {
      // Esperar a que termine la función.
      final result = await widget.onLoad();

      if (!mounted) return;

      // Devolver el resultado.
      widget.onFinish(result);
    } catch (error) {
      if (!mounted) return;

      if (widget.onError != null) {
        widget.onError!(error);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),

            const SizedBox(height: 24),

            Text(
              widget.message,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
