// password_baru_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/password_baru_controller.dart';

class PasswordBaruView
    extends GetView<
        PasswordBaruController> {

  const PasswordBaruView({
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
                  "assets/images/password_baru.png",
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
                        "Password Baru",

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
                        "Buat password baru untuk melanjutkan login.",

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
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            // PASSWORD BARU
                            buildTitle(
                              "Password Baru",
                              size,
                            ),

                            const SizedBox(
                              height: 12,
                            ),

                            Obx(
                              () => TextField(
                                controller:
                                    controller
                                        .passwordBaruController,

                                obscureText:
                                    controller
                                        .isPasswordHidden
                                        .value,

                                decoration:
                                    inputDecoration(
                                  hint:
                                      "Masukkan password baru",

                                  icon:
                                      Icons.lock_outline,

                                  suffix:
                                      IconButton(
                                    onPressed:
                                        controller
                                            .togglePassword,

                                    icon:
                                        Icon(
                                      controller
                                              .isPasswordHidden
                                              .value
                                          ? Icons
                                              .visibility_off_outlined
                                          : Icons
                                              .visibility_outlined,

                                      color:
                                          Colors
                                              .brown,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 25,
                            ),

                            // KONFIRMASI PASSWORD
                            buildTitle(
                              "Konfirmasi Password",
                              size,
                            ),

                            const SizedBox(
                              height: 12,
                            ),

                            Obx(
                              () => TextField(
                                controller:
                                    controller
                                        .konfirmasiPasswordController,

                                obscureText:
                                    controller
                                        .isKonfirmasiPasswordHidden
                                        .value,

                                decoration:
                                    inputDecoration(
                                  hint:
                                      "Konfirmasi password baru",

                                  icon:
                                      Icons.lock_outline,

                                  suffix:
                                      IconButton(
                                    onPressed:
                                        controller
                                            .toggleKonfirmasiPassword,

                                    icon:
                                        Icon(
                                      controller
                                              .isKonfirmasiPasswordHidden
                                              .value
                                          ? Icons
                                              .visibility_off_outlined
                                          : Icons
                                              .visibility_outlined,

                                      color:
                                          Colors
                                              .brown,
                                    ),
                                  ),
                                ),
                              ),
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
                                              .simpanPasswordBaru,

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
                                              "Simpan Password",

                                              style:
                                                  TextStyle(
                                                fontSize:
                                                    size.width *
                                                        0.045,

                                                fontWeight:
                                                    FontWeight.bold,

                                                color:
                                                    Colors.white,
                                              ),
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

  Widget buildTitle(
    String title,
    Size size,
  ) {

    return Text(
      title,

      style: TextStyle(
        fontSize:
            size.width * 0.043,

        fontWeight:
            FontWeight.w600,
      ),
    );
  }

  InputDecoration inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {

    return InputDecoration(
      hintText: hint,

      prefixIcon: Icon(
        icon,
        color: Colors.brown,
      ),

      suffixIcon: suffix,

      filled: true,

      fillColor: Colors.white,

      contentPadding:
          const EdgeInsets.symmetric(
        vertical: 18,
      ),

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          18,
        ),

        borderSide:
            BorderSide.none,
      ),
    );
  }
}