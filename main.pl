:- dynamic(init/1).          /* Mark game dimulai */
:- dynamic(player/1).

/* :- include('character.pl'). */
:- include('map.pl').
/* :- include('items.pl'). */
/* :- include('enemy.pl'). */
/* :- include('quest.pl'). */
/* :- include('battle.pl'). */
/* :- include('store.pl'). */

title :-
    write('Gotta catch em all!'),nl,
    write('Available commands:'),nl,
    write('     start. -- start the game!'),nl,
    write('     help. -- show available commands'),nl,
    write('     quit. -- quit the game'),nl,
    write('     w. a. s. d. -- move'),nl,
    write('     map. -- look at the map'),nl,
    write('     Legends:'),nl,
    write('       - P = Player'),nl,
    write('       - S = Store'),nl,
    write('       - Q = Quest'),nl,
    write('       - D = Dungeon'),nl,
    write('       - # = Wall'),nl,

start :- 
    init(_),
    write('Game sudah dimulai'),!.

start :-
    \+init(_),
    title,
    asserta(init(1)),
    !.

quit :-
    \+init(_),
    write('Game belum dimulai kok diquit sih WKWK gimana aja'),!.

