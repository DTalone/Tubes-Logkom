/* File : enemy.pl */

:-dynamic(enemy/5).

%enemy(A,B,C,D,E)
%enemy(type, hp, attack, defense, level).
% character(A,B,C,D,E,F,G,H)
% character(Jenis, HP, attack, defense, level, exp, base exp, max HP)
initEnemy :-asserta(enemy(slime, 250,70,10,1)),
            asserta(enemy(goblin, 150,100,50,1)),
            asserta(enemy(wolf, 300,150,70,1)),
            asserta(enemy(golem, 400,90,150,1)),
            asserta(enemy(wizard, 450,200,100,1)),
            asserta(enemy(rajagledek, 5000,1000,500,100)).
statusEnemy :- enemy(A,B,C,D,E),
          write('Type     : '), write(A),nl,
          write('HP       : '), write(B),nl,
          write('Attack   : '), write(C),nl,
          write('Defense  : '), write(D),nl,
          write('Level    : '), write(E),nl.

adjusmentEnemy(X):- X = slime, character(_,_,_,_,E,_,_,_),
            enemy(X, F,G,H,I),
            Ben is F + 47 * (E - I), %70
            Cen is G + 9 * (E - I), %50
            Den is H + 4 * (E - I), %30
            Inew is E,
            retract(enemy(X,F,G,H,I)),
            asserta(enemy(X, Ben,Cen,Den,Inew)),!.

adjusmentEnemy(X):- X = goblin, character(_,_,_,_,E,_,_,_),
            enemy(X, F,G,H,I),
            Ben is F + 48 * (E - I), %100
            Cen is G + 9 * (E - I), %70
            Den is H + 4 * (E - I), %40
            Inew is E,
            retract(enemy(X,F,G,H,I)),
            asserta(enemy(X, Ben,Cen,Den,Inew)),!.
adjusmentEnemy(X):- X = wolf, character(_,_,_,_,E,_,_,_),
            enemy(X, F,G,H,I),
            Ben is F + 47 * (E - I), %130
            Cen is G + 8 * (E - I), %90
            Den is H + 4 * (E - I), %50
            Inew is E,
            retract(enemy(X,F,G,H,I)),
            asserta(enemy(X, Ben,Cen,Den,Inew)),!.
adjusmentEnemy(X):- X = golem, character(_,_,_,_,E,_,_,_),
            enemy(X, F,G,H,I),
            Ben is F + 46 * (E - I), %160
            Cen is G + 9 * (E - I), %100
            Den is H + 3 * (E - I), %60
            Inew is E,
            retract(enemy(X,F,G,H,I)),
            asserta(enemy(X, Ben,Cen,Den,Inew)),!.
adjusmentEnemy(X):- X = wizard, character(_,_,_,_,E,_,_,_),
            enemy(X, F,G,H,I),
            Ben is F + 45 * (E - I), %190
            Cen is G + 8 * (E - I), %120
            Den is H + 4 * (E - I), %70
            Inew is E,
            retract(enemy(X,F,G,H,I)),
            asserta(enemy(X, Ben,Cen,Den,Inew)),!.
