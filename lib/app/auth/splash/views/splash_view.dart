// splash_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView
    extends GetView<SplashController> {

  const SplashView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final size =
        MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: Stack(
        children: [

          // BACKGROUND
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/splash.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // OVERLAY
          Container(
            color: Colors.white
                .withOpacity(0.15),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics:
                  const BouncingScrollPhysics(),

              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      size.height,
                ),

                child: Padding(
                  padding:
                      EdgeInsets.symmetric(
                    horizontal:
                        size.width * 0.08,

                    vertical: 24,
                  ),

                  child: Column(
                    children: [

                      SizedBox(
                        height:
                            size.height *
                                0.08,
                      ),

                      // LOGO
                      Container(
                        width:
                            size.width *
                                0.24,

                        height:
                            size.width *
                                0.24,

                        decoration:
                            BoxDecoration(
                          color: Colors
                              .white
                              .withOpacity(
                            0.85,
                          ),

                          shape:
                              BoxShape
                                  .circle,
                        ),

                        child: Icon(
                          Icons
                              .grid_view_rounded,

                          size:
                              size.width *
                                  0.12,

                          color:
                              const Color(
                            0xFF7B4B2A,
                          ),
                        ),
                      ),

                      SizedBox(
                        height:
                            size.height *
                                0.04,
                      ),

                      // TITLE
                      Text(
                        "Anyaman",

                        style:
                            TextStyle(
                          fontSize:
                              size.width *
                                  0.12,

                          fontWeight:
                              FontWeight
                                  .bold,

                          color:
                              const Color(
                            0xFF5A3116,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      // SUBTITLE
                      Text(
                        "Belajar. Lestarikan. Berdaya.",

                        textAlign:
                            TextAlign
                                .center,

                        style:
                            TextStyle(
                          fontSize:
                              size.width *
                                  0.045,

                          color:
                              const Color(
                            0xFF6D4C41,
                          ),

                          height: 1.6,
                        ),
                      ),

                      SizedBox(
                        height:
                            size.height *
                                0.04,
                      ),

                      Container(
                        width:
                            size.width *
                                0.3,

                        height: 2,

                        color:
                            Colors.brown,
                      ),

                      SizedBox(
                        height:
                            size.height *
                                0.04,
                      ),

                      // DESCRIPTION
                      Text(
                        "Belajar anyaman bambu bersama pengrajin lokal dan dukung produk anyaman asli Indonesia.",

                        textAlign:
                            TextAlign
                                .center,

                        style:
                            TextStyle(
                          fontSize:
                              size.width *
                                  0.045,

                          height: 1.8,

                          color:
                              const Color(
                            0xFF5D4037,
                          ),
                        ),
                      ),

                      SizedBox(
                        height:
                            size.height *
                                0.08,
                      ),

                      // BUTTON MASUK
                      SizedBox(
                        width:
                            double.infinity,

                        height: 58,

                        child:
                            ElevatedButton(
                          onPressed:
                              controller
                                  .goToMasuk,

                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(
                              0xFF7B4B2A,
                            ),

                            elevation:
                                0,

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                20,
                              ),
                            ),
                          ),

                          child: Text(
                            "Masuk",

                            style:
                                TextStyle(
                              fontSize:
                                  size.width *
                                      0.05,

                              fontWeight:
                                  FontWeight
                                      .bold,

                              color:
                                  Colors
                                      .white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // BUTTON DAFTAR
                      SizedBox(
                        width:
                            double.infinity,

                        height: 58,

                        child:
                            OutlinedButton(
                          onPressed:
                              controller
                                  .goToDaftar,

                          style:
                              OutlinedButton.styleFrom(
                            side:
                                const BorderSide(
                              color: Color(
                                0xFF7B4B2A,
                              ),

                              width: 2,
                            ),

                            backgroundColor:
                                Colors
                                    .white
                                    .withOpacity(
                              0.2,
                            ),

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                20,
                              ),
                            ),
                          ),

                          child: Text(
                            "Daftar",

                            style:
                                TextStyle(
                              fontSize:
                                  size.width *
                                      0.05,

                              fontWeight:
                                  FontWeight
                                      .bold,

                              color:
                                  const Color(
                                0xFF5A3116,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height:
                            size.height *
                                0.06,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}