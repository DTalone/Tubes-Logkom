:- dynamic(running/1).
:- dynamic(onQuest/1).
:- dynamic(posisi/2).
:- dynamic(gameOver/0).
:- dynamic(gameWin/0).
:- dynamic(nama/1).
:- dynamic(gold/1).
:- dynamic(chapter/1).
:- dynamic(daily/1).
:- dynamic(victory/0).
:- dynamic(quest/5).

quest(0,0,0,0,0).

:- include('character.pl').
:- include('map.pl').
:- include('exploration.pl').
:- include('items.pl').
:- include('enemy.pl').
:- include('quest.pl').
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
    write('1. New Game.'),nl,
    write('2. Load Game.'),nl,
    write('Masukkan angka : '),read(X),
    (X =:= 1 -> newGame
    ;X =:= 2 -> load),
    asserta(running(1)),!.

newGame :- running(_), write('Permainan sudah dimulai!'),!.

newGame:- write('Siapakah nama kamu? (tulis di antara tanda petik dan diakhiri titik. Contoh: \'Silvanna\'.)'),nl,
          write('Nama : '), read(Username),
          asserta(nama(Username)),nl,
          write('Halo '), write(Username),write('! Selamat Bermain.'),nl,nl,
          asserta(running(1)),
          initChar,
          initEnemy,
          initMap,
          randomizeWall,
          story0,
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

quit :- retract(running(1)), write('Terima kasih telah bermain'),nl.
        % sleep(5),
        % halt.
saveGame(_) :-
	\+running(_),
	write('Perintah ini hanya bisa dipakai setelah pemainan dimulai.'), nl,
	write('Gunakan perintah "start." untuk memulai permainan.'), nl, !.

saveGame(FileName) :-
    nama(Username),
        tell(FileName),
            write('nama('), write(Username),write(').'),nl,
        told, !.
load.
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
