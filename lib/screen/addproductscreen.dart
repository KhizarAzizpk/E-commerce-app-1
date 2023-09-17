import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khaksarfirstapp/modules/product.dart';
import 'package:khaksarfirstapp/provider/product.dart';
import 'package:provider/provider.dart';
class addProductScreen extends StatefulWidget {
  const addProductScreen({Key? key}) : super(key: key);
static const routname='/addproductscreen';
  @override
  _addProductScreenState createState() => _addProductScreenState();
}

class _addProductScreenState extends State<addProductScreen> {

  final _pricefocusnode=FocusNode();

  final _descriptionfocusnode=FocusNode();
  final _imagecontroller=TextEditingController();
  final _imagefocusnode=FocusNode();
  var _editproducts=Product(
      id:'',
      title: '',
      description: '',
      price: 0,
    imageUrl: '',
    isfavorite:false,
    uid:''
  );
  var _initvalues={
    'title':'',
    'description':'',
    'price':0,
  };
  var isexist=false;
  var _isloading=false;
  var _init=true;
  final _form=GlobalKey<FormState>();
  void initState() {
    _imagefocusnode.addListener(()=>_updateimage());

    super.initState();
  }


  @override
  void didChangeDependencies() {
    if(_init){


      String? productid=ModalRoute.of(context)!.settings.arguments.toString();
    //String productid='';
       if (productid!='null') {
         isexist=true;
         print('did condition === ${productid.characters.length}');
         _editproducts =
             Provider.of<Products>(context, listen: false).findbyid(
                 productid);

         _initvalues = {
           'title': _editproducts.title,
           'description': _editproducts.description,
           'imageurl': '',
           'price': _editproducts.price,
         };
         _imagecontroller.text = _editproducts.imageUrl;
      }
     else {

    }
    }

    super.didChangeDependencies();
  }
  void dispose() {
    _pricefocusnode.dispose();
    _descriptionfocusnode.dispose();
    _imagecontroller.dispose();
    _imagefocusnode.dispose();
    _imagefocusnode.removeListener(_updateimage);
    super.dispose();
  }

  void _updateimage(){
    if(!_imagefocusnode.hasFocus){
      print('update image called');
      setState(() { });
    }
  }
Future  <void> _saveform() async{
    final isvalid=_form.currentState?.validate();
          if(!isvalid!) {
            return;
          }
    _form.currentState?.save();
          if(_editproducts.id.length>0){

Provider.of<Products>(context,listen: false).updateproduct(_editproducts.id, _editproducts);
Navigator.of(context).pop();
          }
else{
  try{
    await Provider.of<Products>(context,listen: false).addproduct(_editproducts).then((value) => _isloading==false);
    Navigator.of(context).pop();
  }
          catch (error) {
    print ('catch work');
        showDialog(context: context, builder: (ctx) =>
                AlertDialog(
                  title: Text('An error ocurred'),
                  content: Text('something went wrong'),
                  actions: <Widget>[
                    TextButton(onPressed: () {
                      Navigator.of(context).pop();
                    },
                      child: Text('ok'),)
                  ],
                ),
            );
          }
          finally{
            setState(() {
              _isloading=true;
            });
            Navigator.of(context).pop();
          }


         }

  }
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:Text(isexist?'Update Product':'Add Product'),actions: [
        IconButton(onPressed: _saveform, icon: Icon(Icons.save))
      ],),
      body:_isloading?Center(
        child: CircularProgressIndicator(),
      )
          :Padding(
        padding:EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initvalues['title'] as String,
                decoration: InputDecoration(labelText: 'title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted:(_){
                  FocusScope.of(context).requestFocus(_pricefocusnode);
                },
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please provide a value';
                    }
                    return null;

                  },
                onSaved: (value){
                  _editproducts=Product
                    (id: _editproducts.id,
                      title: value as String,
                      description: _editproducts.description,
                      imageUrl:_editproducts.imageUrl,
                      price:_editproducts.price,
                      isfavorite: _editproducts.isfavorite, uid: _editproducts.uid
                      );
                }
              ),
              TextFormField(
                  initialValue: _initvalues['price'].toString(),
                decoration: InputDecoration(labelText: 'price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _pricefocusnode,
                  onFieldSubmitted:(_){
                    FocusScope.of(context).requestFocus(_descriptionfocusnode);
                  },
                  validator: (value){
                  if(value!.isEmpty){
                    return 'Please provide a value';
    }
                  if(double.tryParse(value)==null){
                    return 'Please enter valid number';
                  }
                  if(double.parse(value)<=0){
                    return 'please enter value greater than 0';
                  }
                    return null;

                  },
                  onSaved: (value){
      _editproducts=Product
      (id: _editproducts.id,
      title:_editproducts.title,
      description: _editproducts.description,
      imageUrl:_editproducts.imageUrl,
      price: double.parse(value!),
          isfavorite: _editproducts.isfavorite, uid: _editproducts.uid
      );
      }
              ),
              TextFormField(
                  initialValue: _initvalues['description'] as String,
                decoration: InputDecoration(labelText: 'Description'),
                textInputAction: TextInputAction.next,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please provide a value';
                    }
                    return null;

                  },
                focusNode: _descriptionfocusnode,

                  onSaved: (value){
                    _editproducts=Product
                      (id: _editproducts.id,
                      title:_editproducts.title,
                      description: value.toString(),
                      imageUrl:_editproducts.imageUrl,
                      price: _editproducts.price,
                        isfavorite: _editproducts.isfavorite, uid: _editproducts.uid
                    );
                  }
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey,
                            width: 1)
                    ),
                    child: _imagecontroller.text.isEmpty?Text('enter image Url')
                    :FittedBox(
                      child:
                      Image.network(
                      _imagecontroller.text,
                    ),
                  ),),
                 Expanded(
                   child:
                   TextFormField(
                     decoration: InputDecoration(labelText: 'Image Url'),
                     textInputAction:TextInputAction.done ,
                     keyboardType: TextInputType.url,
                     controller:_imagecontroller ,
                     focusNode: _imagefocusnode,
                       onSaved: (value){
                         _editproducts=Product
                           (id: _editproducts.id,
                           title:_editproducts.title,
                           description: _editproducts.description,
                           imageUrl:value.toString(),
                           price: _editproducts.price,
                             isfavorite: _editproducts.isfavorite,
                           uid: _editproducts.uid
                         );
                       },
                       validator: (value){
                         if(value!.isEmpty){
                           return 'Please provide a Url';
                         }
                         if(!value.startsWith('https')&&!value.startsWith('http')){
                           return 'enter a valid Image Url';
                         }
                       if(!value.endsWith('jpg')&&!value.endsWith('png')){
                         return 'enter a valid Image Url';
                       }
                         return null;

                       },
                     onFieldSubmitted: (_){
                       _saveform();
                     },
                   ),
                 )

                ],
              )
            ],
          )
        ),
      ),
    );
  }
}