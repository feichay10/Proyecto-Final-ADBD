import psycopg2
from flask import Flask, render_template, request, url_for, redirect

app = Flask(__name__)


def get_db_connection():
    conn = psycopg2.connect(host='localhost',
                            database="islas_canarias",
                            user="postgres",
                            password="clave")
    return conn


@app.route('/')
def index():
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


@app.route('/view_animals/', methods=('GET', 'POST'))
def view_animals():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute('')
    animals = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('view_animals.html', animals=animals)


@app.route('/insert/', methods=('GET', 'POST'))
def insert():
    if request.method == 'POST':
        ser_vivo_id = request.form['name']
        isla_id = request.form['id_isla']
        invasoras = request.form['invasoras']
        dieta = request.form['dieta']
        foto = request.form['foto']

        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto)'
                    'VALUES (%s, %s, %s, %s)',
                    (ser_vivo_id, isla_id, invasoras, dieta, foto))
        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for('view_animals'))

    return render_template('insert.html')


@app.route('/about/', methods=('GET', 'POST'))
def about():
    return render_template('about.html')


if __name__ == '_main_':
    app.run(host='0.0.0.0', port=8080, debug=True)
