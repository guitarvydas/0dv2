    dqb = "“"
    dqe = "”"
  string = dqb (~dqb ~dqe any)* dqe

    sqb = "❛"
    sqe = "❜"
  charconst = sqb (~sqb ~sqe any)* sqe

  id = "❲" (~"❲" ~"❳" any)* "❳"


    intb = "⟨"
    inte = "⟩"
  integer = intb (~intb ~inte any)* inte

    symb = "❲"
    syme = "❳"
  symbol = symb (~symb ~syme any)* syme
  sym<text> = symb text syme
    
    kwb = "‹"
    kwe = "›"
  keyword = kwb (~kwb ~kwe any)* kwe

    mcb = "⟪"
    mce = "⟫"
  multi_char_operator = mcb (~mcb ~mce any)* mce

  indentc = "⇢"
  dedentc = "⇠"

    vb = "«"
    ve = "»"
    vb2 = "⎨"
    ve2 = "⎬"
    verbatim = (vb | vb2) (~vb ~ve any)* (ve | ve2)

  comment = "⎣" (~"⎣" ~"⎦" any)* "⎦"

  anyToken1 = string | charconst | id | integer | keyword | multi_char_operator | indentc | dedentc | verbatim | comment | symbol | integer | any
  anyToken = anyToken1

    uspc = "・"
    unl = "⦚"
    srcnl = unl
    
    spc = " "
    nl = "\n"

    commentspace = "◦"
    commentnl = "¶"

    stringspace = "□"
    stringnl = "‡"
    charspace = "☐"
    charnl = "†"

    scopebegin = "⎧"
    scopeend = "⎭"
    
    wsc = space | spc | nl | uspc | unl | indentc | dedentc | commentspace | commentnl | stringspace | stringnl | charspace | charnl | verbatim | scopebegin | scopeend
    ws = wsc*

