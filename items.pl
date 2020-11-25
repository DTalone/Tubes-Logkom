/* File : items.pl */
/* item(ID,Pengguna,Nama,HP,Att,Def) */

:- dynamic(inventory/6).

maxInventory(100).

/* Kategori 1 Senjata */
item(1,archer,crossbow,0,20,0).
item(2,archer,longbow,0,30,0).
item(3,swordsman,haedonggum,0,20,0).
item(4,swordsman,flamberge,0,30,0).
item(5,sorcerer,magic_staff,0,20,0).

/* Kategori 2 Armor*/
item(6,archer,lighter_armor,0,0,30).
item(7,swordsman,heavy_armor,0,0,40).
item(8,sorcerer,magic_robe,0,0,35).

/* Kategori 3 Potion */
item(9,archer,health_potion_s,10,0,0).
item(10,swordsman,health_potion_s,10,0,0).
item(11,sorcerer,health_potion_s,10,0,0).
item(12,archer,health_potion_m,20,0,0).
item(13,swordsman,health_potion_m,20,0,0).
item(14,sorcerer,health_potion_m,20,0,0).
item(15,archer,health_potion_l,40,0,0).
item(16,swordsman,health_potion_l,40,0,0).
item(17,sorcerer,health_potion_l,40,0,0).
item(18,archer,enhancer_attack,0,15,0).
item(19,swordsman,enhancer_attack,0,15,0).
item(20,sorcerer,enhancer_attack,0,15,0).
item(21,archer,enhancer_defense,0,0,15).
item(22,swordsman,enhancer_defense,0,0,15).
item(23,sorcerer,enhancer_defense,0,0,15).
item(24,archer,freeze_potion,0,0,0).
item(25,swordsman,freeze_potion,0,0,0).
item(26,sorcerer,freeze_potion,0,0,0).


cekIsi(Length) :-
    	length(inventory,Length).

isFull :-
    	cekIsi(Length),
    	Length == 100.

addInventory(_) :-
	cekIsi(Length),
	maxInventory(Max),
	Length >= Max,
	write('Inventory sudah penuh.'),
	!,fail.

addInventory(Nama) :-
	item(ID,Pengguna,Nama,HP,Att,Def),
	asserta(inventory(ID,Pengguna,Nama,HP,Att,Def)),
	write('Item berhasil disimpan ke dalam inventory.'),!.

delInventory(Nama) :-
	\+inventory(_,_,Nama,_,_,_),
	write('Tidak ada item tersebut di inventory Anda.'),
	!,fail.

delInventory(Nama) :-
	retract(inventory(_,_,Nama,_,_,_)),
	write(Nama),
	write(' berhasil dihapus dari inventory.'),
	!.

use(Nama) :-
	\+inventory(_,_,Nama,_,_,_),
	write('Tidak ada item tersebut di inventory Anda.'),
	!,fail.

use(Nama) :-
	item(_,Pengguna,Nama,_,_,_),
	character(Jenis,_,_,_,_,_,_,_),
	Jenis \== Pengguna,
	write('Pemain tidak dapat menggunakan item ini.'),
	!.

use(Nama) :-
	item(_,Pengguna,Nama,HP,Att,Def),
	character(Jenis,Health,Attack,Defense,E,F,G,Hmax),
	Jenis=Pengguna,
	Hnew is Health + HP * Health,
	Anew is Attack + Att * Attack,
	Dnew is Defense + Def * Defense,
	Hnew > Hmax,
	retract(inventory(_,_,Nama,_,_,_)),
	retract(character(Jenis,Health,Attack,Defense,E,F,G,Hmax)),
	asserta(character(Jenis,Hmax,Anew,Dnew,E,F,G,Hmax)),
	!.

use(Nama) :-
	item(_,Pengguna,Nama,HP,Att,Def),
	character(Jenis,Health,Attack,Defense,E,F,G,Hmax),
	Jenis=Pengguna,
	Hnew is Health + HP * Health,
	Anew is Attack + Att * Attack,
	Dnew is Defense + Def * Defense,
	Hnew =< Hmax,
	retract(inventory(_,_,Nama,_,_,_)),
	retract(character(Jenis,Health,Attack,Defense,E,F,G,Hmax)),
	asserta(character(Jenis,Hnew,Anew,Dnew,E,F,G,Hmax)),
	!.
