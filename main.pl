:- dynamic(running/1).
:- dynamic(quest/1).
:- dynamic(posisi/2).
:- dynamic(gameOver/0).
:- dynamic(gameWin/0).
:- dynamic(nama/1).

:- include('character.pl').
:- include('map.pl').
:- include('exploration.pl').
:- include('items.pl').
/* :- include('enemy.pl'). */
/* :- include('quest.pl'). */
:- include('battle.pl').
:- include('store.pl').


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
    initChar,
    !.

help :- write('Perintah: '), nl,
        write('    start.              : mulai permainan'), nl,
        write('    quit.               : keluar permainan'), nl,
        write('    help.               : melihat perintah yang dapat digunakan'), nl,
        write('    map.                : melihat map'),nl,
        write('    w. a. s. d.         : gerak'), nl,
        write('    saveGame(Filename). : save game'), nl,
        write('    loadGame(Filename). : load game'), nl.
quit :-
    \+running(_),
    write('Permainan belum dimulai!'),!.

quit :- write('Terima kasih telah bermain'),nl,
        sleep(5),
        halt.
saveGame(_) :-
	\+running(_),
	write('Perintah ini hanya bisa dipakai setelah pemainan dimulai.'), nl,
	write('Gunakan perintah "start." untuk memulai permainan.'), nl, !.

saveGame(FileName) :-
    nama(Username),
        tell(FileName),
            write('nama('), write(Username),write(').'),nl,
        told, !.
loadGame(_) :-
	running(_),
	write('Kamu sudah memulai permainan.'), nl, !.

loadGame(FileName):-
	\+file_exists(FileName),
	write('File tidak ditemukan'), nl, write('Silahkan tulis ulang nama file.'), nl, !.

loadGame(FileName):-
	open(FileName, read, Stream),
        readFileLines(Stream,Lines),
    close(Stream),
    assertaLine(Lines),
    asserta(running(1)), !.
assertaLine([]) :- !.

assertaLine([X|L]):-
	asserta(X),
	assertaLine(L), !.

readFileLines(Stream,[]) :-
    at_end_of_stream(Stream).

readFileLines(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,X),
    readFileLines(Stream,L).
