module.exports = Fuc =
  curry: curry = (f) -> (a, b...) -> if b.length then f a, b...           else
                                                      (b...) -> f a, b...
  isO: (v) -> Object.prototype.toString.call(v) == '[object Object]'
  pp: (o) -> if Fuc.isO o then JSON.stringify o, null, 4 else o.toString()
  __: (args...) -> console.log (args.map Fuc.pp)...; args[0]
  ___: curry (prefix, args...) -> Fuc.__ prefix, args...; args[0]
  flip: (f) -> curry (a, b, c...) -> f b, a, c...
  flap: curry (arg, f, args...) -> f arg, args...
  thus: curry (o, f) -> f.bind o
  unite: curry (objs...) -> o = {}; o[k] = v for k, v of obj for obj in objs; o
  fap: curry (f, arr) -> arr.map(f).filter (i) -> i not in [undefined, null]
  zop: (arr) -> o={}; o[k] = v for [k, v] in arr; o
  _it_all: (glo = (do -> this)['window'] || (do -> this)['global']) ->
    for k of Fuc when k != '_it_all' then glo[k] = Fuc[k]
    Object.prototype.__ = (args...) -> __ this, args...
    for k in ['flap', 'thus', 'unite']
      Object.prototype["_#{k}"] = (args...) -> Fuc[k] this, args...
    Array.prototype._fap = (f) -> Fuc.fap f, this
    Array.prototype._zop = -> Fuc.zop this
    null
