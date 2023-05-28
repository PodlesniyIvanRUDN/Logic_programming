﻿
издание(1338,"россия_сегодня","новости",40).
издание(1339, "московский_вестник","новости",30).
издание(1340, "обо_всем", "мода", 50).
издание(1341, "playboy", "для_взрослых", 75).

издание(1343,"cosmopolitan","мода",45).
издание(1344,"insider","бизнес",80).
издание(1345, "время - деньги","бизнес",100).
издание(1346, "игромания", "видеоигры", 50).
издание(1347, "playstation magazine", "видеоигры", 75).

читатель(46214789, "зубенко_м.п", 44,"пушкина").
читатель(46214790, "заботина_м.п", 31,"калинина").
читатель(46214791, "лихачев_а.в", 50,"камская").
читатель(46214792, "молотов_с.п", 71,"ленина").
читатель(46214793, "лисина_а.в", 42,"красногвардейская").

читатель(46214794, "воронин_к.н", 57,"камская").
читатель(46214795, "калашников_м.т", 80,"пушкина").
читатель(46214796, "дерден_т.п", 27,"ленина").
читатель(46214797, "кеннеди_л.а", 33,"калинина").
читатель(46214798, "резнова_в.а", 18,"красногвардейская").

% подписчик(id_personal, id_ed)

подписчик(46214789,1338).
подписчик(46214790,1339).
подписчик(46214791,1340).
подписчик(46214792,1341).
подписчик(46214793,1342).
подписчик(46214794,1343).
подписчик(46214795,1344).
подписчик(46214796,1345).
подписчик(46214797,1346).
подписчик(46214798,1347).



тема(A,B) :- издание(_,A,B,_).
подписка(A,B) :- издание(_,_,_,A), B = A*30.
регулярный(A,B) :- издание(B,_,_,_), читатель(A,_,_,_), подписчик(A,B) .