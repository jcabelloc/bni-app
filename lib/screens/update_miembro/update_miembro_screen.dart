import 'dart:io';

import 'package:bniapp/models/miembro.dart';
import 'package:bniapp/models/usuario.dart';
import 'package:bniapp/services/miembro_service.dart';
import 'package:bniapp/services/usuario_service.dart';
import 'package:bniapp/utils/app_state.dart';
import 'package:bniapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class UpdateMiembroScreen extends StatefulWidget {
  static const String id = 'update_miembro_screen';

  @override
  _UpdateMiembroScreenState createState() => _UpdateMiembroScreenState();
}

class _UpdateMiembroScreenState extends State<UpdateMiembroScreen> {
  AppState _appState = AppState.instance;
  MiembroService _miembroService = MiembroService();
  UsuarioService _usuarioService = UsuarioService();
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();

  Usuario usuario;
  Miembro miembro;

  TextEditingController _nombresTextController;
  TextEditingController _apellidosTextController;
  TextEditingController _telefonoTextController;
  TextEditingController _empresaTextController;
  TextEditingController _profesionTextController;

  @override
  void initState() {
    usuario = _appState.usuario;
    miembro = _appState.miembro;
    _nombresTextController = TextEditingController(text: miembro.nombres);
    _apellidosTextController = TextEditingController(text: miembro.apellidos);
    _telefonoTextController = TextEditingController(text: miembro.telefono);
    _empresaTextController = TextEditingController(text: miembro.nombreEmpresa);
    _profesionTextController = TextEditingController(text: miembro.profesion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar datos'),
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
                        CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(miembro.avatarUrl),
                        ),
                        Positioned(
                          bottom: -10,
                          right: -10,
                          child: IconButton(
                            color: Theme.of(context).primaryColor,
                            iconSize: 32,
                            onPressed: () async {
                              File image = await ImagePicker.pickImage(
                                  source: ImageSource.gallery,
                                  maxHeight: 200,
                                  maxWidth: 200);
                              setState(() => showSpinner = true);
                              await _miembroService.uploadAvatar(
                                  miembro.idMiembro, image);
                              String avatarUrl = await _miembroService
                                  .getAvatarUrl(miembro.idMiembro);
                              miembro.avatarUrl = avatarUrl;
                              usuario.avatarUrl = avatarUrl;
                              await _miembroService.save(miembro);
                              await _usuarioService.save(usuario);
                              _appState.miembro.avatarUrl = avatarUrl;
                              _appState.usuario.avatarUrl = avatarUrl;
                              setState(() {
                                miembro = miembro;
                                showSpinner = false;
                              });
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
                        controller: _nombresTextController,
                        onChanged: (value) {
                          miembro.nombres = value;
                          usuario.nombres = value;
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
                        controller: _apellidosTextController,
                        onChanged: (value) {
                          miembro.apellidos = value;
                          usuario.apellidos = value;
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
                        controller: _telefonoTextController,
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
                        controller: _empresaTextController,
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
                        controller: _profesionTextController,
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
                              await _miembroService.save(miembro);
                              await _usuarioService.save(usuario);

                              // JCC: Workaround para fijar una latencia antes de volver
                              Future.delayed(
                                  const Duration(
                                      milliseconds: kMiliSegundosEspera), () {
                                _appState.initAppState();
                                Navigator.pop(context, 'saved');
                                setState(() => showSpinner = false);
                              });
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
