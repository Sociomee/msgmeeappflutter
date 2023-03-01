import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:msgmee/theme/custom_theme.dart';

class LinksTabScreen extends StatefulWidget {
  const LinksTabScreen({super.key});

  @override
  State<LinksTabScreen> createState() => _LinksTabScreenState();
}

class _LinksTabScreenState extends State<LinksTabScreen> {
  final String errorImage =
      "https://i.ytimg.com/vi/z8wrRRR7_qU/maxresdefault.jpg";

  List<String> urls = [
    "https://www.espn.in/football/soccer-transfers/story/4163866/transfer-talk-lionel-messi-tells-barcelona-hes-more-likely-to-leave-then-stay"
        "https://speakerdeck.com/themsaid/the-power-of-laravel-queues",
    "https://www.youtube.com/watch?v=W1pNjxmNHNQ",
    "https://www.brainyquote.com/topics/motivational-quotes",
    'https://youtu.be/OUlR2oXgRDs'
  ];
  void getMetadata(String url) async {
    bool _isValid = _getUrlValid(url);
    if (_isValid) {
      Metadata? _metadata = await AnyLinkPreview.getMetadata(
        link: url,
        cache: Duration(days: 7),
        proxyUrl: "https://cors-anywhere.herokuapp.com/", // Needed for web app
      );
      debugPrint(_metadata?.title);
      debugPrint(_metadata?.desc);
    } else {
      debugPrint("URL is not valid");
    }
  }

  bool _getUrlValid(String url) {
    bool _isUrlValid = AnyLinkPreview.isValidLink(
      url,
      protocols: ['http', 'https'],
      hostWhitelist: ['https://youtube.com/'],
      hostBlacklist: ['https://facebook.com/'],
    );
    return _isUrlValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 10, bottom: 10),
              child: Text('RECENT'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: urls.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Container(
                        child: Column(
                          children: [
                            AnyLinkPreview(
                              link: urls[index],
                              displayDirection:
                                  UIDirection.uiDirectionHorizontal,
                              cache: Duration(hours: 1),
                              backgroundColor: CustomTheme.lightgrey1,
                              errorWidget: Container(
                                color: CustomTheme.lightgrey1,
                                // child: Text('Oops!'),
                              ),
                              placeholderWidget: Center(
                                child: CircularProgressIndicator(
                                  color: CustomTheme.primaryColor,
                                ),
                              ),
                              errorImage: errorImage,
                              errorBody: 'Show my custom error body',
                              errorTitle:
                                  'Next one is youtube link, error title',
                            ),
                            // Row(
                            //   children: [
                            //     SizedBox(
                            //       width: 300,
                            //       child: Text(
                            //         urls[index].substring(0, 30),
                            //         softWrap: true,
                            //       ),
                            //     ),
                            //     Icon(
                            //       Icons.arrow_forward_ios,
                            //       color: CustomTheme.iconColor,
                            //     )
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 10, bottom: 10),
              child: Text('LAST WEEK'),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: urls.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: AnyLinkPreview(
                          link: urls[index],
                          displayDirection: UIDirection.uiDirectionHorizontal,
                          cache: Duration(hours: 1),
                          backgroundColor: CustomTheme.lightgrey1,
                          errorWidget: Container(
                            color: CustomTheme.lightgrey1,
                            // child: Text('Oops!'),
                          ),
                          placeholderWidget: Center(
                            child: CircularProgressIndicator(
                              color: CustomTheme.primaryColor,
                            ),
                          ),
                          errorImage: errorImage,
                          errorBody: 'Show my custom error body',
                          errorTitle: 'Next one is youtube link, error title',
                        ),
                      );
                    })),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 10, bottom: 10),
              child: Text('LAST MONTH'),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: urls.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: AnyLinkPreview(
                          link: urls[index],
                          displayDirection: UIDirection.uiDirectionHorizontal,
                          cache: Duration(hours: 1),
                          backgroundColor: CustomTheme.lightgrey1,
                          errorWidget: Container(
                            color: CustomTheme.lightgrey1,
                            // child: Text('Oops!'),
                          ),
                          placeholderWidget: Center(
                            child: CircularProgressIndicator(
                              color: CustomTheme.primaryColor,
                            ),
                          ),
                          errorImage: errorImage,
                          errorBody: 'Show my custom error body',
                          errorTitle: 'Next one is youtube link, error title',
                        ),
                      );
                    })),
          ],
        ),
      )),
    );
  }
}
