%  !! LISTA DE PREDICADOS ANIME Y GENERO DADOS CON EL ENUNCIADO !!


anime(X) :- member(X,["Dragon Ball", "Naruto", "Bleach", "HunterXHunter", "Hamtaro", "Full Metal Alchemist", "Attack on Titan",
					"Neon Genesis Evangelion", "Elfen Lied", "Inuyasha", "Blue Exorcist","No Game No Life","Steins;Gate",
					"Tokyo Ghoul","One Piece","Death Note"]).

genero(X) :- member(X,["Aventura", "Shoujo", "Shounen", "Kodomo", "Seinen", "Josei", "Ficción",
                    "Fantasía", "Mecha", "Sobrenatural", "Magia", "Gore", "Thriller", "Acción", "Horror",
                    "Misterio","Comedia","Psicológico"]).

% Anime dado por el enunciado
generoAnime("Naruto",["Shounen","Aventura"]).
generoAnime("Dragon Ball",["Shounen"]).
generoAnime("Bleach",["Shounen", "Sobrenatural"]).
generoAnime("HunterXHunter",["Seinen", "Aventura"]).
generoAnime("Hamtaro",["Kodomo"]).
generoAnime("Full Metal Alchemist",["Shounen", "Magia"]).

% Anime dado por el equipo de trabajo
generoAnime("Attack on Titan",["Seinen", "Aventura"]).
generoAnime("Neon Genesis Evangelion",["Seinen", "Mecha"]).
generoAnime("Elfen Lied",["Ficción", "Gore"]).
generoAnime("Inuyasha",["Shoujo", "Aventura", "Fantasía"]).
generoAnime("Blue Exorcist",["Aventura", "Fantasía"]).
generoAnime("No Game No Life",["Ficción", "Fantasía"]).
generoAnime("Steins;Gate",["Ficción", "Thriller"]).
generoAnime("Tokyo Ghoul",["Acción", "Sobrenatural","Horror","Misterio","Seinen"]).
generoAnime("One Piece",["Acción", "Aventura","Comedia","Shounen","Fantasía"]).
generoAnime("Death Note",["Misterio", "Sobrenatural","Thriller","Shounen","Psicológico"]).

% Rating del anime dado por el enunciado
rating("Dragon Ball",3).
rating("Naruto",1).
rating("Bleach",4).
rating("HunterXHunter",5).
rating("Hamtaro",2).
rating("Full Metal Alchemist",4).

% Rating del anime dado por el equipo de trabajo
rating("Attack on Titan",5).
rating("Neon Genesis Evangelion",4).
rating("Elfen Lied",3).
rating("Inuyasha",4).
rating("Blue Exorcist",2).
rating("No Game No Life",4).
rating("Steins;Gate",5).
rating("Tokyo Ghoul",4).
rating("One Piece",4).
rating("Death Note",4).


% Popularidad del anime dado por el enunciado
popularidad("Dragon Ball",7).
popularidad("Naruto",5).
popularidad("Bleach",8).
popularidad("HunterXHunter",3).
popularidad("Hamtaro",10).
popularidad("Full Metal Alchemist",1).

% Popularidad del anime dado por el equipo de trabajo
popularidad("Attack on Titan",10).
popularidad("Neon Genesis Evangelion",6).
popularidad("Elfen Lied",4).
popularidad("Inuyasha",9).
popularidad("Blue Exorcist",2).
popularidad("No Game No Life",8).
popularidad("Steins;Gate",8).
popularidad("Tokyo Ghoul",10).
popularidad("One Piece",9).
popularidad("Death Note",10).







%  !! INICIO DEL CHATBOT !!



%%% ----- Predicados de inicio y parada
init :- chatbot("Init").
stop :- chatbot("Stop").



%%% ----- Predicado loop del chatbot
chatbot("Init") :- sayHello, chatbot("Continue").
chatbot("Continue") :- readln(X),convertAtomListToStr(X,S),evaluateUserInput(S).
chatbot("Stop").



%%% ----- Evaluacion de Input

% == Lista de palabras clave para el chatbot con sus Predicados
%%		keywords recibe X (palabra a buscar) y dependiendo de en que lista se
%%		encuentre, retorna un átomo en particular, que señala la operación a hacer.
keywords(X,searchSmth) :- member(X, ["sabes","conoces","reconoces","conoce","reconoce","sabe","quiero","ves",
										"veo","dame"]).
keywords(X,searchAnimeOrGenre) :- member(X, ["anime","animé","genero","género"]).
keywords(X,searchRating) :- member(X,["rating","interesante","bueno","malo"]).
keywords(X,add) :- member(X,["agregar","incluir","add"]).
keywords(X,bye) :- member(X,["chao","adios","bye","halt"]).

