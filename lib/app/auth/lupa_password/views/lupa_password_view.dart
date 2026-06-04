// lupa_password_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/lupa_password_controller.dart';

class LupaPasswordView
    extends GetView<LupaPasswordController> {

  const LupaPasswordView({
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

          // Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/lupa_password.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay
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
                                0.03,
                      ),

                      // Back
                      Align(
                        alignment:
                            Alignment
                                .centerLeft,
                        child: IconButton(
                          onPressed:
                              controller
                                  .kembali,
                          icon:
                              const Icon(
                            Icons
                                .arrow_back_ios_new,
                            color: Color(
                              0xFF5A3116,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height:
                            size.height *
                                0.02,
                      ),

                      // Logo
                      Container(
                        width:
                            size.width *
                                0.22,
                        height:
                            size.width *
                                0.22,
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
                              .lock_reset_outlined,
                          size:
                              size.width *
                                  0.11,
                          color:
                              const Color(
                            0xFF8B5E3C,
                          ),
                        ),
                      ),

                      SizedBox(
                        height:
                            size.height *
                                0.03,
                      ),

                      // Title
                      Text(
                        "Lupa Kata Sandi",
                        textAlign:
                            TextAlign
                                .center,
                        style:
                            TextStyle(
                          fontSize:
                              size.width *
                                  0.085,
                          fontWeight:
                              FontWeight
                                  .bold,
                          color:
                              const Color(
                            0xFF3E2723,
                          ),
                        ),
                      ),

                      const SizedBox(
                          height: 14),

                      Text(
                        "Masukkan email Anda untuk menerima kode OTP reset password.",
                        textAlign:
                            TextAlign
                                .center,
                        style:
                            TextStyle(
                          fontSize:
                              size.width *
                                  0.042,
                          color:
                              Colors
                                  .brown,
                          height: 1.6,
                        ),
                      ),

                      SizedBox(
                        height:
                            size.height *
                                0.06,
                      ),

                      // Card
                      Container(
                        width:
                            double.infinity,
                        padding:
                            EdgeInsets.all(
                          size.width *
                              0.06,
                        ),
                        decoration:
                            BoxDecoration(
                          color: Colors
                              .white
                              .withOpacity(
                            0.90,
                          ),
                          borderRadius:
                              BorderRadius
                                  .circular(
                            30,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [

                            Text(
                              "Email",
                              style:
                                  TextStyle(
                                fontSize:
                                    size.width *
                                        0.043,
                                fontWeight:
                                    FontWeight
                                        .w600,
                              ),
                            ),

                            const SizedBox(
                                height: 12),

                            TextField(
                              controller:
                                  controller
                                      .emailController,
                              keyboardType:
                                  TextInputType
                                      .emailAddress,
                              decoration:
                                  InputDecoration(
                                hintText:
                                    "Masukkan email",
                                prefixIcon:
                                    const Icon(
                                  Icons
                                      .email_outlined,
                                  color: Colors
                                      .brown,
                                ),
                                filled: true,
                                fillColor:
                                    Colors.white,
                                contentPadding:
                                    const EdgeInsets.symmetric(
                                  vertical:
                                      18,
                                ),
                                border:
                                    OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                    18,
                                  ),
                                  borderSide:
                                      BorderSide
                                          .none,
                                ),
                              ),
                            ),

                            SizedBox(
                              height:
                                  size.height *
                                      0.05,
                            ),

                            SizedBox(
                              width:
                                  double.infinity,
                              height: 58,
                              child:
                                  ElevatedButton(
                                onPressed:
                                    controller
                                        .kirimOtp,
                                style:
                                    ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(
                                    0xFF8B5E3C,
                                  ),
                                  elevation:
                                      0,
                                  shape:
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(
                                      18,
                                    ),
                                  ),
                                ),
                                child:
                                    Text(
                                  "Kirim OTP",
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

                          ],
                        ),
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