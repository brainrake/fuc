eq = (ok = require 'assert').deepEqual
F = require './fuc.coffee'

minus = (a, b) -> a - b
minus1 = (n) -> n - 1

ok (F.isO {}) and !(F.isO yes) and !(F.isO 1) and !(F.isO '') and !(F.isO [])

eq '1', F.pp 1
eq 'a', F.pp 'a'
eq '{\n    "a": 1\n}', F.pp a:1

eq (minus 1, 2), (F.curry minus)(1)(2)
eq (minus 1, 2), (F.curry minus)(1, 2)

eq (minus 2, 1), (F.flip minus)(1, 2)

eq (minus1 2), F.flap 2, minus1

eq (1), do F.thus {a:1}, -> @a
eq {a:1}, (F.thus {}, (@a) -> @)(1)

eq {a:1},      F.unite {a:1}, {}
eq {a:1},      F.unite {},    {a:1}
eq {a:2},      F.unite {a:1}, {a:2}
eq {a:2},      F.unite {a:1}, {a:2}
eq {a:1, b:2}, F.unite {a:1}, {b:2}
eq {a:2, b:2}, F.unite {a:1}, {a:2, b:2}

eq [0, 2], F.fap ((n) -> if n%2 then null else n-2), [1, 2, 4]

eq {a:1, b:2}, F.zop [['a', 1], ['b', 2]]

eq 'OK', F.__ 'OK'
eq 'Pass', F.___ 'All Tests', 'Pass'
