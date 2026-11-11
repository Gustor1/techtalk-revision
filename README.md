# TechTalk Révision

Application personnelle de révision du final écrit d’anglais : 402 exercices, corrections en français, entraînement par unité ou par notion, reprise des erreurs et final blanc.

Programme : Tech Talk unités 1–15, 19–21, dix notions de grammaire et compléments du cours. Les exercices sont rédigés pour cette application. Le manuel, ses images et les documents du cours ne sont pas distribués dans ce dépôt.

Ouvrir index.html pour une utilisation locale. Publication statique sur GitHub Pages depuis main à la racine.

La progression locale est stockée par navigateur ; export/import disponibles dans Progression.

Développement : npm ci puis npm test. Aucun outil de développement n’est nécessaire pour utiliser le site.

## Site et synchronisation


Le bouton Synchroniser permet de créer un compte, de confirmer son adresse, puis de se connecter sur chaque appareil. La base Supabase dédiée TechTalk Revision utilise les règles RLS pour limiter chaque utilisateur à ses événements. Seule la clé publiable est incluse dans le client.

Les réponses sont des événements immuables identifiés par UUID. Les envois répétés ne créent pas de doublons. Le client fusionne les événements des appareils ; une file persistante attend le retour du réseau. Les remises à zéro et imports sont des événements de remplacement explicites. Une déconnexion conserve les envois en attente dans la file propre au compte. Les dates des appareils règlent l’ordre des réponses concurrentes, avec un ordre local monotone après observation des événements distants.

La page doit avoir été ouverte avant une coupure pour continuer la révision ; il n’y a pas de cache complet permettant de rouvrir le site hors ligne.

Pour reprendre la progression de l’ancienne version locale : Progression > Exporter dans l’ancienne version, puis se connecter au site et utiliser Progression > Importer. L’import remplace la progression du compte, sur tous les appareils.

## Validation de la publication

Tests du contenu et des parcours de révision, et synchronisation testée dans deux contextes navigateur avec un serveur simulé : fusion, coupure réseau, rechargement, réessais sans doublon et propagation de la remise à zéro. Sur la vraie base : accès anonyme refusé, isolation des lignes entre deux utilisateurs vérifiée dans une transaction annulée, aucun avis de sécurité Supabase. L’inscription par e-mail et la connexion du propriétaire doivent être effectuées par celui-ci ; elles n’ont pas été validées avec ses identifiants.
