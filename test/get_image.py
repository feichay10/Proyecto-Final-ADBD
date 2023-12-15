import psycopg2

# Conexión a la base de datos
conn = psycopg2.connect(database="prueba", user="postgres", password="clave", host="localhost")
cursor = conn.cursor()

# Recuperar la imagen de la base de datos
cursor.execute("SELECT contenido FROM imagenes WHERE nombre = %s", ("teide",))
result = cursor.fetchone()

if result is not None:
    contenido_imagen = result[0]

    # Guardar el contenido en un archivo
    with open("imagen_recuperada.jpg", "wb") as f:
        f.write(contenido_imagen)
else:
    print("No se encontró ninguna imagen con el nombre especificado.")

# Cerrar la conexión
cursor.close()
conn.close()
