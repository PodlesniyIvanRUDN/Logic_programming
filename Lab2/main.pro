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

clauses
    run() :-
        file::consult("../1.txt", whateverDb),
        fail.

    run() :-
        тема("для_взрослых"),
        fail.

    run() :-
        подписка("Maxim"),
        fail.

    run() :-
        бд_читателей(46214789).

    run() :-
        все().

    run().

end implement main

goal
    console::runUtf8(main::run).
