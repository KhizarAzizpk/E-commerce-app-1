import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khaksarfirstapp/provider/product.dart';
class productdetailscreen extends StatefulWidget {
//String title;
static const routname='/productdetail';

  @override
  State<productdetailscreen> createState() => _productdetailscreenState();
}

class _productdetailscreenState extends State<productdetailscreen> {
//  productdetailscreen(this.title);
  List<String> commentsList = [];
  List<String> emailsList = [];
  TextEditingController textEditingController=TextEditingController();
@override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
  final id=ModalRoute.of(context)!.settings.arguments as String;
  Map<String, String> comments = await Provider.of<Products>(context).getComments(id);
  List<String> _comment=[];
  List<String> _email=[];
  comments.forEach((email, comment) {
  _email.add('$email.com');
  _comment.add(comment);
    print('Email: $email, Comment: $comment');
  });
  commentsList=_comment;
  emailsList=_email;

    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
final id=ModalRoute.of(context)!.settings.arguments as String; // id
final product= Provider.of<Products>(context,listen: false);
final productdata=product.findbyid(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(productdata.title),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height, // Adjust the height as needed
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: double.infinity,
                child: Image.network(
                  productdata.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    return progress == null
                        ? child
                        : CircularProgressIndicator(
                      color: Theme.of(context).indicatorColor,
                      backgroundColor: Colors.blue,
                      value: 0.3,
                    );
                  },
                ),
              ),
              Divider(),
              SizedBox(height: 10),
              Text(
                '\$${productdata.price}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  '${productdata.description}',
                  style: TextStyle(fontStyle: FontStyle.italic),
                  softWrap: true,
                ),
              ),
              const Divider(),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                height: 30,
                width: MediaQuery.of(context).size.width * .8,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        decoration: const InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                          hintText: 'Add a comment',
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (String comment) {
                          // setState(() {
                          commentsList.add(comment);
                          // });
                        },
                      ),
                    ),
                    SizedBox(width: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        product.addComment(id,textEditingController.text);
                        textEditingController.clear();
                        // Do something when the button is pressed
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                 // physics: NeverScrollableScrollPhysics(),
                 // shrinkWrap: true,
                  itemCount: commentsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(commentsList[index]),
                      subtitle: Text(emailsList[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
