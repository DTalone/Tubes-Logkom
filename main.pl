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
    asserta(quest(0,0,0,0,0)),
    repeat,
    write('Selamat datang pemuda pencari tujuan hidup'),nl,
    write('1. New Game.'),nl,
    write('2. Load Game.'),nl,
    write('Masukkan angka : '),read(X),
    (X =:= 1 -> newGame
    ;X =:= 2 -> loadGame),
    asserta(running(1)),
    write('\nuntuk melihat perintah apa saja yang dapat digunakan silahkan mengetik \'help.\''),!.

newGame :- running(_), write('Permainan sudah dimulai!'),!.

newGame:- write('Siapakah nama kamu? (tulis di antara tanda petik dan diakhiri titik. Contoh: \'Silvanna\'.)'),nl,
          write('Nama : '), read(Username),
          asserta(nama(Username)),nl,
          write('Halo '), write(Username),write('! Selamat Bermain.'),nl,nl,
          asserta(running(1)),
          asserta(chapter(0)),
          asserta(gold(1000)),
          initChar,
          initEnemy,
          initMap,
          story0,
          !.

help :- write('Perintah: '), nl,
        write('    start.              : mulai permainan'), nl,
        write('    quit.               : keluar permainan'), nl,
        write('    help.               : melihat perintah yang dapat digunakan'), nl,
        write('    map.                : melihat map'),nl,
        write('    w. a. s. d.         : gerak'), nl,
        write('    saveGame            : save game'), nl,
        write('    cekInventory.       : cek inventory'), nl,
        write('    delInventory(Nama)  : membuang items dari inventory.'),
      	write('    status.             : cek status character'), nl,
      	write('    use(NamaEquip).     : memakai/mengganti senjata atau armor'), nl.
quit :-
    \+running(_),
    write('Permainan belum dimulai!'),!.

quit :- retract(running(1)),
        retractall(running(_)),
        retractall(onQuest(_)),
        retractall(posisi(_,_)),
        retractall(gameOver),
        retractall(gameWin),
        retractall(nama(_)),
        retractall(gold(_)),
        retractall(chapter(_)),
        retractall(daily(_)),
        retractall(victory),
        retractall(quest(_,_,_,_,_)),
        retractall(currQuest(_,_,_,_,_)),
        retractall(character(_,_,_,_,_,_,_,_)),
        retractall(enemy(_,_,_,_,_)),
        retractall(inventory(_,_,_,_,_,_,_)),
        retractall(armor(_)),
        retractall(senjata(_)),
        retractall(wall(_,_,_,_)),
        retractall(dungeon(_,_)),
        retractall(panjang(_)),
        retractall(lebar(_)),
        write('Terima kasih telah bermain'),nl,
        !.
        % sleep(5),
        % halt.
saveGame :-
	\+running(_),
	write('Perintah ini hanya bisa dipakai setelah pemainan dimulai.'), nl,
	write('Gunakan perintah "start." untuk memulai permainan.'), nl, !.

saveGame :-
        write('Masukkan nama file : '),read(FileName),
        tell(FileName),
            nama(Username),
            write(nama(Username)),write('.'),nl,
            gold(Gold),
            write(gold(Gold)),write('.'),nl,
            character(Jenis, HP, Attack, Defense, Level, Exp, MaxExp, MaxHP),
            write(character(Jenis, HP, Attack, Defense, Level, Exp, MaxExp, MaxHP)),write('.'),nl,
            (onQuest(Quest) ->
            write(onQuest(Quest)),write('.'),nl;true),
            posisi(Absis,Ordinat),
            write(posisi(Absis,Ordinat)),write('.'),nl,
            chapter(Chapter),
            write(chapter(Chapter)),write('.'),nl,
            (daily(Daily) ->
            write(daily(Daily)),write('.'),nl;true),
            quest(Slime,Goblin,Wolf,Golem,Wizard),
            write(quest(Slime,Goblin,Wolf,Golem,Wizard)),write('.'),nl,
            (currQuest(Slime1,Goblin1,Wolf1,Golem1,Wizard1) ->
            write(currQuest(Slime1,Goblin1,Wolf1,Golem1,Wizard1)),write('.'),nl;true),
            (inventory(ID,Pengguna,JenisItem,Nama,HP1,Att,Def) ->
            write(inventory(ID,Pengguna,JenisItem,Nama,HP1,Att,Def)),write('.'),nl;true),
            (armor(A)->
            write(armor(A)),write('.'),nl;true),
            (senjata(B) ->
            write(senjata(B)),write('.'),nl;true),
            wall(C,D,E,F),
            write(wall(C,D,E,F)),write('.'),nl,
            dungeon(G,H),
            write(dungeon(G,H)),write('.'),nl,
            panjang(I),
            write(panjang(I)),write('.'),nl,
            lebar(J),
            write(lebar(J)),write('.'),nl,
        told,
        write('File telah disimpan dengan nama : '), write(FileName),
        !.

loadGame :-
	running(_),
	write('Kamu sudah memulai permainan.'), nl, !.

loadGame:-
  write('Masukkan nama file : '), read(FileName),
  (\+file_exists(FileName) -> write('\n!File tidak ditemukan!\n'), nl, !,fail
  ;open(FileName, read, Stream),
        readFileLines(Stream,Lines),
    close(Stream),
    assertaLine(Lines),
    asserta(running(1))), write('\nFile berhasil di-load!\n'),!.

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
