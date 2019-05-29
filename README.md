# Proyecto #2: Laboratorio de Lenguajes de Programación I
## AniBot

> AniBot es un bot algo obtuso que te recomendará anime... en la medida de sus posibilidades,
claro está.

AniBot nació como un bot destinado a recomendar series anime al usuario con sólo interactuar con él. Se trata de un programa escrito en Prolog y diseñado para reconocer un subconjunto limitado de lenguaje natural, sin modismos. No es empleada ninguna librería, el proyecto fue diseñado y desarrollado en su totalidad por el equipo de trabajo.

AniBot fue continuamente actualizado hasta que empezó a ser capaz de aprender nuevas frases del usuario, dado un entorno muy específico. Además, puede realizar las siguientes tareas:

* Listar series, películas, o contenido anime con sólo indicarle un género.

* Retornar la lista de contenido anime con un rating o popularidad específico, o ambos. Por ejemplo: retornar los anime poco conocidos de 5 estrellas.

* Indicar los datos de una serie/pelicula/contenido anime que pregunte el usuario.

* Aprender nuevas frases, tópicos, géneros y anime de no conocerlos, con los datos suministrados por el usuario.

* Subir la popularidad de un anime cuando los usuarios pregunten al menos 5 veces por el mismo.

Otros detalles pueden encontrarse en este archivo README y en el [enunciado del proyecto](https://github.com/swsandra/AniBot/blob/master/proyecto2_prolog.pdf)

### Autores:

* Aurivan Castro (14-10205@usb.ve)
* Sandra Vera (14-11130@usb.ve)

### Versión

* 1.1 - Noviembre, 2018.

## Ejecución

En el intérprete, para iniciar, primero cargar los predicados, y luego colocar:

```Prolog
?- init.
```

Para detener el bot, introduzca:

```Prolog
|: keyword
```

donde keyword está en la lista `["chao","adios","bye","halt"]`.

El bot pedirá confirmación dos veces, y las dos veces tendrá que confirmar con "si", de lo contrario el bot creerá que quiere que continuen hablando.

## De la implementación

### Acerca de los predicados

En cuanto a la implementación de los predicados, para cumplir los requerimientos de evaluación del proyecto se crearon los predicados para filtrar animes:`filtrarGenero`, `filtrarRate` y `filtrarPop`. Los tres tienen como parámetros el elemento por el cual se va a filtrar (género, número de rating o rango de popularidad respectivamente), la lista de animes a filtrar y la lista de retorno. En el caso base de cada predicado, se comprueba que el elemento por el cual se va a filtrar está en el dominio correspondiente,es decir que el género existe, el rating está entre 1 y 5 y la popularidad está entre 1 y 10.

Por otra parte, para ordenar los animes por popularidad y rating (predicados `ordPop` y `ordRate`) se implementó el algoritmo de ordenamiento *insertion sort*. Para dichos predicados, se tienen como parámetros la lista que se desea ordenar y la lista de retorno. En ambos casos se definieron predicados auxiliares para insertar en las listas en la posición correcta (`insertRate` e `insertPop`) con parámetros que corresponden al anime a insertar en la lista, la lista sobre la cual se realiza el ordenamiento y la lista de retorno.

Para agregar un anime nuevo se definieron dos predicados, `agregarConPop` y `agregarSinPop`, dependiendo de si se quiere agregar con popularidad o no respectivamente. Si se desea agregar un anime con popularidad, se tienen como parámetros el nombre del anime, el rating, una lista de géneros y la popularidad. Si se desea agregar un anime sin popularidad, se omite el parámetro correspondiente a la popularidad. En estos dos últimos predicados se comprueba que el anime a añadir no esté en la base de conocimientos, que el número correspondiente al rating esté entre 1 y 5 y,en caso de que se agregue con popularidad, que la popularidad esté entre 1 y 10. Además, para los géneros se emplea el predicado auxiliar `agregarGeneros`, que revisa si un género se encuentra en la lista de géneros y de no ser el caso lo agrega a la lista.

### Acerca del chatbot

En general, el chatbot puede reconocer un conjunto de frases. Se dividieron los predicados en secciones, de manera que todo esté separado. Se presentan las siguientes secciones:

1. Predicados de inicio, parada y loop del chatbot.
2. Evaluación de input. Toma un input y según eso decide como procesarlo.
3. Redirección a alguna funcionalidad, contiene predicados que realizan acciones según lo decidido.
4. Otros predicados no incluidos arriba pero usados en alguna parte del programa.
5. Mensajes, o colección de mensajes de respuesta del chatbot.

Al recibir el input, no se requiere que se coloque entre comillas. Basta con presionar enter y el chatbot tomará la lista suministrada, gracias al uso del predicado built-in `readln`.

#### Para listar anime según su popularidad o rating

El bot es capaz de reconocer palabras como "conocido" para filtrar popularidad, y otras como "rating","estrellas",etc., aún cuando éstas estén en oraciones más complejas. Esto podría llevar a que oraciones sin sentido como `4 dame dos estrellas` imprima la lista de los anime con 4 estrellas, pues sólo toma el número de entre todas las palabras dadas junto con "estrellas".

Para la popularidad no ocurre lo mismo, pues están bien determinados los substrings que debe contener la oración, y cuando aprende nuevas palabras parecidas, el bot las agrupa en conjuntos con significados similares gracias al apoyo del usuario.

#### Para listar anime de un genero, o preguntar por una serie/película/contenido anime

En este caso, se colocan ambas funcionalidades en la misma explicación porque el input es parecido. El formato, aunque flexible, de cómo el bot reconoce las tareas, es el siguiente:

```Prolog
|: palabraClave word1 word2 word3 ...
```

donde "palabraClase" está en la lista extendible:

`["sabes","conoces","reconoces","conoce","reconoce","sabe","quiero","ves","veo","dame"]`

Por lo tanto, para retornar una lista del genero X tendría que darse input parecido a `sabes X` (sólo toma la primera palabra como género) y para preguntar por un anime algo como `sabes X1 X2 X3` donde nombre de anime será la concatenación de todos los Xi. En el caso de ser un género o un anime desconocido, se redirecciona al mensaje por defecto de error.

Esta funcionalidad es case-sensitive. Por ejemplo, si el usuario pregunta por "death note", se redirigirá a fail aún cuando "Death Note" esté en la lista del bot. Los mismo para los géneros.


#### Acerca del ordenamiento

Por cuestiones de tiempo, no pudieron integrarse la funcionalidad de ordenar dado un rating/popularidad al bot, a pesar de haberse implementado los predicados. La forma de probar esta funcionalidad es utilizar los predicados `ordRat` y `ordPop`. (Dirigirse a los mismos en el código para informacion acerca de los parámetros).


#### Agregar anime

En este caso, el formato es:

```Prolog
|: palabraClave word1 word2 word3 ...
```

donde `palabraClase` está en la lista: `["agregar","incluir","add"]`.

Se tomará como nombre de anime la concatenación de todos los word(i). Si el anime ya existe, se redirige al fail. De lo contrario, se piden los datos correspondientes. El orden para dar la informacion es especificado por el bot en el momento de la ejecución. Si se viola tal orden entonces redirige al fail. De lo contrario, lo agrega y da un mensaje de éxito correspondiente.

Para verificar que se agregó el ánime, basta con preguntar por el mismo como se especificó arriba, y se mostrarán inclusive los detalles (rating, popularidad, género). Es importante al momento de preguntar, recordar que esa funcionalidad es case-sensitive, por lo que aún si se agregó el anime "Monogatari", si pregunto por "monogatari" puede fallar.
