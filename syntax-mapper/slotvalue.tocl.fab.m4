SlotvalueRewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’
  slotvalue_rec [idchain dotc id] = ‛❪‹slot-value› «idchain» '«id»❫’
  slotvalue_bottom [id] = ‛«id»’
  dotc [kdot ws] = ‛«kdot»«ws»’

  include(`tokens.fab.inc')
}
