/* File : items.pl */
/* item(ID,Pengguna,Jenis,Nama,HP,Att,Def) */

:- dynamic(inventory/7).
:- dynamic(senjata/1).
:- dynamic(armor/1).

maxInventory(100).

/* Kategori 1 Senjata */
item(1,archer,senjata,crossbow,0,20,0).
item(2,archer,senjata,longbow,0,30,0).
item(3,swordsman,senjata,haedonggum,0,20,0).
item(4,swordsman,senjata,flamberge,0,30,0).
item(5,sorcerer,senjata,magic_staff,0,20,0).

/* Kategori 2 Armor*/
item(6,archer,armor,lighter_armor,0,0,30).
item(7,swordsman,armor,heavy_armor,0,0,40).
item(8,sorcerer,armor,magic_robe,0,0,35).

/* Kategori 3 Potion */
item(9,archer,potion,health_potion_s,10,0,0).
item(10,swordsman,potion,health_potion_s,10,0,0).
item(11,sorcerer,potion,health_potion_s,10,0,0).
item(12,archer,potion,health_potion_m,20,0,0).
item(13,swordsman,potion,health_potion_m,20,0,0).
item(14,sorcerer,potion,health_potion_m,20,0,0).
item(15,archer,potion,health_potion_l,40,0,0).
item(16,swordsman,potion,health_potion_l,40,0,0).
item(17,sorcerer,potion,health_potion_l,40,0,0).
item(18,archer,potion,enhancer_attack,0,15,0).
item(19,swordsman,potion,enhancer_attack,0,15,0).
item(20,sorcerer,potion,enhancer_attack,0,15,0).
item(21,archer,potion,enhancer_defense,0,0,15).
item(22,swordsman,potion,enhancer_defense,0,0,15).
item(23,sorcerer,potion,enhancer_defense,0,0,15).
item(24,archer,potion,freeze_potion,0,0,0).
item(25,swordsman,potion,freeze_potion,0,0,0).
item(26,sorcerer,potion,freeze_potion,0,0,0).


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
	item(ID,Pengguna,Jenis,Nama,HP,Att,Def),
	asserta(inventory(ID,Pengguna,Jenis,Nama,HP,Att,Def)),
	write('Item berhasil disimpan ke dalam inventory.'),!.

delInventory(Nama) :-
	\+inventory(_,_,_,Nama,_,_,_),
	write('Tidak ada item tersebut di inventory Anda.'),
	!,fail.

delInventory(Nama) :-
	retract(inventory(_,_,_,Nama,_,_,_)),
	write(Nama),
	write(' berhasil dihapus dari inventory.'),
	!.

use(Nama) :-
	\+inventory(_,_,_,Nama,_,_,_),
	write('Tidak ada item tersebut di inventory Anda.'),
	!,fail.

use(Nama) :-
	item(_,Pengguna,_,Nama,_,_,_),
	character(Jenis,_,_,_,_,_,_,_),
	Jenis \== Pengguna,
	write('Pemain tidak dapat menggunakan item ini.'),
	!.

use(Nama) :-
	\+senjata(_),
	item(_,Pengguna,JenisIt,Nama,HP,Att,Def),
	character(Jenis,Health,Attack,Defense,E,F,G,Hmax),
	Jenis=Pengguna,
	JenisIt='senjata', 
	Weapon is Nama,
	Hnew is Health + HP,
	Anew is Attack + Att,
	Dnew is Defense + Def,
	Hnew > Hmax,
	retract(inventory(_,_,_,Nama,_,_,_)),
	retract(character(Jenis,Health,Attack,Defense,E,F,G,Hmax)),
	asserta(character(Jenis,Hmax,Anew,Dnew,E,F,G,Hmax)),
	asserta(senjata(Weapon)),
	write(''),nl,
	write(''),nl,
	write('Berhasil memakai senjata'),nl,
	!.

use(Nama) :-
	senjata(_),
	item(_,Pengguna,JenisIt,Nama,HP,Att,Def),
	character(Jenis,Health,Attack,Defense,E,F,G,Hmax),
	Jenis=Pengguna,
	JenisIt='senjata', 
	Weapon is Nama,
	Hnew is Health + HP,
	Anew is Attack + Att,
	Dnew is Defense + Def,
	Hnew > Hmax,
	retract(senjata(_)),
	retract(inventory(_,_,_,Nama,_,_,_)),
	retract(character(Jenis,Health,Attack,Defense,E,F,G,Hmax)),
	asserta(character(Jenis,Hmax,Anew,Dnew,E,F,G,Hmax)),
	asserta(senjata(Weapon)),
	write(''),nl,
	write(''),nl,
	write('Berhasil mengganti senjata'),nl,
	!.

use(Nama) :-
	\+senjata(_),
	item(_,Pengguna,JenisIt,Nama,HP,Att,Def),
	character(Jenis,Health,Attack,Defense,E,F,G,Hmax),
	Jenis=Pengguna,
	JenisIt='senjata', 
	Weapon is Nama,
	Hnew is Health + HP,
	Anew is Attack + Att,
	Dnew is Defense + Def,
	Hnew =< Hmax,
	retract(inventory(_,_,_,Nama,_,_,_)),
	retract(character(Jenis,Health,Attack,Defense,E,F,G,Hmax)),
	asserta(character(Jenis,Hnew,Anew,Dnew,E,F,G,Hmax)),
	asserta(senjata(Weapon)),
	write(''),nl,
	write(''),nl,
	write('Berhasil memakai senjata'),nl,
	!.

