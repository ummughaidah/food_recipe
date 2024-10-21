import 'package:flutter/material.dart';
import 'package:food_recipe/detail_recipe.dart';
import 'package:food_recipe/model/recipes_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  // inisialisasi list data recipe model
  List<RecipesModel> displayRecipes = recipesModelList;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Find best recipes for cooking',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green.shade100),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white),
              child: TextFormField(
                controller: searchController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search recipes...',
                    prefixIcon: Icon(Icons.search_rounded)),
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      displayRecipes = recipesModelList;
                    } else {
                      displayRecipes = recipesModelList.where((element) {
                        return element.name!
                            .toLowerCase()
                            .contains(value.toLowerCase());
                      }).toList();
                    }
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Popular category',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 8),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayRecipes.length,
                itemBuilder: (context, index) {
                  // inisialisasi data
                  final RecipesModel recipesModel = displayRecipes[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailRecipe(recipesModel: recipesModel);
                      }));
                    },
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.green.shade100)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                recipesModel.image!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // nama recipe
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Text(
                                          recipesModel.name!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      // lama waktu masak
                                      Text(
                                        '${recipesModel.cookTimeMinutes.toString()} min',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black54),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  // ingredients
                                  Text(
                                    recipesModel.ingredients!.join(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
