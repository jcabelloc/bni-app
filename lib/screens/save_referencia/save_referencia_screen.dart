import 'package:bniapp/models/asistencia.dart';
import 'package:bniapp/models/miembro.dart';
import 'package:bniapp/models/sesion.dart';
import 'package:bniapp/services/asistencia_service.dart';
import 'package:bniapp/services/sesion_service.dart';
import 'package:bniapp/utils/app_state.dart';
import 'package:bniapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SaveReferenciaScreen extends StatefulWidget {
  static const String id = 'save_referencia_screen';

  @override
  _SaveReferenciaScreenState createState() => _SaveReferenciaScreenState();
}

class _SaveReferenciaScreenState extends State<SaveReferenciaScreen> {
  AppState _appState = AppState.instance;
  SesionService _sesionService = SesionService();
  AsistenciaService _asistenciaService = AsistenciaService();
  final _formKey = GlobalKey<FormState>();

  bool showSpinner = false;
  Miembro miembro;
  Sesion proximaSesion;
  Asistencia proximaAsistencia;

  TextEditingController _empresaTextController;
  TextEditingController _cargoTextController;
  TextEditingController _nombreTextController;
  TextEditingController _fechaHoraTextController;

  @override
  void initState() {
    miembro = _appState.miembro;
    initData();
  }

  void initData() async {
    proximaSesion = await _sesionService.getProximaSesion(miembro.idGrupo);
    proximaAsistencia = await _asistenciaService.getById(
        proximaSesion.idSesion, miembro.idMiembro);
    proximaAsistencia ??=
        Asistencia.fromSesionAndMiembro(proximaSesion, miembro);

    setState(() {
      proximaAsistencia = proximaAsistencia;
      _empresaTextController =
          TextEditingController(text: proximaAsistencia.referencia.empresa);
      _cargoTextController =
          TextEditingController(text: proximaAsistencia.referencia.cargo);
      _nombreTextController =
          TextEditingController(text: proximaAsistencia.referencia.nombre);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar referencia'),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.location_city),
                          labelText: 'Empresa',
                        ),
                        controller: _empresaTextController,
                        onChanged: (value) {
                          proximaAsistencia.referencia.empresa = value;
                        },
                        validator: (value) {
                          return value.isEmpty
                              ? 'Por favor ingrese la empresa'
                              : null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.work),
                          labelText: 'Cargo',
                        ),
                        controller: _cargoTextController,
                        onChanged: (value) {
                          proximaAsistencia.referencia.cargo = value;
                        },
                        validator: (value) {
                          return value.isEmpty
                              ? 'Por favor ingrese el cargo'
                              : null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'Nombre',
                        ),
                        controller: _nombreTextController,
                        onChanged: (value) {
                          proximaAsistencia.referencia.nombre = value;
                        },
                        validator: (value) {
                          return value.isEmpty
                              ? 'Por favor ingrese el nombre'
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
                              await _asistenciaService.save(proximaAsistencia);
                              // JCC: Workaround para fijar una latencia antes de volver
                              Future.delayed(
                                  const Duration(
                                      milliseconds: kMiliSegundosEspera), () {
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