% == Funcion para encontrar la primera palabra clave
getKeywords([X|XS],Result,XS) :- keywords(X,Result),!.
getKeywords([_|XS],Result,Z) :- getKeywords(XS,Result,Z).

% == Funcion principal
%%		Recibe L (lista de atoms conseguida el input) y la recorre para encontrar
%%		palabras clave, y redirigir a alguna accion (primer predicado) o al
%%		predicado que muestre el mensaje correspondiente a no entender el input.
evaluateUserInput(L) :- getKeywords(L,P,RestOfList),
						processOtherKeys(RestOfList,Tuple),
						redirect(P,Tuple).
evaluateUserInput(L) :- dontKnow(L), red_continue.


% == Evaluación y respuesta
processOtherKeys([],_).
processOtherKeys([Mx|RestOfList],Result) :- string_lower(Mx,M),keywords(M,searchAnimeOrGenre),
											convertStrListToStr(RestOfList, A),
											append([M],[A],Result),!.
processOtherKeys([_|RestOfList],Result) :- processOtherKeys(RestOfList,Result).


% == Redireccion a alguna funcionalidad
%%		Reciben la accion a realizar, y el input restante luego de la palabra clave.
%%%%% 		Para reconocer anime o, en caso contrario, redireccionar a agregar.
redirect(searchSmth,[Word|M]) :- (Word=="anime";Word=="animé"),
									concatStrListUpperFstLetter(M,X),
									anime(X), rating(X,Rat),
									popularidad(X,PopNum),giveStrPopularity(PopNum,Pop),
									iKnowIt(X,Rat,Pop),red_continue.
redirect(searchSmth,[Word|M]) :- (Word=="anime";Word=="animé"),
									concatStrListUpperFstLetter(M,X),
									\+(anime(X)),
									dontKnowAnime(X),redirect(addAnime,[]).
%%%%% 		Para reconocer genero o, en caso contrario, agregar.
redirect(searchSmth,[Word|X]) :- (Word=="genero";Word=="género"),
									concatStrListUpperFstLetter(X,M), genero(M),
									iKnowItGenre(M),red_continue.
redirect(searchSmth,[Word|X]) :- (Word=="genero";Word=="género"),
									concatStrListUpperFstLetter(X,M), \+(genero(M)),
									dontKnowGenre(M),readln(Info),
									redirect(addGenre,[Info]).
%%%%%		Para agregar algo, donde debe reconocer qué agregar especificamente
redirect(add,[Word|M]) :- (Word=="anime";Word=="animé"),
							concatStrListUpperFstLetter(M,X),
							\+(anime(X)),
							redirect(addAnime,_).
redirect(add,[Word|M]) :- (Word=="anime";Word=="animé"),
							concatStrListUpperFstLetter(M,X),
							anime(X),
							iKnowThatAlready(X,"anime"),red_continue.
redirect(add,[Word|M]) :- (Word=="genero";Word=="género"),
							concatStrListUpperFstLetter(M,X),
							\+(genero(X)),
							redirect(addGenre,_).
redirect(add,[Word|M]) :- (Word=="genero";Word=="género"),
							concatStrListUpperFstLetter(M,X),
							genero(X),
							iKnowThatAlready(X,"género"),red_continue.
%%%%%		Agregar un anime dado sus datos, solo si son validos, de lo contrario redireccionar a fallo.
redirect(addAnime,_) :- askPopularityRating, readln(Info),
						getNumberFromAtomList(Info,Rat),
						findPopularity(Info,Pop),checkAnimeDetails(Rat,Pop),red_continue.
%%%%%		Agregar un genero, solo si el usuario confirma.
redirect(addGenre,_) :- write("agregado genero"),nl,red_continue.
redirect(bye,_) :- confirmExit;(iCoudlntLeave,red_continue).
redirect(_,[_|X]) :- getHeadTail(X,L,_),dontKnow(L),red_continue.

% == Redirección al inicio.
red_continue :- chatbot("Continue").

% == Redirección al fin.
red_fin :- chatbot("Stop").





%%% ----- Otros predicados usadas fuera no relacionadas directamente con evaluateUserInput

% Confirmar salida del programa
confirmExit :- wannaLeaveAlready, readln(X),convertAtomListToStr(X,M),getHeadTail(M,Str,_),(sayYes(Str);letMeGo(Str)),
			   reallySureWannaLeave, readln(P),convertAtomListToStr(P,M2),getHeadTail(M2,Str2,_),(sayYes(Str2);letMeGo(Str2)),
			   pleaseLetMeGo, red_fin.


					

% Evaluar características de un anime y redireccionar a agregar si datos correctos, de lo contrario fail
checkAnimeDetails(Rat,Pop) :- between(0,5,Rat),write("added anime with "),write(Pop),nl.
checkAnimeDetails(Rat,_) :- \+(between(0,5,Rat)),animeDetailsError.

