:- dynamic(running/1).
:- dynamic(posisi/2).
:- dynamic(gameOver/1).
:- dynamic(gameWin/1).

/* :- include('character.pl'). */
:- include('map.pl').
:- include('items.pl').
/* :- include('enemy.pl'). */
/* :- include('quest.pl'). */
/* :- include('battle.pl'). */
% :- include('store.pl').


start :-
    running(_),
    write('Game has already started!'),!.

start :-
    \+running(_),
    write( '_|                            _|              _|_|_|    _|_|    _|      _|'),nl,
    write( '_|          _|_|      _|_|_|  _|  _|        _|        _|    _|  _|_|  _|_|'),nl,
    write( '_|        _|    _|  _|        _|_|          _|        _|    _|  _|  _|  _|'),nl,
    write( '_|        _|    _|  _|        _|  _|        _|        _|    _|  _|      _|'),nl,
    write( '_|_|_|_|    _|_|      _|_|_|  _|    _|        _|_|_|    _|_|    _|      _|'),nl,
    nl,
    asserta(running(1)),
    initMap,
    initPlayer,
    randomizeWall,
    !.

help :- write('Perintah: '), nl,
        write('    start.          -- mulai permainan'), nl,
        write('    quit.           -- keluar permainan'), nl,
        write('    help.           -- melihat perintah yang dapat digunakan'), nl,
        write('    w. a. s. d.     -- gerak'), nl,
        write('    save(Filename). -- save game'), nl,
        write('    load(Filename). -- load game'), nl.
quit :-
    \+running(_),
    write('Permainan belum dimulai!'),!.
quit :- halt.
