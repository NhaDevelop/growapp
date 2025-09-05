import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';

class HtmlContentScreen extends StatelessWidget {
  final String title;
  final String htmlData;
  const HtmlContentScreen(
      {super.key, required this.title, required this.htmlData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context, title: title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Html(
          data: htmlData,
          style: {
            "img": Style(
              width: Width(MediaQuery.of(context).size.width - 32), // Account for padding
              height: Height.auto(),
              display: Display.block,
            ),
          },
          extensions: [
            TagExtension(
              tagsToExtend: {"img"},
              builder: (extensionContext) {
                final attributes = extensionContext.attributes;
                final src = attributes['src'];
                if (src != null) {
                  return GestureDetector(
                    onTap: () {
                      // Show full-size image in a dialog when tapped
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          backgroundColor: Colors.black,
                          child: Stack(
                            children: [
                              Center(
                                child: InteractiveViewer(
                                  child: Image.network(
                                    src,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.error,
                                        color: Colors.white,
                                        size: 50,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 40,
                                right: 20,
                                child: IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Image.network(
                      src,
                      width: MediaQuery.of(context).size.width - 32,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: MediaQuery.of(context).size.width - 32,
                          height: 200,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.error,
                            color: Colors.grey,
                            size: 50,
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}