# Configuracion del Proyecto

###
* ... varias configuraciones iniciales fueron omitidas




## Configuracion de Firebase

### Add Firebase to your Android app
* Desde la consola de Firebase, agregar Firebase a nuestra Android app, luego seguir las instrucciones

* Update build.gradle applicationId "pe.itana.bnidev"
* Register app: pe.itana.bnidev
* Nickname: BNI Dev
* Descargar archivo: google-services.json
* Mover dicho archivo al proyecto, a la ruta: Android/app
* Agregar las depedencias indicadas al build.gradle del proyecto y del app
* Ejecutar el app y verificar que todo funcione

### Agregar dependencias Firebase para Flutter
* firebase_core: ^0.4.4+3
* firebase_auth: ^0.16.0
* cloud_firestore: ^0.13.5

* Ejecutar el app y verificar que todo siga funcionando


### Autenticacion
* Ir a la consola de Firebase / Autenticacion
* Proceder con: "Set-up sing-in method"
* Esoger el proveedor: Email/Password

### Agregar Firebase Storage
* Agregar la dependencia =>  firebase_storage: ^3.1.5
* Agregar la dependencia =>   image_picker: ^0.6.5+3

