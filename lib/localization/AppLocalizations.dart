class AppLocalizations {
  final String languageCode;

  AppLocalizations(this.languageCode);

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'welcome_back': 'Welcome Back',
      'home': 'Home',
      'visits': 'Visits',
      'sync_data': 'Sync data',
      'command': 'Command',
      'sign_in_to_continue': 'Sign in to continue',
      'username': 'Username',
      'enter_username': 'Enter your username',
      'password': 'Password',
      'enter_password': 'Enter your password',
      'password_too_short': 'Password must be at least 6 characters',
      'login': 'Login',
      'please_enter_username': 'Please enter your username',
      'please_enter_password': 'Please enter your password',
      'create_new_command': 'Create Command',
      'delete_all_commands': 'Delete all orders',
      'confirm_message': 'Are you sure you want to delete all orders? This action cannot be undone.',
      'confirm_deletion': 'Confirm Deletion',
      'cancel': 'Cancel',
      'check-in-only': 'Check-in only',
      'visitor': 'Visitor',
      'responsible': 'Responsible',
      'visit_date': 'Visit Date',
      'status': 'Status',
      'create_new_stock': 'Create Stock',
      'stock_line': 'Stock line',
      'command_line': 'Command Lines',
      'add_line_product': 'Add line product',
      'add_stock_line': 'Add Stock Line',
    },
    'fr': {
      'welcome_back': 'Bienvenue',
      'home': 'Accueil',
      'visits': 'Visites',
      'sign_in_to_continue': 'Connectez-vous pour continuer',
      'sync_data': 'Sync données',
      'username': 'Nom d’utilisateur',
      'enter_username': 'Entrez votre nom d’utilisateur',
      'password': 'Mot de passe',
      'enter_password': 'Entrez votre mot de passe',
      'password_too_short': 'Le mot de passe doit comporter au moins 6 caractères',
      'login': 'Se connecter',
      'please_enter_username': 'Veuillez saisir votre nom d’utilisateur',
      'please_enter_password': 'Veuillez saisir votre mot de passe',
      'create_new_command': 'Créer commande',
      'delete_all_commands': 'Supprimer toutes les orders',
      'confirm_message': 'Êtes-vous sûr de vouloir supprimer toutes les commandes ? Cette action est irréversible.',
      'confirm_deletion': 'Confirmer la suppression',
      'cancel': 'Annuler',
      'check-in-only': 'Pointage uniquement',
      'visitor': 'Visiteur',
      'responsible': 'Responsable',
      'visit_date': 'Date de visite',
      'status': 'Statut',
      'create_new_stock': 'Créer Stock',
      'stock_line': 'Lignes de Stock',
      'command_line': 'Lignes de commande',
      'add_line_product': 'Ajouter une ligne de produit',
      'add_stock_line': 'Ajouter une ligne de stock',
    },
  };

  String text(String key) {
    return _localizedValues[languageCode]?[key] ??
        _localizedValues['en']![key] ??
        key;
  }
}
