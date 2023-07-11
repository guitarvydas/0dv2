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

    vb = "❪"
    ve = "❫"
    verbatim = vb (~vb ~ve any)* ve

  comment = "⎣" (~"⎣" ~"⎦" any)* "⎦"

    ab = "⎨"
    ae = "⎬"
  annotation = ab (~ab ~ae any)* ae
    scopebegin = "⎧"
    scopeend   = "⎭"

  anyToken1 = string | charconst | id | integer | keyword | multi_char_operator | indentc | dedentc | verbatim | comment | symbol | integer | any
  anyToken = anyToken1

    uspc = "・"
    unl = "⦚"
    srcnl = unl
    
    spc = " "
    nl = "\n"

    commentspace = "◦"
    commentnl = "¶"

    annotationspace = uspc

    stringspace = "□"
    stringnl = "‡"
    charspace = "☐"
    charnl = "†"


    wsc = space | spc | nl | uspc | unl | indentc | dedentc | commentspace | commentnl | stringspace | stringnl | charspace | charnl | verbatim | annotationspace | annotation
    ws = wsc*


