%set_prolog_flag(double_quotes, atom).

:- dynamic (anime/1).
:- dynamic (genero/1).
:- dynamic (generoAnime/2).
:- dynamic (rating/2).
:- dynamic (popularidad/2).




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
rating("Neon Genesis Evangelion",5).
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






%  !! PREDICADOS !!

%Mostrar animes por genero
%Parametros: Genero, lista de animes a filtrar y lista de retorno
filtrarGenero(Genero, [], []):-genero(Genero).
filtrarGenero(Genero, [Anime|Animes], [Anime|L]) :- filtrarGenero(Genero, Animes, L),
													genero(Genero), 
													generoAnime(Anime, GenerosAnime), 
													member(Genero,GenerosAnime).
													
filtrarGenero(Genero, [Anime|Animes], L) :- filtrarGenero(Genero, Animes, L),
											genero(Genero), 
											generoAnime(Anime, GenerosAnime), 
											not(member(Genero,GenerosAnime)).

%Mostrar por rating
%Parametros: Rating, lista de animes a filtrar y lista de retorno
filtrarRate(Rate, [], []):- Rate=<5, Rate>0.
filtrarRate(Rate, [Anime|Animes], [Anime|L]) :- filtrarRate(Rate, Animes, L),
													rating(Anime, Rate).
													
filtrarRate(Rate, [Anime|Animes], L) :- filtrarRate(Rate, Animes, L),
											not(rating(Anime, Rate)).

%Mostrar por popularidad
%Parametros: lista de numeros que corresponden a la popularidad, lista de animes a filtrar y lista de retorno
filtrarPop(_, [], []).
filtrarPop(Popularidad, [Anime|Animes], [Anime|L]) :- filtrarPop(Popularidad, Animes, L),
												popularidad(Anime, Pop),
												member(Pop,Popularidad).
filtrarPop(Popularidad, [Anime|Animes], L) :- filtrarPop(Popularidad, Animes, L),
										popularidad(Anime, Pop),
										not(member(Pop,Popularidad)).

%Ordenar por rating
%Predicado auxiliar que inserta en la lista de animes ordenados por rating
insertRate(Anime, [], [Anime]):- !.
insertRate(Anime, [Anime1|L1], [Anime, Anime1|L1]):- rating(Anime,Rate),
														rating(Anime1,Rate1),
														Rate=<Rate1, !.
insertRate(Anime, [Anime1|L1], [Anime1|L]) :- insertRate(Anime, L1, L).

%Parametros: lista de animes a ordenar y lista de retorno
ordRate([], []):- !.
ordRate([Anime|L], S):- ordRate(L, S1), 
						insertRate(Anime, S1, S).

%Ordenar por popularidad
%Predicado auxiliar que inserta en la lista de animes ordenados por popularidad
insertPop(Anime, [], [Anime]):- !.
insertPop(Anime, [Anime1|L1], [Anime, Anime1|L1]):- popularidad(Anime,Pop),
														popularidad(Anime1,Pop1),
														Pop=<Pop1, !.
insertPop(Anime, [Anime1|L1], [Anime1|L]) :- insertPop(Anime, L1, L).

%Parametros: lista de animes a ordenar y lista de retorno
ordPop([], []):- !.
ordPop([Anime|L], S):- ordPop(L, S1), 
						insertPop(Anime, S1, S).

%Agregar un anime
%Predicado auxiliar que comprueba si un genero esta en la lista
%de generos, si no lo agrega
agregarGeneros([]).
agregarGeneros([Genero|Generos]) :- genero(Genero),
									agregarGeneros(Generos).
agregarGeneros([Genero|Generos]) :- not(genero(Genero)),
									assert(genero(Genero)),
									agregarGeneros(Generos).


%Parametros: anime, rating y un genero
agregarSinPop(Anime, Rate, Generos):- not(anime(Anime)),
										Rate =< 5,
										Rate > 0,
										assert(anime(Anime)),
										agregarGeneros(Generos),
										assert(rating(Anime, Rate)),
										assert(generoAnime(Anime, Generos)),
										assert(popularidad(Anime, 1)).

