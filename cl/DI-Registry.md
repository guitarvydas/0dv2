## System Diagram

A Diagram represents a *system* composed of a top-level Container that contains Leaf components and other Container components.

Currently, we parse diagrams from draw.io format into JSON format.

We expect to be able to parse diagrams created by different editors, e.g. Excalidraw.

The *Registry* code accepts two inputs and returns a registry.  A registry is essentially a *map* or a *hash table*.
The inputs are:
1. An array of Leaf Component specifiers.
2. The name of a system diagram to be parsed.

A Leaf Component specifier is a manually constructed instantiator entry for a Leaf component.

The diagram is parsed to find all Containers and to create instantiator entries for each Container.  The diagram also references Leaf Components but does not generate instantiators for them, as that information is explicitly, manually supplied as the first argument to the registry creator procedure.

## Instantiator Entry

An instantiator is a procedure (a piece of code) that instantiates a component, either Leaf or Container.

An instantiator *entry* is simply a mapping of a *name* to an instantiator procedure.

`{ name X instantiator }` 

Objects in OO languages contain implicit instantiators.  In the Registry described here, we simply make this concept explicit.

## Registry

A registry is a table of instantiator entries.

- A "name" refers to the name of the prototype component (e.g., a Class), not the name of the instance.

- Leaves and Containers are prototypes that need to be instantiated before use, similar to `__init__()` for a Class.

- Unique instances are internally identified, but the programmer does not need to know the internal ID. It's like declaring a local variable with a user-defined class type and then instantiating it. The local variable "holds" the unique instance, but the user doesn't need to know if the variable contains a pointer to heap or the actual data.

- A Leaf instantiator creates a unique instance of instance data for the Component and returns a pointer to a handler function. This function takes `(instance-data, message)` and reacts to the incoming message within the unique instance context, producing a list of 0 or more outgoing messages.

## Container and Leaf Components

A Container is a specialized kind of Leaf. 

A Container is like a recursive Leaf.  A Container can contain Leaves and other Containers.

A Leaf is simply a piece of executable code written in some language, e.g. Odin, Python, JS, Common Lisp, Rust, etc..  A Leaf is the "bottom" of recursion - the termination case.  A Leaf does not recur deeper and does not contain other Components.

## Containers

A Container's instance data contains a set of children and a set of connections between children and to/from itself:

- A Child's output can connect to another Child input (`.Across` type connection).

- A Child's output can connect to its parent's output (`.Up` type connection).

- A Child's output can be left unconnected (`.NC` type connection).

- A Child's input can be left unconnected (lack of any kind of connection).

- A Container's input can internally connect to one of its children (`.Down`).

- A Container's input can internally connect to its own output (`.Through`).

- A Container's input can be left internally unconnected (`.NC`).

- A Container's output can be left internally unconnected (lack of any kind of connection).

Hence, a Connection consists of 3 attributes:
1. A Direction (`.Down`, `.Up`, `.Across`, `.Through`, `.NC`).
2. A Sender `{ component X port }` if connected, or a Sender which is `.Self: { .Self X port }` (direction must be `.Down` or `.NC`).
3. A Receiver `{ component X port }` if connected, or a Receiver which is `.Self { .Self X port }` (direction must be `.Up`), or a null Receiver: `nil` or `{ nil X port }` if `.NC`.

Fan-out is the notion that a single source port feeds multiple sink ports.

Fan-in is the notion that multiple source ports feed into a single sink port.

![[DrawIO/fanin-and-fanout.drawio.svg]]

Fan-in and fan-out can be represented as multiple single connections from the same source or to the same sink.  This requires that all connections in a Container be examined and acted upon in an atomic manner.

### Fan Out Connection
In the above diagram example, fan out would be represented as
1. a connection {.Across, {A output1}, {B input1}}
2. a connection {.Across, {A output1}, {C input1}}

### Fan In Connection
In the above diagram example, fan in would be represented as
1. a connection {.Across, {B output1}, {A input1}}
2. a connection {.Across, {C output1}, {A input1}}

## Notes

`.NC`'s (No Connection) are represented as the lack of connection

There are 4 different kinds of NCs (No Connection), but we don't need that information at this low level. The type checker needs to ensure that the programmer truly intended to leave a port unconnected and must weed out such "type errors" before generating this low-level connection table.

The 4 kinds of higher level NC are: 
1. child output NC (`.NC_out`), 
2. child input NC (`.NC_in`), 
3. Container input NC (`.NC_down`), and, 
4. Container output NC (`.NC_up`)).

## Most Recent Document
see https://publish.obsidian.md/programmingsimplicity/2023-07-24-Component+Registry+(Working+Paper%2C+DI+Note)
