
 
defstruct Message
(-
    port
    datum
    -)
defstruct System
(-
    components
    connectors
    -)
defstruct Connector
(-
    src
    src_port
    dst
    dst_port
    -)
defstruct Component
(-
    name
    input
    output
    state
    data
    -)
def(funcall step self sys )(-
 for component in sys.components {
 for component.output.len > 0 {
 msg, _ :=(funcall component.output.dequeue )(funcall route sys component msg )}
 }
 for component in sys.components {
 msg, ok :=(funcall component.input.dequeue )if ok {(funcall component.state component msg.port msg.datum )(setf retry true) }
 }
 return retry
-)

def(funcall route self sys from msg )(-
 for c in sys.connectors {
 if c.src == from && c.src_port == msg.port {
 new_msg :=(funcall msg setf new_msg.port c.dst_port )(funcall c.dst.input.enqueue new_msg )}
 }
-)

def(funcall run self sys port data )(-
 msg :=(funcall Message User_Datum ){port, data}(funcall route sys nil msg )for component in sys.components {
 component.state(component, Port("__STATE_ENTER__"), nil)
 }
 for(funcall step sys ){
 }
 for component in sys.components {
 component.state(component, Port("__STATE_EXIT__"), nil)
 }
-)

def(funcall add_component self sys name handler )(-
 component := new((funcall Component User_Datum ))
    (setf component.name name)
    (setf component.state handler)(funcall sys.components.append component )return component
-)

def(funcall add_connection self sys connection )(-(funcall sys.connectors.append connection )-)

def(funcall send self component port data )(- component.output.enqueue ((funcall Message User_Datum ){port,data}) -)

def(funcall tran self component state )(-
 component.state(component, Port("__STATE_EXIT__"), nil)
    (setf component.state state) component.state(component, Port("__STATE_ENTER__"), nil)
-)









