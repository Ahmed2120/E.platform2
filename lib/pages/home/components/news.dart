import 'package:eplatform/core/utility/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../model/mainmodel.dart';

class News extends StatelessWidget {
  const News({required this.model, Key? key}) : super(key: key);
  final MainModel model;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: model.homeBloglList.length,
        itemBuilder: (context, index) => InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                      color: const Color(0xFF000000).withOpacity(0.12)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 1,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    model.homeBloglList[index].Image == ''
                        ? Image.asset('assets/images/score.png')
                        : Image.network(
                            model.homeBloglList[index].Image,
                            height: 40,
                            width: 50,
                            fit: BoxFit.fill,
                          ),
                    SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                        width: 150,
                        child: Text(
                          model.homeBloglList[index].Name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          textAlign: TextAlign.right,
                          maxLines: 3,
                        )),
                  ],
                ),
              ),
              // child: Stack(
              //   alignment: Alignment.center,
              //   children: [
              //     Container(
              //       height: 110,
              //       padding: const EdgeInsets.all(10),
              //       margin: const EdgeInsets.symmetric(horizontal: 10),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: Colors.white,
              //         border: Border.all(
              //             color: const Color(0xFF000000).withOpacity(0.12)),
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.grey.withOpacity(0.5),
              //             blurRadius: 1,
              //             offset:
              //                 const Offset(0, 3), // changes position of shadow
              //           ),
              //         ],
              //       ),
              //       child: Column(
              //         children: [
              //           SizedBox(
              //             height: 15,
              //           ),
              //           SizedBox(
              //               width: 150,
              //               child: Text(
              //                 model.homeBloglList[index].Name,
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     color: Colors.black),
              //                 textAlign: TextAlign.right,
              //                 maxLines: 3,
              //               )),
              //         ],
              //       ),
              //     ),
              //     Positioned(
              //         top: 10,
              //         child: model.homeBloglList[index].Image == ''
              //             ? Image.asset('assets/images/score.png')
              //             : Image.network(
              //                 model.homeBloglList[index].Image,
              //                 height: 40,
              //                 width: 50,
              //                 fit: BoxFit.fill,
              //               )),
              //   ],
              // ),
            ));
  }
}
