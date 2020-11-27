/* File : character.pl */

:-dynamic(character/8).

% character(Jenis, HP, attack, defense, level, exp, base exp, max HP)
% character(A,B,C,D,E,F,G,H)
initChar :- write('Role yang tersedia'),nl,
            write('1. Archer.'),nl,
            write('2. Swordsman.'),nl,
            write('3. Sorcerer.'),nl,
            write('Masukkan angka : '), read(X),nl,
            (X =:= 1 ->asserta(character('archer', 500,120,50,1,0,300, 500)) ;
            X =:= 2 ->asserta(character('swordsman', 700,130,60,1,0,300,700));
              X =:= 3 ->asserta(character('sorcerer', 600,160,40,1,0,300,600))).
levelUp :- character(A,B,C,D,E,F,G,H), F >= G,
          Hnew is H + 43 * E,
          Cnew is C + 8 * E,
          Dnew is D + 4 * E,
          Enew is E + 1,
          Fnew is F mod G,
          Gnew is G + E * 100,
          retract(character(A,B,C,D,E,F,G,H)), asserta(character(A,Hnew,Cnew,Dnew,Enew,Fnew,Gnew, Hnew)),
          write('Level up '), write(E), write(' -> '),write(Enew),nl,!.
levelUp :-!.

status :- character(A,B,C,D,E,F,G,H),gold(Gold),\+senjata(_),\+armor(_),
	  write('###########################################'),nl,
	  write('#              STATUS PEMAIN              #'),nl,
	  write('###########################################'),nl,
          write('Job      : '), write(A),nl,
          write('HP       : '), write(B),write('/'),write(H),nl,
          write('Attack   : '), write(C),nl,
          write('Defense  : '), write(D),nl,
          write('Level    : '), write(E),nl,
          write('Exp      : '), write(F),write('/'),write(G),nl,
          write('Gold     : '), write(Gold),nl,!.

status :- character(A,B,C,D,E,F,G,H),gold(Gold),senjata(Senjata),\+armor(_),
	  write('###########################################'),nl,
	  write('#              STATUS PEMAIN              #'),nl,
	  write('###########################################'),nl,
          write('Job      : '), write(A),nl,
          write('HP       : '), write(B),write('/'),write(H),nl,
          write('Attack   : '), write(C),nl,
          write('Defense  : '), write(D),nl,
          write('Level    : '), write(E),nl,
          write('Exp      : '), write(F),write('/'),write(G),nl,
          write('Gold     : '), write(Gold),nl,
	  write('Senjata  : '), write(Senjata),nl,!.

status :- character(A,B,C,D,E,F,G,H),gold(Gold),\+senjata(_),armor(Armor),
	  write('###########################################'),nl,
	  write('#              STATUS PEMAIN              #'),nl,
	  write('###########################################'),nl,
          write('Job      : '), write(A),nl,
          write('HP       : '), write(B),write('/'),write(H),nl,
          write('Attack   : '), write(C),nl,
          write('Defense  : '), write(D),nl,
          write('Level    : '), write(E),nl,
          write('Exp      : '), write(F),write('/'),write(G),nl,
          write('Gold     : '), write(Gold),nl,
	  write('Armor    : '), write(Armor),nl,!.

status :- character(A,B,C,D,E,F,G,H),gold(Gold),senjata(Senjata),armor(Armor),
	  write('###########################################'),nl,
	  write('#              STATUS PEMAIN              #'),nl,
	  write('###########################################'),nl,
          write('Job      : '), write(A),nl,
          write('HP       : '), write(B),write('/'),write(H),nl,
          write('Attack   : '), write(C),nl,
          write('Defense  : '), write(D),nl,
          write('Level    : '), write(E),nl,
          write('Exp      : '), write(F),write('/'),write(G),nl,
          write('Gold     : '), write(Gold),nl,
	  write('Senjata  : '), write(Senjata),nl,
	  write('Armor    : '), write(Armor),nl,!.
