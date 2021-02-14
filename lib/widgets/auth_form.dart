import 'dart:io';

import 'package:chat_app/widgets/image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username, File image ,
      bool isLogin, BuildContext ctx) submutfn;
  final bool _isLoading;
  AuthForm(this.submutfn, this._isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = '';
  String _password = '';
  String _username = '';
  File _userImageFile;

  void _pickedImage(File pickedImage) {
    _userImageFile = pickedImage;
  }

  void _submit() {
    final isValid = _formKey.currentState.validate();
    //this line to when i pressed in button the keyboard is down
    FocusScope.of(context).unfocus();
    if (!_isLogin &&_userImageFile == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please pick an image.'),
        duration: Duration(seconds: 10),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
    if (isValid) {
      _formKey.currentState.save();
      //trim to delete any space to avoid the error
      widget.submutfn(
          _email.trim(), _password.trim(),_username.trim(), _userImageFile, _isLogin, context);
      // print(_email);
      // print(_password);
      // print(_username);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isLogin) UserImagePicker(_pickedImage),
                TextFormField(
                  autocorrect: false,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.none,
                  //key to unique all fields in form like id
                  key: ValueKey('email'),
                  validator: (val) {
                    if (val.isEmpty || !val.contains('@')) {
                      return 'please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (val) => _email = val,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: 'Email', labelText: 'Email Address'),
                ),
                if (!_isLogin)
                  TextFormField(
                    autocorrect: true,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.words,
                    key: ValueKey('username'),
                    validator: (val) {
                      if (val.isEmpty || val.length < 4) {
                        return 'please enter a least 4 character';
                      }
                      return null;
                    },
                    onSaved: (val) => _username = val,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'username', labelText: 'User Name'),
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (val) {
                    if (val.isEmpty || val.length < 7) {
                      return 'please must be at least 7 character';
                    }
                    return null;
                  },
                  onSaved: (val) => _password = val,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'password', labelText: 'Password'),
                ),
                SizedBox(
                  height: 12,
                ),
                if (widget._isLoading) CircularProgressIndicator(),
                if (!widget._isLoading)
                  RaisedButton(
                      child: Text(_isLogin ? 'Login' : 'SignUp'),
                      onPressed: _submit),
                if (!widget._isLoading)
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create new account'
                          : 'I already have an account'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
