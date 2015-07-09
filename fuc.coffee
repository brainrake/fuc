module.exports = Fuc =
  __: (arg, args...) -> console.log arg, args...; arg
  ___: curry (prefix, arg, args...) -> console.log prefix, arg, args...; arg
  curry: curry = (f) -> (a, b...) ->
    if b[0] is undefined then ((b...) -> f a, b...) else f a, b...
  flip: (f) -> curry (a, b, c...) -> f b, a, c...
  flap: curry (arg, f, args...) -> f arg, args...
  thus: curry (o, f) -> f.bind o
  unite: curry (objs...) -> o = {}; o[k] = v for k, v of obj for obj in objs; o
  fap: curry (f, arr) -> arr.map(f).filter (i) -> i not in [undefined, null]
  zop: (arr) -> o={}; o[k] = v for [k, v] in arr; o
  _it_all: ->
    (window || global)[k] = Fuc[k] for k of Fuc when k is not '_it_all'
    Object.prototype.__ = (args...) -> console.log @, args...;
    for k in ['flap', 'thus', 'unite']
      Object.prototype["_#{k}"] = (arg...) -> Fuc[k] this, arg...
    Array.prototype._fap = (f) -> Fuc.fap f, this
    Array.prototype._zop = -> Fuc.zop this
    null
