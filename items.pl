/* File : items.pl */
/* item(ID,Pengguna,Jenis,Nama,HP,Att,Def) */

:- dynamic(inventory/7).
:- dynamic(senjata/1).
:- dynamic(armor/1).

maxInventory(100).

/* Kategori 1 Senjata */
item(1,archer,senjata,crossbow,0,30,0).
item(2,archer,senjata,longbow,0,50,0).
item(3,swordsman,senjata,haedonggum,0,30,0).
item(4,swordsman,senjata,flamberge,0,50,0).
item(5,sorcerer,senjata,magic_staff,0,40,0).

/* Kategori 2 Armor*/
item(6,archer,armor,lighter_armor,0,0,30).
item(7,swordsman,armor,heavy_armor,0,0,40).
item(8,sorcerer,armor,magic_robe,0,0,35).

/* Kategori 3 Potion */
item(9,archer,potion,health_potion_s,50,0,0).
item(10,swordsman,potion,health_potion_s,50,0,0).
item(11,sorcerer,potion,health_potion_s,50,0,0).
item(12,archer,potion,health_potion_m,100,0,0).
item(13,swordsman,potion,health_potion_m,100,0,0).
item(14,sorcerer,potion,health_potion_m,100,0,0).
item(15,archer,potion,health_potion_l,300,0,0).
item(16,swordsman,potion,health_potion_l,300,0,0).
item(17,sorcerer,potion,health_potion_l,300,0,0).
item(18,archer,potion,enhancer_attack,0,30,0).
item(19,swordsman,potion,enhancer_attack,0,30,0).
item(20,sorcerer,potion,enhancer_attack,0,30,0).
item(21,archer,potion,enhancer_defense,0,0,30).
item(22,swordsman,potion,enhancer_defense,0,0,30).
item(23,sorcerer,potion,enhancer_defense,0,0,30).


cekIsi(Length) :-
    	length(inventory,Length).

isFull :-
    	cekIsi(Length),
    	Length == 100.

addInventory(_) :-
	cekIsi(Length),
	maxInventory(Max),
	Length >= Max,nl,
	write('Inventory sudah penuh.'),
	!,fail.

addInventory(Nama) :-
	item(ID,Pengguna,Jenis,Nama,HP,Att,Def),
	asserta(inventory(ID,Pengguna,Jenis,Nama,HP,Att,Def)),nl,
	write('Item berhasil disimpan ke dalam inventory.'),!.

delInventory(Nama) :-
	running(_),
	\+inventory(_,_,_,Nama,_,_,_),nl,
	write('Tidak ada item tersebut di inventory Anda.'),nl,
	!.

delInventory(Nama) :-
	running(_),
	retract(inventory(_,_,_,Nama,_,_,_)),nl,
	write(Nama),
	write(' berhasil dihapus dari inventory.'),nl,
	!.

use(Nama) :-
	running(_),
	\+inventory(_,_,_,Nama,_,_,_),nl,
	write('Tidak ada item tersebut di inventory Anda.'),nl,
	!.

use(Nama) :-
	running(_),
	item(_,Pengguna,_,Nama,_,_,_),
	character(Jenis,_,_,_,_,_,_,_),
	Jenis \== Pengguna,nl,
	write('Pemain tidak dapat menggunakan item ini.'),nl,
	!.

use(Nama) :-
	running(_),
	\+senjata(_),
	item(_,Pengguna,JenisIt,Nama,_,Att,_),
	character(Jenis,Health,Attack,Defense,E,F,G,Hmax),
	Jenis==Pengguna,
	JenisIt=='senjata',
	Hnew is Health,
	Anew is Attack + Att,
	Dnew is Defense,
	retract(inventory(_,_,_,Nama,_,_,_)),
	retract(character(Jenis,Health,Attack,Defense,E,F,G,Hmax)),
	asserta(character(Jenis,Hnew,Anew,Dnew,E,F,G,Hmax)),
	asserta(senjata(Nama)),nl,
	write('Berhasil memakai senjata'),nl,
	!.

use(Nama) :-
	running(_),
	senjata(Cur),
	item(_,Pengguna,JenisIt,Nama,_,Att,Def),
	item(_,_,_,Cur,_,AttCur,_),
	character(Jenis,Health,Attack,Defense,E,F,G,Hmax),
	Jenis==Pengguna,
	JenisIt=='senjata',
	Hnew is Health,
	Anew is Attack + Att - AttCur,
	Dnew is Defense + Def,
	retract(senjata(_)),
	retract(inventory(_,_,_,Nama,_,_,_)),
	retract(character(Jenis,Health,Attack,Defense,E,F,G,Hmax)),
	asserta(character(Jenis,Hnew,Anew,Dnew,E,F,G,Hmax)),
	asserta(inventory(_,_,_,Cur,_,_,_)),
	asserta(senjata(Nama)),nl,
	write('Berhasil mengganti senjata'),nl,
	!.

