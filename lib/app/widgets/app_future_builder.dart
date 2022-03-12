import 'package:flutter/material.dart';

class AppFutureBuilder<T> extends StatefulWidget {
  final Future<T> future;
  final Widget Function(T? data) onData;
  final Function(dynamic error)? onError;
  final WidgetBuilder? onLoading;
  const AppFutureBuilder({
    Key? key,
    this.onLoading,
    this.onError,
    required this.future,
    required this.onData,
  }) : super(key: key);

  @override
  State<AppFutureBuilder<T>> createState() => _AppFutureBuilderState<T>();
}

class _AppFutureBuilderState<T> extends State<AppFutureBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.waiting) {
          return widget.onLoading != null
              ? widget.onLoading!.call(context)
              : const Center(
                  child: CircularProgressIndicator(),
                );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            var error = snapshot.error;
            return widget.onError != null
                ? widget.onError!.call(error)
                : Center(
                    child: SingleChildScrollView(
                      child: Text(
                        error.toString(),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
          } else {
            return widget.onData(snapshot.data);
          }
        }
        return Container();
      },
    );
  }
}
