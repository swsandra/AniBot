Integrantes:
    Aurivan Castro  14-10205
    Sandra Vera     14-11130

	En cuanto a la implementación de los predicados, para cumplir los requerimientos
de evaluación del proyecto se crearon los predicados para filtrar animes filtrarGenero, 
filtrarRate y filtrarPop. Los tres tienen como parámetros el elemento por el cual se 
va a filtrar (género, número de rating o rango de popularidad respectivamente), la lista 
de animes a filtrar y la lista de retorno. En el caso base de cada predicado, se
comprueba que el elemento por el cual se va a filtrar está en el dominio correspondiente,
es decir que el género existe, el rating está entre 1 y 5 y la popularidad está entre 1 y 10.

	Por otra parte, para ordenar los animes por popularidad y rating (predicados ordPop y 
ordRate) se implementó el algoritmo de ordenamiento insertion sort. Para dichos predicados, 
se tienen como parámetros la lista que se desea ordenar y la lista de retorno. En ambos 
casos se definieron predicados auxiliares para insertar en las listas en la posición correcta 
(insertRate e insertPop) con parámetros que corresponden al anime a insertar en la lista, la 
lista sobre la cual se realiza el ordenamiento y la lista de retorno.

	Para agregar un anime nuevo se definieron dos predicados, agregarConPop y agregarSinPop, 
dependiendo de si se quiere agregar con popularidad o no respectivamente. Si se desea 
agregar un anime con popularidad, se tienen como parámetros el nombre del anime, el rating, 
una lista de géneros y la popularidad. Si se desea agregar un anime sin popularidad, se omite
el parámetro correspondiente a la popularidad. En estos dos últimos predicados se comprueba
que el anime a añadir no esté en la base de conocimientos, que el número correspondiente al 
rating esté entre 1 y 5 y,en caso de que se agregue con popularidad, que la popularidad esté 
entre 1 y 10. Además, para los géneros se emplea el predicado auxiliar agregarGeneros, que 
revisa si un género se encuentra en la lista de géneros y de no ser el caso lo agrega a 
la lista.