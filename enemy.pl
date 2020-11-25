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
            Ben is F + 70 * (E - I),
            Cen is G + 50 * (E - I),
            Den is H + 30 * (E - I),
            retract(enemy(X,F,G,H,I)),
            asserta(enemy(X, Ben,Cen,Den,I)),!.

adjusmentEnemy(X):- X = goblin, character(_,_,_,_,E,_,_,_),
            enemy(X, F,G,H,I),
            Ben is F + 100 * (E - I),
            Cen is G + 70 * (E - I),
            Den is H + 40 * (E - I),
            retract(enemy(X,F,G,H,I)),
            asserta(enemy(X, Ben,Cen,Den,I)),!.
adjusmentEnemy(X):- X = wolf, character(_,_,_,_,E,_,_,_),
            enemy(X, F,G,H,I),
            Ben is F + 130 * (E - I),
            Cen is G + 90 * (E - I),
            Den is H + 50 * (E - I),
            retract(enemy(X,F,G,H,I)),
            asserta(enemy(X, Ben,Cen,Den,I)),!.
adjusmentEnemy(X):- X = golem, character(_,_,_,_,E,_,_,_),
            enemy(X, F,G,H,I),
            Ben is F + 160 * (E - I),
            Cen is G + 100 * (E - I),
            Den is H + 60 * (E - I),
            retract(enemy(X,F,G,H,I)),
            asserta(enemy(X, Ben,Cen,Den,I)),!.
adjusmentEnemy(X):- X = wizard, character(_,_,_,_,E,_,_,_),
            enemy(X, F,G,H,I),
            Ben is F + 190 * (E - I),
            Cen is G + 120 * (E - I),
            Den is H + 70 * (E - I),
            retract(enemy(X,F,G,H,I)),
            asserta(enemy(X, Ben,Cen,Den,I)),!.
