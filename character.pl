/* File : character.pl */

:-dynamic(character/7).

% character(Jenis, HP, attack, defense, level, exp, base exp, max HP)
% character(A,B,C,D,E,F,G,H)
initChar :- write('Silahkan pilih role : '), read(Role),
            (Role = 'archer' ->asserta(character('archer', 500,120,50,1,0,300, 500)) ;
            Role = 'swordsman' ->asserta(character('swordsman', 700,130,60,1,0,300,700));
              Role = 'sorcerer' ->asserta(character('sorcerer', 600,160,40,1,0,300,600))).
levelUp :- character(A,B,C,D,E,F,G,H), F >= G,
          Hnew is H + 100 * E,
          Cnew is C + 50 * E,
          Dnew is D + 30 * E,
          Enew is E + 1,
          Fnew is F mod G,
          Gnew is G + E * 100,
          retract(character(A,B,C,D,E,F,G,H)), asserta(character(A,B,Cnew,Dnew,Enew,Fnew,Gnew, Hnew)),
          write('Level up '), write(E), write(' -> '),write(Enew),nl,!.

status :- character(A,B,C,D,E,F,G,H),
          write('Job      : '), write(A),nl,
          write('HP       : '), write(B),write('/'),write(H),nl,
          write('Attack   : '), write(C),nl,
          write('Defense  : '), write(D),nl,
          write('Level    : '), write(E),nl,
          write('Exp      : '), write(F),write('/'),write(G),nl,!.
