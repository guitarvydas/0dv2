package zd

import "core:container/queue"

Port :: distinct string
FIFO      :: queue.Queue(Message)
fifo_push :: queue.push_back
fifo_pop  :: queue.pop_front_safe
