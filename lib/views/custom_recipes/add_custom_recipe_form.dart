import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/constants/uidata.dart';
import 'package:recipeapp/controllers/user_controller.dart';
import 'package:recipeapp/models/custom_recipe.dart';

class AddCustomRecipeForm extends StatefulWidget {
  const AddCustomRecipeForm({Key? key}) : super(key: key);

  @override
  State<AddCustomRecipeForm> createState() => _AddCustomRecipeFormState();
}

class _AddCustomRecipeFormState extends State<AddCustomRecipeForm> {
  String selectedCategory = 'Not Selected';

  List<String> categories = dishCategories;

  late TextEditingController _titleController;
  late TextEditingController _cookTimeController;
  late TextEditingController _descriptionController;

  UserController userController = Get.find();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _cookTimeController = TextEditingController();
    _descriptionController = TextEditingController();
    addData();
  }

  addData() async {
    await userController.refreshUser();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _cookTimeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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
        title: const Text(
          'Select an option',
          style: TextStyle(fontSize: 20, color: kDark),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                Get.back();
                getImageFromGallery();
              },
              child:
                  const Text('Photo Gallery', style: TextStyle(fontSize: 14)),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                getImageFromCamera();
              },
              child: const Text('Camera', style: TextStyle(fontSize: 14)),
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
                controller: _titleController,
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
                controller: _cookTimeController,
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
                controller: _descriptionController,
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
                  // Отримання даних форми
                  String title = _titleController.text;
                  String imageUrl = _image != null
                      ? _image!.path
                      : ''; // Передаємо шлях до зображення
                  String category = selectedCategory;
                  String cookTime = _cookTimeController.text;
                  if (cookTime.isEmpty) {
                    cookTime = "Not Specified";
                  } else {
                    cookTime += " min";
                  }
                  String description = _descriptionController.text;
                  if (description.isEmpty) {
                    description = "There is no description for this recipe";
                  }
                  String postedBy = userController.getUser?.username ?? '';

                  // Перевірка чи поля "Title" та "Image" заповнені
                  if (title.isEmpty || imageUrl.isEmpty) {
                    // Повідомлення про помилку, якщо поля не заповнені
                    Get.snackbar(
                      'Error',
                      'Please fill in the Title and select an Image.',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  // Створення об'єкта Recipe
                  CustomRecipe recipe = CustomRecipe(
                      title: title,
                      imageUrl: imageUrl,
                      category: category,
                      cookTime: cookTime,
                      description: description,
                      postedBy: postedBy);

                  // Відправлення даних назад до попередньої сторінки
                  Get.back(result: recipe);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kWhite,
                ),
                child: const Text(
                  'Post',
                  style: TextStyle(color: kDark, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