%Parametros: anime, rating, un genero y popularidad
agregarConPop(Anime, Rate, Generos, Pop):- not(anime(Anime)),
											Rate =< 5,
											Rate > 0,
											Pop =< 10,
											Pop > 0,
											assert(anime(Anime)),
											agregarGeneros(Generos),
											assert(rating(Anime, Rate)),
											assert(generoAnime(Anime, Generos)),
											assert(popularidad(Anime, Pop)).







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
keywords(X,add) :- member(X,["agregar","incluir","add"]).
keywords(X,bye) :- member(X,["chao","adios","bye","halt"]).
keywords(X,searchAnime) :- string_lower(X,Xx),anime(M),string_lower(M,Mm),Xx==Mm.
keywords(X,searchGenre) :- string_lower(X,Xx),anime(M),string_lower(M,Mm),Xx==Mm.
keywordsEspecial(X,searchRating) :- member(X,["estrella","estrellas","rating","interesante","bueno","malo","medio","super malo"]).

% == Funcion para encontrar la primera palabra clave
getKeywords([X|XS],Result,XS) :- keywords(X,Result),!.
getKeywords([_|XS],Result,Z) :- getKeywords(XS,Result,Z).

% == Funcion principal
%%		Recibe L (lista de atoms conseguida el input) y la recorre para encontrar
%%		palabras clave, y redirigir a alguna accion (primer predicado) o al
%%		predicado que muestre el mensaje correspondiente a no entender el input.
evaluateUserInput(L) :- convertStrListToStr_aux(L,Str),
						sub_string(Str,_,_,_,X),keywordsEspecial(X,searchRating),
						atom_string(Str,Atom),atomic_list_concat(AtomList,' ',Atom),
						getNumberFromAtomList(AtomList,Rate),
						redirect(filterRate,Rate).
evaluateUserInput(L) :- convertStrListToStr_aux(L,Str),
						sub_string(Str,_,_,_,"conocido"),
						findPopularity(L,Pop),between(1,10,Pop),
						giveStrPopularity(Pop,StrPop),
						findall(X,anime(X),ListaAnime),
						getPopularityRange(Pop,Fst_Num,Scd_Num),
						findall(Num,between(Fst_Num,Scd_Num,Num),PopList),
						filtrarPop(PopList,ListaAnime,ListaFiltrada),
						write("Estos son los anime "),write(StrPop),write("s."),nl,
						printListAnimeAll_withoutPop(ListaOrdenada),
						length(ListaFiltrada,Len),theresNothingHere(Len),
						red_continue.
evaluateUserInput(L) :- convertStrListToStr(L,Str),sub_string(Str,_,_,_,X),
						keywords(X,add),
						write("¿Puedes repetirme el nombre del anime que quieres agregar? Es para anotarlo bien."),
						readln(Line),atomic_list_concat(Line,' ',Atom),
						atom_string(Atom,Anime),
						redirect(addAnimeAux,[Anime]).
evaluateUserInput(L) :- convertStrListToStr(L,Str),sub_string(Str,_,_,_,X),
						keywords(X,searchSmth),cutInKeyWord(X,L,Result),
						redirect(search,Result).
evaluateUserInput(L) :- convertStrListToStr(L,Str),sub_string(Str,_,_,_,X),
						keywords(X,bye),redirect(bye,_).
%evaluateUserInput(L) :- convertStrListToStr(L,Str),sub_string(Str,_,_,_,X),
%						keywords(X,searchAnime),
%						redirect(searchSmth,["anime",X]).
%evaluateUserInput(L) :- getKeywords(L,P,RestOfList),
%						processOtherKeys(RestOfList,Tuple),
%						redirect(P,Tuple).
evaluateUserInput(L) :- convertStrListToStr(L,Str),dontKnow(Str), red_continue.

% == Evaluación y respuesta
processOtherKeys([],[]).
processOtherKeys([Mx|RestOfList],Result) :- string_lower(Mx,M),keywords(M,Z),
											member(Z,[searchSmth,searchAnimeOrGenre]),
											convertStrListToStr(RestOfList, A),
											append([M],[A],Result),!.
processOtherKeys([_|RestOfList],Result) :- processOtherKeys(RestOfList,Result).

cutInKeyWord(Keyword,[Keyword|XS],XS).
cutInKeyWord(Keyword,[_|XS],Result) :- cutInKeyWord(Keyword,XS,Result).



% ----- Redireccion a alguna funcionalidad

%%		Reciben la accion a realizar, y el input restante luego de la palabra clave.

%%%%% 		Para reconocer anime o, en caso contrario, redireccionar a agregar.
redirect(searchSmth,[Word|M]) :- (Word=="anime";Word=="animé"),
									convertStrListToStr(M,Str),
									anime(X), string_lower(X,Str), rating(X,Rat),
									popularidad(X,PopNum),giveStrPopularity(PopNum,Pop),
									generoAnime(X,GenresList),
									iKnowIt(X,Rat,Pop,GenresList),red_continue.
