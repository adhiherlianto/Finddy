import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:finddy/domain/entities/location/location_model.dart';
import 'package:finddy/gen/assets.gen.dart';
import 'package:finddy/presentation/screen/complete_profile/ParamScreenTwo.dart';
import 'package:finddy/presentation/screen/complete_profile/widget/step_indicator.dart';
import 'package:finddy/presentation/screen/widget/finddy_button.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/screen/widget/finddy_textfield.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'cubit/complete_profile_cubit.dart';

class CompleteProfileStepOneScreen extends StatefulWidget {
  const CompleteProfileStepOneScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileStepOneScreen> createState() =>
      _CompleteProfileStepOneScreenState();
}

class _CompleteProfileStepOneScreenState
    extends State<CompleteProfileStepOneScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  List<String> _province = [];
  List<LocationModel> _listLocation = [];
  File? selectedImage;
  String? _valProvince;
  String? _valCity;
  String? _locationId;
  @override
  void initState() {
    context.read<CompleteProfileCubit>().getAllProvince();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteProfileCubit, CompleteProfileState>(
      listener: (context, state) {
        if (state is GetProvinceSuccess) {
          _province = state.province;
        } else if (state is GetLocationSuccess && _valProvince != null) {
          _listLocation = state.location;
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Column(
                  children: [
                    const StepIndicator(currentStep: 1),
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 44, 24, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FDText.headersH3(
                              text: "Lengkapi data kamu",
                              color: AppColors.neutralBlack60),
                          const SizedBox(height: 12),
                          const FDText.bodyP3(
                              text: "Isi identitas lengkapmu dulu ya!",
                              color: AppColors.neutralBlack60),
                          const SizedBox(height: 40),
                          InkWell(
                              onTap: () {
                                pickPhoto();
                              },
                              child: Center(
                                child: selectedImage != null
                                    ? ClipOval(
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(48),
                                          child: Image.file(
                                            selectedImage!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Image.asset(Assets.images.profile.path,
                                        width: 100, height: 100),
                              )),
                          const SizedBox(height: 33),
                          const FDText.headersH6(
                            text: "Username",
                            color: AppColors.neutralBlack60,
                          ),
                          const SizedBox(height: 12),
                          FDTextField.normal(
                            hintText: "Masukan username kamu",
                            textEditingController: _usernameController,
                            onChanged: (data) {},
                          ),
                          const SizedBox(height: 24),
                          const FDText.headersH6(
                            text: "Asal perguruan tinggi",
                            color: AppColors.neutralBlack60,
                          ),
                          const SizedBox(height: 12),
                          FDTextField.normal(
                            hintText: "Pilih perguruan tinggi",
                            textEditingController: _universityController,
                            onChanged: (data) {},
                          ),
                          const SizedBox(height: 24),
                          const FDText.headersH6(
                            text: "Provinsi",
                            color: AppColors.neutralBlack60,
                          ),
                          const SizedBox(height: 12),
                          DropdownSearch<String>(
                            popupProps: const PopupProps.bottomSheet(
                                showSearchBox: true,
                                constraints: BoxConstraints.expand()),
                            items: _province,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                hintText: "Pilih Provinsi",
                              ),
                            ),
                            onChanged: (value) {
                              _valProvince = value;
                              context
                                  .read<CompleteProfileCubit>()
                                  .getLocation(_valProvince!);
                            },
                          ),
                          const SizedBox(height: 24),
                          const FDText.headersH6(
                            text: "Kabupaten/Kota",
                            color: AppColors.neutralBlack60,
                          ),
                          const SizedBox(height: 12),
                          DropdownSearch<LocationModel>(
                            popupProps: const PopupProps.bottomSheet(
                                showSearchBox: true,
                                constraints: BoxConstraints.expand()),
                            items: _listLocation,
                            itemAsString: (item) => item.name.toString(),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                hintText: "Pilih Kabupaten/Kota",
                              ),
                            ),
                            onChanged: (value) {
                              if (value != null) {
                                _valCity = value.name;
                                _locationId = value.id;
                              }
                            },
                          ),
                          const SizedBox(height: 24),
                          const FDText.headersH6(
                            text: "Kontak (No. Whatsapp)",
                            color: AppColors.neutralBlack60,
                          ),
                          const SizedBox(height: 12),
                          FDTextField.normal(
                            isNumber: true,
                            hintText: "Masukan Kontakmu",
                            textEditingController: _phoneController,
                            onChanged: (data) {},
                          ),
                          const SizedBox(height: 40),
                          FDButton.primary(
                              onPressed: () {
                                ParamScreenTwo params = ParamScreenTwo(
                                    location: {
                                      "locationId": _locationId!,
                                      "province": _valProvince!,
                                      "city": _valCity!,
                                    },
                                    phone: _phoneController.text,
                                    photo: selectedImage != null
                                        ? selectedImage!.path.toString()
                                        : "kosong",
                                    university: _universityController.text,
                                    username: _usernameController.text);
                                context.pushNamed(
                                  "complete-profile-step-2",
                                  extra: params,
                                );
                              },
                              text: "Lanjutkan"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Future _bottomSheetLocation(List list, String type) async {
  //   await showModalBottomSheet(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(20.0),
  //     ),
  //     context: context,
  //     builder: (BuildContext context) => Container(
  //         padding: const EdgeInsets.all(10),
  //         height: 500,
  //         child: ListView.builder(
  //           itemBuilder: (context, index) {
  //             int? selectedValue;
  //             return StatefulBuilder(
  //               builder: (context, setState) {
  //                 return Column(
  //                   children: [
  //                     ListTile(
  //                       title: Text(type == "province"
  //                           ? list[index].toString()
  //                           : list[index].name.toString()),
  //                       trailing: Radio<int>(
  //                         value: index,
  //                         groupValue: selectedValue,
  //                         onChanged: (int? value) {
  //                           setState(() {
  //                             selectedValue = value;
  //                             if (type == "province") {
  //                               _valCity = null;
  //                               _locationId = null;
  //                               _valProvince = list[index].toString();
  //                               context
  //                                   .read<CompleteProfileCubit>()
  //                                   .getLocation(_valProvince!);
  //                             } else {
  //                               _valCity = list[index].name.toString();
  //                               _locationId = list[index].id.toString();
  //                             }
  //                           });
  //                           Future.delayed(const Duration(milliseconds: 200),
  //                               () {
  //                             context.pop();
  //                           });
  //                         },
  //                       ),
  //                     ),
  //                     const Divider()
  //                   ],
  //                 );
  //               },
  //             );
  //           },
  //           itemCount: list.length,
  //         )),
  //   );
  // }

  // Widget _dropDown(List items, String? value, String type) {
  //   return DropdownButtonFormField(
  //       decoration: InputDecoration(
  //           border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(4),
  //           ),
  //           contentPadding:
  //               const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //           filled: true,
  //           fillColor: AppColors.neutralwhite),
  //       focusColor: Colors.transparent,
  //       hint: FDText.bodyP4(
  //           text: type == 'kemampuan' ? "Pilih Kemampuan" : "Pilih Lokasi",
  //           color: AppColors.neutralBlack20),
  //       items: items
  //           .map((e) =>
  //               DropdownMenuItem(value: e, child: FDText.bodyP4(text: e)))
  //           .toList(),
  //       value: value,
  //       onChanged: (value) {
  //         setState(() {
  //           _valProvince = value as String;
  //         });
  //       });
  // }

  Future pickFile(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      File? imageTemp = File(image.path);
      imageTemp = await cropImage(imageTemp);
      setState(() {
        selectedImage = imageTemp;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future pickPhoto() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheet(
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(FeatherIcons.camera),
              title: const Text("Camera"),
              onTap: () {
                pickFile(ImageSource.camera);
                context.pop();
              },
            ),
            ListTile(
              leading: const Icon(FeatherIcons.image),
              title: const Text("Pick from Galery"),
              onTap: () {
                pickFile(ImageSource.gallery);
                context.pop();
              },
            ),
          ],
        ),
        onClosing: () {},
      ),
    );
  }

  Future<File?> cropImage(File imageFile) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }
}
