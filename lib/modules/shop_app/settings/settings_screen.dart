import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shareed/components/compnnents.dart';

class SettingsScreen extends StatelessWidget {


  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var phoneController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          defaultFormField(
            controller: nameController,
              type: TextInputType.name,
              label: 'Name',
              prefix: Icons.person,
              validate: (String? value)
              {
               if(value!.isEmpty)
               {
                 return 'name must be empty';
               }
               return null;
              },
          ),
          SizedBox(height: 15.0,),
          defaultFormField(
            controller: emailController,
            type: TextInputType.emailAddress,
            label: 'Email Address',
            prefix: Icons.email,
            validate: (String? value)
            {
              if(value!.isEmpty)
              {
                return 'email address must be empty';
              }
              return null;
            },
          ),
          SizedBox(height: 15.0,),
          defaultFormField(
            controller: phoneController,
            type: TextInputType.phone,
            label: 'Phone',
            prefix: Icons.phone,
            validate: (String? value)
            {
              if(value!.isEmpty)
              {
                return 'phone must be empty';
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}