redirect(searchSmth,[Word|M]) :- (Word=="anime";Word=="animé"),
									convertStrListToStr(M,Str),
									anime(X),\+(string_lower(X,Str)),
									dontKnowAnime(X),redirect(addAnime,[X]).

%%%%% 		Para reconocer genero o, en caso contrario, agregar.
redirect(searchSmth,[Word|X]) :- (Word=="genero";Word=="género"),
									concatStrListUpperFstLetter(X,M), genero(M),
									iKnowItGenre(M),
									red_continue.
redirect(searchSmth,[Word|X]) :- (Word=="genero";Word=="género"),
									concatStrListUpperFstLetter(X,M), \+(genero(M)),
									dontKnowGenre(M),readln(Info),
									redirect(addGenre,[Info]).

%%%%%		Para reconocer cualquier otra cosa que empezó con palabras como "sabes", se busca entre genero/anime
%redirect(searchSmth,[Word|X]) :- \+(keywords(Word,searchAnimeOrGenre)),

redirect(search,List) :- convertStrListToStr(List,Str),
						 genero(Str),iKnowItGenre(Str),red_continue.
redirect(search,List) :- convertStrListToStr(List,Xx),
						 anime(X),string_lower(X,P),Xx==P,rating(X,Rat),
						 popularidad(X,PopNum),giveStrPopularity(PopNum,Pop),
						 generoAnime(X,GenresList),
						 iKnowIt(X,Rat,Pop,GenresList),red_continue.

%%%%%		Para agregar algo, donde debe reconocer qué agregar especificamente
%%%%%%%%		Si es un Anime, preguntar datos solo si no lo conoce
redirect(add,[Word|M]) :- (Word=="anime";Word=="animé"),
							concatStrListUpperFstLetter(M,X),
							\+(anime(X)),
							redirect(addAnime,_).
redirect(add,[Word|M]) :- (Word=="anime";Word=="animé"),
							concatStrListUpperFstLetter(M,X),
							anime(X),
							iKnowThatAlready(X,"anime"),red_continue.
%%%%%%%%		Si es un Genero, agregar solo si no lo conoce
redirect(add,[Word|M]) :- (Word=="genero";Word=="género"),
							concatStrListUpperFstLetter(M,X),
							\+(genero(X)),
							redirect(addGenre,_).
redirect(add,[Word|M]) :- (Word=="genero";Word=="género"),
							concatStrListUpperFstLetter(M,X),
							genero(X),
							iKnowThatAlready(X,"género"),red_continue.

%%%%%		Para agregar un anime pidiendo sus datos, solo si éstos son validos, de lo contrario redireccionar a fallo.
redirect(addAnime,[X]) :- askPopularityRatingGenre, readln(Info),
						getNumberFromAtomList(Info,Rat),
						findPopularity(Info,Pop),
						findGenre(Info,Genre),
						checkAnimeDetails(X,Rat,Pop,[Genre],CodigoError),
						addedSuccessfully(CodigoError,X,"Anime"),
						red_continue.

%%%%%		Para agregar un genero, solo si el usuario confirma.
redirect(addGenre,_) :- write("agregado genero"),nl,red_continue.

%%%%%		Para filtrar todos los anime por un rating dado, sólo si es válido, de lo contrario redireccionar a fail.
redirect(filterRate,Rate) :- between(1,5,Rate),findall(X,anime(X),L),
							 filtrarRate(Rate,L,ListaFiltrada),
							 write("Estos son los anime con "),write(Rate),
							 write(" estrellas."),nl,
							 printListAnimeAll_withoutRate(ListaFiltrada),
							 length(ListaFiltrada,Len),theresNothingHere(Len),
							 red_continue.
redirect(filterRate,Rate) :- \+(between(1,5,Rate)),
							 write("Epa, el rating que me diste no tiene sentido. Dame un número del 1 al 5."),nl,
							 write("Bueno, espero que tengas más suerte dándome un rating la próxima vez."),nl,
							 failed,red_continue.

redirect(addAnimeAux,[X]) :- \+(anime(X)),
							 redirect(addAnime,[X]).
redirect(addAnimeAux,[X]) :- iKnowThatAlready(X,"anime"),red_continue. 

%%%%%		Para salir del chatbot.
redirect(bye,_) :- confirmExit;(iCoudlntLeave,red_continue).

%%%%%		En cualquier otro caso, el chatbot no sabe que esta diciendo el usuario
redirect(_,X) :- atomic_list_concat(X,'',L),dontKnow(L),red_continue.

