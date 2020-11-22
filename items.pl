/* File : items.pl */

/* senjata(X,Y) benar, jika X dapat menggunakan senjata Y */
senjata(archer,crossbow).
senjata(archer,longbow).
senjata(swordsman,haedonggum).
senjata(swordsman,flamberge).
senjata(sorcerer,magic_staff).

/* armor(X,Y) benar, jika X dapat menggunakan armor Y */
armor(archer,lighter_armor).
armor(swordsman,heavy_armor).
armor(sorcere,magic_robe).

/* potion(X) benar, jika X adalah potion */
potion(health_potion_s).
potion(health_potion_m).
potion(health_potion_l).
potion(enhancer_attack).
potion(enhancer_defense).
potion(freeze_potion).