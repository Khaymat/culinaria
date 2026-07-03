import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injection_container.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/category_bloc.dart';
import 'login_page.dart';
import 'meals_page.dart';
import 'search_page.dart';
import 'favorites_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CategoryBloc>()..add(FetchCategories()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Culinaria'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SearchPage())),
            ),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => FavoritesPage())),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is Authenticated) {
                    return DrawerHeader(
                      decoration: BoxDecoration(color: Colors.orange),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.account_circle, size: 64, color: Colors.white),
                          Text(state.user.name, style: TextStyle(color: Colors.white, fontSize: 20)),
                          Text(state.user.email, style: TextStyle(color: Colors.white70, fontSize: 14)),
                        ],
                      ),
                    );
                  }
                  return DrawerHeader(
                    decoration: BoxDecoration(color: Colors.orange),
                    child: Text('Culinaria', style: TextStyle(color: Colors.white, fontSize: 24)),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Favorit'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => FavoritesPage()));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Keluar'),
                onTap: () {
                  context.read<AuthBloc>().add(LogoutEvent());
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CategoryError) {
              return Center(child: Text(state.message));
            } else if (state is CategoryLoaded) {
              return GridView.builder(
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  MealsPage(category: category.strCategory)));
                    },
                    child: Card(
                      elevation: 2,
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              category.strCategoryThumb,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(category.strCategory,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
