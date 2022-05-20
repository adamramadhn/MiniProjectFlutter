import 'package:flutter/material.dart';

var txtRegisEmail = TextEditingController();
var txtRegisPass = TextEditingController();
var txtRegisNama = TextEditingController();
var txtRegisNohp = TextEditingController();

Widget regisInputEmail() {
  return TextFormField(
      cursorColor: Colors.white,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: txtRegisEmail,
      onSaved: (String? val) {
        txtRegisEmail.text = val!;
      },
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Email must be filled!';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Masukkan Email',
        hintStyle: const TextStyle(color: Colors.white),
        labelText: "Masukkan Email",
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: const Icon(
          Icons.email_outlined,
          color: Colors.white,
        ),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
      style: const TextStyle(fontSize: 16.0, color: Colors.white));
}

Widget regisInputPassword() {
  return TextFormField(
      cursorColor: Colors.white,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      autofocus: false,
      controller: txtRegisPass,
      // onSaved: (String? val) {
      //   txtRegisPass.text = val!;
      // },
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Password must be filled!';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Masukkan Password',
        hintStyle: const TextStyle(color: Colors.white),
        labelText: "Masukkan Password",
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: const Icon(
          Icons.password,
          color: Colors.white,
        ),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
      style: const TextStyle(fontSize: 16.0, color: Colors.white));
}

Widget regisInputNama() {
  return TextFormField(
      cursorColor: Colors.white,
      keyboardType: TextInputType.text,
      obscureText: false,
      autofocus: false,
      controller: txtRegisNama,
      onSaved: (String? val) {
        txtRegisNama.text = val!;
      },
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Nama must be filled!';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Masukkan Nama',
        hintStyle: const TextStyle(color: Colors.white),
        labelText: "Masukkan Nama",
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: const Icon(
          Icons.perm_identity,
          color: Colors.white,
        ),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
      style: const TextStyle(fontSize: 16.0, color: Colors.white));
}

Widget regisInputNoHp() {
  return TextFormField(
      cursorColor: Colors.white,
      keyboardType: TextInputType.phone,
      obscureText: false,
      autofocus: false,
      controller: txtRegisNohp,
      onSaved: (String? val) {
        txtRegisNohp.text = val!;
      },
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'No Hp must be filled!';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Masukkan No Hp',
        hintStyle: const TextStyle(color: Colors.white),
        labelText: "Masukkan No Hp",
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: const Icon(
          Icons.phone,
          color: Colors.white,
        ),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
      style: const TextStyle(fontSize: 16.0, color: Colors.white));
}