use(Nama) :-
	running(_),
	\+armor(_),
	item(_,Pengguna,JenisIt,Nama,_,_,Def),
	character(Jenis,Health,Attack,Defense,E,F,G,Hmax),
	Jenis==Pengguna,
	JenisIt=='armor',
	Hnew is Health,
	Anew is Attack,
	Dnew is Defense + Def,
	retract(inventory(_,_,_,Nama,_,_,_)),
	retract(character(Jenis,Health,Attack,Defense,E,F,G,Hmax)),
	asserta(character(Jenis,Hnew,Anew,Dnew,E,F,G,Hmax)),
	asserta(armor(Nama)),nl,
	write('Berhasil memakai armor'),nl,
	!.

use(Nama) :-
	running(_),
	armor(Cur),
	item(_,Pengguna,JenisIt,Nama,_,Att,Def),
	item(_,_,_,Cur,_,_,DefCur),
	character(Jenis,Health,Attack,Defense,E,F,G,Hmax),
	Jenis==Pengguna,
	JenisIt=='armor',
	Hnew is Health,
	Anew is Attack + Att,
	Dnew is Defense + Def - DefCur,
	retract(armor(_)),
	retract(inventory(_,_,_,Nama,_,_,_)),
	retract(character(Jenis,Health,Attack,Defense,E,F,G,Hmax)),
	asserta(character(Jenis,Hnew,Anew,Dnew,E,F,G,Hmax)),
	asserta(inventory(_,_,_,Cur,_,_,_)),
	asserta(armor(Nama)),nl,
	write('Berhasil mengganti armor'),nl,
	!.

usePotions(Nama) :-
	\+inventory(_,_,_,Nama,_,_,_),
	write('Tidak ada item tersebut di inventory Anda.'),
	!,fail.

usePotions(Nama) :-
	item(_,_,_,Nama,HP,Att,Def),
	character(Jenis,Health,Attack,Defense,E,F,G,Hmax),
	Hnew is Health + HP * Health,
	Anew is Attack + Att * Attack /100,
	Dnew is Defense + Def * Defense /100,
	Hnew > Hmax,
	retract(inventory(_,_,_,Nama,_,_,_)),
	retract(character(Jenis,Health,Attack,Defense,E,F,G,Hmax)),
	asserta(character(Jenis,Hmax,Anew,Dnew,E,F,G,Hmax)),nl,nl,
	write('Potion berhasil dipakai.'),nl,
	!.

usePotions(Nama) :-
	item(_,_,_,Nama,HP,Att,Def),
	character(Jenis,Health,Attack,Defense,E,F,G,Hmax),
	Hnew is Health + HP * Health,
	Anew is Attack + Att * Attack /100,
	Dnew is Defense + Def * Defense /100,
	Hnew =< Hmax,
	retract(inventory(_,_,_,Nama,_,_,_)),
	retract(character(Jenis,Health,Attack,Defense,E,F,G,Hmax)),
	asserta(character(Jenis,Hnew,Anew,Dnew,E,F,G,Hmax)),nl,nl,
	write('Potion berhasil dipakai.'),nl,
	!.

print_list([]).
print_list([A|B]) :-
  	write(A),nl,
  	print_list(B).

cekInventory :-
	running(_),
	\+inventory(_,_,_,_,_,_,_),nl,
	write('Inventory kosong'),nl,
	!.

cekInventory :-
	running(_),nl,
	write('##########################################'),nl,
	write('#            INVENTORY PEMAIN            #'),nl,
	write('##########################################'),nl,
	findall(Nama,inventory(_,_,_,Nama,_,_,_),List),
	print_list(List),
	!.

cekPotions :-
	running(_),nl,
	\+inventory(_,_,'potion',_,_,_,_),
	write('Potion tidak ada'),nl,nl,
	!.

cekPotions :-
	running(_),
	write('###########################################'),nl,
	write('#              POTION PEMAIN              #'),nl,
	write('###########################################'),nl,
	findall(Nama,inventory(_,_,'potion',Nama,_,_,_),List),
	print_list(List),nl,
	write('Mau pakai yang mana? (Ketik nama potion diakhiri tanda \'.\') '),nl, read(X),
	usePotions(X),
	!.
