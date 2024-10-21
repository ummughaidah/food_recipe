import 'package:flutter/material.dart';
import 'package:food_recipe/model/recipes_model.dart';

class DetailRecipe extends StatelessWidget {
  // model recipe
  final RecipesModel recipesModel;

  const DetailRecipe({super.key, required this.recipesModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          recipesModel.name!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // food image
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                recipesModel.image!,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ingredients',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // ingredients
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: recipesModel.ingredients!.map((ingredients) {
                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.green.shade100),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            ingredients,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54),
                          ),
                        ),
                      ),
                    );
                  }).toList()),
            ),
            const SizedBox(height: 16),
            const Text(
              'Preparation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // preparation
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: recipesModel.instructions!.map((instructions) {
                    return Row(
                      children: [
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.green.shade100,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            instructions,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    );
                  }).toList()),
            )
          ],
        ),
      ),
    );
  }
}
