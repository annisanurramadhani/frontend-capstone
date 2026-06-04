// otp_lupa_password_view.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/otp_lupa_password_controller.dart';

class OtpLupaPasswordView
    extends GetView<
        OtpLupaPasswordController> {

  const OtpLupaPasswordView({
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
                  "assets/images/otp.png",
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
                                0.02,
                      ),

                      // BACK
                      Align(
                        alignment:
                            Alignment
                                .centerLeft,

                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },

                          icon: const Icon(
                            Icons
                                .arrow_back_ios_new,

                            color:
                                Color(
                              0xFF5A3116,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height:
                            size.height *
                                0.05,
                      ),

                      // ICON
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
                            0.9,
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
                                  0.12,

                          color:
                              const Color(
                            0xFF8B5E3C,
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
                        "OTP Lupa Password",

                        textAlign:
                            TextAlign.center,

                        style:
                            TextStyle(
                          fontSize:
                              size.width *
                                  0.08,

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
                        height: 12,
                      ),

                      Text(
                        "Masukkan kode OTP untuk melanjutkan reset password.",

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

                          height: 1.7,
                        ),
                      ),

                      SizedBox(
                        height:
                            size.height *
                                0.07,
                      ),

                      // CARD
                      Container(
                        width:
                            double.infinity,

                        padding:
                            EdgeInsets.all(
                          size.width *
                              0.07,
                        ),

                        decoration:
                            BoxDecoration(
                          color: Colors
                              .white
                              .withOpacity(
                            0.9,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            30,
                          ),
                        ),

                        child: Column(
                          children: [

                            // OTP
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,

                              children: [

                                otpField(
                                  controller:
                                      controller
                                          .otp1Controller,
                                ),

                                otpField(
                                  controller:
                                      controller
                                          .otp2Controller,
                                ),

                                otpField(
                                  controller:
                                      controller
                                          .otp3Controller,
                                ),

                                otpField(
                                  controller:
                                      controller
                                          .otp4Controller,
                                ),

                              ],
                            ),

                            SizedBox(
                              height:
                                  size.height *
                                      0.05,
                            ),

                            // BUTTON
                            SizedBox(
                              width:
                                  double.infinity,

                              height: 58,

                              child: Obx(
                                () => ElevatedButton(
                                  onPressed:
                                      controller
                                              .isLoading
                                              .value
                                          ? null
                                          : controller
                                              .verifikasiOtp,

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
                                      controller
                                              .isLoading
                                              .value
                                          ? const CircularProgressIndicator(
                                              color:
                                                  Colors.white,
                                            )
                                          : Text(
                                              "Verifikasi",

                                              style:
                                                  TextStyle(
                                                fontSize:
                                                    size.width *
                                                        0.05,

                                                fontWeight:
                                                    FontWeight.bold,

                                                color:
                                                    Colors.white,
                                              ),
                                            ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height:
                                  size.height *
                                      0.04,
                            ),

                            // RESEND
                            GestureDetector(
                              onTap:
                                  controller
                                      .kirimUlangOtp,

                              child: Text(
                                "Kirim ulang kode OTP",

                                style:
                                    TextStyle(
                                  fontSize:
                                      size.width *
                                          0.04,

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

  Widget otpField({
    required TextEditingController
        controller,
  }) {

    return SizedBox(
      width: 60,

      child: TextField(
        controller: controller,

        textAlign:
            TextAlign.center,

        keyboardType:
            TextInputType.number,

        inputFormatters: [
          LengthLimitingTextInputFormatter(
            1,
          ),
        ],

        style: const TextStyle(
          fontSize: 24,
          fontWeight:
              FontWeight.bold,
        ),

        decoration: InputDecoration(
          filled: true,

          fillColor:
              Colors.white,

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(
              18,
            ),

            borderSide:
                BorderSide.none,
          ),
        ),
      ),
    );
  }
}