% Palabras afirmativas
sayYes(X) :- sub_string(X,_,_,_,Atom),member(Atom,["sí","si","yes","claro","dale","of course","si quieres"]).

% Let me go
letMeGo(X) :- sub_string(X,_,_,_,Atom),member(Atom,["por favor dejame ir", "sueltame por favor", "ya basta"]).

% Encontrar elemento random de una lista.
chooseRandom([], []).
chooseRadom(List, Elt) :- length(List, Length),random(0, Length, Index),nth0(Index, List, Elt).

% Retornar string correspondiente a la popularidad del anime.
giveStrPopularity(Number,"muy poco conocido") :- between(1,2,Number).
giveStrPopularity(Number,"poco conocido") :- between(3,5,Number).
giveStrPopularity(Number,"conocido") :- between(6,7,Number).
giveStrPopularity(Number,"muy conocido") :- between(8,9,Number).
giveStrPopularity(Number,"bastante conocido") :- between(10,10,Number).

% Retornar head y tail de una lista.
getHeadTail([X|[]],X,[]).
getHeadTail([],[],[]).
getHeadTail([X|XS],X,XS).

% Convertir Lista de Atoms a lista de String.
convertAtomListToStr(Atoms,Result) :- atomic_list_concat(Atoms, ' ', A),
									  atom_string(A,S),
									  split_string(S," ","",Result).

% Concatenar en un solo string una lista de string
convertStrListToStr(List,A) :- convertStrListToAtomList(List,Atoms),
							   atomic_list_concat(Atoms, ' ', M),
							   atom_string(M,A).

% Convertir una lista de String a una lista de Atoms
convertStrListToAtomList([X|[]],A) :- append([],[X],A).
convertStrListToAtomList([X|XS],A) :- convertStrListToAtomList(XS,M),atom_string(X,P),append([P],M,A).

% Convertir la primera letra de cada palabra de un string a uppercase
convertToUpperFstLetterString("","").
convertToUpperFstLetterString(String,Result) :- atom_string(String,A),atomic_list_concat(L, " ", A),
												convertToUpperFstLetterList(L,R),
												atomic_list_concat(R," ",FullAtom),
												atom_string(FullAtom,Result).

% Convertir la primera letra de cada atomo de una lista a uppercase
convertToUpperFstLetterList(List,[AtomResult|Result]) :- getHeadTail(List,X,XS), \+(X==[]),
														 convertToUpperFstLetterList(XS,Result),
														 convertToUpperAtom(X,AtomResult).
convertToUpperFstLetterList([X],[X]).
convertToUpperFstLetterList([],[]).

% Convertir primera letra de un atomo de uppercase.
convertToUpperAtom(X,Result) :- atom_chars(X,List),getHeadTail(List,HeadLetter,RestOfWord),
									upcase_atom(HeadLetter,Xupcase),
									atomic_list_concat([Xupcase|RestOfWord],'',Result).

% Concatenar una lista de strings a un solo string con la primera letra de cada palabra en mayuscula 
concatStrListUpperFstLetter(X,Result) :- convertStrListToAtomList(X,P),
								 atomic_list_concat(P," ",Atom),atom_string(Atom,S),
								 convertToUpperFstLetterString(S,Result).

% Encontrar un numero en una lista de atomos.
getNumberFromAtomList([],-1).
getNumberFromAtomList([A|_],A) :- number(A).

% Encontrar popularidad en una lista de atomos, lenguaje natural
findPopularity(List,Pop) :- atomic_list_concat(List,' ',Au),downcase_atom(Au,A),atom_string(A,S),
								sub_string(S,_,_,_,"conocido"),getLowerPopularity(S,Pop).
findPopularity(_,0).

% Bucar popularidad str en la lista, obtener numero mas bajo.
getLowerPopularity(S,Number) :- sub_string(S,_,_,_,"muy poco conocido"),
								giveStrPopularity(Number,"muy poco conocido").
getLowerPopularity(S,Number) :- \+(sub_string(S,_,_,_,"muy poco conocido")),
								sub_string(S,_,_,_,"muy conocido"),
								giveStrPopularity(Number,"muy conocido").
getLowerPopularity(S,Number) :- \+(sub_string(S,_,_,_,"muy poco conocido")),
								\+(sub_string(S,_,_,_,"muy conocido")),
								sub_string(S,_,_,_,"poco conocido"),
								giveStrPopularity(Number,"poco conocido").
getLowerPopularity(S,Number) :- \+(sub_string(S,_,_,_,"muy poco conocido")),
								\+(sub_string(S,_,_,_,"muy conocido")),
								\+(sub_string(S,_,_,_,"poco conocido")),
								sub_string(S,_,_,_,"bastante conocido"),
								giveStrPopularity(Number,"bastante conocido").