use(Nama) :-
	senjata(_),
	item(_,Pengguna,JenisIt,Nama,HP,Att,Def),
	character(Jenis,Health,Attack,Defense,E,F,G,Hmax),
	Jenis=Pengguna,
	JenisIt='senjata', 
	Weapon is Nama,
	Hnew is Health + HP,
	Anew is Attack + Att,
	Dnew is Defense + Def,
	Hnew =< Hmax,
	retract(senjata(_)),
	retract(inventory(_,_,_,Nama,_,_,_)),
	retract(character(Jenis,Health,Attack,Defense,E,F,G,Hmax)),
	asserta(character(Jenis,Hnew,Anew,Dnew,E,F,G,Hmax)),
	asserta(senjata(Weapon)),
	write(''),nl,
	write(''),nl,
	write('Berhasil mengganti senjata'),nl,
	!.

use(Nama) :-
	\+armor(_),
	item(_,Pengguna,JenisIt,Nama,HP,Att,Def),
	character(Jenis,Health,Attack,Defense,E,F,G,Hmax),
	Jenis=Pengguna,
	JenisIt='armor', 
	Ar is Nama,
	Hnew is Health + HP,
	Anew is Attack + Att,
	Dnew is Defense + Def,
	Hnew > Hmax,
	retract(inventory(_,_,_,Nama,_,_,_)),
	retract(character(Jenis,Health,Attack,Defense,E,F,G,Hmax)),
	asserta(character(Jenis,Hmax,Anew,Dnew,E,F,G,Hmax)),
	asserta(armor(Ar)),
	write(''),nl,
	write(''),nl,
	write('Berhasil memakai armor'),nl,
	!.

use(Nama) :-
	armor(_),
	item(_,Pengguna,JenisIt,Nama,HP,Att,Def),
	character(Jenis,Health,Attack,Defense,E,F,G,Hmax),
	Jenis=Pengguna,
	JenisIt='armor', 
	Ar is Nama,
	Hnew is Health + HP,
	Anew is Attack + Att,
	Dnew is Defense + Def,
	Hnew > Hmax,
	retract(armor(_)),
	retract(inventory(_,_,_,Nama,_,_,_)),
	retract(character(Jenis,Health,Attack,Defense,E,F,G,Hmax)),
	asserta(character(Jenis,Hmax,Anew,Dnew,E,F,G,Hmax)),
	asserta(armor(Ar)),
	write(''),nl,
	write(''),nl,
	write('Berhasil mengganti armor'),nl,
	!.

use(Nama) :-
	\+armor(_),
	item(_,Pengguna,JenisIt,Nama,HP,Att,Def),
	character(Jenis,Health,Attack,Defense,E,F,G,Hmax),
	Jenis=Pengguna,
	JenisIt='armor', 
	Ar is Nama,
	Hnew is Health + HP,
	Anew is Attack + Att,
	Dnew is Defense + Def,
	Hnew =< Hmax,
	retract(inventory(_,_,_,Nama,_,_,_)),
	retract(character(Jenis,Health,Attack,Defense,E,F,G,Hmax)),
	asserta(character(Jenis,Hnew,Anew,Dnew,E,F,G,Hmax)),
	asserta(armor(Ar)),
	write(''),nl,
	write(''),nl,
	write('Berhasil memakai armor'),nl,
	!.

use(Nama) :-
	armor(_),
	item(_,Pengguna,JenisIt,Nama,HP,Att,Def),
	character(Jenis,Health,Attack,Defense,E,F,G,Hmax),
	Jenis=Pengguna,
	JenisIt='armor', 
	Ar is Nama,
	Hnew is Health + HP,
	Anew is Attack + Att,
	Dnew is Defense + Def,
	Hnew =< Hmax,
	retract(armor(_)),
	retract(inventory(_,_,_,Nama,_,_,_)),
	retract(character(Jenis,Health,Attack,Defense,E,F,G,Hmax)),
	asserta(character(Jenis,Hnew,Anew,Dnew,E,F,G,Hmax)),
	asserta(armor(Ar)),
	write(''),nl,
	write(''),nl,
	write('Berhasil mengganti senjata'),nl,
	!.

usePotions(Nama) :-
	\+inventory(_,_,_,Nama,_,_,_),
	write('Tidak ada item tersebut di inventory Anda.'),
	!,fail.

usePotions(Nama) :-
	item(_,_,JenisIt,Nama,HP,Att,Def),
	character(Jenis,Health,Attack,Defense,E,F,G,Hmax),
	JenisIt='potion', 
	Hnew is Health + HP * Health /100,
	Anew is Attack + Att * Attack /100,
	Dnew is Defense + Def * Defense /100,
	Hnew > Hmax,
	retract(inventory(_,_,_,Nama,_,_,_)),
	retract(character(Jenis,Health,Attack,Defense,E,F,G,Hmax)),
	asserta(character(Jenis,Hmax,Anew,Dnew,E,F,G,Hmax)),
	!.

usePotions(Nama) :-
	item(_,_,JenisIt,Nama,HP,Att,Def),
	character(Jenis,Health,Attack,Defense,E,F,G,Hmax),
	JenisIt='potion', 
	Hnew is Health + HP * Health /100,
	Anew is Attack + Att * Attack /100,
	Dnew is Defense + Def * Defense /100,
	Hnew =< Hmax,
	retract(inventory(_,_,_,Nama,_,_,_)),
	retract(character(Jenis,Health,Attack,Defense,E,F,G,Hmax)),
	asserta(character(Jenis,Hnew,Anew,Dnew,E,F,G,Hmax)),
	!.