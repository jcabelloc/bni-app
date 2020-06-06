import 'dart:io';

import 'package:bniapp/models/miembro.dart';
import 'package:bniapp/screens/login/login_screen.dart';
import 'package:bniapp/services/auth_service.dart';
import 'package:bniapp/services/miembro_service.dart';
import 'package:bniapp/utils/miembro_state.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class UpdateMiembroScreen extends StatefulWidget {
  static const String id = 'update_miembro_screen';

  @override
  _UpdateMiembroScreenState createState() => _UpdateMiembroScreenState();
}

enum MenuOption { salir }

class _UpdateMiembroScreenState extends State<UpdateMiembroScreen> {
  MiembroService _miembroService = MiembroService();
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  Miembro miembro;
  bool showSpinner = false;
  File nuevoAvatar;

  @override
  void initState() {
    super.initState();
    miembro = Provider.of<MiembroState>(context, listen: false).miembro;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar datos'),
        actions: <Widget>[
          PopupMenuButton<MenuOption>(
            onSelected: (MenuOption result) {
              switch (result) {
                case MenuOption.salir:
                  {
                    _authService.logout();
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginScreen.id, (route) => false);
                    break;
                  }
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOption>>[
              const PopupMenuItem<MenuOption>(
                  value: MenuOption.salir,
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Salir'),
                  )),
            ],
          )
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: <Widget>[
                        nuevoAvatar == null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: miembro.avatarUrl != null
                                    ? NetworkImage(miembro.avatarUrl ?? '')
                                    : AssetImage('images/avatar-placeholder.gif'),
                              )
                            : CircleAvatar(
                                radius: 64,
                                backgroundImage: FileImage(nuevoAvatar),
                              ),
                        Positioned(
                          bottom: -10,
                          right: -10,
                          child: IconButton(
                            color: Theme.of(context).primaryColor,
                            iconSize: 32,
                            onPressed: () async {
                              nuevoAvatar = await ImagePicker.pickImage(
                                  source: ImageSource.gallery,
                                  maxHeight: 200,
                                  maxWidth: 200);
                              if (nuevoAvatar != null)
                                setState(() => nuevoAvatar);
                            },
                            icon: Icon(Icons.camera_alt),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'Nombres',
                        ),
                        initialValue: miembro.nombres,
                        onChanged: (value) {
                          miembro.nombres = value;
                        },
                        validator: (value) {
                          return value.isEmpty
                              ? 'Por favor ingrese sus nombres'
                              : null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.people),
                          labelText: 'Apellidos',
                        ),
                        initialValue: miembro.apellidos,
                        onChanged: (value) {
                          miembro.apellidos = value;
                        },
                        validator: (value) {
                          return value.isEmpty
                              ? 'Por favor ingrese sus apellidos'
                              : null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.phone),
                          labelText: 'Telefono',
                        ),
                        initialValue: miembro.telefono,
                        onChanged: (value) {
                          miembro.telefono = value;
                        },
                        validator: (value) {
                          return value.isEmpty
                              ? 'Por favor ingrese su telefono'
                              : null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.location_city),
                          labelText: 'Centro de Labores',
                        ),
                        initialValue: miembro.nombreEmpresa,
                        onChanged: (value) {
                          miembro.nombreEmpresa = value;
                        },
                        validator: (value) {
                          return value.isEmpty
                              ? 'Por favor ingrese su centro de labores'
                              : null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.school),
                          labelText: 'Profesion',
                        ),
                        initialValue: miembro.profesion,
                        onChanged: (value) {
                          miembro.profesion = value;
                        },
                        validator: (value) {
                          return value.isEmpty
                              ? 'Por favor ingrese su profesion'
                              : null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => showSpinner = true);
                              if (nuevoAvatar != null) {
                                await _miembroService.uploadAvatar(
                                    miembro.idMiembro, nuevoAvatar);
                                String avatarUrl = await _miembroService
                                    .getAvatarUrl(miembro.idMiembro);
                                miembro.avatarUrl = avatarUrl;
                              }
                              await _miembroService.save(miembro);
                              Provider.of<MiembroState>(context, listen: false)
                                  .updateMiembro(miembro);

                              Navigator.pop(context);
                              setState(() => showSpinner = false);
                            }
                          },
                          child: Text('GUARDAR'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
