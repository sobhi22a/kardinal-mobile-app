import 'package:e_commerce_app/core/functions/static_values.dart';
import 'package:e_commerce_app/core/widgets/default_button.dart';
import 'package:e_commerce_app/database/models/command_model.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/bloc/commands_bloc.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/bloc/commands_state.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/components/accordions/accordion-command-component.dart';
import 'package:e_commerce_app/localization/AppLocalizations.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

// Wrapper widget that provides the bloc
class CommandScreenProvider extends StatelessWidget {
  const CommandScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommandsBloc()
        ..getVisitByDate()
        ..getGrossiste()
        ..getListOfCommands(),
      child: const CommandScreen(),
    );
  }
}

class CommandScreen extends StatefulWidget {
  const CommandScreen({super.key});

  @override
  State<CommandScreen> createState() => _CommandScreenState();
}

class _CommandScreenState extends State<CommandScreen> {
  List<Map<String, dynamic>> clients = [];
  List<Map<String, dynamic>> grossiste = [];
  Map<String, dynamic> visitPlanToday = {};
  List<Command> listCommands = [];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations(currentLanguage);

    return BlocConsumer<CommandsBloc, CommandsState>(
      listener: (BuildContext context, CommandsState state) {
        if (state is ListCliensState) {
          clients = state.list;
        }
        if (state is ListGrossitesState) {
          grossiste = state.list;
        }
        if (state is VisitPlanTodayState) {
          visitPlanToday = state.data;
        }
        if (state is CommandCreatedSuccessState) {
          Navigator.of(context, rootNavigator: true).pop();
          if (state.isSampleCommand == false) {
            GoRouter.of(context).push('/commandLine/${state.commandId}');
          }
        }
        if (state is ListCommandsState) {
          listCommands = state.list;
        }
      },
      builder: (context, state) {
        final cubit = context.read<CommandsBloc>();

        return Scaffold(
          appBar: AppBar(
            title: Text(t.text('orders')),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildVisitInfoCard(visitPlanToday, t, context, cubit),
                      const SizedBox(height: 10),
                      Expanded(
                        child: SingleChildScrollView(
                          child: AccordionCommandComponent(accordionSections: listCommands),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (listCommands.isNotEmpty)
                _buildDeleteAllFooter(context, cubit, t),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVisitInfoCard(
      Map<String, dynamic> visitPlanToday,
      AppLocalizations t,
      BuildContext context,
      CommandsBloc cubit,
      ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildChip(
                    icon: Icons.location_on,
                    label: t.text('region'),
                    value: visitPlanToday['regionName'] ?? '',
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 20),
                  _buildChip(
                    icon: Icons.calendar_today,
                    label: t.text('date'),
                    value: visitPlanToday['visitDate'] ?? '',
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _buildChip(
                icon: Icons.supervised_user_circle,
                label: t.text('responsable'),
                value: visitPlanToday['responsibleName'] ?? '',
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _showCommandFormDialog(
                context,
                cubit,
                clients,
                grossiste,
                visitPlanToday,
              ),
              icon: const Icon(Icons.add),
              label: Text(t.text('create_new_command')),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteAllFooter(
      BuildContext context,
      CommandsBloc cubit,
      AppLocalizations t,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _showDeleteAllConfirmation(context, cubit, t),
            icon: const Icon(Icons.delete_sweep),
            label: Text(t.text('delete_all_commands')),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildChip({
  required IconData icon,
  required String label,
  required String value,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

void _showDeleteAllConfirmation(
    BuildContext context,
    CommandsBloc cubit,
    AppLocalizations t,
    ) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) => AlertDialog(
      title: Row(
        children: [
          Icon(Icons.warning, color: Colors.orange[700]),
          const SizedBox(width: 10),
          Expanded(child: Text(t.text('confirm_deletion'))),
        ],
      ),
      content: Text(
        t.text('confirm_message'),
        style: const TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(t.text('cancel')),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.of(dialogContext).pop();
            await cubit.deleteAllCommands();
            await cubit.deleteAllCommandLines();
            cubit.getListOfCommands();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: Text(t.text('ok')),
        ),
      ],
    ),
  );
}

void _showCommandFormDialog(
    BuildContext context,
    CommandsBloc cubit,
    List<Map<String, dynamic>> clients,
    List<Map<String, dynamic>> grossiste,
    Map<String, dynamic> visitPlanToday,
    ) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) => BlocProvider.value(
      value: cubit,
      child: CommandFormDialog(
        clients: clients,
        grossiste: grossiste,
        visitPlanToday: visitPlanToday,
        cubit: cubit,
      ),
    ),
  );
}

class CommandFormDialog extends StatefulWidget {
  final List<Map<String, dynamic>> clients;
  final List<Map<String, dynamic>> grossiste;
  final Map<String, dynamic> visitPlanToday;
  final CommandsBloc cubit;

  const CommandFormDialog({
    super.key,
    required this.clients,
    required this.grossiste,
    required this.visitPlanToday,
    required this.cubit,
  });

  @override
  State<CommandFormDialog> createState() => _CommandFormDialogState();
}

class _CommandFormDialogState extends State<CommandFormDialog> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic>? selectedClient;
  List<Map<String, dynamic>> selectedGrossistes = [];
  final TextEditingController descriptionController = TextEditingController();
  bool createWithoutCommandLines = false;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations(currentLanguage);

    return BlocBuilder<CommandsBloc, CommandsState>(
      builder: (context, state) {
        final isCreating = state is CommandCreatingState;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDialogHeader(context, t),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildClientAutocomplete(t),
                          const SizedBox(height: 20),
                          if (!createWithoutCommandLines) ...[
                            _buildGrossisteSelector(t),
                            if (selectedGrossistes.isEmpty)
                              _buildGrossisteError(t),
                            const SizedBox(height: 20),
                          ],
                          _buildDescriptionField(t),
                          const SizedBox(height: 20),
                          _buildSimpleModeSwitch(t),
                          const SizedBox(height: 20),
                          defaultButton(
                            function: isCreating ? null : _submitForm,
                            text: isCreating
                                ? t.text('creating')
                                : t.text('create_command'),
                          ),
                          if (isCreating)
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogHeader(BuildContext context, AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.add_shopping_cart, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              t.text('create_new_command'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildClientAutocomplete(AppLocalizations t) {
    return EasyAutocomplete(
      suggestions: widget.clients
          .map((client) => client['label'].toString())
          .toList(),
      onChanged: (value) {},
      onSubmitted: (value) {
        final selectedUser = widget.clients.firstWhere(
              (client) => client['label'] == value,
          orElse: () => {},
        );
        if (selectedUser.isNotEmpty) {
          setState(() {
            selectedClient = selectedUser;
          });
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty || selectedClient == null) {
          return t.text('please_select_client');
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: t.text('clients'),
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }

  Widget _buildGrossisteSelector(AppLocalizations t) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: MultiSelectBottomSheetField(
          initialChildSize: 0.4,
          listType: MultiSelectListType.CHIP,
          searchable: true,
          buttonText: Text(
            t.text('grossiste'),
            style: const TextStyle(fontSize: 16),
          ),
          title: Text(
            t.text('grossiste'),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          items: widget.grossiste
              .map((item) => MultiSelectItem(item, item['label']))
              .toList(),
          initialValue: const [],
          onConfirm: (values) {
            setState(() {
              selectedGrossistes = List<Map<String, dynamic>>.from(values);
            });
          },
          chipDisplay: MultiSelectChipDisplay(
            onTap: (value) {
              setState(() {
                selectedGrossistes.remove(value);
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildGrossisteError(AppLocalizations t) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          t.text('please_select_grossiste'),
          style: const TextStyle(color: Colors.red, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildDescriptionField(AppLocalizations t) {
    return TextFormField(
      controller: descriptionController,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: t.text('description'),
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildSimpleModeSwitch(AppLocalizations t) {
    return SwitchListTile(
      title: Text(t.text('check-in-only')),
      value: createWithoutCommandLines,
      onChanged: (value) {
        setState(() {
          createWithoutCommandLines = value;
          if (value) {
            selectedGrossistes.clear();
          }
        });
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      if (!createWithoutCommandLines && selectedGrossistes.isEmpty) {
        final t = AppLocalizations(currentLanguage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.text('please_select_grossiste')),
          ),
        );
        return;
      }

      widget.cubit.createCommand(
        context: context,
        client: selectedClient,
        grossistes: selectedGrossistes,
        visitPlan: widget.visitPlanToday,
        simpleCreation: createWithoutCommandLines,
        description: descriptionController.text,
      );
    }
  }
}