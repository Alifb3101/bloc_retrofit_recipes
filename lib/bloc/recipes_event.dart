import 'package:equatable/equatable.dart';

abstract class Recipeevent{

  Recipeevent();

}
class getrecipes extends Recipeevent{
}
class searchrecipes extends Recipeevent{
  String query;
  searchrecipes({
    required this.query,
});
}


