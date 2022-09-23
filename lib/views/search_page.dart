import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/blocs/search_bloc/search_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          onChanged: (value){
            context.read<SearchBloc>().add(OnChanged(value));
          },
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state){
            if(state is SearchLoaded){
              return ListView.separated(
                  itemBuilder: (context, index){
                    return Text(state.todos[index].title);
                  },
                  itemCount: state.todos.length,
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
