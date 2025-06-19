import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/recipes_bloc.dart';
import 'package:untitled/bloc/recipes_state.dart';
import '../bloc/recipes_event.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    context.read<Recipesbloc>().add(getrecipes());
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: BlocBuilder<Recipesbloc, recipestate>(
            builder: (context, state) {
              return ListView.builder(
                itemCount: state.recipe.length,
                itemBuilder: (context, index) {
                  final item = state.recipe[index];
return ListTile(
  title: Text("${item.name}"),
  leading: CircleAvatar(backgroundImage: NetworkImage("${item.image}"),),
  subtitle: Text("${item.cuisine}"),
);
                },);
            },
          ))
        ],
      ),
    );
  }
}
