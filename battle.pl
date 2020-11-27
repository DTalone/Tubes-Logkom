:- dynamic(round/1). %tanda apabila sedang battle
:- dynamic(kabur/0).  %tanda jika berhasil kabur
:- dynamic(currEnemy/6). %menyimpan enemy sekarang

battle(A) :- adjusmentEnemy(A),
          enemy(A,B,C,D,E),
          asserta(round(1)),
          asserta(currEnemy(A,B,C,D,E,B)),
          printStat,
          fight,
          retractall(currEnemy(_,_,_,_,_,_)),
          retractall(round(_)),
          (kabur -> true
          ;gameOver -> true
          ;victory -> character(S,T,U,V,W,X,Y,Z),
          gold(G),
          Xnew is X + E * 100,
          Gnew is G + 30,
          retract(character(S,T,U,V,W,X,Y,Z)),
          retract(gold(G)),
          asserta(character(S,T,U,V,W,Xnew,Y,Z))),
          asserta(gold(Gnew)),
          levelUp,!.

bossMode:-write('Selamat Datang di Boss Mode, Ini merupakan akhir dari perjalanan Anda!\n'),
          enemy('rajagledek',B,C,D,E),
          asserta(round(1)),
          asserta(currEnemy('rajagledek',B,C,D,E,B)),
          printStat,
          fight,
          retractall(currEnemy(_,_,_,_,_)),
          retractall(round(_)),
          (victory ->
          write('##############################################'),nl,
          write('#     Selamat Anda memenangkan game ini!     #'),nl,
          write('##############################################'),nl,nl,asserta(gameWin);asserta(gameOver),write('Game Over'),nl,quit).

fight :-  repeat,
          turnUser,
          currEnemy(_,W,_,_,_,_),
          (endCondition(W,2) -> asserta(victory),write('Kamu menang'),nl,!;
          kabur -> !;
          turnEnemy, character(_,X,_,_,_,_,_,_),(endCondition(X,1) -> write('Kamu kalah'),nl,asserta(gameOver),!;
                                                                      round(Round), Roundnew is Round + 1, retract(round(Round)), asserta(round(Roundnew)),fight)).

turnUser :- write('Apa yang akan Anda lakukan ?'),nl,
            write('1. Attack.'),nl,
            write('2. Special Attack.'),nl,
            write('3. Kabur.'),nl,
            write('4. Use Potions.'),nl,
            write('Masukkan angka : '), read(X),nl,
            (X =:= 1 -> attack
            ;X =:= 2 -> specialAttack
            ;X =:= 3 -> run
            ;X =:= 4 -> cekPotions),
            (kabur ->
              write('################################'),nl,
              write('#     Anda berhasil kabur!     #\n'),
              write('################################'),nl,!;printStat).

turnEnemy :- character(A,B,C,D,E,F,G,H),
            currEnemy(_,_,K,_,_,_),
            Bnew is B - K + D,
            retract(character(A,B,C,D,E,F,G,H)),
            asserta(character(A,Bnew,C,D,E,F,G,H)),nl,
            write('##########Giliran Musuh!##########'),nl,
            write('#    Awwww sakit banget broo!    #\n'),
            write('##################################'),nl,nl, printStat, nl.

printStat :- character(A,B,_,_,_,_,_,H),currEnemy(I,J,_,_,_,K), round(Round), B < 0,
          write('Giliran ke-'),write(Round),nl,
          write('Job      : '), write(A),write('           '),write('Type       : '), write(I),nl,
          write('HP       : '), write('0'),write('/'),write(H),write('          '),write('HP       : '), write(J),write('/'),write(K),nl,!.

printStat :- character(A,B,_,_,_,_,_,H),currEnemy(I,J,_,_,_,K), round(Round), J < 0,
          write('Giliran ke-'),write(Round),nl,
          write('Job      : '), write(A),write('           '),write('Type       : '), write(I),nl,
          write('HP       : '), write(B),write('/'),write(H),write('          '),write('HP       : '), write('0'),write('/'),write(K),nl,!.

printStat :- character(A,B,_,_,_,_,_,H),currEnemy(I,J,_,_,_,K), round(Round),
          write('Giliran ke-'),write(Round),nl,
          write('Job      : '), write(A),write('           '),write('Type       : '), write(I),nl,
          write('HP       : '), write(B),write('/'),write(H),write('          '),write('HP       : '), write(J),write('/'),write(K),nl,!.
attack :- character(_,_,X,_,_,_,_,_),
          currEnemy(A,B,C,D,E,F),
          Bnew is B - X + D, Bnew < B,
          retract(currEnemy(A,B,C,D,E,F)),
          asserta(currEnemy(A,Bnew,C,D,E,F)),nl,
          write('##########Giliran Anda!!##########'),nl,
          write('#    Damagenya ga nahan broo!    #\n'),
          write('##################################'),nl,nl.
attack :- character(_,_,X,_,_,_,_,_),
          currEnemy(A,B,C,D,E,F),
          Bnew is B - X + D, Bnew > B, Bnew1 is B - 10,
          retract(currEnemy(A,B,C,D,E,F)),
          asserta(currEnemy(A,Bnew1,C,D,E,F)),nl,
          write('##########Giliran Anda!!##########'),nl,
          write('#    Damagenya ga nahan broo!    #\n'),
          write('##################################'),nl,nl.
specialAttack :- character(_,_,Y,_,_,_,_,_),round(X),Z is X mod 3,
                (Z =:= 0-> nl,
                  write('##########Giliran Anda!!##########'),nl,
                  write('#    Sakit banget Bang Jago!!    #\n'),
                  write('##################################'),nl,currEnemy(A,B,C,D,E,F),
                  Bnew is B - 2 * Y,retract(currEnemy(A,B,C,D,E,F)),asserta(currEnemy(A,Bnew,C,D,E,F)),nl;
                  write('Serangan ini tidak bisa digunakan!\n'),fail).
% specialAttack :- fail.
endCondition(X,Y):- Y = 1,   X < 1, nl,!.
endCondition(X,Y):- Y = 2,  X < 1 , nl,!.
%
% attack :-
%
%
% attack :-
%

% specialAttack :-
%
%
% specialAttack :-
%
% usePotions :-
%
% usePotions :-
%
% usePotions :-
%

run :- random(1,100,X),  retractall(kabur),nl,
    ( X < 25 -> asserta(kabur),!;write('Anda tidak berhasil kabur!\n')).
