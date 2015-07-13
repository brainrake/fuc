module.exports = Fuc =
  curry: curry = (f) -> (a, b...) -> if b.length then f a, b...           else
                                                      (b...) -> f a, b...
  flip: (f) -> curry (a, b, c...) -> f b, a, c...
  ap: curry (f, args...) -> f args...
  isO: isO = (v) -> Object.prototype.toString.call(v) == '[object Object]'
  isA: isA = Array.isArray
  pp: (o) -> (isO o) or (isA o) and JSON.stringify(o, null, 4 if isO o) or o+''
  pa: flip Fuc.ap
  dnib: curry (o, f) -> f.bind o
  uni: curry (objs...) -> o = {}; o[k] = v for k, v of obj for obj in objs; o
  __: (args...) -> console.log (args.map Fuc.pp)...; args[0]
  ___: curry (prefix, args...) -> Fuc.__ prefix, args...; args[0]
  maf: curry (f, arr) -> arr.map(f).filter (i) -> i not in [undefined, null]
  flat: ([arr...]) -> arr
  flap: curry (f, arr) ->
  zop: (arr) -> o={}; o[k] = v for [k, v] in arr; o
  fup: (cls, meth) -> cls.prototype['_'+meth] = Fuc[meth]
  _it_all: (glo = (do -> this)['window'] || (do -> this)['global']) ->
    for k of Fuc when k != '_it_all' then glo[k] = Fuc[k]
    for cls, meths of {
      Function: ['curry', 'flip', 'ap']
      Object: ['isO', 'isA', 'pp', 'uni', 'pa', 'dnib', 'uni', '__', '___']
      Array: ['maf', 'zop'] } then for k in meths
        key = if k[0] == '_' then k else "_#{k}"
        glo[cls].prototype[key] = (args...) -> Fuc[k] this, args...
    null
