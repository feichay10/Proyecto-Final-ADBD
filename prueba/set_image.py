import psycopg2
from psycopg2 import sql

# Conexión a la base de datos
conn = psycopg2.connect(database="prueba", user="postgres", password="clave", host="localhost")
cursor = conn.cursor()

# Leer el contenido binario de la imagen
with open("../img/sitios-interes/teide.jpg", "rb") as f:
    contenido_imagen = f.read()

# Insertar la imagen en la base de datos
cursor.execute(sql.SQL("INSERT INTO imagenes (nombre, contenido) VALUES (%s, %s)"),
               ("teide", psycopg2.Binary(contenido_imagen)))

# Confirmar la transacción y cerrar la conexión
conn.commit()
cursor.close()
conn.close()
