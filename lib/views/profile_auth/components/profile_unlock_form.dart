import 'package:ardrive/blocs/blocs.dart';
import 'package:ardrive/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UnlockProfileForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider<ProfileUnlockCubit>(
        create: (context) => ProfileUnlockCubit(
          profileCubit: context.bloc<ProfileCubit>(),
          profileDao: context.repository<ProfileDao>(),
        ),
        child: BlocBuilder<ProfileUnlockCubit, ProfileUnlockState>(
          builder: (context, state) => ReactiveForm(
            formGroup: context.bloc<ProfileUnlockCubit>().form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Unlock Profile',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Container(height: 16),
                ReactiveTextField(
                  formControlName: 'password',
                  autofocus: true,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  showErrors: (control) => control.dirty && control.invalid,
                  validationMessages: {
                    'password-incorrect': 'You entered an incorrect password',
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('UNLOCK'),
                    onPressed: () =>
                        context.bloc<ProfileUnlockCubit>().submit(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