% == Redirección al inicio.
red_continue :- chatbot("Continue").

% == Redirección al fin.
red_fin :- chatbot("Stop").





%%% ----- Otros predicados usadas fuera no relacionadas directamente con evaluateUserInput

% Concatenar atoms de manera segura
atomic_list_concat_secure([],_).
atomic_list_concat_secure([X],X).
atomic_list_concat_secure([X|XS],Atom) :- atomic_list_concat_secure(XS,R),
										  \+((R==''),\+(X=='')),
										  atomic_list_concat([X|R],' ',Atom).
atomic_list_concat_secure([X|XS],X) :- atomic_list_concat_secure(XS,R),
										  R=='',\+(X=='').
atomic_list_concat_secure([''|XS],R) :- atomic_list_concat_secure(XS,R),
										  \+(R=='').
atomic_list_concat_secure([''|XS],'') :- atomic_list_concat_secure(XS,R),
										  R==''.


% Confirmar salida del programa
confirmExit :- wannaLeaveAlready, readln(X),convertAtomListToStr(X,M),getHeadTail(M,Str,_),(sayYes(Str);letMeGo(Str)),
			   reallySureWannaLeave, readln(P),convertAtomListToStr(P,Mx),getHeadTail(Mx,Strx,_),(sayYes(Strx);letMeGo(Strx)),
			   pleaseLetMeGo, red_fin.

%Imprimir elementos de una lista de anime sin su popularidad
printListAnimeAll_withoutPop([]).
printListAnimeAll_withoutPop([L|List]) :- rating(L,Rat), generoAnime(L,Genres),
								write("* "),write(L),
								write(" :   rating="),write(Rat),
								write(", y tiene de género(s) "),
								printListSingleLine(Genres),
								write("."),
								nl,printListAnimeAll_withoutPop(List).

%Imprimir elementos de una lista de anime sin sus estrellas
printListAnimeAll_withoutRate([]).
printListAnimeAll_withoutRate([L|List]) :- popularidad(L,P),giveStrPopularity(P,Pop),generoAnime(L,Genres),
								write("* "),write(L),
								write(",  "),write(Pop),
								write(" y tiene de género(s) "),
								printListSingleLine(Genres),
								write("."),
								nl,printListAnimeAll_withoutRate(List).

%Imprimir elementos de una lista de anime sin sus generos en varias lineas
printListAnimeAll_withoutGenre([]).
printListAnimeAll_withoutGenre([L|List]) :- popularidad(L,P),giveStrPopularity(P,Pop), rating(L,Rat),
								write("* "),write(L),
								write(" :   rating="),write(Rat),
								write(",  "),write(Pop),write("."),
								nl,printListAnimeAll_withoutGenre(List).

%Imprimir elementos de una lista cualquiera en una linea, separadas por comas
printListSingleLine([L]) :- write(L).
printListSingleLine([L|List]) :- write(L),write(", "),printListSingleLine(List).

% Preguntar si agregar anime al genero
askAddToGenre(GenreName) :- readln(X),convertAtomListToStr(X,M),getHeadTail(M,Str,_),sayYes(Str),
							redirect(addAnime,GenreName).

% Evaluar características dadas de un anime y redireccionar a agregar si datos correctos, de lo contrario fail
checkAnimeDetails(Anime,Rat,0,Genres,0) :- agregarSinPop(Anime,Rat,Genres).
checkAnimeDetails(Anime,Rat,Pop,Genres,0) :- agregarConPop(Anime,Rat,Genres,Pop).
checkAnimeDetails(_,-1,0,"",-1) :- animeDetailsError.

% Palabras afirmativas
sayYes(X) :- sub_string(X,_,_,_,Atom),member(Atom,["sí","si","yes","claro","dale","of course","si quieres"]).

% Palabras para terminar el chatbot
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

% Retornar el inicio del rango y final del rango para la popularidad correspondiente
getPopularityRange(Number,1,2) :- between(1,2,Number).
getPopularityRange(Number,3,5) :- between(3,5,Number).
getPopularityRange(Number,6,7) :- between(6,7,Number).
getPopularityRange(Number,8,9) :- between(8,9,Number).
getPopularityRange(Number,10,10) :- between(10,10,Number).

% Retornar head y tail de una lista.
getHeadTail([X|[]],X,[]).
getHeadTail([],[],[]).
getHeadTail([X|XS],X,XS).

