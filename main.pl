:- dynamic(running/1).
:- dynamic(gameOver/1).
:- dynamic(gameWin/1).
:- dynamic(nama/1).
/* :- include('character.pl'). */
:- include('map.pl').
:- include('items.pl').
/* :- include('enemy.pl'). */
/* :- include('quest.pl'). */
/* :- include('battle.pl'). */
% :- include('store.pl').


start :-
    running(_),
    write('Permainan sudah dimulai!'),!.

start :-
    \+running(_),
    write( '_|                            _|              _|_|_|    _|_|    _|      _|'),nl,
    write( '_|          _|_|      _|_|_|  _|  _|        _|        _|    _|  _|_|  _|_|'),nl,
    write( '_|        _|    _|  _|        _|_|          _|        _|    _|  _|  _|  _|'),nl,
    write( '_|        _|    _|  _|        _|  _|        _|        _|    _|  _|      _|'),nl,
    write( '_|_|_|_|    _|_|      _|_|_|  _|    _|        _|_|_|    _|_|    _|      _|'),nl,
    nl,
    write('Selamat datang pemuda pencari tujuan hidup'),nl,
    write('Siapakah nama kamu?'),nl,
    read(Username),
    asserta(nama(Username)),
    write('Halo '), write(Username), nl,
    asserta(running(1)),
    initMap,
    initPlayer,
    randomizeWall,
    !.

help :- 
    write('  ____________________________________________________________'),nl,
    write(' |____________________________________________________________|'),nl,
    write(' | Perintah:                                                  |'), nl,
    write(' |   start.          -- mulai permainan                       |'), nl,
    write(' |   quit.           -- keluar permainan                      |'), nl,
    write(' |   help.           -- melihat perintah yang dapat digunakan |'), nl,
    write(' |   w. a. s. d.     -- gerak                                 |'), nl,
    write(' |   save(Filename). -- save game                             |'), nl,
    write(' |   load(Filename). -- load game                             |'), nl,
    write(' |____________________________________________________________|'), nl.

quit :-
    \+running(_),
    write('Permainan belum dimulai!'),!.

quit :- write('Terima kasih telah bermain'),nl,
        sleep(5),
        halt.
save(_) :-
	\+running(_),
	write('Perintah ini hanya bisa dipakai setelah pemainan dimulai.'), nl,
	write('Gunakan perintah "start." untuk memulai permainan.'), nl, !.

save(FileName) :-
    nama(Username),
        tell(FileName),
            write('nama('), write(Username),write(').'),nl,
        told, !.
