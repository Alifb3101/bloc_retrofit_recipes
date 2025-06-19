import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/recipes_bloc.dart';
import 'package:untitled/bloc/recipes_event.dart';
import 'package:untitled/bloc/recipes_state.dart';


class SingleRecipe extends StatefulWidget {
  final int id;
  const SingleRecipe({super.key, required this.id});

  @override
  State<SingleRecipe> createState() => _SingleRecipeState();
}

class _SingleRecipeState extends State<SingleRecipe> {
  
  @override
  Widget build(BuildContext context) {
    context.read<Recipesbloc>().add(getrecipes());
    return Scaffold(
      appBar: AppBar(
        title: Text("", style: TextStyle(fontWeight: FontWeight.w700 , color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child: BlocBuilder<Recipesbloc, recipestate>(
  builder: (context, state) {
    var item = state.recipe[widget.id];
    return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(item.image!,height: 800, width: double.infinity,alignment: Alignment.center,),
            ),
            SizedBox(height: 16),
            Text(
              item.name!,
              style:  TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.amber),
                SizedBox(width: 4),
                Text("${item.rating} (${item.reviewCount} reviews)"),
              ],
            ),
            SizedBox(height: 8),
            Text("Cuisine: ${item.cuisine} • Difficulty: ${item.difficulty}"),
            Text("Prep: ${item.prepTimeMinutes} mins | Cook: ${item.cookTimeMinutes} mins"),
            Text("Calories/Serving: ${item.caloriesPerServing} • Servings: ${item.servings}"),
            SizedBox(height: 20),

            _sectionTitle("Ingredients"),
            SizedBox(height: 8),
            Column(
              children: item.ingredients!
                  .map((ing) => _bulletItem(ing))
                  .toList(),
            ),

            SizedBox(height: 20),
            _sectionTitle("Instructions"),
            SizedBox(height: 8),
            Column(
              children: List.generate(
                item.instructions!.length,
                    (index) => _numberedItem(index + 1, item.instructions![index]),
              ),
            ),

            SizedBox(height: 20),
            _sectionTitle("Tags"),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: List.generate(
                item.tags!.length,
                    (index) => Chip(label: Text(item.tags![index])),
              ),
            ),

            SizedBox(height: 20),
            _sectionTitle("Meal Type"),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: List.generate(
                item.mealType!.length,
                    (index) => Chip(
                  label: Text(item.mealType![index]),
                  backgroundColor: Colors.blue.shade100,
                ),
              ),
            ),
          ],
        );
  },
),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style:  TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    );
  }

  Widget _bulletItem(String text) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(" • ", style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text, style:  TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _numberedItem(int number, String text) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$number. ", style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Expanded(child: Text(text, style:  TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}