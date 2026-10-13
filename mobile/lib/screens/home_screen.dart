import 'package:flutter/material.dart';

import '../models/semijoia.dart';
import '../services/api_service.dart';
import 'form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _api = ApiService();
  List<SemiJoia> _items = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final list = await _api.listar();
      setState(() => _items = list);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _openForm([SemiJoia? s]) async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => FormScreen(semijoia: s)),
    );
    if (changed == true) _load();
  }

  Future<void> _delete(SemiJoia s) async {
    try {
      await _api.deletar(s.id!);
      _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Semijoias'), actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: _load)]),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (_, i) {
                      final s = _items[i];
                      return Dismissible(
                        key: Key(s.id.toString()),
                        background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 16), child: const Icon(Icons.delete, color: Colors.white)),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (_) async => await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Excluir?'),
                                content: Text('Excluir ${s.nome}?'),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
                                  TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Excluir')),
                                ],
                              ),
                            ) ??
                            false,
                        onDismissed: (_) => _delete(s),
                        child: ListTile(
                          title: Text(s.nome),
                          subtitle: Text('${s.tipo} • ${s.material} • R\$ ${s.preco.toStringAsFixed(2)}'),
                          trailing: Icon(s.disponivel ? Icons.check_circle : Icons.cancel, color: s.disponivel ? Colors.green : Colors.grey),
                          onTap: () => _openForm(s),
                        ),
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}