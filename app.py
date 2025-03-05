from flask import Flask, render_template, request, jsonify, g
from flask_babel import Babel, gettext as _
import logging

app = Flask(__name__)

# Configurer le logging
logging.basicConfig(level=logging.DEBUG)

# Configurer Flask-Babel
app.config['BABEL_DEFAULT_LOCALE'] = 'fr'
babel = Babel(app)

@babel.localeselector
def get_locale():
    # Vous pouvez utiliser la fonction request.accept_languages pour détecter la langue préférée de l'utilisateur
    return request.accept_languages.best_match(['fr', 'en', 'de'])

@app.route('/')
def index():
    app.logger.debug(f"Rendu de la page d'accueil en {get_locale()}")
    return render_template('index.html')

@app.route('/contact', methods=['POST'])
def contact():
    data = request.get_json()
    name = data.get('name')
    email = data.get('email')
    message = data.get('message')
    app.logger.debug(f"Reçu les données du formulaire - Nom: {name}, Email: {email}, Message: {message}")
    # Ici, vous pouvez ajouter la logique pour sauvegarder les données de contact ou envoyer un email
    # Utiliser gettext pour traduire le message de réponse
    return jsonify({'status': 'success', 'message': _('Merci pour votre message !')})

if __name__ == "__main__":
    app.logger.debug('Lancement de l\'application Flask')
    app.run(debug=True)
