import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipeapp/constants/constants.dart';
import 'package:recipeapp/constants/uidata.dart';
import 'package:recipeapp/controllers/user_controller.dart';
import 'package:recipeapp/models/custom_recipe.dart';
import 'package:recipeapp/themes/themes.dart';

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

  void _selectFoodCategory(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final Color textColor = getTextColor(context);
        final reverseColor =
            textColor == Colors.black ? Colors.white : Colors.black;

        return AlertDialog(
          title: Text('Select Category', style: TextStyle(color: reverseColor)),
          backgroundColor: textColor,
          content: SingleChildScrollView(
            child: Column(
              children: categories.map((category) {
                return ListTile(
                  title: Text(
                    category,
                    style: TextStyle(color: reverseColor),
                  ),
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

  Future<void> showPictureChooseOptions(BuildContext context) async {
    final Color textColor = getTextColor(context);
    final reverseColor =
        textColor == Colors.black ? Colors.white : Colors.black;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Select an option',
          style: TextStyle(fontSize: 20, color: reverseColor),
        ),
        backgroundColor: textColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                Get.back();
                getImageFromGallery();
              },
              child: Text('Photo Gallery',
                  style: TextStyle(fontSize: 14, color: reverseColor)),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                getImageFromCamera();
              },
              child: Text('Camera',
                  style: TextStyle(fontSize: 14, color: reverseColor)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color textColor = getTextColor(context);
    final reverseColor = theme.colorScheme.background == Colors.grey.shade400
        ? Colors.black
        : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Recipe',
          style: TextStyle(
              color: textColor, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: textColor,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: theme.colorScheme.background,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: theme.colorScheme.background,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title',
                style: TextStyle(color: textColor),
              ),
              TextFormField(
                controller: _titleController,
                style: TextStyle(color: textColor),
                keyboardType: TextInputType.text,
                maxLength: 50,
                cursorColor: reverseColor,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: reverseColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: reverseColor),
                  ),
                  hintText: 'Enter title',
                  hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Picture',
                style: TextStyle(color: textColor),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => showPictureChooseOptions(context),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey.withOpacity(0.3),
                  child: _image == null
                      ? Center(
                          child: Text(
                          'No Image selected',
                          style: TextStyle(color: textColor),
                        ))
                      : FittedBox(
                          fit: BoxFit.fill,
                          child: Image.file(
                            _image!,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Category',
                style: TextStyle(color: textColor),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectFoodCategory(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: reverseColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    selectedCategory,
                    style: TextStyle(color: textColor),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Cook Time (in minutes)',
                style: TextStyle(color: textColor),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _cookTimeController,
                style: TextStyle(color: textColor),
                keyboardType: TextInputType.number,
                maxLength: 5,
                cursorColor: reverseColor,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: reverseColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: reverseColor),
                  ),
                  hintText: 'Enter cook time',
                  hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Description',
                style: TextStyle(color: textColor),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                style: TextStyle(color: textColor),
                maxLines: 20,
                minLines: 1,
                maxLength: 20 * 50,
                keyboardType: TextInputType.multiline,
                cursorColor: reverseColor,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: reverseColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: reverseColor),
                  ),
                  hintText: 'Enter recipe description',
                  hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
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
                      colorText: textColor,
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
                    backgroundColor:
                        theme.colorScheme.background == Colors.grey.shade400
                            ? kGray2
                            : Colors.white),
                child: Text(
                  'Post',
                  style: TextStyle(
                      color: textColor == Colors.black
                          ? Colors.white
                          : Colors.black,
                      fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
