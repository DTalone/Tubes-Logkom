:- dynamic(currQuest/5).
% pada saat menduduki posisi quest
startQuest:- write('\nSelamat datang di Quest\n'),
             write('Pilihan quest\n'),
             write('1. Main Quest.\n'),
             write('2. Daily Quest.\n'),
             write('Masukkan angka : '),read(X),
             (X =:= 1  -> mainQuest
              ;X =:= 2 -> dailyQuest).

% menampilkan statistik quest yang diambil
quest :-
    running(_),
    \+(currQuest(_,_,_,_,_)),nl,
    write('Anda tidak sedang menjalani quest'),
    !.
quest :-
    running(_),
    (currQuest(_,_,_,_,_)),
    currQuest(A,B,C,D,E),
    quest(F,G,H,I,J),
    write('Progress Quest: '),nl,
    write(' Slime ('),write(F),write('/'),write(A),write(')'),nl,
    write(' Goblin ('),write(G),write('/'),write(B),write(')'),nl,
    write(' Golem ('),write(H),write('/'),write(C),write(')'),nl,
    write(' Wolf ('),write(I),write('/'),write(D),write(')'),nl,
    write(' Wizard ('),write(J),write('/'),write(E),write(')'),nl,
    !.
% main quest
mainQuest :-  \+onQuest(_),   chapter(X), X < 5, asserta(onQuest(1)),quest(A,B,C,D,E),
              retractall(quest(A,B,C,D,E)),asserta(quest(0,0,0,0,0)), retractall(currQuest(_,_,_,_,_)),
              Xnew is X + 1, retractall(chapter(_)), asserta(chapter(Xnew)),
              (X =:= 0 -> beforeStory1,asserta(currQuest(7,0,0,0,0))
              ;X =:= 1 -> beforeStory2,asserta(currQuest(5,7,0,0,0))
              ;X =:= 2 -> beforeStory3,asserta(currQuest(0,0,7,0,0))
              ;X =:= 3 -> beforeStory4,asserta(currQuest(0,0,0,7,0))
              ;X =:= 4 -> beforeStory5,asserta(currQuest(0,0,0,0,7))),!.

mainQuest:- chapter(X), X =:= 5 , write('\nSilahkan mengunjungi Dungeon\n'),!.

mainQuest :- write('\nAnda sedang menjalankan quest.\n'),!.
% daily quest
dailyQuest :- \+onQuest(_),asserta(onQuest(2)),currQuest(A,B,C,D,E),
              retractall(currQuest(A,B,C,D,E)),
              repeat,
              write('Selamat datang di dalam daily quest :'),nl,
              write('Silahkan memilih daily quest :'),nl,
              write('1. Persahabatan Slime dan Goblin'),nl,
              write('2. Perkumpulan tingkat bawah ras monster'),nl,
              write('3. Sekali monster tetap monster'),nl,
              read(X),
              (X =:= 1 -> daily1,!
              ;X =:= 2 -> daily2,!
              ;X =:= 2 -> daily3,!
              ;write('Pilihan tidak ada'),nl,fail),!.
dailyQuest :- write('\nAnda sedang menjalankan quest.\n'),!.

daily1 :- write('Slime dan Goblin adalah sahabat sejak kecil!'),nl,
          write('Taklukan 2 Slime dan 2 Goblin'),nl,
          retractall(daily(_)), asserta(daily(1)),
          asserta(currQuest(2,2,0,0,0)).

daily2 :- write('Karena merasa senasib sepenanggungan, Slime, Goblin, dan Golem'),nl,
          write('mendirikan persatuan ras monster tingkat bawah'),nl,
          write('Taklukan 3 Slime, 3 Goblin dan 3 Golem'),nl,
          retractall(daily(_)), asserta(daily(2)),
          asserta(currQuest(3,3,3,0,0)).


daily3 :- write('Slime, Goblin, Golem, dan Wolf adalah golongan ras monster pribumi'),nl,
          write('sehingga mereka membentuk perkumpulan yang dinamakan Sekali Monster'),nl,
          write('tetap Monster'),nl,
          write('Taklukan 4 Slime, 4 Goblin, 4 Golem, dan 4 Wolf'),nl,
          retractall(daily(_)), asserta(daily(3)),
          asserta(currQuest(4,4,4,4,0)).
% memeriksa apakah quest sudah terlaksana atau kurang
cekQuest :- onQuest(_), quest(A,B,C,D,E), currQuest(F,G,H,I,J), A >= F, B >= G, C >= H, D >= I, E >= J,
            onQuest(X), (X =:= 1 -> chapter(Y);daily(Y)),
            collect(X,Y), retract(currQuest(F,G,H,I,J)),!.
