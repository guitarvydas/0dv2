```
            fifo_push(&c.dst.input, new_msg)
-->
            c.dst.input.enqueue (new_msg)
-->
            (funcall (slot-value (slot-value (slot-value c 'dst) 'input) 'enqueue) new_msg)
```

