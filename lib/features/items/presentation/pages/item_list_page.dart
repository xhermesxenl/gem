import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Bloc (events + states via part/part of)
import '../bloc/item_bloc.dart';

// Injection de dépendances
import '../../../../core/di/injection.dart';

// Usecases
import '../../domain/usecases/get_items.dart';
import '../../domain/usecases/add_item.dart';
import '../../domain/usecases/update_item.dart';
import '../../domain/usecases/delete_item.dart';

//Supabase
import 'package:supabase_flutter/supabase_flutter.dart';

class ItemListPage extends StatelessWidget {
  const ItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemBloc(
        sl<GetItems>(),
        sl<AddItem>(),
        sl<UpdateItem>(),
        sl<DeleteItem>(),
      )..add(LoadItemsEvent()),
      child: const _ItemListView(),
    );
  }
}

class _ItemListView extends StatelessWidget {
  const _ItemListView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Items"),
        actions: [
      IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () async {
          await Supabase.instance.client.auth.signOut();
          if (context.mounted) {
            context.go('/signin'); // 🚀 retour à la page login
          }
        },
      ),
    ],
        ),
      body: BlocListener<ItemBloc, ItemState>(
        listener: (context, state) {
          if (state is ItemLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("✅ Action réussie")),
            );
          } else if (state is ItemError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("❌ ${state.message}")),
            );
          }
        },
        child: BlocBuilder<ItemBloc, ItemState>(
          builder: (context, state) {
            if (state is ItemLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ItemLoaded) {
              if (state.items.isEmpty) {
                return const Center(child: Text("Aucun item"));
              }
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (_, i) {
                  final item = state.items[i];
                  return ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.description ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showUpdateItemDialog(
                            context,
                            item.id,
                            item.title,
                            item.description,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            //context.read<ItemBloc>().add(DeleteItemEvent(item.id));
                            _showDeleteConfirmDialog(context, item.id, item.title);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is ItemError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddItemDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

void _showAddItemDialog(BuildContext parentContext) {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  showDialog(
    context: parentContext,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text("Ajouter un item"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Titre"),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Annuler"),
          ),
          BlocBuilder<ItemBloc, ItemState>(
            bloc: parentContext.read<ItemBloc>(), // ⚡ ici le bon bloc
            builder: (context, state) {
              final isLoading = state is ItemActionInProgress;
              return ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        parentContext.read<ItemBloc>().add(
                              AddItemEvent(
                                titleController.text,
                                descController.text,
                              ),
                            );
                        Navigator.pop(dialogContext);
                      },
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text("Ajouter"),
              );
            },
          ),
        ],
      );
    },
  );
}


void _showDeleteConfirmDialog(BuildContext parentContext, String id, String title) {
  showDialog(
    context: parentContext,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text("Confirmer la suppression"),
        content: Text("Voulez-vous vraiment supprimer « $title » ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              parentContext.read<ItemBloc>().add(DeleteItemEvent(id));
              Navigator.pop(dialogContext);
            },
            child: const Text("Supprimer"),
          ),
        ],
      );
    },
  );
}


  void _showUpdateItemDialog(
    BuildContext parentContext,
    String id,
    String oldTitle,
    String? oldDesc,
  ) {
    final titleController = TextEditingController(text: oldTitle);
    final descController = TextEditingController(text: oldDesc ?? "");

    showDialog(
      context: parentContext,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Modifier l’item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Titre"),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () {
                parentContext.read<ItemBloc>().add(
                  UpdateItemEvent(
                    id,
                    titleController.text,
                    descController.text,
                  ),
                );
                Navigator.pop(dialogContext);
              },
              child: const Text("Enregistrer"),
            ),
          ],
        );
      },
    );
  }
}