% mengambil bonus dari pengerjaan quest
collect(A,B) :- character(AA,BB,C,D,E,F,G,H), gold(X),
                (A =:= 1 , B =:= 1 -> Fnew is F + 300, Xnew is X + 500,
                retract(character(AA,BB,C,D,E,F,G,H)), retract(gold(X)),
                asserta(character(AA,BB,C,D,E,Fnew,G,H)), asserta(gold(Xnew)),afterStory1
                ;A =:= 1, B =:= 2 -> Fnew is F + 400, Xnew is X + 1000,
                retract(character(AA,BB,C,D,E,F,G,H)), retract(gold(X)),
                asserta(character(AA,BB,C,D,E,Fnew,G,H)), asserta(gold(Xnew)),afterStory2
                ;A =:= 1, B =:= 3 -> Fnew is F + 500, Xnew is X + 1500,
                retract(character(AA,BB,C,D,E,F,G,H)), retract(gold(X)),
                asserta(character(AA,BB,C,D,E,Fnew,G,H)), asserta(gold(Xnew)),afterStory3
                ;A =:= 1, B =:= 4 -> Fnew is F + 600, Xnew is X + 2000,
                retract(character(AA,BB,C,D,E,F,G,H)), retract(gold(X)),
                asserta(character(AA,BB,C,D,E,Fnew,G,H)), asserta(gold(Xnew)),afterStory4
                ;A =:= 1, B =:= 5 -> Fnew is F + 700, Xnew is X + 3000,
                retract(character(AA,BB,C,D,E,F,G,H)), retract(gold(X)),
                asserta(character(AA,BB,C,D,E,Fnew,G,H)), asserta(gold(Xnew)),afterStory5
                ;A =:= 2, B =:= 1 -> Fnew is F + 100, Xnew is X + 50,
                retract(character(AA,BB,C,D,E,F,G,H)), retract(gold(X)), retractall(daily(_)),
                asserta(character(AA,BB,C,D,E,Fnew,G,H)), asserta(gold(Xnew))
                ;A =:= 2, B =:= 2 -> Fnew is F + 200, Xnew is X + 100,
                retract(character(AA,BB,C,D,E,F,G,H)), retract(gold(X)),retractall(daily(_)),
                asserta(character(AA,BB,C,D,E,Fnew,G,H)), asserta(gold(Xnew))
                ;A =:= 2, B =:= 3 -> Fnew is F + 300, Xnew is X + 200,
                retract(character(AA,BB,C,D,E,F,G,H)), retract(gold(X)),retractall(daily(_)),
                asserta(character(AA,BB,C,D,E,Fnew,G,H)), asserta(gold(Xnew)))
                ,retractall(onQuest(_)),levelUp.




% Cerita cerita yang terdapat
story0 :- nama(Username),
          write('######################################################################'),nl,
          write('Emprit Kingdom adalah kerajaan yang makmur dan sejahtera.'),nl,
          write('Hingga pada suatu saat terjadi kudeta dalam internal Emprit'),nl,
          write('Kingdom, yaitu ras monster melakukan pembunuhan terhadap Raja'),nl,
          write('Jedar Jeder yang merupakan Raja Emprit Kingdom. Tepat sehari'),nl,
          write('sebelum pembunuhan Raja Jedar Jeder. Lahir anak dari Raja'),nl,
          write('Jedar Jeder. Anak ini dinamakan '),write(Username),write('. Sejak terbunuhnya '),nl,
          write('Raja Emprit Kingdom, kerajaan ini runtuh hingga tidak'),nl,
          write('dikenal namanya. Karena ditinggal sejak kecil oleh ayahnya'),nl,
          write(Username),write(' akan mulai berpetualang untuk mengungkap apa yang'),nl,
          write('terjadi pada ayahnya dan kerajaan yang dipimpin ayahnya'),nl,
          write('serta mencari jati diri '),write(Username),write('.'),nl,
          write('######################################################################'),nl.

beforeStory1 :- nama(Username),
                write('######################################################################'),nl,
                write('Tepat 30 Tahun setelah meninggalnya Raja Jedar Jeder, terdapat'),nl,
                write('sebuah pesta yang dilaksanakan oleh ras monster bernama slime.'),nl,
                write(Username),write(' mendengar kabar bahwa slime membantu'),nl,
                write('upaya pembunuhan terhadap Raja Jedar Jeder. Pergilah '),write(Username),nl,
                write('ke tempat tersebut. Ketika sudah berada di tempat tersebut'),nl,
                write(Username),write(' dihadang untuk mengganggu pestanya dan'),nl,
                write(Username),write(' tidak terima sehingga melawan.'),nl,
                          write('######################################################################'),nl.
afterStory1 :-  nama(Username),
                write('######################################################################'),nl,
                write('Setelah penaklukan slime, '),write(Username),write(' pergi berpetualang'),nl,
                write('jauh karena ternyata slime bukan merupakan dalang utama'),nl,
                write('pembunuhan Raja Jedar Jeder.'),nl,
                          write('######################################################################'),nl.

