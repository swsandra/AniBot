%set_prolog_flag(double_quotes, atom).

anime(X) :- member(X,["Dragon Ball", "Naruto", "Bleach", "HunterXHunter", "Hamtaro", "Full Metal Alchemist", "Attack on Titan", "Neon Genesis Evangelion", "Elfen Lied", "Inuyasha", "Blue Exorcist"]).

genero(X) :- member(X,["Aventura", "Shoujo", "Shounen", "Kodomo", "Seinen", "Josei", "Ficción",
                    "Fantasía", "Mecha", "Sobrenatural", "Magia", "Gore"]).

generoAnime("Naruto",["Shounen","Aventura"]).
generoAnime("Dragon Ball",["Shounen"]).
generoAnime("Bleach",["Shounen", "Sobrenatural"]).
generoAnime("HunterXHunter",["Seinen", "Aventura"]).
generoAnime("Hamtaro",["Kodomo"]).
generoAnime("Full Metal Alchemist",["Shounen", "Magia"]).

generoAnime("Attack on Titan",["Seinen", "Aventura"]).
generoAnime("Neon Genesis Evangelion",["Seinen", "Mecha"]).
generoAnime("Elfen Lied",["Ficción", "Gore"]).
generoAnime("Inuyasha",["Shoujo", "Aventura", "Fantasía"]).
generoAnime("Blue Exorcist",["Ficción", "Fantasía"]).

rating("Dragon Ball",3).
rating("Naruto",1).
rating("Bleach",4).
rating("HunterXHunter",5).
rating("Hamtaro",2).
rating("Full Metal Alchemist",4).

rating("Attack on Titan",5).
rating("Neon Genesis Evangelion",5).
rating("Elfen Lied",3).
rating("Inuyasha",4).
rating("Blue Exorcist",2).

popularidad("Dragon Ball",7).
popularidad("Naruto",5).
popularidad("Bleach",8).
popularidad("HunterXHunter",3).
popularidad("Hamtaro",10).
popularidad("Full Metal Alchemist",1).

popularidad("Attack on Titan",10).
popularidad("Neon Genesis Evangelion",6).
popularidad("Elfen Lied",4).
popularidad("Inuyasha",9).
popularidad("Blue Exorcist",2).


%Mostrar animes por genero
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
filtrarRate(Rate, [], []):- Rate=<5, Rate>0.
filtrarRate(Rate, [Anime|Animes], [Anime|L]) :- filtrarRate(Rate, Animes, L),
													rating(Anime, Rate).
													
filtrarRate(Rate, [Anime|Animes], L) :- filtrarRate(Rate, Animes, L),
											not(rating(Anime, Rate)).

%Mostrar por popularidad (Popularidad es una lista con los numeros de la popularidad)
filtrarPop(_, [], []).
filtrarPop(Popularidad, [Anime|Animes], [Anime|L]) :- filtrarPop(Popularidad, Animes, L),
												popularidad(Anime, Pop),
												member(Pop,Popularidad).
													
filtrarPop(Popularidad, [Anime|Animes], L) :- filtrarPop(Popularidad, Animes, L),
										popularidad(Anime, Pop),
										not(member(Pop,Popularidad)).

%Ordenar por rating
insertRate(Anime, [], [Anime]):- !.
insertRate(Anime, [Anime1|L1], [Anime, Anime1|L1]):- rating(Anime,Rate),
														rating(Anime1,Rate1),
														Rate=<Rate1, !.
insertRate(Anime, [Anime1|L1], [Anime1|L]) :- insertRate(Anime, L1, L).

ordRate([], []):- !.
ordRate([Anime|L], S):- ordRate(L, S1), 
						insertRate(Anime, S1, S).

%Ordenar por popularidad
insertPop(Anime, [], [Anime]):- !.
insertPop(Anime, [Anime1|L1], [Anime, Anime1|L1]):- popularidad(Anime,Pop),
														popularidad(Anime1,Pop1),
														Pop=<Pop1, !.
insertPop(Anime, [Anime1|L1], [Anime1|L]) :- insertPop(Anime, L1, L).

ordPop([], []):- !.
ordPop([Anime|L], S):- ordPop(L, S1), 
						insertPop(Anime, S1, S).
