Odin0Dstruct {
  program [item+] = ‛«item»’
  item [i] = ‛«i»’

  struct [id ws1 kcc ws2 kstruct ws3 structtype? lb ws4 fields+ rb] = ‛
«id»«ws1»::«ws2»‹struct›«ws3»«ws4»{«fields»}’

  field [id ws1 kcolon ws2 toComma terminator ws3] = ‛«id»«ws1»«ws2»«ws3»’

  include(`tokens.fab.inc')
  include(`skim.fab.inc')
}
