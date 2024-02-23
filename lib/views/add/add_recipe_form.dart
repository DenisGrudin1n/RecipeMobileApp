import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipeapp/constants/constants.dart';

class AddRecipeForm extends StatelessWidget {
  const AddRecipeForm({Key? key}) : super(key: key);

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
                'Picture',
                style: TextStyle(color: kWhite),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Додати обробник для додавання фото
                },
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey.withOpacity(0.3),
                  child: const Center(
                    child: Text(
                      'Add Photo',
                      style: TextStyle(color: kWhite),
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
                onTap: () {
                  // Додати обробник для відкриття вікна з категоріями
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    'Select Category',
                    style: TextStyle(color: kWhite),
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
                maxLines: null,
                keyboardType: TextInputType.multiline,
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
                  primary: kWhite,
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
