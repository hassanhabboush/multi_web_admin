import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoriesStream =
        FirebaseFirestore.instance.collection('categories').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _categoriesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Colors.cyan),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.size,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 8,
              crossAxisCount: 6,  crossAxisSpacing: 8),
          itemBuilder: (context, index) {
            final categoryData = snapshot.data!.docs[index];
            return ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(
                        categoryData['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(categoryData['categoryName'],),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
