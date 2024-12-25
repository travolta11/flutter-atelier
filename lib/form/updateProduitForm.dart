import 'package:flutter/material.dart';

class ProduitFormUpdate extends StatefulWidget {
  final Map<String, dynamic> initialData;
  final Function(Map<String, dynamic>) onSubmit;
  ProduitFormUpdate({required this.initialData, required this.onSubmit});
  @override
  _ProduitFormState createState() => _ProduitFormState();
}

class _ProduitFormState extends State<ProduitFormUpdate> {
  final _formKey = GlobalKey<FormState>();
  String _marque = '';
  String _designation = '';
  String _categorie = '';
  bool fav = false;
  double _prix = 0.0;
  int _quantite = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _marque = widget.initialData['marque'] ?? '';
    _designation = widget.initialData['designation'] ?? '';
    _categorie = widget.initialData['categorie'] ?? '';
    _prix = widget.initialData['prix'] ?? 0.0;
    _quantite = widget.initialData['quantite'] ?? 0;
    fav = widget.initialData['fav'] ?? false;
  }

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
                    initialValue: _marque,
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
                    initialValue: _designation,
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
                    initialValue: _categorie,
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
                    initialValue: _prix.toString(),
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
                    initialValue: _quantite.toString(),
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
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text('Modifier'),
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
      });
    } catch (error) {
      print('Error: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
