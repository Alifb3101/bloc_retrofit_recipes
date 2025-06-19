import 'package:bloc/bloc.dart';
import 'package:untitled/bloc/recipes_event.dart';
import 'package:untitled/bloc/recipes_state.dart';
import 'package:untitled/database/api/api.dart';
import 'package:untitled/model/all_recipes_fetch.dart';

class Recipesbloc extends Bloc<Recipeevent , recipestate>{
  Recipesbloc() : super(recipestate()){
    on<getrecipes>(fetrecipes);
    on<searchrecipes>(fetchsearch);

  }
  void fetrecipes(getrecipes event , Emitter<recipestate>emit)async{
    final data = await API().getrecipesList();
    RecipeModel modellist = RecipeModel.fromJson(data);
    recipestate newstate = recipestate();
    newstate.recipe = modellist.recipes!;
    emit(newstate);
  }

  void fetchsearch(searchrecipes event , Emitter<recipestate>emit)async{
    final data = await API().getsearchitem(event.query);
    RecipeModel modellist = RecipeModel.fromJson(data);
    recipestate newstate = recipestate();
    newstate.recipe = modellist.recipes!;
    emit(newstate);
  }


}