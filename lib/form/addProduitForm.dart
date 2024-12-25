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

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey[400]),
      prefixIcon: Icon(icon, color: Colors.purple),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.grey[700]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.purple, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
      filled: true,
      fillColor: Color(0xFF2D2D2D),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Opacity(
            opacity: _isLoading ? 0.5 : 1,
            child: AbsorbPointer(
              absorbing: _isLoading,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Ajouter un Produit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: _buildInputDecoration('Marque', Icons.branding_watermark),
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
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: _buildInputDecoration('Désignation', Icons.description),
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
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: _buildInputDecoration('Catégorie', Icons.category),
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
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: _buildInputDecoration('Prix', Icons.euro),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer le Prix';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _prix = double.tryParse(value ?? '0') ?? 0.0;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: _buildInputDecoration('Quantité', Icons.inventory),
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
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.purple,
                          child: CircleAvatar(
                            radius: 48,
                            backgroundImage: AssetImage('assets/images/placeholder.jpg'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Ajouter',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
      await widget.onSubmit({
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Une erreur est survenue'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}