    dqb = "“"
    dqe = "”"
  string = dqb (~dqb ~dqe any)* dqe

    sqb = "❛"
    sqe = "❜"
  charconst = sqb (~sqb ~sqe any)* sqe

  ID = "❲" (~"❲" ~"❳" any)* "❳"


    intb = "⟨"
    inte = "⟩"
  integer = intb (~intb ~inte any)* inte

    symb = "❲"
    syme = "❳"
  symbol = symb (~symb ~syme any)* syme
    
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
  verbatim = vb (~vb ~ve any)* ve

  comment = "⎣" (~"⎣" ~"⎦" any)* "⎦" 

  AnyToken = string | charconst | ID | integer | keyword | multi_char_operator | indentc | dedentc | verbatim | comment | symbol | integer | any

    uspc = "・"
    unl = "⦚"
    in_nl = unl
    
    spc = " "
    nl = "\n"
  // space += uspc | unl | comment