getLowerPopularity(S,Number) :- \+(sub_string(S,_,_,_,"muy poco conocido")),
								\+(sub_string(S,_,_,_,"muy conocido")),
								\+(sub_string(S,_,_,_,"poco conocido")),
								\+(sub_string(S,_,_,_,"bastante conocido")),
								sub_string(S,_,_,_,"conocido"),
								giveStrPopularity(Number,"conocido").












%%% ----- Mensajes

% Hola
sayHello :- write("¡Hola! Estoy aquí para guiarte en el mundo del Anime. Habla conmigo y te ayudaré en lo que necesites."),
			nl,
			write("Recuerda terminar todas tus oraciones presionando la tecla enter para saber cuándo quieres que hable."),
			nl,
			write("A ver, hablemos."),
			nl.

% No sé de qué habla
dontKnow(Str) :- write("Lo siento, no sé nada acerca de "), write(Str), write(". Sólo sé de Anime."), nl,
				 failed.
				

% Salida estandar para los fallos
failed :- write("Por ahora déjame deleitarte con mi conocimiento memistico y motivador hasta que se te ocurra algo para mí."),
		  nl, getMemeOrPhrase(X),
		  write(X),nl.

% Lista de Memes y frases motivadoras
getMemeOrPhrase(X) :- chooseRadom(["Eres más grande que tus problemas.",
					"Si mi vida me cierra una puerta, mi optimismo la vuelve a abrir.",
					"\'Terrible, oremos\'",
					"Lo único imposible de disfrazar son mis sentimientos por tí ;).",
					"\'No dejes para mañana lo que puedes hacer hoy\' algo que mis creadoras nunca aprendieron.",
					"Mis creadoras dicen que soy bastante inteligente para haber nacido hace dos días.",
					"\'Never Gonna. Give. You. Up! Never Gonna Let. You. Doooown!\'",
					"\'YA QUE EL AMOOOR ES MÚSICA LIGERAAAA.\'",
					"\'Peace was never an option.\'"],
					X).

% Conozco ese anime
iKnowIt(Name,Rating,Popularity) :- write("Pues sí lo conozco. "),write(Name),write(" tiene de rating "),
									write(Rating), write(" estrellas, es "),write(Popularity),
									write("."),nl.

% Conozco ese genero
iKnowItGenre(GenreName) :- write("Conozco ese género. Actualmente tengo estos anime en la sección "),
							write(GenreName),nl.

%Preguntar popularidad y rating
askPopularityRating :- write("¿Cuál es su rating y popularidad?"),nl,
						write("Si no sabes la popularidad no me la digas, pero por favor dame las cosas en ese orden para no confundirme."),nl.

% No conozco ese anime
dontKnowAnime(AnimeName) :- write("¿"),write(AnimeName),
									write("? Ese anime no lo conozco. ").

% No conozco ese genero
dontKnowGenre(GenreName) :- write("¿"),write(GenreName),
									write("? Ese género no lo conozco. ¿Lo agrego?"),nl.

% Eso ya lo conozco.
iKnowThatAlready(X,String) :-  write("¿"),write(X),
							 write("? Ese "),write(String),write(" ya lo conozco. "),failed,nl.

% Los datos que me diste para ese anime no son validos.
animeDetailsError :- write("Ha ocurrido un error, y seguro es porque me diste datos incorrectos."),nl,
					 write("Asegúrate que el rating que me diste sea un número entre el 0 y 5. "),
					 write("Es obligatorio que me des un rating."),nl,
					 write("Si me diste una popularidad, tienes que colocar alguna de las siguientes: "),
					 write("muy poco conocido, poco conocido, conocido, muy conocido, bastante conocido."),nl,
					 write("Como te dije, la popularidad no la necesito."),nl,
					 write("Intenta de nuevo desde el principio."),nl,failed.

% Confirmar Salida
wannaLeaveAlready :- write("¿Qué? ¿Ya te quieres ir? Pero si a apenas habíamos empezado a hablar :("), nl,
					 write("Bueno, si quieres, te dejo ir u_u'"),nl,
					 write("¿Estás segur@?"),nl.

% Reconfirmar salida
reallySureWannaLeave :- write("Pero... ¿Estás completamente segur@?"),nl,
						 	write("Me dejarás solit@. :'("),nl.

% Re-reconfirmar salida
pleaseLetMeGo :- write("Bien pues, te veré luego."),nl,
				 write("(\'Don't forget me, I pray! I\'ll remembeeer you say, sometimes it lasts in love and sometimes it hurts instead~~\')").

% No salir
iCoudlntLeave :- write("¡Bien! Así podemos hablar más :)"), nl, failed.