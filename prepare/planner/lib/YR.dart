GridView.builder(
gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 2,
childAspectRatio: 8.0 / 9.0,
),

itemCount: querySnapshot.size,
itemBuilder: (context, index) => Product(querySnapshot.docs[index]),
<<<<<<< HEAD
);
=======
);

class HelloConvexAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hello ConvexAppBar')),
      body: Center(
          child: FlatButton(
            child: Text('Click to show usage'),
            onPressed: () => Navigator.of(context).pushNamed('/'),
          )),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        items: [
          TabItem(icon: Icons.list),
          TabItem(icon: Icons.calendar_today),
          TabItem(icon: Icons.assessment),
        ],
        initialActiveIndex: 1 /*optional*/,
        onTap: (int i) => print('click index=$i'),
      ),
    );
  }
}
>>>>>>> YR
