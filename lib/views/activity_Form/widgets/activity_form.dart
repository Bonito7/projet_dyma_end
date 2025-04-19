import 'package:flutter/material.dart';
import 'package:projet_dyma_end/providers/city_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/activity_model.dart';
import 'activity_form_autocomplete.dart';
import 'activity_form_image_picker.dart';

class ActivityForm extends StatefulWidget {
  final String cityName;
  const ActivityForm({super.key, required this.cityName});

  @override
  State<ActivityForm> createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late FocusNode _priceFocusNode;
  late FocusNode _urlFocusNode;
  late FocusNode _addressFocusNode;
  late String? _nameInputAsync;
  final TextEditingController _urlController = TextEditingController();
  bool isLoading = false;

  late Activity newActivity;

  FormState? get form {
    return formKey.currentState;
  }

  @override
  void initState() {
    // TODO: implement initState
    newActivity = Activity(
      city: widget.cityName,
      name: '',
      price: 0,
      image: '',
      location: LocationActivity(
        address: null,
        latitude: null,
        longitude: null,
      ),
      status: ActivityStatus.ongoing,
    );
    _priceFocusNode = FocusNode();
    _urlFocusNode = FocusNode();
    _addressFocusNode = FocusNode();
    _addressFocusNode.addListener(() async {
      if (_addressFocusNode.hasFocus) {
        var location = await showInputAutocomplete(context);
      } else {
        print('no focus');
      }
    });

    super.initState();
  }

  void updateUrlField(String url) {
    setState(() {
      _urlController.text = url;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _urlController.dispose();
    _priceFocusNode.dispose();
    _urlFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    try {
      CityProvider cityProvider = Provider.of<CityProvider>(
        context,
        listen: false,
      );
      // Save the form state before proceeding
      formKey.currentState?.save();
      // Set loading state to true
      setState(() => isLoading = true);
      // Check if the activity name is unique asynchronously
      _nameInputAsync = await cityProvider.verifyIfActivityNameIsUnique(
        widget.cityName,
        newActivity.name,
      );

      // Validate the form fields after async check
      if (form!.validate()) {
        // Add the activity to the city using the provider
        await cityProvider.addActivityToCity(newActivity);
        // Return to previous screen
        Navigator.pop(context);
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      // Handle any exceptions that occur during form submission
      print('Error: $e');
      // Always stop loading after the process
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Remplissez le nom';
                } else if (_nameInputAsync != null) {
                  return _nameInputAsync;
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Nom',
                labelStyle: TextStyle(
                  color: Colors.orangeAccent,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                    width: 2.0,
                  ),
                ),
              ),
              cursorColor: Colors.green,
              onSaved: (newValue) => newActivity.name = newValue!,
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) return 'Remplissez le prix';
                return null;
              },
              focusNode: _priceFocusNode,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Prix',
                labelStyle: TextStyle(
                  color: Colors.orangeAccent,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                    width: 2.0,
                  ),
                ),
              ),
              cursorColor: Colors.green,
              onSaved: (newValue) =>
                  newActivity.price = double.parse(newValue!),
            ),
            const SizedBox(height: 25),
            TextFormField(
              focusNode: _addressFocusNode,
              decoration: const InputDecoration(
                labelText: 'Adresse de la ville',
                labelStyle: TextStyle(
                  color: Colors.orangeAccent,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                    width: 2.0,
                  ),
                ),
              ),
              onSaved: (newValue) => newActivity.location!.address = newValue!,
            ),
            const SizedBox(height: 25),
            TextFormField(
              keyboardType: TextInputType.url,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Remplissez l\'url de l\'image';
                }
                return null;
              },
              focusNode: _urlFocusNode,
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'Url de l\'image',
                labelStyle: TextStyle(
                  color: Colors.orangeAccent,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                    width: 2.0,
                  ),
                ),
              ),
              cursorColor: Colors.green,
              onSaved: (newValue) => newActivity.image = newValue!,
            ),
            const SizedBox(height: 10),
            ActivityFormImagePicker(
              updateUrl: updateUrlField,
            ),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Annuler',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Colors.orangeAccent),
                  ),
                  onPressed: isLoading ? null : submitForm,
                  child: isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text(
                          'Enregistrer',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
