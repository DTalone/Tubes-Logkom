:- dynamic(round/1). %tanda apabila sedang battle
:- dynamic(kabur/0).  %tanda jika berhasil kabur
:- dynamic(currEnemy/6). %menyimpan enemy sekarang

battle(A) :- enemy(A,B,C,D,E),
          asserta(round(0)),
          adjusmentEnemy(A),
          asserta(currEnemy(A,B,C,D,E,B)),
          repeat,
          round(Round), Roundnew is Round + 1,
          retract(round(Round)), asserta(round(Roundnew)),
          turnUser,
          endCondition,
          printStat,
          turnEnemy,
          printStat,
          endCondition.

turnUser :- write('Apa yang akan Anda lakukan ?'),nl,
            write('- attack.'),nl,
            write('- specialAttack.'),nl,
            write('- run.'),nl,
            write('- usePotions.'),nl,
            read(X),X.

turnEnemy :- character(A,B,C,D,E,F,G,H),
            currEnemy(_,_,K,_,_,_),
            Bnew is B - K + D,
            retract(character(A,B,C,D,E,F,G,H)),
            asserta(character(A,Bnew,C,D,E,F,G,H)),
            write('awww enemy menyerang'), nl.

printStat :- character(A,B,_,_,_,_,_,H),currEnemy(I,J,_,_,_,K),
          write('Job      : '), write(A),write('          '),write('Type     : '), write(I),nl,
          write('HP       : '), write(B),write('/'),write(H),write('          '),write('HP       : '), write(J),write('/'),write(K),nl.

attack :- character(_,_,X,_,_,_,_,_),
          currEnemy(A,B,C,D,E,F),
          Bnew is B - X + D,
          retract(currEnemy(A,B,C,D,E,F)),
          asserta(currEnemy(A,Bnew,C,D,E,F)),
          write('serangan berhasil'),nl.
          
endCondition:-  character(_,X,_,_,_,_,_,_), X < 0, write('Kamu Kalah'),nl,!.
endCondition:- currEnemy(_,W,_,_,_,_), W < 0 , write('Kamu menang'),nl,!.
%
% attack :-
%
%
% attack :-
%
% specialAttack :-
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

run :-
    gameOver, lose, !.
run :-
    \+ gameOver,
    \+ kabur,
    write('Run tidak berhasil!'), nl,
    write('Semangat!'), nl, !.

run :- random(1,100,X),
    ( X < 50 -> write(X); write('Tidak berhasil'),retract(kabur)), !.
