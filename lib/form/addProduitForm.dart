import 'package:flutter/material.dart';

class ProduitForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  ProduitForm({required this.onSubmit});
  @override
  _ProduitFormState createState() => _ProduitFormState();
}

class _ProduitFormState extends State<ProduitForm> {
  final _formKey = GlobalKey<FormState>();
  String _marque = '';
  String _designation = '';
  String _categorie = '';
  bool fav = false;
  double _prix = 0.0;
  int _quantite = 0;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: _isLoading ? 0.5 : 1,
          child: AbsorbPointer(
            absorbing: _isLoading,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Marque'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer la marque';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _marque = value ?? '';
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Désignation'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer la Désignation';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _designation = value ?? '';
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Catégorie'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer la Catégorie';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _categorie = value ?? '';
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Prix'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer la Prix';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _prix = double.tryParse(value ?? '0') ?? 0.0;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Quantité'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer la Quantité';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _quantite = int.tryParse(value ?? '0') ?? 0;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            const AssetImage('assets/images/placeholder.jpg'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text('Ajouter'),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });
    try {
      _formKey.currentState?.save();
      widget.onSubmit({
        'fav': fav,
        'marque': _marque,
        'designation': _designation,
        'categorie': _categorie,
        'prix': _prix,
        'quantite': _quantite,
        'image': '' 
      });
    } catch (error) {
      print('Error during submission: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
