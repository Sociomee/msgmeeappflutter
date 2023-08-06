import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/theme/colors.dart';

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
  List<String> content = [
    'Find & Download 4,078 Link Icon Icons in Line, Flat, Glyph, Colored Outline, and many more design styles for web, mobile, and graphic. ',
    'https://docs.google.com/spreadsheets/d/1D0PmYVdV1lQSjuf-grPuZGhMZnoO9ROAPGkWG91dW0k/edit#gid=0',
    'https://docs.google.com/spreadsheets/d/1D0PmYVdV1lQSjuf-grPuZGhMZnoO9ROAPGkWG91dW0k/edit#gid=0',
    'https://docs.google.com/spreadsheets/d/1D0PmYVdV1lQSjuf-grPuZGhMZnoO9ROAPGkWG91dW0k/edit#gid=0',
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
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
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
                          width: 391.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColors.grey)),
                          child: Column(
                            children: [
                              //? DO Not Delete this code
                              // AnyLinkPreview(
                              //   link: urls[index],
                              //   displayDirection:
                              //       UIDirection.uiDirectionHorizontal,
                              //   cache: Duration(hours: 1),
                              //   backgroundColor: AppColors.lightgrey1,
                              //   borderRadius: 5,
                              //   errorWidget:
                              //       Container(color: AppColors.lightgrey1),
                              //   placeholderWidget: Center(
                              //       child: CircularProgressIndicator(
                              //           color: AppColors.primaryColor)),
                              //   errorImage: errorImage,
                              //   errorBody: 'Show my custom error body',
                              //   errorTitle:
                              //       'Next one is youtube link, error title',
                              // ),
                              Row(
                                children: [
                                  Container(
                                    width: 89,
                                    height: 89,
                                    decoration: BoxDecoration(
                                        color: AppColors.black.withOpacity(.2)),
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset('assets/link.svg',
                                        height: 44),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 89,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      decoration: BoxDecoration(
                                          color: AppColors.lightgrey1,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5))),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                  width: 271,
                                                  child: Text(
                                                    content[index],
                                                    overflow: TextOverflow.clip,
                                                  )),
                                              Text(
                                                'docs.google.com',
                                                style: TextStyle(
                                                  color: Color(0x7F4E4E4E),
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 300,
                                      child: Text(urls[index],
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: AppColors.iconColor,
                                      size: 15,
                                    )
                                  ],
                                ),
                              )
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
                          child: Container(
                            width: 391.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: AppColors.grey)),
                            child: Column(
                              children: [
                                //? DO Not Delete this code
                                // AnyLinkPreview(
                                //   link: urls[index],
                                //   displayDirection:
                                //       UIDirection.uiDirectionHorizontal,
                                //   cache: Duration(hours: 1),
                                //   backgroundColor: AppColors.lightgrey1,
                                //   borderRadius: 5,
                                //   errorWidget:
                                //       Container(color: AppColors.lightgrey1),
                                //   placeholderWidget: Center(
                                //       child: CircularProgressIndicator(
                                //           color: AppColors.primaryColor)),
                                //   errorImage: errorImage,
                                //   errorBody: 'Show my custom error body',
                                //   errorTitle:
                                //       'Next one is youtube link, error title',
                                // ),
                                Row(
                                  children: [
                                    Container(
                                      width: 89,
                                      height: 89,
                                      decoration: BoxDecoration(
                                          color:
                                              AppColors.black.withOpacity(.2)),
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset('assets/link.svg',
                                          height: 44),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 89,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        decoration: BoxDecoration(
                                            color: AppColors.lightgrey1,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5))),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                    width: 271,
                                                    child: Text(
                                                      content[index],
                                                      overflow:
                                                          TextOverflow.clip,
                                                    )),
                                                Text(
                                                  'docs.google.com',
                                                  style: TextStyle(
                                                    color: Color(0x7F4E4E4E),
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: Text(urls[index],
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppColors.iconColor,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
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
                          child: Container(
                            width: 391.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: AppColors.grey)),
                            child: Column(
                              children: [
                                //? DO Not Delete this code
                                // AnyLinkPreview(
                                //   link: urls[index],
                                //   displayDirection:
                                //       UIDirection.uiDirectionHorizontal,
                                //   cache: Duration(hours: 1),
                                //   backgroundColor: AppColors.lightgrey1,
                                //   borderRadius: 5,
                                //   errorWidget:
                                //       Container(color: AppColors.lightgrey1),
                                //   placeholderWidget: Center(
                                //       child: CircularProgressIndicator(
                                //           color: AppColors.primaryColor)),
                                //   errorImage: errorImage,
                                //   errorBody: 'Show my custom error body',
                                //   errorTitle:
                                //       'Next one is youtube link, error title',
                                // ),
                                Row(
                                  children: [
                                    Container(
                                      width: 89,
                                      height: 89,
                                      decoration: BoxDecoration(
                                          color:
                                              AppColors.black.withOpacity(.2)),
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset('assets/link.svg',
                                          height: 44),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 89,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        decoration: BoxDecoration(
                                            color: AppColors.lightgrey1,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5))),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                    width: 271,
                                                    child: Text(
                                                      content[index],
                                                      overflow:
                                                          TextOverflow.clip,
                                                    )),
                                                Text(
                                                  'docs.google.com',
                                                  style: TextStyle(
                                                    color: Color(0x7F4E4E4E),
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: Text(urls[index],
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppColors.iconColor,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })),
            ],
          ),
        )),
      ),
    );
  }
}
