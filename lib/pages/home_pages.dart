import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/recipes_bloc.dart';
import 'package:untitled/bloc/recipes_state.dart';
import 'package:untitled/pages/single_recipes.dart';
import '../bloc/recipes_event.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    context.read<Recipesbloc>().add(getrecipes());

    return Scaffold(
      body: BlocBuilder<Recipesbloc, recipestate>(
        builder: (context, state) {
          return Padding(
            padding:  EdgeInsets.symmetric(vertical: 80 , horizontal: 20),
            child: Column(
              children: [
                Container(child: TextField(
                  controller: _text,
                  onChanged: (value) => context.read<Recipesbloc>().add(searchrecipes(query: value)),
                  decoration: InputDecoration(
                    hintText: "Search your favorite recipe...",
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                    suffixIcon: _text.text.isNotEmpty
                        ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _text.clear();
                        context.read<Recipesbloc>().add(getrecipes());
                      },
                    )
                        : null,
                  ),
                ),),
                SizedBox(height: 30,),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.recipe.length,
                    itemBuilder: (context, index) {
                      final item = state.recipe[index];
                      return InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SingleRecipe(id: index))),
                        child: ListTile(
                          title: Text("${item.name}"),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage("${item.image}"),
                          ),
                          subtitle: Text("${item.cuisine}"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
