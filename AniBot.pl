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
rating("Neon Genesis Evangelion",4).
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


