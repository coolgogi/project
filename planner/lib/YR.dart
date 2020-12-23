GridView.builder(
gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 2,
childAspectRatio: 8.0 / 9.0,
),

itemCount: querySnapshot.size,
itemBuilder: (context, index) => Product(querySnapshot.docs[index]),
);