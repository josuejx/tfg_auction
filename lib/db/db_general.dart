import 'dart:io';

import 'package:dartssh2/dartssh2.dart';
import 'package:get/get.dart';

class DBGeneral {
  static Future uploadImage(File file, String nombreFichero) async {
    try {
      var client = SSHClient(
        await SSHSocket.connect('access935918845.webspace-data.io', 22),
        username: 'u1799247386',
        onPasswordRequest: () => 'AuctionTFG2023',
      );

      String fileName = '';
      if (GetPlatform.isWindows) {
        fileName = file.path.split('\\').last;
      } else {
        fileName = file.path.split('/').last;
      }
      String extension = fileName.split('.').last;

      final sftp = await client.sftp();

      if (nombreFichero.substring(0, 1) == 'U') {
        nombreFichero = '/usuarios/${nombreFichero.substring(1)}.$extension';
      } else if (nombreFichero.substring(0, 1) == 'P') {
        nombreFichero = '/productos/${nombreFichero.substring(1)}.$extension';
      }

      final remoteFile = await sftp.open(nombreFichero,
          mode: SftpFileOpenMode.create | SftpFileOpenMode.write);
      await remoteFile.write(file.openRead().cast());
    } catch (e) {
      print(e);
    }
  }

  static Future deleteImage(String nombreFichero) async {
    try {
      var client = SSHClient(
        await SSHSocket.connect('access935918845.webspace-data.io', 22),
        username: 'u1799247386',
        onPasswordRequest: () => 'AuctionTFG2023',
      );

      String carpeta = '';
      if (nombreFichero.substring(0, 1) == 'U') {
        carpeta = '/usuarios';
      } else if (nombreFichero.substring(0, 1) == 'P') {
        carpeta = '/productos';
      }

      final sftp = await client.sftp();
      var dir = await sftp.listdir('/usuarios');

      for (var item in dir) {
        if (item.filename == nombreFichero) {
          await sftp.remove('$carpeta/$nombreFichero');
          return;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future replaceImage(File file, String nombreFichero) async {
    await deleteImage(nombreFichero);
    await uploadImage(file, nombreFichero);
  }
}
