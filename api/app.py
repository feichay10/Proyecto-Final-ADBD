import os
import psycopg2
from flask import Flask, render_template, request, url_for, redirect, current_app

app = Flask(__name__)


def get_db_connection():
    conn = psycopg2.connect(host='127.0.0.1',
                            database="islas_canarias",
                            user="postgres",
                            password="tibYDKQ8")
    return conn


@app.route('/')
def index():
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('SELECT i.nombre AS isla, dp.capital, array_agg(dp.municipio) AS municipios, MIN(dp.poblacion) AS poblacion '
                    'FROM distribucion_poblacional dp '
                    'JOIN isla i ON dp.isla_id = i.id_isla '
                    'GROUP BY i.nombre, dp.capital;')
        island = cur.fetchall()
        cur.close()
        conn.close()
        return render_template('index.html', islands=island)
    except Exception as e:
        current_app.logger.error(f"Error at the data base consultation: {e}")
        return render_template('error.html', error_type=type(e).__name__, error_message=str(e)), 500


@app.route('/view_animals/', methods=['GET'])
def view_animals():
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('SELECT sv.nombre, sv.nombre_cientifico, aa.invasoras, aa.dieta, aa.foto '
                    'FROM animales_autoctonos aa '
                    'JOIN seres_vivos sv ON aa.ser_vivo_id = sv.id_seres_vivos;')
        animals = cur.fetchall()
        cur.close()
        conn.close()
        return render_template('view_animals.html', animals=animals)
    except Exception as e:
        current_app.logger.error(f"Error at the data base consultation: {e}")
        return render_template('error.html', error_type=type(e).__name__, error_message=str(e)), 500


@app.route('/insert_animals/', methods=['GET', 'POST'])
def insert_animals():
    try:
        if request.method == 'POST':
            nombre = request.form['nombre']
            nombre_cientifico = request.form['nombre_cientifico']
            tipo = request.form['tipo']

            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute('INSERT INTO seres_vivos (nombre, nombre_cientifico, tipo) VALUES (%s, %s, %s);',
                        (nombre, nombre_cientifico, tipo))
            conn.commit()
            cur.close()
            conn.close()
            return redirect(url_for('update_animals'))
        else:
            return render_template('insert_animals.html')
    except Exception as e:
        current_app.logger.error(f"Error at the data base consultation: {e}")
        return render_template('error.html', error_type=type(e).__name__, error_message=str(e)), 500


@app.route('/update_animals/', methods=('GET', 'POST'))
def update_animals():
    try:
        if request.method == 'POST':
            nombre = request.form['nombre']
            isla = request.form['isla']
            invasoras = request.form['invasoras']
            dieta = request.form['dieta']

            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute('UPDATE animales_autoctonos '
                        'SET isla_id = (SELECT id_isla FROM isla WHERE nombre = %s), invasoras = %s, dieta = %s, foto = NULL '
                        'WHERE ser_vivo_id = (SELECT id_seres_vivos FROM seres_vivos WHERE nombre = %s);',
                        (isla, invasoras, dieta, nombre))
            conn.commit()
            cur.close()
            conn.close()
            return redirect(url_for('view_animals'))
        else:
            return render_template('update_animals.html')
    except Exception as e:
        current_app.logger.error(f"Error at the data base consultation: {e}")
        return render_template('error.html', error_type=type(e).__name__, error_message=str(e)), 500


@app.route('/delete_animals/', methods=('GET', 'POST'))
def delete_animals():
    try:
        if request.method == 'POST':
            nombre = request.form['nombre']

            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute('DELETE FROM seres_vivos WHERE nombre = %s;', (nombre,))
            conn.commit()
            cur.close()
            conn.close()
            return redirect(url_for('view_animals'))
        else:
            return render_template('delete_animals.html')
    except Exception as e:
        current_app.logger.error(f"Error at the data base consultation: {e}")
        return render_template('error.html', error_type=type(e).__name__, error_message=str(e)), 500


@app.route('/about/', methods=('GET', 'POST'))
def about():
    return render_template('about.html')


if __name__ == '_main_':
    app.run(host='0.0.0.0', port=8080, debug=True)