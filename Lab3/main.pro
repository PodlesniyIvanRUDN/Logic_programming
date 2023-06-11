implement main
    open core, stdio

domains
    unit = лет; год; года.

class facts - whateverDb
    publisher : (integer Id, string Название, string Темы, integer Price).
    reader : (integer Id_чел, string Имя, integer Возраст, unit Unit, string Дом).
    sub : (integer Id_чел, integer Id).

class facts
    sum : (real Sum) single.

clauses
    sum(0).

class predicates
    тема : (string Тема) nondeterm anyflow.
    подписка : (string Name) nondeterm anyflow.
    бд_читателей : (integer Id_чел) failure.
    все : () failure.

clauses
    тема(Topic) :-
        publisher(_, Name, Topic, _),
        write("\n", Name, " ", Topic),
        write("\n"),
        fail.

    подписка(Name) :-
        publisher(_, Name, _, Price),
        sum(Sum),
        assert(sum(Sum + Price * 30)),
        fail.

    подписка(Name) :-
        publisher(_, Name, _, _),
        sum(Sum),
        write("\n", Name, " ", Sum),
        write("\n"),
        fail.

    бд_читателей(X) :-
        sub(X, Y),
        publisher(Y, Name, _, _),
        reader(X, Info, Age, Extra, _),
        write("\n", Info, " ", Age, " ", Extra, " - ", Name),
        fail.

    все() :-
        sub(X, Y),
        publisher(Y, Name, _, _),
        reader(X, Info, Age, Extra, _),
        write("\n", Info, " ", Age, " ", Extra, " - ", Name),
        fail.

class predicates
    длина : (A*) -> integer N.
    сумм_эл : (real* List) -> real Sum.
    сред : (real* List) -> real Average determ.
    макс : (real* List, real Max [out]) nondeterm.
    мин : (real* List, real Min [out]) nondeterm.

clauses
    длина([]) = 0.
    длина([_ | T]) = длина(T) + 1.

    сумм_эл([]) = 0.
    сумм_эл([H | T]) = сумм_эл(T) + H.

    сред(L) = сумм_эл(L) / длина(L) :-
        длина(L) > 0.

    макс([Max], Max).

    макс([H1, H2 | T], Max) :-
        H1 >= H2,
        макс([H1 | T], Max).

    макс([H1, H2 | T], Max) :-
        H1 <= H2,
        макс([H2 | T], Max).

    мин([Min], Min).

    мин([H1, H2 | T], Min) :-
        H1 <= H2,
        мин([H1 | T], Min).

    мин([H1, H2 | T], Min) :-
        H1 >= H2,
        мин([H2 | T], Min).

class predicates
    out_list : (integer*) nondeterm.
    out_list : (string*) nondeterm.
    out_list : (main::whateverDb*) nondeterm.
    available_options : (string Genre) -> main::whateverDb* Genres nondeterm.
    paper_price_sum : () -> real Sum determ.
    max_price : () -> real Max nondeterm.
    min_price : () -> real Min nondeterm.

clauses
    available_options(Темы) = Genres :-
        Genres = [ publisher(Id, Название, Темы, Price) || publisher(Id, Название, Темы, Price) ].

    out_list([X | Y]) :-
        write(X),
        nl,
        out_list(Y).

    paper_price_sum() = Sum :-
        Sum = сумм_эл([ Price || publisher(_, _, _, Price) ]).

    max_price() = Res :-
        макс([ Price || publisher(_, _, _, Price) ], Max),
        Res = Max,
        !.
    min_price() = Res :-
        мин([ Price || publisher(_, _, _, Price) ], Min),
        Res = Min,
        !.

clauses
    run() :-
        file::consult("../1.txt", whateverDb),
        fail.

    run() :-
        PList = available_options("для_взрослых"),
        write(PList),
        nl,
        write("Printing list..."),
        nl,
        out_list(PList),
        write("Printing finished"),
        nl,
        fail.

    run() :-
        write("sum of every journal :", paper_price_sum()),
        nl,
        write("Max price:", max_price()),
        nl,
        write("Min price:", min_price()),
        nl,
        fail.

    run().

end implement main

goal
    console::runUtf8(main::run).
