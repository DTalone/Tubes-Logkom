:- dynamic(battle/1).
:- dynamic(kabur/0).


run :-
    gameOver, lose, !.
run :-
    \+ gameOver,
    \+ kabur,
    write('Run tidak berhasil!'), nl,
    write('Semangat!'), nl, !.

run :- random(1,100,X),
    ( X < 50 -> write(X); write('Tidak berhasil'),retract(kabur)), !.
