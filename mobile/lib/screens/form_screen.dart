import 'package:flutter/material.dart';

import '../models/semijoia.dart';
import '../services/api_service.dart';

class FormScreen extends StatefulWidget {
  final SemiJoia? semijoia;

  const FormScreen({super.key, this.semijoia});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _form = GlobalKey<FormState>();
  late final TextEditingController _nome;
  late final TextEditingController _tipo;
  late final TextEditingController _material;
  late final TextEditingController _preco;
  late final TextEditingController _peso;
  late final TextEditingController _descricao;
  bool _disponivel = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final s = widget.semijoia;
    _nome = TextEditingController(text: s?.nome ?? '');
    _tipo = TextEditingController(text: s?.tipo ?? '');
    _material = TextEditingController(text: s?.material ?? '');
    _preco = TextEditingController(text: s?.preco.toString() ?? '');
    _peso = TextEditingController(text: s?.pesoGramas.toString() ?? '');
    _descricao = TextEditingController(text: s?.descricao ?? '');
    _disponivel = s?.disponivel ?? true;
  }

  @override
  void dispose() {
    _nome.dispose();
    _tipo.dispose();
    _material.dispose();
    _preco.dispose();
    _peso.dispose();
    _descricao.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _saving = true);
    final s = SemiJoia(
      id: widget.semijoia?.id,
      nome: _nome.text.trim(),
      tipo: _tipo.text.trim(),
      material: _material.text.trim(),
      preco: double.parse(_preco.text),
      pesoGramas: double.parse(_peso.text),
      descricao: _descricao.text.trim().isEmpty ? null : _descricao.text.trim(),
      disponivel: _disponivel,
    );
    try {
      if (widget.semijoia == null) {
        await ApiService().criar(s);
      } else {
        await ApiService().atualizar(widget.semijoia!.id!, s);
      }
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.semijoia == null ? 'Nova Semijoia' : 'Editar Semijoia')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(controller: _nome, decoration: const InputDecoration(labelText: 'Nome'), validator: (v) => v == null || v.isEmpty ? 'Obrigatorio' : null),
              TextFormField(controller: _tipo, decoration: const InputDecoration(labelText: 'Tipo'), validator: (v) => v == null || v.isEmpty ? 'Obrigatorio' : null),
              TextFormField(controller: _material, decoration: const InputDecoration(labelText: 'Material'), validator: (v) => v == null || v.isEmpty ? 'Obrigatorio' : null),
              TextFormField(controller: _preco, decoration: const InputDecoration(labelText: 'Preco'), keyboardType: TextInputType.number, validator: (v) => double.tryParse(v ?? '') == null ? 'Numero invalido' : null),
              TextFormField(controller: _peso, decoration: const InputDecoration(labelText: 'Peso (g)'), keyboardType: TextInputType.number, validator: (v) => double.tryParse(v ?? '') == null ? 'Numero invalido' : null),
              TextFormField(controller: _descricao, decoration: const InputDecoration(labelText: 'Descricao')),
              SwitchListTile(title: const Text('Disponivel'), value: _disponivel, onChanged: (v) => setState(() => _disponivel = v)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saving ? null : _save,
                child: _saving ? const CircularProgressIndicator() : const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}