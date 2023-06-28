

defstruct Message

    port
    datum
    
Port :: distinct string
defstruct System

    components
    connectors
    
defstruct Connector

    src
    src_port
    dst
    dst_port
    
defstruct Component

    name
    input
    output
    state
    data
    
def step(self sys )

    for component in sys.components 
        for component.output.len > 0 
            msg, _ := queue.pop_front_safe(&component.output)
            route(sys, component, msg)
            
        
    for component in sys.components 
        msg, ok := queue.pop_front_safe(&component.input)
        if ok 
            component.state(component, msg.port, msg.datum)
            retry = true
            
        
    return retry
    
def route(self sys from msg )

    for c in sys.connectors 
        if c.src == from && c.src_port == msg.port 
            new_msg := msg
            new_msg.port = c.dst_port
            queue.push_back(&c.dst.input, new_msg)
            
        
    
def run(self sys port data )

    msg := Message(User_Datum)port, data
    route(sys, nil, msg)
    for component in sys.components 
        component.state(component, ENTER, nil)
        
    for step(sys) 
        
    for component in sys.components 
        component.state(component, EXIT, nil)
        
    
def add_component(self sys name handler )

    component := new(Component(User_Datum))
    component.name = name
    component.state = handler
    append(&sys.components, component)
    return component
    
def add_connection(self sys connection )

    append(&sys.connectors, connection)
    
def send(self component port data )

    queue.push_back(&component.output, Message(User_Datum)port, data)
    
ENTER :: Port("__STATE_ENTER__")
EXIT :: Port("__STATE_EXIT__")
def tran(self component state )

    component.state(component, EXIT, nil)
    component.state = state
    component.state(component, ENTER, nil)
    




