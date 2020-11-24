/* File : character.pl */

:-dynamic(character/7).

% character(Jenis, HP, attack, defense, level, exp, base exp)
% character(A,B,C,D,E,F,G)
initChar :- write('Silahkan pilih role : '), nl,
            write(' - archer'),nl,
            write(' - swordsman'),nl,
            write(' - sorcerer'),nl,read(Role),
            (Role = 'archer' ->asserta(character('archer', 200,120,50,1,0,300)) ;
            Role = 'swordsman' ->asserta(character('swordsman', 300,130,60,1,0,300));
            Role = 'sorcerer' ->asserta(character('sorcerer', 250,160,40,1,400,300))).

levelUp :- character(A,B,C,D,E,F,G), F > G,
          Bnew is B + 100 * E,
          Cnew is C + 50 * E,
          Dnew is D + 30 * E,
          Enew is E + 1,
          Fnew is F mod G,
          Gnew is G + E * 100,
          retract(character(A,B,C,D,E,F,G)), asserta(character(A,Bnew,Cnew,Dnew,Enew,Fnew,Gnew)),
          write('Level up '), write(E), write(' -> '),write(Enew),nl.