% Convertir Lista de Atoms a lista de String.
convertAtomListToStr([],[]).
convertAtomListToStr(Atoms,Result) :- atomic_list_concat(Atoms, ' ', A),
									  atom_string(A,S),
									  split_string(S," ","",Result).

% Concatenar en un solo string una lista de string
convertStrListToStr(List,A) :- convertStrListToAtomList(List,Atoms),
							   atomic_list_concat(Atoms, ' ', M),
							   atom_string(M,A).


% Concatenar en un solo string una lista de string (aux)
convertStrListToStr_aux(List,A) :- convertStrListToAtomList(List,Atoms),
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
convertToUpperFstLetterList(List,[AtomResult|Result]) :- getHeadTail(List,X,XS), \+(X==""),
														 convertToUpperFstLetterList(XS,Result),
														 convertToUpperAtom(X,AtomResult).
convertToUpperFstLetterList([X],[AtomResult]) :- convertToUpperAtom(X,AtomResult).
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
getNumberFromAtomList([A|_],A) :- number(A),!.
getNumberFromAtomList([A|_],M) :- atom_number(A,M),!.
getNumberFromAtomList([_|AS],Num) :- getNumberFromAtomList(AS,Num).
getNumberFromAtomList([],-1).

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

% Encontrar el genero del input del usuario
findGenre([],"").
findGenre([X|XS],Genre) :- atom_string(X,Str),member(Str,["género","genero","genre"]),
							getHeadTail(XS,Head,_),convertToUpperAtom(Head,A),
							atom_string(A,Genre),!.
findGenre([X|XS],Genre) :- atom_string(X,Str),\+(member(Str,["género","genero","genre"])),
							findGenre(XS,Genre).











%%% ----- Mensajes

% Hola
sayHello :- write("¡Hola! Estoy aquí para guiarte en el mundo del Anime. Habla conmigo y te ayudaré en lo que necesites."),
			nl,
			write("Recuerda terminar todas tus oraciones presionando la tecla enter para saber cuándo quieres que hable."),
			nl,
			write("A ver, hablemos."),
			nl.

% No sé de qué habla
dontKnow(Str) :- write("Lo siento, no sé qué quisiste decir con \'"), write(Str), write("\'. Mejor intenta de nuevo."), nl,
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
iKnowIt(Name,Rating,Popularity,GenresList) :- write("Pues sí lo conozco. "),write(Name),write(" tiene de rating "),
										write(Rating), write(" estrellas, es "),write(Popularity),
										write(" y es de género(s): "),printListSingleLine(GenresList),
										write("."),nl.

% Conozco ese genero
iKnowItGenre(GenreName) :- findall(X,anime(X),L),filtrarGenero(GenreName,L,Result),
							length(Result,Length),iKnowItGenre(GenreName,Length,Result).
iKnowItGenre(GenreName,0,_) :- write("Conozco ese género, pero actualmente no conozco ningun anime de esa sección."),nl,
							 askAddToGenre(GenreName).
iKnowItGenre(GenreName,Length,L) :- Length>0,
									write("Conozco ese género. Actualmente tengo estos anime en la sección "),
									write(GenreName),write(":"),nl,
									ordRate(L,List),
									printListAnimeAll_withoutGenre(List).

% Te puede gustar...
youMayLike(GenreName) :- findall(X,anime(X),L),filtrarGenero(GenreName,L,Result),
							length(Result,Length),youMayLike(GenreName,Length,Result).
youMayLike(GenreName,0,_) :- iKnowItGenre(GenreName,0,_).
youMayLike(_,Length,List) :- Length>0,
									write("Puede que te gusten los siguiente animes."),
									printList(List).

%Preguntar popularidad y rating
askPopularityRatingGenre :- write("¿Cuál es su rating y género?"),nl,
						write("Si no sabes la popularidad no me la digas, pero por favor dame las cosas en ese orden para no confundirme."),nl,
						write("Orden: rating.... genero....popularidad"),nl,
						write("Importante que pongas la palabra \"género\" para saber cual palabra quieres que tome."),
						nl.


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

% Agregado elemento con exito (imprimir mensaje de exito solo si CodigoError==0)
addedSuccessfully(0,Name,ListName) :- write("Ya agregé "),write(Name),write(" a mi lista de "),
									write(ListName),write("."),nl.
addedSuccessfully(-1,_,_).

% No hay nada en esta lista
theresNothingHere(0) :- write("Oh no, no tengo nada aquí :/"),
						nl,write("Intenta mejor con otra cosa."),nl.
theresNothingHere(_).

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