beforeStory2 :- nama(Username),
                write('######################################################################'),nl,
                write('Saat di perjalanan, '),write(Username),write(' beristirahat di bawah sebuah'),nl,
                write('pohon apel. Ketika tertidur pulas, '),write(Username),write(' mendapati'),nl,
                write('bahwa tas yang dibawanya diambil oleh sekumpulan monster Goblin.'),nl,
                write(Username),write(' lari mengejar goblin hingga ke dalam markasnya.'),nl,
                write('Di markas goblin '),write(Username),write(' langsung berhadapan dengan'),nl,
                write('goblin dan sekutunya yaitu slime untuk mendapatkan tasnya kembali.'),nl,
                          write('######################################################################'),nl.
afterStory2 :-  nama(Username),
                write('######################################################################'),nl,
                write('Setelah mendapatkan tasnya kembali, '),write(Username),write(' pergi'),nl,
                write('melanjutkan petualangnnya yang sempat terhentikan.'),nl,
                write('######################################################################'),nl.

beforeStory3 :- nama(Username),
                write('######################################################################'),nl,
                write('Saat '),write(Username),write(' beristirahat di suatu jembatan, terdapat'),nl,
                write('sekumpulan Golem menghalangi '),write(Username),write(' untuk berjalan. Golem ini'),nl,
                write('merupakan teman baik dari Goblin. Golem ingin membalaskan dendam'),nl,
                write('Goblin yang telah ditaklukan oleh '),write(Username),write(' di markas Goblin.'),nl,
                          write('######################################################################'),nl.

afterStory3 :-  nama(Username),
                write('######################################################################'),nl,
                write('Golem berhasil ditaklukan, lalu dari dalam tubuh Golem terdapat'),nl,
                write('cahaya. '),write(Username),write(' menuju pusat cahaya tersebut dan menemukan sebuah'),nl,
                write('peta menunjuk kepada markas persembunyian pemimpin dari ras monster.'),nl,
                          write('######################################################################'),nl.


beforeStory4 :- nama(Username),
                write('######################################################################'),nl,
                write('Saat malam hari, penglihatan '),write(Username),write(' sudah mulai gelap.'),nl,
                write('Lalu muncul auman serigala, dan tepat setelah auman tersebut wolf'),nl,
                write('muncul dihadapan '),write(Username),write('. Menurut buku yang dibaca '),write(Username),write(', Wolf'),nl,
                write('bukan merupakan ras monster melainkan ras manusia yang berusaha'),nl,
                write('mengubah dirinya menjadi ras monster.'),nl,
                          write('######################################################################'),nl.
afterStory4 :-  nama(Username),
                write('######################################################################'),nl,
                write('Wolf ditaklukan dan '),write(Username),write(' melanjutkan perjalanannya.'),nl,
                write('######################################################################'),nl.

beforeStory5 :- nama(Username),
                write('######################################################################'),nl,
                write('Setibanya di dalam markas yang ditunjukkan pada peta, '),write(Username),nl,
                write('disambut oleh para Wizard yang sudah menunggu kedatangannya'),nl,
                write('di depan gerbang. '),write(Username),write(' meminta untuk menemui boss mereka.'),nl,
                write('Namun, Wizard tidak mengizinkannya, sehingga terjadi pertarungan'),nl,
                write('yang besar.'),nl,
                          write('######################################################################'),nl.
afterStory5 :-  nama(Username),
                write('######################################################################'),nl,
                write('Sekarang pintu sudah terbuka dan '),write(Username),write(' mulai mencari'),nl,
                write('pemimpin dari ras monster.'),nl,
                          write('######################################################################'),nl.
beforeBoss :- nama(Username),
              write('######################################################################'),nl,
              write('Pemimpin dari pembunuhan Raja Jedar Jeder sudah di depan mata, '),nl,
              write(Username),write(' tidak ingin membiarkan pemimpin ras monster hidup'),nl,
              write('begitu saja, karena dia sudah membunuh ayahnya. '),write(Username),write(' pun bergegas menuju dasar dari Dungeon, '),nl,
              write('tempat pemimpin ras monster berada. '),nl,
                        write('######################################################################'),nl.
afterBoss :-  nama(Username),
              write('######################################################################'),nl,
              write(Username),write(' berhasil menaklukan pemimpin ras monster dan meruntuhkan'),nl,
              write('kejayaan ras monster sehingga masyarakat hidup sejahtera kembali'),nl,
              write('seperti saat terdapat Emprit Kingdom. '),write(Username),write(' lalu dinobatkan'),nl,
              write('sebagai pahlawan Emprit Kingdom.'),nl,
              write('######################################################################'),nl.
