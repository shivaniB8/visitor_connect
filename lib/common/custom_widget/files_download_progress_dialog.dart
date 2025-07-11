import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:host_visitor_connect/common/res/styles.dart';

class FilesDownloadProgressDialog extends StatelessWidget {
  final Stream? downloadStream;
  final Function(String) onComplete;

  const FilesDownloadProgressDialog({
    Key? key,
    required this.downloadStream,
    required this.onComplete,
  }) : super(key: key);

  double _getProgressValue(AsyncSnapshot snapshot) {
    final snapshotData = snapshot.data;

    return snapshot.hasData && snapshotData is DownloadProgress
        ? snapshotData.progress ?? 0.0
        : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder(
          stream: downloadStream,
          builder: (context, snapshot) {
            final snapshotData = snapshot.data;
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshotData is FileInfo) {
              Navigator.pop(context);
              onComplete.call(snapshotData.file.path);
              return const SizedBox.shrink();
            } else if (snapshot.connectionState == ConnectionState.done &&
                !snapshot.hasData) {
              Navigator.pop(context);
              return const SizedBox.shrink();
            } else {
              final progressValue = _getProgressValue(snapshot);
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Loading',
                    style: text_style_title8,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: progressValue,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        '${(progressValue * 100).toInt().toString()}%',
                        style: text_style_title8,
                      )
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
