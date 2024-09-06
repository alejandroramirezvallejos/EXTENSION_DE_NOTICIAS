# Relación entre la extensión de noticias digitales y los cambios en los hábitos de lectura actuales
## Tema
Estimar y comparar el promedio de letras por noticias digitales (periódicos) de Bolivia, analizando específicamente las noticias periodísticas de los domingos desde 2010 hasta 2024.
## Preguntas de Interés
¿Se han adaptado los periódicos digitales a los hábitos de lectura de la generación actual?
¿Ha disminuido la cantidad de palabras en una publicación periodística digital entre el 3 de enero de 2010 y el 7 de enero de 2024?
## Variables
Variables cuantitativas: cantidad de palabras
Variables categóricas: año de la emisión de la noticia digital (periódico), URL de la noticia digital, nombre del periódico emisor de la noticia.
## Población
Noticias digitales publicadas los días domingo entre los años 2010 y 2024.
## Muestra
Muestreo aleatorio simple: En nuestra investigación, seleccionaremos al azar domingos cada dos años, entre 2010 y 2024. Del número total de domingos en cada período bianual, se elegirá aleatoriamente un número que representará un domingo específico. Por ejemplo, si en el período 2010-2012 se elige aleatoriamente el número 2, se tomará el segundo domingo del número total de domingos. Repetiremos este proceso hasta alcanzar el 30% del total de domingos en cada período bianual. Para cada domingo seleccionado, analizaremos 4 noticias escogidas al azar. 
## Marco Muestral
Nuestro objetivo es analizar si el número de letras por publicación digital ha aumentado o disminuido a lo largo de los años, para evaluar si los periódicos digitales se han adaptado a los hábitos de lectura de la generación actual a lo largo de los años.
## Tecnología
Se utilizará C++ como base para la extracción de letras de cada noticia digital. Además, se lo utilizara para organizar los datos en formato .csv directamente del archivo en crudo post corrección de errores. Por otro lado, se empleará R para la creación de gráficos y el muestreo de datos.
## ¿Por qué ese tipo de estudio es apropiado?
Nuestra pregunta de interés es “¿Se han adaptado los periódicos digitales a los hábitos de lectura de la generación actual?”. Para poder realizar dicho análisis y generar un estudio representativo, necesitamos considerar la longitud de las noticias periodísticas.
Sabiendo esto, consideramos que la unidad apropiada para en análisis estadístico es la letra. Esto debido a que es la unidad mínima de escritura y proporcionara mayor exactitud y representatividad para la pregunta de interés.
Además, optamos por el muestreo aleatorio simple como técnica de muestreo. Ya que procederemos con la elección aleatoria de domingo y luego obtendremos 4 noticias de cada domingo aleatoriamente. Esto nos garantizará una muestra sin sesgo y tendrá representatividad de la población.
## Precauciones para tomar en cuenta
•	Si en un domingo seleccionado al azar no hay 4 noticias disponibles para el análisis, se elegirá otro domingo aleatoriamente.
•	Para el análisis estadístico solo consideraremos la sección del conjunto de información sobre la noticia, omitiendo así partes de las noticias como los derechos de autor, publicidad, y todo lo que los usuarios no leerían con relación a la noticia.
