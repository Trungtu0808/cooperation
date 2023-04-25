import 'package:app_chat_firebase/import_file/import_all.dart';

final numberOnlyRegex = RegExp(r'[0-9]');

final vnPhoneNumberRegex = RegExp(r'^\d{10,11}$');

final phoneNumberPartsRegex = RegExp(r'^([\d]{3})([\d]+)([\d]{3})$');

final RegExp emailRegex = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$');

final notContainsProtocolUrlRegex =
    RegExp(r'[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)');

ValidatorFunction mustMatchEmail({
  required String controlName,
}) {
  return (AbstractControl<dynamic> control) {

    final form = control as FormGroup;

    final formControl = form.control(controlName);

    if (formControl.isNull ||
        formControl.value.toString().isEmpty ||
        emailRegex.hasMatch(formControl.value.toString())) {
      return null;
    }

    if (!emailRegex.hasMatch(formControl.value ?? '')) {
      formControl.setErrors({controlName.tr(): true});
      // force messages to show up as soon as possible
      formControl.markAsTouched();
    } else {
      formControl.removeError(controlName.tr());
    }
    return null;
  };
}

ValidatorFunction mustMatchPassword({
  required String controlName,
}) {
  return (AbstractControl<dynamic> control) {
    final form = control as FormGroup;

    final formControl = form.control(controlName);
    if (formControl.isNull ||
        //formControl.value.toString().isEmpty ||
        passwordRegex.hasMatch(formControl.value.toString())) {
      return null;
    }

    if (!passwordRegex.hasMatch(formControl.value ?? '')) {
      formControl.setErrors({controlName.tr(): true});
      // force messages to show up as soon as possible
      formControl.markAsTouched();
    } else {
      formControl.removeError(controlName.tr());
    }
    return null;
  };
}

ValidatorFunction mustMatchPasswordAndPasswordConfirmation({
  required String controlName,
  required String matchingControlName,
}) {
  return (AbstractControl<dynamic> control) {
    final form = control as FormGroup;

    final formControl = form.control(controlName);
    final matchingFormControl = form.control(matchingControlName);
    if (matchingFormControl.isNull ||
        matchingFormControl.value.toString().isEmpty) {
      return null;
    }
    if (formControl.value != matchingFormControl.value) {
      matchingFormControl.setErrors({matchingControlName.tr(): true});

      // force messages to show up as soon as possible
      matchingFormControl.markAsTouched();
    } else {
      matchingFormControl.removeError(matchingControlName.tr());
    }

    return null;
  };
}
