import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/constants/uidata.dart';

class AddRecipeForm extends StatefulWidget {
  const AddRecipeForm({Key? key}) : super(key: key);

  @override
  State<AddRecipeForm> createState() => _AddRecipeFormState();
}

class _AddRecipeFormState extends State<AddRecipeForm> {
  String selectedCategory = 'Select Category';

  List<String> categories = dishCategories;

  void _selectCategory(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Category'),
          content: SingleChildScrollView(
            child: Column(
              children: categories.map((category) {
                return ListTile(
                  title: Text(category),
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                    Get.back();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  File? _image;
  final picker = ImagePicker();

//Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

//Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> showOptions(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select an option'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                Get.back();
                getImageFromGallery();
              },
              child: const Text('Photo Gallery'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                getImageFromCamera();
              },
              child: const Text('Camera'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Recipe',
          style: TextStyle(
              color: kWhite, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kWhite,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: kPrimary,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: kPrimary,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Title',
                style: TextStyle(color: kWhite),
              ),
              TextFormField(
                style: const TextStyle(color: kWhite),
                keyboardType: TextInputType.text,
                maxLength: 50,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter title',
                  hintStyle: TextStyle(color: kWhite.withOpacity(0.5)),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Picture',
                style: TextStyle(color: kWhite),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => showOptions(context),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey.withOpacity(0.3),
                  child: _image == null
                      ? const Center(child: Text('No Image selected'))
                      : FittedBox(
                          fit: BoxFit.fill,
                          child: Image.file(
                            _image!,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Category',
                style: TextStyle(color: kWhite),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectCategory(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    selectedCategory,
                    style: const TextStyle(color: kWhite),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Cook Time (in minutes)',
                style: TextStyle(color: kWhite),
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(color: kWhite),
                keyboardType: TextInputType.number,
                maxLength: 5,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter cook time',
                  hintStyle: TextStyle(color: kWhite.withOpacity(0.5)),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Description',
                style: TextStyle(color: kWhite),
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(color: kWhite),
                maxLines: 20,
                minLines: 1,
                maxLength: 20 * 50,
                keyboardType: TextInputType.multiline,
                cursorColor: kWhite,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter recipe description',
                  hintStyle: TextStyle(color: kWhite.withOpacity(0.5)),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Додати обробник для публікації рецепту
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kWhite,
                ),
                child: const Text('Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
